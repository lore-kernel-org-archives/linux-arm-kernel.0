From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 11:17:37 +0300
Subject: [PATCH v3 2/4] mtd: mxc_nand: limit the size of used oob
In-Reply-To: <cover.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
Message-ID: <6edf6c3df2371522cb43ab864272e560176b0d5b.1431504091.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For 4k pages the i.MX NFC hardware uses no more than 218 bytes for 8bit ECC
data. Larger oobsize confuses the logic of copy_spare(). Limit the size of used
oob size to avoid that.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   * Move used_oobsize into struct mxc_nand_host, and initialize it from
     _probe() (Uwe Kleine-K?nig)
   * Add a more details to in-code comment
---
 drivers/mtd/nand/mxc_nand.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 33b22b9c0b30..51c1600d7eb9 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -189,6 +189,7 @@ struct mxc_nand_host {
 	int			clk_act;
 	int			irq;
 	int			eccsize;
+	int			used_oobsize;
 	int			active_cs;
 
 	struct completion	op_completion;
@@ -827,7 +828,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 	u16 sparebuf_size = host->devtype_data->spare_len;
 
 	/* size of oob chunk for all but possibly the last one */
-	oob_chunk_size = (mtd->oobsize / num_chunks) & ~1;
+	oob_chunk_size = (host->used_oobsize / num_chunks) & ~1;
 
 	if (bfrom) {
 		for (i = 0; i < num_chunks - 1; i++)
@@ -838,7 +839,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 		/* the last chunk */
 		memcpy32_fromio(d + i * oob_chunk_size,
 				s + i * sparebuf_size,
-				mtd->oobsize - i * oob_chunk_size);
+				host->used_oobsize - i * oob_chunk_size);
 	} else {
 		for (i = 0; i < num_chunks - 1; i++)
 			memcpy32_toio(&s[i * sparebuf_size],
@@ -848,7 +849,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 		/* the last chunk */
 		memcpy32_toio(&s[oob_chunk_size * sparebuf_size],
 			      &d[i * oob_chunk_size],
-			      mtd->oobsize - i * oob_chunk_size);
+			      host->used_oobsize - i * oob_chunk_size);
 	}
 }
 
@@ -1606,6 +1607,15 @@ static int mxcnd_probe(struct platform_device *pdev)
 	else if (mtd->writesize == 4096)
 		this->ecc.layout = host->devtype_data->ecclayout_4k;
 
+	/*
+	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
+	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
+	 * into copying invalid data to/from the spare IO buffer, as this
+	 * might cause ECC data corruption when doing sub-page write to a
+	 * partially written page.
+	 */
+	host->used_oobsize = min(mtd->oobsize, 218U);
+
 	if (this->ecc.mode == NAND_ECC_HW) {
 		if (is_imx21_nfc(host) || is_imx27_nfc(host))
 			this->ecc.strength = 1;
-- 
2.1.4
