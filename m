From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 29 Dec 2014 17:46:00 +0100
Subject: [PATCH] ARM: shmobile: R-Mobile: Remove !CONFIG_PM_RUNTIME section
Message-ID: <1419871560-8623-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit b2b49ccbdd547135 ("PM: Kconfig: Set PM_RUNTIME if PM_SLEEP
is selected"), CONFIG_PM_RUNTIME is always enabled if CONFIG_PM is
enabled, so this section is no longer needed.

As of commit 464ed18ebdb6236f ("PM: Eliminate CONFIG_PM_RUNTIME"),
CONFIG_PM_RUNTIME no longer exists, and this section will always be
executed, which may enable clocks that are not needed.

This reverts commit 64b0089e0c486736 ("ARM: shmobile: R-Mobile: Enable
module clocks if !CONFIG_PM_RUNTIME").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 64b0089e0c486736 is in renesas-dt-pm-for-v3.20
("[GIT PULL] Renesas ARM Based SoC DT PM Updates for v3.20")

On r8a7740/armadillo, without this patch the MSTP clocks for CEU20, FSI,
IIC[01], LCDC1, SCIFA[02-7], SCIFB, SY_DMAC[1-3], TPU0, and USB_DMAC are kept
running.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 3b9c8dd2a9cf3151..07fb4ea4d8e94258 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -135,14 +135,6 @@ static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
 		goto fail;
 	}
 
-	if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
-		error = pm_clk_resume(dev);
-		if (error) {
-			dev_err(dev, "pm_clk_resume failed %d\n", error);
-			goto fail;
-		}
-	}
-
 	return 0;
 
 fail:
-- 
1.9.1
