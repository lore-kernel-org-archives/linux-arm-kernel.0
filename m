From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Jun 2017 19:42:19 -0500
Subject: [PATCH 2/2] [v2] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <1498783339-749-1-git-send-email-timur@codeaurora.org>
References: <1498783339-749-1-git-send-email-timur@codeaurora.org>
Message-ID: <1498783339-749-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
are actually available to the HLOS.  The others are blocked by the XPU,
and any attempt to access them will cause an XPU violation that halts
the system.

Instead, the ACPI table now lists only specific GPIOs that are exposed
externally as generic GPIO pins.  The full list of GPIOs is still
registered, but the pin count for the unavailable GPIOs is set to zero.
The pinctrl-msm driver will block those unavailable GPIOs from being
accessed.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 112 +++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index bb3ce5c..106e6c1 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -43,68 +43,102 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct msm_pingroup *groups;
 	char (*names)[NAME_SIZE];
-	unsigned int i;
-	u32 num_gpios;
+	unsigned int i, num_gpios, max_gpios;
+	u32 *gpios;
 	int ret;
 
-	/* Query the number of GPIOs from ACPI */
-	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
+	/* The total number of GPIOs that exist */
+	ret = device_property_read_u32(&pdev->dev, "num-gpios", &max_gpios);
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "missing num-gpios property\n");
+		dev_err(&pdev->dev, "missing num-gpios property\n");
 		return ret;
 	}
+	if (!max_gpios || max_gpios > MAX_GPIOS) {
+		dev_err(&pdev->dev, "invalid 'num-gpios' property\n");
+		return -EINVAL;
+	}
 
-	if (!num_gpios || num_gpios > MAX_GPIOS) {
-		dev_warn(&pdev->dev, "invalid num-gpios property\n");
+	/* The number of GPIOs in the approved list */
+	num_gpios = ret = device_property_read_u32_array(&pdev->dev, "gpios",
+							 NULL, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"missing or invalid 'gpios' property (ret=%i)\n", ret);
+		return ret;
+	}
+	if (ret == 0) {
+		dev_warn(&pdev->dev, "no GPIOs defined\n");
 		return -ENODEV;
 	}
 
-	pins = devm_kcalloc(&pdev->dev, num_gpios,
+	gpios = devm_kcalloc(&pdev->dev, num_gpios, sizeof(u32), GFP_KERNEL);
+	if (!gpios)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(&pdev->dev, "gpios", gpios,
+					     num_gpios);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"could not read list of GPIOs (ret=%i)\n", ret);
+		return ret;
+	}
+
+	pins = devm_kcalloc(&pdev->dev, max_gpios,
 		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
-	groups = devm_kcalloc(&pdev->dev, num_gpios,
+	groups = devm_kcalloc(&pdev->dev, max_gpios,
 		sizeof(struct msm_pingroup), GFP_KERNEL);
 	names = devm_kcalloc(&pdev->dev, num_gpios, NAME_SIZE, GFP_KERNEL);
 
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
 
+	devm_kfree(&pdev->dev, gpios);
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
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
