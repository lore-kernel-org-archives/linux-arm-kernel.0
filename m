From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Dec 2017 18:39:35 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
Message-ID: <20171219023935.GA17456@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18, Timur Tabi wrote:
> Stephen, any follow-up to this?  I'd like to get these patches into
> 4.16 if at all possible.  Thanks.
> 

Ah I missed that the u16 array can't be iterated through. Any
chance the ACPI tables can be changed to list pin ranges, like
<33 3>, <90 2>, to indicate that pins 33, 34, 35 and pins 90, 91
are available? That would allow us to put that into the core
pinctrl-msm.c file a little better and then only expose pins on
the gpiochip when call gpiochip_add_pin_range(). If we want to
support this in DT, I think we would have a DT property like
available-gpios = <33 3>, <90 2>, <100 34> that we can then
iterate through and add only these pins to the gpiochip. That's
better than a bitmap in DT and is still compressed somewhat.

Without going all the way down into that path, here's my patch to
make your patch smaller, but perhaps we can just look for the
ACPI property or the DT property in the pinctrl-msm.c core and
then add pin ranges directly. Then this ACPI driver doesn't
really need to change besides for the ID update. We can expose
all the pins and offsets, etc. from the hardware driver but cut
out gpios in the core layer in a generic way.

---8<---
From: Timur Tabi <timur@codeaurora.org>

Newer versions of the firmware for the Qualcomm Datacenter Technologies
QDF2400 restricts access to a subset of the GPIOs on the TLMM.  To
prevent older kernels from accidentally accessing the restricted GPIOs,
we change the ACPI HID for the TLMM block from QCOM8001 to QCOM8002,
and introduce a new property "gpios".  This property is an array of
specific GPIOs that are accessible.  When an older kernel boots on
newer (restricted) firmware, it will fail to probe.

To implement the sparse GPIO map, we register all of the GPIOs, but set
the pin count for the unavailable GPIOs to zero.  The pinctrl-msm
driver will block those unavailable GPIOs from being accessed.

To allow newer kernels to support older firmware, the driver retains
support for QCOM8001.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 89 +++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index bb3ce5c3e18b..2ca2f40719b3 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -38,45 +38,107 @@ static struct msm_pinctrl_soc_data qdf2xxx_pinctrl;
 /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
 #define NAME_SIZE	8
 
+enum {
+	QDF2XXX_V1,
+	QDF2XXX_V2,
+};
+
 static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 {
+	const struct acpi_device_id *id;
 	struct pinctrl_pin_desc *pins;
 	struct msm_pingroup *groups;
 	char (*names)[NAME_SIZE];
-	unsigned int i;
+	unsigned int i, j;
 	u32 num_gpios;
+	unsigned int avail_gpios; /* The number of GPIOs we support */
+	u16 *gpios = NULL; /* An array of supported GPIOs */
 	int ret;
 
 	/* Query the number of GPIOs from ACPI */
 	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "missing num-gpios property\n");
+		dev_err(&pdev->dev, "missing 'num-gpios' property\n");
 		return ret;
 	}
-
 	if (!num_gpios || num_gpios > MAX_GPIOS) {
-		dev_warn(&pdev->dev, "invalid num-gpios property\n");
+		dev_err(&pdev->dev, "invalid 'num-gpios' property\n");
 		return -ENODEV;
 	}
 
+	/*
+	 * The QCOM8001 HID contains only the number of GPIOs, and assumes
+	 * that all of them are available. avail_gpios is the same as num_gpios.
+	 *
+	 * The QCOM8002 HID introduces the 'gpios' DSD, which lists
+	 * specific GPIOs that the driver is allowed to access.
+	 *
+	 * The make the common code simpler, in both cases we create an
+	 * array of GPIOs that are accessible.  So for QCOM8001, that would
+	 * be all of the GPIOs.
+	 */
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+
+	if (id->driver_data == QDF2XXX_V1) {
+		avail_gpios = num_gpios;
+	} else {
+		/* The number of GPIOs in the approved list */
+		ret = device_property_read_u16_array(&pdev->dev, "gpios",
+						     NULL, 0);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "missing 'gpios' property\n");
+			return ret;
+		}
+		/*
+		 * The number of available GPIOs should be non-zero, and no
+		 * more than the total number of GPIOS.
+		 */
+		if (!ret || ret > num_gpios) {
+			dev_err(&pdev->dev, "invalid 'gpios' property\n");
+			return -ENODEV;
+		}
+		avail_gpios = ret;
+
+		gpios = devm_kmalloc_array(&pdev->dev, avail_gpios,
+					   sizeof(gpios[0]), GFP_KERNEL);
+		if (!gpios)
+			return -ENOMEM;
+
+		/* Assume the array of available GPIOs is sorted */
+		ret = device_property_read_u16_array(&pdev->dev, "gpios", gpios,
+						     avail_gpios);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not read list of GPIOs\n");
+			return ret;
+		}
+	}
+
 	pins = devm_kcalloc(&pdev->dev, num_gpios,
 		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
 	groups = devm_kcalloc(&pdev->dev, num_gpios,
 		sizeof(struct msm_pingroup), GFP_KERNEL);
-	names = devm_kcalloc(&pdev->dev, num_gpios, NAME_SIZE, GFP_KERNEL);
+	names = devm_kcalloc(&pdev->dev, avail_gpios, NAME_SIZE, GFP_KERNEL);
 
 	if (!pins || !groups || !names)
 		return -ENOMEM;
 
-	for (i = 0; i < num_gpios; i++) {
-		snprintf(names[i], NAME_SIZE, "gpio%u", i);
-
+	/*
+	 * Initialize the array.  GPIOs not listed in the 'gpios' bitmap
+	 * still need a number, but nothing else.
+	 */
+	for (i = 0, j = 0; i < num_gpios; i++) {
 		pins[i].number = i;
-		pins[i].name = names[i];
+		groups[i].pins = &pins[i].number;
+
+		/* Only expose GPIOs that are available */
+		if (gpios && gpios[j] != i)
+			continue;
 
 		groups[i].npins = 1;
-		groups[i].name = names[i];
-		groups[i].pins = &pins[i].number;
+		snprintf(names[j], NAME_SIZE, "gpio%u", i);
+		pins[i].name = names[j];
+		groups[i].name = names[j];
+		j++;
 
 		groups[i].ctl_reg = 0x10000 * i;
 		groups[i].io_reg = 0x04 + 0x10000 * i;
@@ -100,6 +162,8 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 		groups[i].intr_detection_width = 2;
 	}
 
+	devm_kfree(&pdev->dev, gpios);
+
 	qdf2xxx_pinctrl.pins = pins;
 	qdf2xxx_pinctrl.groups = groups;
 	qdf2xxx_pinctrl.npins = num_gpios;
@@ -110,7 +174,8 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
-	{"QCOM8001"},
+	{"QCOM8001", QDF2XXX_V1},
+	{"QCOM8002", QDF2XXX_V2},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
