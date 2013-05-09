From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 May 2013 15:34:55 +0800
Subject: [PATCH 2/2] mtd: atmel_nand: add a new dt binding item for nand dma
 support
In-Reply-To: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
References: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1368084895-18266-3-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will set the nand dma support in dts. Since we will not use
cpu_is_xxx() in nand driver. We needn't include the mach/cpu.h any more.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 .../devicetree/bindings/mtd/atmel-nand.txt         |    1 +
 drivers/mtd/nand/atmel_nand.c                      |   11 +++--------
 include/linux/platform_data/atmel.h                |    1 +
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index d555421..b6eb484 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -15,6 +15,7 @@ Required properties:
   optional gpio and may be set to 0 if not present.
 
 Optional properties:
+- atmel,nand-has-dma : boolean to support dma transfer for nand read/write.
 - nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
   Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
   "soft_bch".
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 7bf912b..61d3869 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -43,8 +43,6 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/pinctrl/consumer.h>
 
-#include <mach/cpu.h>
-
 static int use_dma = 1;
 module_param(use_dma, int, 0);
 
@@ -128,11 +126,6 @@ struct atmel_nand_host {
 
 static struct nand_ecclayout atmel_pmecc_oobinfo;
 
-static int cpu_has_dma(void)
-{
-	return cpu_is_at91sam9rl() || cpu_is_at91sam9g45();
-}
-
 /*
  * Enable NAND.
  */
@@ -1336,6 +1329,8 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 
 	board->on_flash_bbt = of_get_nand_on_flash_bbt(np);
 
+	board->has_dma = of_property_read_bool(np, "atmel,nand-has-dma");
+
 	if (of_get_nand_bus_width(np) == 16)
 		board->bus_width_16 = 1;
 
@@ -1600,7 +1595,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 	}
 
-	if (!cpu_has_dma())
+	if (!host->board.has_dma)
 		use_dma = 0;
 
 	if (use_dma) {
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 59f558d..cea9f70 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -71,6 +71,7 @@ struct atmel_nand_data {
 	u8		on_flash_bbt;		/* bbt on flash */
 	struct mtd_partition *parts;
 	unsigned int	num_parts;
+	bool		has_dma;		/* support dma transfer */
 
 	/* default is false, only for at32ap7000 chip is true */
 	bool		need_reset_workaround;
-- 
1.7.9.5
