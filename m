From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 13 Dec 2017 12:30:18 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
Message-ID: <1513189818-7384-4-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 134 +++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index bb3ce5c3e18b..deb08e08e86d 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -38,68 +38,139 @@
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
 	unsigned int i;
 	u32 num_gpios;
+	unsigned int avail_gpios; /* The number of GPIOs we support */
+	u16 *gpios; /* An array of supported GPIOs */
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
+
+		gpios = devm_kmalloc_array(&pdev->dev, avail_gpios,
+					   sizeof(gpios[0]), GFP_KERNEL);
+		if (!gpios)
+			return -ENOMEM;
+
+		for (i = 0; i < avail_gpios; i++)
+			gpios[i] = i;
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
 
+	/*
+	 * Initialize the array.  GPIOs not listed in the 'gpios' array
+	 * still need a number, but nothing else.
+	 */
 	for (i = 0; i < num_gpios; i++) {
-		snprintf(names[i], NAME_SIZE, "gpio%u", i);
-
 		pins[i].number = i;
-		pins[i].name = names[i];
-
-		groups[i].npins = 1;
-		groups[i].name = names[i];
 		groups[i].pins = &pins[i].number;
+	}
 
-		groups[i].ctl_reg = 0x10000 * i;
-		groups[i].io_reg = 0x04 + 0x10000 * i;
-		groups[i].intr_cfg_reg = 0x08 + 0x10000 * i;
-		groups[i].intr_status_reg = 0x0c + 0x10000 * i;
-		groups[i].intr_target_reg = 0x08 + 0x10000 * i;
-
-		groups[i].mux_bit = 2;
-		groups[i].pull_bit = 0;
-		groups[i].drv_bit = 6;
-		groups[i].oe_bit = 9;
-		groups[i].in_bit = 0;
-		groups[i].out_bit = 1;
-		groups[i].intr_enable_bit = 0;
-		groups[i].intr_status_bit = 0;
-		groups[i].intr_target_bit = 5;
-		groups[i].intr_target_kpss_val = 1;
-		groups[i].intr_raw_status_bit = 4;
-		groups[i].intr_polarity_bit = 1;
-		groups[i].intr_detection_bit = 2;
-		groups[i].intr_detection_width = 2;
+	/* Populate the entries that are meant to be exposes as GPIOs. */
+	for (i = 0; i < avail_gpios; i++) {
+		unsigned int gpio = gpios[i];
+
+		groups[gpio].npins = 1;
+		snprintf(names[i], NAME_SIZE, "gpio%u", gpio);
+		pins[gpio].name = names[i];
+		groups[gpio].name = names[i];
+
+		groups[gpio].ctl_reg = 0x10000 * gpio;
+		groups[gpio].io_reg = 0x04 + 0x10000 * gpio;
+		groups[gpio].intr_cfg_reg = 0x08 + 0x10000 * gpio;
+		groups[gpio].intr_status_reg = 0x0c + 0x10000 * gpio;
+		groups[gpio].intr_target_reg = 0x08 + 0x10000 * gpio;
+
+		groups[gpio].mux_bit = 2;
+		groups[gpio].pull_bit = 0;
+		groups[gpio].drv_bit = 6;
+		groups[gpio].oe_bit = 9;
+		groups[gpio].in_bit = 0;
+		groups[gpio].out_bit = 1;
+		groups[gpio].intr_enable_bit = 0;
+		groups[gpio].intr_status_bit = 0;
+		groups[gpio].intr_target_bit = 5;
+		groups[gpio].intr_target_kpss_val = 1;
+		groups[gpio].intr_raw_status_bit = 4;
+		groups[gpio].intr_polarity_bit = 1;
+		groups[gpio].intr_detection_bit = 2;
+		groups[gpio].intr_detection_width = 2;
 	}
 
+	devm_kfree(&pdev->dev, gpios);
+
 	qdf2xxx_pinctrl.pins = pins;
 	qdf2xxx_pinctrl.groups = groups;
 	qdf2xxx_pinctrl.npins = num_gpios;
@@ -110,7 +181,8 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
-	{"QCOM8001"},
+	{"QCOM8001", QDF2XXX_V1},
+	{"QCOM8002", QDF2XXX_V2},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
