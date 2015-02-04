From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Feb 2015 14:52:46 +0100
Subject: [PATCH 3/3] drivers: sh: Disable PM runtime for multi-platform
 r8a73a4 with genpd
In-Reply-To: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
References: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1423057966-23321-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the default PM domain using PM_CLK is used for PM runtime, the real PM
domain(s) cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on an r8a73a4. The R-Mobile PM domain driver will take care of
PM runtime management of the module clocks.

The default PM domain is still needed for:
  - platforms without genpd support,
  - the legacy (non-DT) case, where genpd may take over later, except
    for the C5 "always on" PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 6b16a67ba618b793..89b7785de1fcf5b7 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -80,8 +80,8 @@ static int __init sh_pm_runtime_init(void)
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) {
 		if (!of_machine_is_compatible("renesas,emev2") &&
 		    !of_machine_is_compatible("renesas,r7s72100") &&
-		    !of_machine_is_compatible("renesas,r8a73a4") &&
 #ifndef CONFIG_PM_GENERIC_DOMAINS_OF
+		    !of_machine_is_compatible("renesas,r8a73a4") &&
 		    !of_machine_is_compatible("renesas,r8a7740") &&
 		    !of_machine_is_compatible("renesas,sh73a0") &&
 #endif
-- 
1.9.1
