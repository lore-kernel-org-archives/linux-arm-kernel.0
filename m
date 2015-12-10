From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:38 +0100
Subject: [PATCH v4 54/58] mtd: nand: kill the chip->flash_node field
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-55-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the nand_chip struct directly embeds an mtd_info struct we can
get rid of the ->flash_node field and forward set/get_flash_node requests
to the MTD layer.

As a side effect, we no longer need the mtd_set_of_node() call done in
nand_dt_init().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 3 ---
 include/linux/mtd/nand.h     | 7 ++-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index ae3fd2a..8bb8ebd6 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3945,9 +3945,6 @@ static int nand_dt_init(struct nand_chip *chip)
 	if (!dn)
 		return 0;
 
-	/* MTD can automatically handle DT partitions, etc. */
-	mtd_set_of_node(nand_to_mtd(chip), dn);
-
 	if (of_get_nand_bus_width(dn) == 16)
 		chip->options |= NAND_BUSWIDTH_16;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9cb7ace..2bee2e4 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -545,7 +545,6 @@ struct nand_buffers {
  *			flash device
  * @IO_ADDR_W:		[BOARDSPECIFIC] address to write the 8 I/O lines of the
  *			flash device.
- * @flash_node:		[BOARDSPECIFIC] device node describing this instance
  * @read_byte:		[REPLACEABLE] read one byte from the chip
  * @read_word:		[REPLACEABLE] read one word from the chip
  * @write_byte:		[REPLACEABLE] write a single byte to the chip on the
@@ -645,8 +644,6 @@ struct nand_chip {
 	void __iomem *IO_ADDR_R;
 	void __iomem *IO_ADDR_W;
 
-	struct device_node *flash_node;
-
 	uint8_t (*read_byte)(struct mtd_info *mtd);
 	u16 (*read_word)(struct mtd_info *mtd);
 	void (*write_byte)(struct mtd_info *mtd, uint8_t byte);
@@ -724,12 +721,12 @@ struct nand_chip {
 static inline void nand_set_flash_node(struct nand_chip *chip,
 				       struct device_node *np)
 {
-	chip->flash_node = np;
+	mtd_set_of_node(&chip->mtd, np);
 }
 
 static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
 {
-	return chip->flash_node;
+	return mtd_get_of_node(&chip->mtd);
 }
 
 static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
-- 
2.1.4
