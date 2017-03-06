From: timur@codeaurora.org (Timur Tabi)
Date: Mon,  6 Mar 2017 17:32:02 -0600
Subject: [PATCH] pinctrl: qcom: qdf2xxx: add names to the gpios
Message-ID: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysfs and debugfs entries for pin control drivers work better when
the individual pins are given real names, even if they are all just
"gpio0", "gpio1", etc.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
index f448534..bb3ce5c 100644
--- a/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
+++ b/drivers/pinctrl/qcom/pinctrl-qdf2xxx.c
@@ -35,10 +35,14 @@
 /* A reasonable limit to the number of GPIOS */
 #define MAX_GPIOS	256
 
+/* maximum size of each gpio name (enough room for "gpioXXX" + null) */
+#define NAME_SIZE	8
+
 static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 {
 	struct pinctrl_pin_desc *pins;
 	struct msm_pingroup *groups;
+	char (*names)[NAME_SIZE];
 	unsigned int i;
 	u32 num_gpios;
 	int ret;
@@ -59,15 +63,21 @@ static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
 		sizeof(struct pinctrl_pin_desc), GFP_KERNEL);
 	groups = devm_kcalloc(&pdev->dev, num_gpios,
 		sizeof(struct msm_pingroup), GFP_KERNEL);
+	names = devm_kcalloc(&pdev->dev, num_gpios, NAME_SIZE, GFP_KERNEL);
 
-	if (!pins || !groups)
+	if (!pins || !groups || !names)
 		return -ENOMEM;
 
 	for (i = 0; i < num_gpios; i++) {
+		snprintf(names[i], NAME_SIZE, "gpio%u", i);
+
 		pins[i].number = i;
+		pins[i].name = names[i];
 
-		groups[i].npins = 1,
+		groups[i].npins = 1;
+		groups[i].name = names[i];
 		groups[i].pins = &pins[i].number;
+
 		groups[i].ctl_reg = 0x10000 * i;
 		groups[i].io_reg = 0x04 + 0x10000 * i;
 		groups[i].intr_cfg_reg = 0x08 + 0x10000 * i;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
