From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 11:16:46 +0200
Subject: [PATCH] i2c: designware: fix platform driver probe rename
Message-ID: <4006973.dp9o3gm8C4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A function rename was incomplete and missed the !CONFIG_PM
case:

i2c-designware-platdrv.c:340:13: error: 'dw_i2c_plat_prepare' undeclared here (not in a function)
i2c-designware-platdrv.c:341:14: error: 'dw_i2c_plat_complete' undeclared here (not in a function)

This renames the macros accordingly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6ad6fde3970c ("i2c: designware: Rename platform driver probe and PM functions")
---
Found on ARM randconfig builds

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index f6b252a8ffd1..eb55760ccd9f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -307,8 +307,8 @@ static void dw_i2c_plat_complete(struct device *dev)
 		pm_request_resume(dev);
 }
 #else
-#define dw_i2c_prepare	NULL
-#define dw_i2c_complete	NULL
+#define dw_i2c_plat_prepare	NULL
+#define dw_i2c_plat_complete	NULL
 #endif
 
 #ifdef CONFIG_PM
