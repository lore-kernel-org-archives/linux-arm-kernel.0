From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 13 Jul 2017 16:52:43 -0500
Subject: [PATCH 2/2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
Message-ID: <1499982763-29619-3-git-send-email-timur@codeaurora.org>
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
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 157 +++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 46 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index bb3ce5c..266f2e6 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -38,83 +38,148 @@
 /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
 #define NAME_SIZE	8
 
+enum {
+	QDF2XXX_V1,
+	QDF2XXX_V2,
+};
+
+static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
+	{"QCOM8001", QDF2XXX_V1},
+	{"QCOM8002", QDF2XXX_V2},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
+
 static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 {
+	const struct acpi_device_id *id =
+		acpi_match_device(qdf2xxx_acpi_ids, &pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pins;
 	struct msm_pingroup *groups;
 	char (*names)[NAME_SIZE];
 	unsigned int i;
-	u32 num_gpios;
+	unsigned int num_gpios; /* The number of GPIOs we support */
+	u32 max_gpios; /* The highest number GPIO that exists */
+	u16 *gpios; /* An array of supported GPIOs */
 	int ret;
 
-	/* Query the number of GPIOs from ACPI */
-	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
+	/* The total number of GPIOs that exist */
+	ret = device_property_read_u32(dev, "num-gpios", &max_gpios);
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "missing num-gpios property\n");
+		dev_err(dev, "missing or invalid 'num-gpios' property\n");
 		return ret;
 	}
+	if (!max_gpios || max_gpios > MAX_GPIOS) {
+		dev_err(dev, "invalid 'num-gpios' property\n");
+		return -EINVAL;
+	}
 
-	if (!num_gpios || num_gpios > MAX_GPIOS) {
-		dev_warn(&pdev->dev, "invalid num-gpios property\n");
-		return -ENODEV;
+	/*
+	 * The QCOM8001 HID contains only the number of GPIOs, and assumes
+	 * that all of them are available.  num_gpios is the same as max_gpios.
+	 *
+	 * The QCOM8002 HID introduces the 'gpios' DSD, which lists
+	 * specific GPIOs that the driver is allowed to access.
+	 *
+	 * The make the common code simpler, in both cases we create an
+	 * array of GPIOs that are accessible.  So for QCOM8001, that would
+	 * be all of the GPIOs.
+	 */
+	if (id->driver_data == QDF2XXX_V1) {
+		num_gpios = max_gpios;
+
+		gpios = devm_kcalloc(dev, num_gpios, sizeof(u16), GFP_KERNEL);
+		if (!gpios)
+			return -ENOMEM;
+
+		for (i = 0; i < num_gpios; i++)
+			gpios[i] = i;
+	} else {
+		/* The number of GPIOs in the approved list */
+		ret = device_property_read_u16_array(dev, "gpios", NULL, 0);
+		if (ret < 0) {
+			dev_err(dev, "missing/invalid 'gpios' property\n");
+			return ret;
+		}
+		if (ret == 0) {
+			dev_warn(dev, "no GPIOs defined\n");
+			return -ENODEV;
+		}
+		num_gpios = ret;
+
+		gpios = devm_kcalloc(dev, num_gpios, sizeof(u16), GFP_KERNEL);
+		if (!gpios)
+			return -ENOMEM;
+
+		ret = device_property_read_u16_array(dev, "gpios", gpios,
+						     num_gpios);
+		if (ret < 0) {
+			dev_err(dev, "could not read list of GPIOs\n");
+			return ret;
+		}
 	}
 
-	pins = devm_kcalloc(&pdev->dev, num_gpios,
+	pins = devm_kcalloc(dev, max_gpios,
 		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
-	groups = devm_kcalloc(&pdev->dev, num_gpios,
+	groups = devm_kcalloc(dev, max_gpios,
 		sizeof(struct msm_pingroup), GFP_KERNEL);
-	names = devm_kcalloc(&pdev->dev, num_gpios, NAME_SIZE, GFP_KERNEL);
+	names = devm_kcalloc(dev, num_gpios, NAME_SIZE, GFP_KERNEL);
 
 	if (!pins || !groups || !names)
 		return -ENOMEM;
 
-	for (i = 0; i < num_gpios; i++) {
-		snprintf(names[i], NAME_SIZE, "gpio%u", i);
-
+	/*
+	 * Initialize the array.  GPIOs not listed in the 'gpios' array
+	 * still need a number and a name, but nothing else.
+	 */
+	for (i = 0; i < max_gpios; i++) {
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
+	for (i = 0; i < num_gpios; i++) {
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
 
+	devm_kfree(dev, gpios);
+
 	qdf2xxx_pinctrl.pins = pins;
 	qdf2xxx_pinctrl.groups = groups;
-	qdf2xxx_pinctrl.npins = num_gpios;
-	qdf2xxx_pinctrl.ngroups = num_gpios;
-	qdf2xxx_pinctrl.ngpios = num_gpios;
+	qdf2xxx_pinctrl.npins = max_gpios;
+	qdf2xxx_pinctrl.ngroups = max_gpios;
+	qdf2xxx_pinctrl.ngpios = max_gpios;
 
 	return msm_pinctrl_probe(pdev, &qdf2xxx_pinctrl);
 }
 
-static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
-	{"QCOM8001"},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
-
 static struct platform_driver qdf2xxx_pinctrl_driver = {
 	.driver = {
 		.name = "qdf2xxx-pinctrl",
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
