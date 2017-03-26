From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Mar 2017 14:27:25 +0200
Subject: [PATCH] mtd: physmap_of: really fix the physmap add-ons
Message-ID: <20170326122725.5594-1-linus.walleij@linaro.org>
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
The previous attempts to bake a single module from several *optional*
pieces doesn't play well with tristate, and if there is a way to
achieve that except making everything an #ifdef in the same file,
I sure haven't figured it out. I guess #include "physmap_addon.c"
directly into the C file would work but ugh that is ugly.
---
 drivers/mtd/maps/Makefile               | 8 ++------
 drivers/mtd/maps/physmap_of_gemini.c    | 2 ++
 drivers/mtd/maps/physmap_of_versatile.c | 2 ++
 3 files changed, 6 insertions(+), 6 deletions(-)

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
-- 
2.9.3
