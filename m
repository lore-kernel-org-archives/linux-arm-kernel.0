From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:20:02 +0000
Subject: [RFC 45/47] mtd: nand: stm_nand_bch: read and write buffers (FLEX)
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-46-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read or write in 4 Byte chunks at a time until there is less than
8 Bytes remaining, at which point split down into reading the
reset a single Byte at a time.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index f5b0a00..975326e 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -686,6 +686,75 @@ static void flex_addr(struct nandi_controller *nandi,
 	writel(addr, nandi->base + NANDHAM_FLEX_ADD);
 }
 
+static void flex_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct nandi_controller *nandi = chip->priv;
+	int aligned;
+
+	emiss_nandi_select(STM_NANDI_HAMMING);
+
+	/* Read bytes until buf is 4-byte aligned */
+	while (len && ((unsigned int)buf & 0x3)) {
+		*buf++ = (uint8_t)(readl(nandi->base + NANDHAM_FLEX_DATA)
+				   & 0xff);
+		len--;
+	};
+
+	/* Use 'BEATS_4'/readsl */
+	if (len > 8) {
+		aligned = len & ~0x3;
+		writel(FLEX_DATA_CFG_BEATS_4 | FLEX_DATA_CFG_CSN,
+		       nandi->base + NANDHAM_FLEX_DATAREAD_CONFIG);
+
+		readsl(nandi->base + NANDHAM_FLEX_DATA, buf, aligned >> 2);
+
+		buf += aligned;
+		len -= aligned;
+
+		writel(FLEX_DATA_CFG_BEATS_1 | FLEX_DATA_CFG_CSN,
+		       nandi->base + NANDHAM_FLEX_DATAREAD_CONFIG);
+	}
+
+	/* Mop up remaining bytes */
+	while (len > 0) {
+		*buf++ = (uint8_t)(readl(nandi->base + NANDHAM_FLEX_DATA)
+				   & 0xff);
+		len--;
+	}
+}
+
+static void flex_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct nandi_controller *nandi = chip->priv;
+	int aligned;
+
+	/* Write bytes until buf is 4-byte aligned */
+	while (len && ((unsigned int)buf & 0x3)) {
+		writel(*buf++, nandi->base + NANDHAM_FLEX_DATA);
+		len--;
+	};
+
+	/* USE 'BEATS_4/writesl */
+	if (len > 8) {
+		aligned = len & ~0x3;
+		writel(FLEX_DATA_CFG_BEATS_4 | FLEX_DATA_CFG_CSN,
+		       nandi->base + NANDHAM_FLEX_DATAWRITE_CONFIG);
+		writesl(nandi->base + NANDHAM_FLEX_DATA, buf, aligned >> 2);
+		buf += aligned;
+		len -= aligned;
+		writel(FLEX_DATA_CFG_BEATS_1 | FLEX_DATA_CFG_CSN,
+		       nandi->base + NANDHAM_FLEX_DATAWRITE_CONFIG);
+	}
+
+	/* Mop up remaining bytes */
+	while (len > 0) {
+		writel(*buf++, nandi->base + NANDHAM_FLEX_DATA);
+		len--;
+	}
+}
+
 /*
  * Hamming-FLEX operations (optimised replacements for nand_base.c versions)
  */
@@ -1743,6 +1812,9 @@ static void nandi_set_mtd_defaults(struct nandi_controller *nandi,
 	chip->priv = nandi;
 	chip->ecc.layout = &info->ecclayout;
 
+	chip->read_buf = flex_read_buf;
+	chip->write_buf = flex_write_buf;
+
 	chip->bbt_options |= NAND_BBT_USE_FLASH;
 
 	/* mtd_info */
-- 
1.8.3.2
