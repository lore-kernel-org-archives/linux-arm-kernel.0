From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 11:17:36 +0300
Subject: [PATCH v3 1/4] mtd: nand: mxc_nand: cleanup copy_spare function
In-Reply-To: <cover.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
Message-ID: <8d9838f27db99f5a9f4b9a95e7aab23773b54217.1431504091.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

To give people without the reference manual at hand a chance to
understand how spare area is handled in the i.MX nand controller,
improve commenting, naming of variables and coding style.

No functional change intended.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
[baruch: declare oob_chunk_size; update comments; reword commit log]
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mtd/nand/mxc_nand.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 372e0e38f59b..33b22b9c0b30 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -807,32 +807,48 @@ static void mxc_nand_select_chip_v2(struct mtd_info *mtd, int chip)
 }
 
 /*
- * Function to transfer data to/from spare area.
+ * The controller splits a page into data chunks of 512 bytes + partial oob.
+ * There are writesize / 512 such chunks, the size of the partial oob parts is
+ * oobsize / #chunks rounded down to a multiple of 2. The last oob chunk then
+ * contains additionally the byte lost by rounding (if any).
+ * This function handles the needed shuffling between host->data_buf (which
+ * holds a page in natural order, i.e. writesize bytes data + oobsize bytes
+ * spare) and the NFC buffer.
  */
 static void copy_spare(struct mtd_info *mtd, bool bfrom)
 {
 	struct nand_chip *this = mtd->priv;
 	struct mxc_nand_host *host = this->priv;
-	u16 i, j;
-	u16 n = mtd->writesize >> 9;
+	u16 i, oob_chunk_size;
+	u16 num_chunks = mtd->writesize / 512;
+
 	u8 *d = host->data_buf + mtd->writesize;
 	u8 __iomem *s = host->spare0;
-	u16 t = host->devtype_data->spare_len;
+	u16 sparebuf_size = host->devtype_data->spare_len;
 
-	j = (mtd->oobsize / n >> 1) << 1;
+	/* size of oob chunk for all but possibly the last one */
+	oob_chunk_size = (mtd->oobsize / num_chunks) & ~1;
 
 	if (bfrom) {
-		for (i = 0; i < n - 1; i++)
-			memcpy32_fromio(d + i * j, s + i * t, j);
-
-		/* the last section */
-		memcpy32_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
+		for (i = 0; i < num_chunks - 1; i++)
+			memcpy32_fromio(d + i * oob_chunk_size,
+					s + i * sparebuf_size,
+					oob_chunk_size);
+
+		/* the last chunk */
+		memcpy32_fromio(d + i * oob_chunk_size,
+				s + i * sparebuf_size,
+				mtd->oobsize - i * oob_chunk_size);
 	} else {
-		for (i = 0; i < n - 1; i++)
-			memcpy32_toio(&s[i * t], &d[i * j], j);
-
-		/* the last section */
-		memcpy32_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
+		for (i = 0; i < num_chunks - 1; i++)
+			memcpy32_toio(&s[i * sparebuf_size],
+				      &d[i * oob_chunk_size],
+				      oob_chunk_size);
+
+		/* the last chunk */
+		memcpy32_toio(&s[oob_chunk_size * sparebuf_size],
+			      &d[i * oob_chunk_size],
+			      mtd->oobsize - i * oob_chunk_size);
 	}
 }
 
-- 
2.1.4
