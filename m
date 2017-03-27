From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 17:16:58 +0200
Subject: [PATCH v2] mtd: physmap_of: really fix the physmap add-ons
Message-ID: <20170327151658.6175-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way of building the of_physmap add-ons result in just
the add-on being in the object code, and not the actual core
implementation and regress the Gemini and Versatile.

There is no way around exporting these functions. If they are
built as modules, they will become modules with exported functions,
if they are builtins they will become builtins.

Fixes: 4f04f68e1598 ("mtd: physmap_of: fixup gemini/versatile dependencies")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make the Kconfig entries tristate so they can follow the config
  of the main code portions.
- Use the IS_ENABLED() macro from <linux/kconfig.h> to determine
  whether a certain function is available for builtin OR module.
  This is finally the silver bullet: allyes and allmod builds
  fine on x86_64.
---
 drivers/mtd/maps/Kconfig                | 4 ++--
 drivers/mtd/maps/Makefile               | 8 ++------
 drivers/mtd/maps/physmap_of_gemini.c    | 2 ++
 drivers/mtd/maps/physmap_of_gemini.h    | 3 ++-
 drivers/mtd/maps/physmap_of_versatile.c | 2 ++
 drivers/mtd/maps/physmap_of_versatile.h | 3 ++-
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 542fdf8e81fa..a4fa2f725d33 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -75,7 +75,7 @@ config MTD_PHYSMAP_OF
 	  taken from OF device tree.
 
 config MTD_PHYSMAP_OF_VERSATILE
-	bool "ARM Versatile OF-based physical memory map handling"
+	tristate "ARM Versatile OF-based physical memory map handling"
 	depends on MTD_PHYSMAP_OF
 	depends on MFD_SYSCON
 	default y if (ARCH_INTEGRATOR || ARCH_VERSATILE || ARCH_REALVIEW)
@@ -85,7 +85,7 @@ config MTD_PHYSMAP_OF_VERSATILE
 	  the flash can be taken out of write protection.
 
 config MTD_PHYSMAP_OF_GEMINI
-	bool "Cortina Gemini OF-based physical memory map handling"
+	tristate "Cortina Gemini OF-based physical memory map handling"
 	depends on MTD_PHYSMAP_OF
 	depends on MFD_SYSCON
 	default ARCH_GEMINI
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index aef1846b4de2..608bdd37ac99 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -17,12 +17,8 @@ obj-$(CONFIG_MTD_CK804XROM)	+= ck804xrom.o
 obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
 obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
-ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
-physmap_of-objs += physmap_of_versatile.o
-endif
-ifdef CONFIG_MTD_PHYSMAP_OF_GEMINI
-physmap_of-objs += physmap_of_gemini.o
-endif
+obj-$(CONFIG_MTD_PHYSMAP_OF_VERSATILE) += physmap_of_versatile.o
+obj-$(CONFIG_MTD_PHYSMAP_OF_GEMINI) += physmap_of_gemini.o
 obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
index 9d371cd728ea..616f162c4da1 100644
--- a/drivers/mtd/maps/physmap_of_gemini.c
+++ b/drivers/mtd/maps/physmap_of_gemini.c
@@ -6,6 +6,7 @@
  * detect and set it up when booting on this platform.
  */
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/mtd/map.h>
@@ -115,3 +116,4 @@ int of_flash_probe_gemini(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(of_flash_probe_gemini);
diff --git a/drivers/mtd/maps/physmap_of_gemini.h b/drivers/mtd/maps/physmap_of_gemini.h
index c675025288dd..99eaa8637f79 100644
--- a/drivers/mtd/maps/physmap_of_gemini.h
+++ b/drivers/mtd/maps/physmap_of_gemini.h
@@ -1,7 +1,8 @@
 #include <linux/of.h>
 #include <linux/mtd/map.h>
+#include <linux/kconfig.h>
 
-#ifdef CONFIG_MTD_PHYSMAP_OF_GEMINI
+#if IS_ENABLED(CONFIG_MTD_PHYSMAP_OF_GEMINI)
 int of_flash_probe_gemini(struct platform_device *pdev,
 			  struct device_node *np,
 			  struct map_info *map);
diff --git a/drivers/mtd/maps/physmap_of_versatile.c b/drivers/mtd/maps/physmap_of_versatile.c
index 8c6ccded9be8..0583876bc053 100644
--- a/drivers/mtd/maps/physmap_of_versatile.c
+++ b/drivers/mtd/maps/physmap_of_versatile.c
@@ -21,6 +21,7 @@
  */
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -252,3 +253,4 @@ int of_flash_probe_versatile(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(of_flash_probe_versatile);
diff --git a/drivers/mtd/maps/physmap_of_versatile.h b/drivers/mtd/maps/physmap_of_versatile.h
index 5b86f6dc6b3d..f4b5fa7476ac 100644
--- a/drivers/mtd/maps/physmap_of_versatile.h
+++ b/drivers/mtd/maps/physmap_of_versatile.h
@@ -1,7 +1,8 @@
 #include <linux/of.h>
 #include <linux/mtd/map.h>
+#include <linux/kconfig.h>
 
-#ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
+#if IS_ENABLED(CONFIG_MTD_PHYSMAP_OF_VERSATILE)
 int of_flash_probe_versatile(struct platform_device *pdev,
 			     struct device_node *np,
 			     struct map_info *map);
-- 
2.9.3
