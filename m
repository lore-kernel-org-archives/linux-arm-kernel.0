From: rogerq@ti.com (Roger Quadros)
Date: Wed, 1 Oct 2014 14:33:29 +0300
Subject: [PATCH v2 1/2] mtd: nand: Force omap_elm to be built as a module if
 omap2_nand is a module
In-Reply-To: <1412163210-12948-1-git-send-email-rogerq@ti.com>
References: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Message-ID: <1412163210-12948-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

This commit adds a hidden option to build the omap_elm as a module, if
omap2_nand is a module (and similarly in the built-in case).

This fixes the following build error when omap2_nand is chosen built-in,
and omap_elm is chosen as a module:

drivers/built-in.o: In function `omap_nand_probe':
drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
drivers/built-in.o: In function `omap_elm_correct_data':
drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bch_error_page'

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/Kconfig  | 5 ++++-
 drivers/mtd/nand/Makefile | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f1cf503..1cb4b1b 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -96,7 +96,7 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND_OMAP2
-	tristate "Support hardware based BCH error correction"
+	bool "Support hardware based BCH error correction"
 	default n
 	select BCH
 	help
@@ -106,6 +106,9 @@ config MTD_NAND_OMAP_BCH
 	  legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
 	  so they should not enable this config symbol.
 
+config MTD_NAND_OMAP_BCH_BUILD
+	def_tristate MTD_NAND_OMAP2 && MTD_NAND_OMAP_BCH
+
 config MTD_NAND_IDS
 	tristate
 
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b3237b7..9c847e4 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
 obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2.o
-obj-$(CONFIG_MTD_NAND_OMAP_BCH)		+= omap_elm.o
+obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
 obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
-- 
1.8.3.2
