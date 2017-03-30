From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Mar 2017 17:36:39 +0200
Subject: [PATCH v3] mtd: physmap_of: really fix the physmap add-ons
Message-ID: <20170330153639.26819-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current way of building the of_physmap add-ons result in just
the add-on being in the object code, and not the actual core
implementation and regress the Gemini and Versatile.

Bake the physmap_of.o object by baking physmap_of_core.o and
adding the Versatile and/or Gemini add-ons to the final object.
Rename the source file physmap_of_core.c to get the desired
build components.

Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 4f04f68e1598 ("mtd: physmap_of: fixup gemini/versatile dependencies")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Build and bake the final object in an elegant way suggested
  by Boris.
---
 drivers/mtd/maps/Makefile                            | 10 ++++------
 drivers/mtd/maps/{physmap_of.c => physmap_of_core.c} |  0
 2 files changed, 4 insertions(+), 6 deletions(-)
 rename drivers/mtd/maps/{physmap_of.c => physmap_of_core.c} (100%)

diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index aef1846b4de2..5a09a72ab112 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -17,12 +17,10 @@ obj-$(CONFIG_MTD_CK804XROM)	+= ck804xrom.o
 obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
 obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
-ifdef CONFIG_MTD_PHYSMAP_OF_VERSATILE
-physmap_of-objs += physmap_of_versatile.o
-endif
-ifdef CONFIG_MTD_PHYSMAP_OF_GEMINI
-physmap_of-objs += physmap_of_gemini.o
-endif
+physmap_of-objs-y		+= physmap_of_core.o
+physmap_of-objs-$(CONFIG_MTD_PHYSMAP_OF_VERSATILE) += physmap_of_versatile.o
+physmap_of-objs-$(CONFIG_MTD_PHYSMAP_OF_GEMINI) += physmap_of_gemini.o
+physmap_of-objs			:= $(physmap_of-objs-y)
 obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of_core.c
similarity index 100%
rename from drivers/mtd/maps/physmap_of.c
rename to drivers/mtd/maps/physmap_of_core.c
-- 
2.9.3
