From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 12 Apr 2016 16:34:30 +0800
Subject: [PATCH] Revert "soc: mediatek: SCPSYS: Fix double enabling of
 regulators"
Message-ID: <1460450070-30556-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit cc8ed76938b5cf6a54ab3d60edabaf808dc960d1
("soc: mediatek: SCPSYS: Fix double enabling of regulators") [1].

This patch fixes mt8173-evb failing boot issue. With commit [1],
genpd state will not sync to real power domain state. So some
resources such as clocks and regulators may stay in a wrong state.

There is no regulator double enabling issue on mainline kernel, so
we can refert commit [1] safely.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 57e781c..837effe 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -491,13 +491,14 @@ static int scpsys_probe(struct platform_device *pdev)
 		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
 
 		/*
-		 * With CONFIG_PM disabled turn on all domains to make the
-		 * hardware usable.
+		 * Initially turn on all domains to make the domains usable
+		 * with !CONFIG_PM and to get the hardware in sync with the
+		 * software.  The unused domains will be switched off during
+		 * late_init time.
 		 */
-		if (!IS_ENABLED(CONFIG_PM))
-			genpd->power_on(genpd);
+		genpd->power_on(genpd);
 
-		pm_genpd_init(genpd, NULL, true);
+		pm_genpd_init(genpd, NULL, false);
 	}
 
 	/*
-- 
1.9.1
