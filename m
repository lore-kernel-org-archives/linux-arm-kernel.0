From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Wed, 8 Aug 2018 10:47:40 +0300
Subject: [PATCH] ARM: at91: pm: remove pm_bu initialization in
 at91_pm_backup_init()
Message-ID: <1533714460-6883-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to initialize pm_bu since it is used only if backup
mode is selected. In case backup mode initialization fails (which means
pm_bu is invalid) the ULP0 mode will be selected.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index c8ef696b83b6..901d6445964d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -577,8 +577,6 @@ static int __init at91_pm_backup_init(void)
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
 		return 0;
 
-	pm_bu = NULL;
-
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
 	if (!np) {
 		pr_warn("%s: failed to find sfrbu!\n", __func__);
@@ -587,7 +585,6 @@ static int __init at91_pm_backup_init(void)
 
 	pm_data.sfrbu = of_iomap(np, 0);
 	of_node_put(np);
-	pm_bu = NULL;
 
 	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
-- 
2.7.4
