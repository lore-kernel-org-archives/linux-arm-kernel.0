From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jan 2016 13:39:25 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: Fix double enabling of regulators
Message-ID: <1453466365-24406-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_PM enabled do not call genpd->power_on manually as this
will cause the regulators being turned on once in SCPSYS probe and
then again when the genpd core turns on the domains. Instead, call
genpd->power_on only with CONFIG_PM disabled and tell the genpd core
that the domains are disabled when registered.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/soc/mediatek/mtk-scpsys.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 0221387..78227db 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -500,14 +500,13 @@ static int __init scpsys_probe(struct platform_device *pdev)
 		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
 
 		/*
-		 * Initially turn on all domains to make the domains usable
-		 * with !CONFIG_PM and to get the hardware in sync with the
-		 * software.  The unused domains will be switched off during
-		 * late_init time.
+		 * With CONFIG_PM disabled turn on all domains to make the
+		 * hardware usable.
 		 */
-		genpd->power_on(genpd);
+		if (!IS_ENABLED(CONFIG_PM))
+			genpd->power_on(genpd);
 
-		pm_genpd_init(genpd, NULL, false);
+		pm_genpd_init(genpd, NULL, true);
 	}
 
 	/*
-- 
2.7.0.rc3
