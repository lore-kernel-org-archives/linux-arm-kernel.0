From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 9 May 2013 15:34:54 +0800
Subject: [PATCH 1/2] atmel_nand: at91/avr32/: Replace cpu_is_at32ap7000() with
 a nand platform data
In-Reply-To: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
References: <1368084895-18266-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1368084895-18266-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand driver use cpu_is_at32ap7000() macro for a workaround. For the
multi-platform support, we will remove this cpu_is_xxx() macro.

This patch adds a boolean variable need_reset_workaround in structure
atmel_nand_data. Using this variable we can remove cpu_is_at32ap7000() macro.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/avr32/mach-at32ap/at32ap700x.c |    3 +++
 drivers/mtd/nand/atmel_nand.c       |   13 ++++++-------
 include/linux/platform_data/atmel.h |    3 +++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index b323d8d..697ef58 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1979,6 +1979,9 @@ at32_add_device_nand(unsigned int id, struct atmel_nand_data *data)
 				ARRAY_SIZE(smc_cs3_resource)))
 		goto fail;
 
+	/* For at32ap7000, we use the reset workaround for nand driver */
+	data->need_reset_workaround = true;
+
 	if (platform_device_add_data(pdev, data,
 				sizeof(struct atmel_nand_data)))
 		goto fail;
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2d23d29..7bf912b 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1174,10 +1174,9 @@ static int atmel_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	 * Workaround: Reset the parity registers before reading the
 	 * actual data.
 	 */
-	if (cpu_is_at32ap7000()) {
-		struct atmel_nand_host *host = chip->priv;
+	struct atmel_nand_host *host = chip->priv;
+	if (host->board.need_reset_workaround)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
-	}
 
 	/* read the page */
 	chip->read_buf(mtd, p, eccsize);
@@ -1298,11 +1297,11 @@ static int atmel_nand_correct(struct mtd_info *mtd, u_char *dat,
  */
 static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 {
-	if (cpu_is_at32ap7000()) {
-		struct nand_chip *nand_chip = mtd->priv;
-		struct atmel_nand_host *host = nand_chip->priv;
+	struct nand_chip *nand_chip = mtd->priv;
+	struct atmel_nand_host *host = nand_chip->priv;
+
+	if (host->board.need_reset_workaround)
 		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
-	}
 }
 
 #if defined(CONFIG_OF)
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 6a293b7..59f558d 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -71,6 +71,9 @@ struct atmel_nand_data {
 	u8		on_flash_bbt;		/* bbt on flash */
 	struct mtd_partition *parts;
 	unsigned int	num_parts;
+
+	/* default is false, only for at32ap7000 chip is true */
+	bool		need_reset_workaround;
 };
 
  /* Serial */
-- 
1.7.9.5
