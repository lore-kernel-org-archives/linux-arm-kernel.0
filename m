From: mw@semihalf.com (Marcin Wojtas)
Date: Sat, 17 Oct 2015 23:28:48 +0200
Subject: [PATCH] pinctrl: mvebu: armada-38x: add suspend/resume support
Message-ID: <1445117328-31678-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds suspend/resume support by saving and restoring registers'
state in a dedicated array.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 6ec82c6..094cb48 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -23,6 +23,7 @@
 #include "pinctrl-mvebu.h"
 
 static void __iomem *mpp_base;
+static u32 *mpp_saved_regs;
 
 static int armada_38x_mpp_ctrl_get(unsigned pid, unsigned long *config)
 {
@@ -424,6 +425,7 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 	const struct of_device_id *match =
 		of_match_device(armada_38x_pinctrl_of_match, &pdev->dev);
 	struct resource *res;
+	int nregs;
 
 	if (!match)
 		return -ENODEV;
@@ -441,11 +443,44 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 	soc->modes = armada_38x_mpp_modes;
 	soc->nmodes = armada_38x_mpp_controls[0].npins;
 
+	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
+
+	mpp_saved_regs = devm_kcalloc(&pdev->dev, nregs, sizeof(u32),
+				      GFP_KERNEL);
+	if (!mpp_saved_regs)
+		return -ENOMEM;
+
 	pdev->dev.platform_data = soc;
 
 	return mvebu_pinctrl_probe(pdev);
 }
 
+int armada_38x_pinctrl_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mvebu_pinctrl_soc_info *soc = platform_get_drvdata(pdev);
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
+int armada_38x_pinctrl_resume(struct platform_device *pdev)
+{
+	struct mvebu_pinctrl_soc_info *soc = platform_get_drvdata(pdev);
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
 static int armada_38x_pinctrl_remove(struct platform_device *pdev)
 {
 	return mvebu_pinctrl_remove(pdev);
@@ -458,6 +493,8 @@ static struct platform_driver armada_38x_pinctrl_driver = {
 	},
 	.probe = armada_38x_pinctrl_probe,
 	.remove = armada_38x_pinctrl_remove,
+	.suspend = armada_38x_pinctrl_suspend,
+	.resume = armada_38x_pinctrl_resume,
 };
 
 module_platform_driver(armada_38x_pinctrl_driver);
-- 
1.8.3.1
