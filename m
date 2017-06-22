From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 22 Jun 2017 15:54:10 -0500
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
Message-ID: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
are actually available to the HLOS.  The others are blocked by the XPU,
and any attempt to access them will cause an XPU violation that halts
the system.

Instead, the ACPI table now lists only specific GPIOs that are exposed
externally as generic GPIO pins.  To maintain consistency, the GPIOs are
enumerated 0 .. (N-1) as before, so that "gpio0" is really whatever is
the first GPIO listed in ACPI.  The actual mapping is available via
/sys/kernel/debug/gpio.

Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 46 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index bb3ce5c..983df72 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -32,9 +32,6 @@
 
 static struct msm_pinctrl_soc_data qdf2xxx_pinctrl;
 
-/* A reasonable limit to the number of GPIOS */
-#define MAX_GPIOS	256
-
 /* maximum size of each gpio name (enough room for "gpioXXX" + null) */
 #define NAME_SIZE	8
 
@@ -43,22 +40,35 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct msm_pingroup *groups;
 	char (*names)[NAME_SIZE];
-	unsigned int i;
-	u32 num_gpios;
+	unsigned int i, num_gpios;
+	u32 *gpios;
 	int ret;
 
 	/* Query the number of GPIOs from ACPI */
-	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
+	num_gpios = ret = device_property_read_u32_array(&pdev->dev, "gpios",
+							 NULL, 0);
 	if (ret < 0) {
-		dev_warn(&pdev->dev, "missing num-gpios property\n");
+		dev_err(&pdev->dev,
+			"missing or invalid 'gpios' property (ret=%i)\n", ret);
 		return ret;
 	}
-
-	if (!num_gpios || num_gpios > MAX_GPIOS) {
-		dev_warn(&pdev->dev, "invalid num-gpios property\n");
+	if (ret == 0) {
+		dev_warn(&pdev->dev, "no GPIOs defined\n");
 		return -ENODEV;
 	}
 
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
 	pins = devm_kcalloc(&pdev->dev, num_gpios,
 		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
 	groups = devm_kcalloc(&pdev->dev, num_gpios,
@@ -69,7 +79,9 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_gpios; i++) {
-		snprintf(names[i], NAME_SIZE, "gpio%u", i);
+		unsigned int gpio = gpios[i];
+
+		snprintf(names[i], NAME_SIZE, "gpio%u", gpio);
 
 		pins[i].number = i;
 		pins[i].name = names[i];
@@ -78,11 +90,11 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 		groups[i].name = names[i];
 		groups[i].pins = &pins[i].number;
 
-		groups[i].ctl_reg = 0x10000 * i;
-		groups[i].io_reg = 0x04 + 0x10000 * i;
-		groups[i].intr_cfg_reg = 0x08 + 0x10000 * i;
-		groups[i].intr_status_reg = 0x0c + 0x10000 * i;
-		groups[i].intr_target_reg = 0x08 + 0x10000 * i;
+		groups[i].ctl_reg = 0x10000 * gpio;
+		groups[i].io_reg = 0x04 + 0x10000 * gpio;
+		groups[i].intr_cfg_reg = 0x08 + 0x10000 * gpio;
+		groups[i].intr_status_reg = 0x0c + 0x10000 * gpio;
+		groups[i].intr_target_reg = 0x08 + 0x10000 * gpio;
 
 		groups[i].mux_bit = 2;
 		groups[i].pull_bit = 0;
@@ -100,6 +112,8 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 		groups[i].intr_detection_width = 2;
 	}
 
+	devm_kfree(&pdev->dev, gpios);
+
 	qdf2xxx_pinctrl.pins = pins;
 	qdf2xxx_pinctrl.groups = groups;
 	qdf2xxx_pinctrl.npins = num_gpios;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
