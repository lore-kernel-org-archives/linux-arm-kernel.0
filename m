From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 11:17:38 +0300
Subject: [PATCH v3 3/4] mtd: mxc_nand: fix truncate of unaligned oob copying
In-Reply-To: <cover.1431504091.git.baruch@tkos.co.il>
References: <cover.1431504091.git.baruch@tkos.co.il>
Message-ID: <a0876f2605899db96aa812b5aa4eceeb5d22ce1d.1431504091.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy to/from oob io area might not be aligned to 4 bytes. When 8 bit ECC is
used, the buffer size is 26. Add memcpy16_{to,from}io, and use them to avoid
truncating the buffer. Prefer memcpy32_{to,from}io when the buffer is properly
aligned for better performance.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   * Use memcpy16_{to,from}io (Uwe Kleine-K?nig)
---
 drivers/mtd/nand/mxc_nand.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 51c1600d7eb9..010be8aa41d4 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -281,12 +281,44 @@ static void memcpy32_fromio(void *trg, const void __iomem  *src, size_t size)
 		*t++ = __raw_readl(s++);
 }
 
+static void memcpy16_fromio(void *trg, const void __iomem  *src, size_t size)
+{
+	int i;
+	u16 *t = trg;
+	const __iomem u16 *s = src;
+
+	/* We assume that src (IO) is always 32bit aligned */
+	if (PTR_ALIGN(trg, 4) == trg && IS_ALIGNED(size, 4)) {
+		memcpy32_fromio(trg, src, size);
+		return;
+	}
+
+	for (i = 0; i < (size >> 1); i++)
+		*t++ = __raw_readw(s++);
+}
+
 static inline void memcpy32_toio(void __iomem *trg, const void *src, int size)
 {
 	/* __iowrite32_copy use 32bit size values so divide by 4 */
 	__iowrite32_copy(trg, src, size / 4);
 }
 
+static void memcpy16_toio(void __iomem *trg, const void *src, int size)
+{
+	int i;
+	__iomem u16 *t = trg;
+	const u16 *s = src;
+
+	/* We assume that trg (IO) is always 32bit aligned */
+	if (PTR_ALIGN(src, 4) == src && IS_ALIGNED(size, 4)) {
+		memcpy32_toio(trg, src, size);
+		return;
+	}
+
+	for (i = 0; i < (size >> 1); i++)
+		__raw_writew(*s++, t++);
+}
+
 static int check_int_v3(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
@@ -832,22 +864,22 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 
 	if (bfrom) {
 		for (i = 0; i < num_chunks - 1; i++)
-			memcpy32_fromio(d + i * oob_chunk_size,
+			memcpy16_fromio(d + i * oob_chunk_size,
 					s + i * sparebuf_size,
 					oob_chunk_size);
 
 		/* the last chunk */
-		memcpy32_fromio(d + i * oob_chunk_size,
+		memcpy16_fromio(d + i * oob_chunk_size,
 				s + i * sparebuf_size,
 				host->used_oobsize - i * oob_chunk_size);
 	} else {
 		for (i = 0; i < num_chunks - 1; i++)
-			memcpy32_toio(&s[i * sparebuf_size],
+			memcpy16_toio(&s[i * sparebuf_size],
 				      &d[i * oob_chunk_size],
 				      oob_chunk_size);
 
 		/* the last chunk */
-		memcpy32_toio(&s[oob_chunk_size * sparebuf_size],
+		memcpy16_toio(&s[oob_chunk_size * sparebuf_size],
 			      &d[i * oob_chunk_size],
 			      host->used_oobsize - i * oob_chunk_size);
 	}
-- 
2.1.4
