From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 10 Nov 2015 09:57:10 -0600
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and reporting
Message-ID: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't report an error message if the ACPI tables are missing
the num-gpios property (which indicates how many GPIOs there are on this
SOC), and it didn't check to ensure that the mallocs didn't fail.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index e9ff3bc..f448534 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -32,6 +32,9 @@
 
 static struct msm_pinctrl_soc_data qdf2xxx_pinctrl;
 
+/* A reasonable limit to the number of GPIOS */
+#define MAX_GPIOS	256
+
 static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 {
 	struct pinctrl_pin_desc *pins;
@@ -42,11 +45,13 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 
 	/* Query the number of GPIOs from ACPI */
 	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "missing num-gpios property\n");
 		return ret;
+	}
 
-	if (!num_gpios) {
-		dev_warn(&pdev->dev, "missing num-gpios property\n");
+	if (!num_gpios || num_gpios > MAX_GPIOS) {
+		dev_warn(&pdev->dev, "invalid num-gpios property\n");
 		return -ENODEV;
 	}
 
@@ -55,6 +60,9 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 	groups = devm_kcalloc(&pdev->dev, num_gpios,
 		sizeof(struct msm_pingroup), GFP_KERNEL);
 
+	if (!pins || !groups)
+		return -ENOMEM;
+
 	for (i = 0; i < num_gpios; i++) {
 		pins[i].number = i;
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
