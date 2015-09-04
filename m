From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 4 Sep 2015 12:05:12 +0800
Subject: [PATCH] soc: mediatek: Move the initial setting of pmic wrap
 interrupt before requesting irq.
Message-ID: <1441339512-15510-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seperate the initialization of pmic wrap interrupt from pmic wrap init to make sure setting is correct before requesting irq.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index f432291..c91d629 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -725,10 +725,6 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 0x1, PWRAP_WACS2_EN);
 	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
 	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
-	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
-	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
-	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
-	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
 
 	if (pwrap_is_mt8135(wrp)) {
 		/* enable pwrap events and pwrap bridge in AP side */
@@ -896,6 +892,16 @@ static int pwrap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * watch dog@pwrap,
+	 * The bootloader may not initial the wdt/interrupt setting of pwrap,
+	 * set it before reguesting the irq.
+	 */
+	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
+	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
+	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
+	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
+
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt, IRQF_TRIGGER_HIGH,
 			"mt-pmic-pwrap", wrp);
-- 
1.8.1.1.dirty
