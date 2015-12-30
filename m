From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 30 Dec 2015 20:36:01 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: Enable STAUPD_PRD before WDT_SRC_EN
 enabled.
Message-ID: <1451478961-5668-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STAUPD_TRIG will be enable when WDT_INT enable on probe function, if
doesn't enable STAUPD_PRD together, interrupt will be triggered because
STAUPD timeout. To avoid unexpected interrupt, enable periodic status
update which will be updated to PMIC every selected time period.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a8cde17..6e5c20f 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -904,6 +904,11 @@ static int pwrap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * Enable periodic status update which will be updated to PMIC
+	 * every selected time period.
+	 */
+	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
 	/* Initialize watchdog, may not be done by the bootloader */
 	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
 	pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
-- 
1.9.1
