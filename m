From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 27 Mar 2016 17:10:55 -0400
Subject: [PATCH 1/4] drivers/bus: make brcmstb_gisb.c driver explicitly
 non-modular
In-Reply-To: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1459113058-14340-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for this driver is currently:

config BRCMSTB_GISB_ARB
        bool "Broadcom STB GISB bus arbiter"

...meaning that it currently is not being built as a module by anyone.
Lets remove all modular references, so that when reading the driver
there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/brcmstb_gisb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f364fa4d24eb..319104b22ca4 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -13,7 +13,6 @@
 
 #include <linux/init.h>
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/sysfs.h>
@@ -408,5 +407,4 @@ static int __init brcm_gisb_driver_init(void)
 	return platform_driver_probe(&brcmstb_gisb_arb_driver,
 				     brcmstb_gisb_arb_probe);
 }
-
-module_init(brcm_gisb_driver_init);
+device_initcall(brcm_gisb_driver_init);
-- 
2.6.1
