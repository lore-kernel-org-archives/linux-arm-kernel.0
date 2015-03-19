From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Mar 2015 11:30:47 +0100
Subject: [PATCH] pinctrl: mvebu: add suspend/resume support to Armada XP
 pinctrl driver
Message-ID: <1426761047-3103-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds suspend/resume support to the Armada XP pinctrl
driver, by simply saving and restoring the MPP registers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index fc33761..d191c3a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -34,6 +34,7 @@
 #include "pinctrl-mvebu.h"
 
 static void __iomem *mpp_base;
+static u32 *mpp_saved_regs;
 
 static int armada_xp_mpp_ctrl_get(unsigned pid, unsigned long *config)
 {
@@ -406,12 +407,42 @@ static struct pinctrl_gpio_range mv78460_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(2,  64, 64,  3),
 };
 
+static int armada_xp_pinctrl_suspend(struct platform_device *pdev,
+				     pm_message_t state)
+{
+	struct mvebu_pinctrl_soc_info *soc =
+		platform_get_drvdata(pdev);
+	int i, nregs;
+
+	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
+
+	for (i = 0; i < nregs; i++)
+		mpp_saved_regs[i] = readl(mpp_base + i * 4);
+
+	return 0;
+}
+
+static int armada_xp_pinctrl_resume(struct platform_device *pdev)
+{
+	struct mvebu_pinctrl_soc_info *soc =
+		platform_get_drvdata(pdev);
+	int i, nregs;
+
+	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
+
+	for (i = 0; i < nregs; i++)
+		writel(mpp_saved_regs[i], mpp_base + i * 4);
+
+	return 0;
+}
+
 static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_xp_pinctrl_info;
 	const struct of_device_id *match =
 		of_match_device(armada_xp_pinctrl_of_match, &pdev->dev);
 	struct resource *res;
+	int nregs;
 
 	if (!match)
 		return -ENODEV;
@@ -459,6 +490,13 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 		break;
 	}
 
+	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
+
+	mpp_saved_regs = devm_kmalloc(&pdev->dev, nregs * sizeof(u32),
+				      GFP_KERNEL);
+	if (!mpp_saved_regs)
+		return -ENOMEM;
+
 	pdev->dev.platform_data = soc;
 
 	return mvebu_pinctrl_probe(pdev);
@@ -476,6 +514,8 @@ static struct platform_driver armada_xp_pinctrl_driver = {
 	},
 	.probe = armada_xp_pinctrl_probe,
 	.remove = armada_xp_pinctrl_remove,
+	.suspend = armada_xp_pinctrl_suspend,
+	.resume = armada_xp_pinctrl_resume,
 };
 
 module_platform_driver(armada_xp_pinctrl_driver);
-- 
2.1.0
