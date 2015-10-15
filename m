From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Oct 2015 09:17:31 +0200
Subject: [PATCH v3 4/4] mtd: pxa3xx_nand: clean up the pxa3xx timings
In-Reply-To: <1444893451-16610-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444893451-16610-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444893451-16610-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the previous modifications, lots of pxa3xx specific definitions can
be removed.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c                | 20 ++++++++------------
 include/linux/platform_data/mtd-nand-pxa3xx.h | 11 +++--------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 45e5e660d421..ac197ca4ad5b 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -260,15 +260,14 @@ static struct pxa3xx_nand_timing timing[] = {
 };
 
 static struct pxa3xx_nand_flash builtin_flash_types[] = {
-{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, &timing[0] },
-{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1] },
-{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1] },
-{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },
-{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2] },
-{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2] },
-{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
-{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
-{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
+	{ 0x46ec, 16, 16, &timing[1] },
+	{ 0xdaec,  8,  8, &timing[1] },
+	{ 0xd7ec,  8,  8, &timing[1] },
+	{ 0xa12c,  8,  8, &timing[2] },
+	{ 0xb12c, 16, 16, &timing[2] },
+	{ 0xdc2c,  8,  8, &timing[2] },
+	{ 0xcc2c, 16, 16, &timing[2] },
+	{ 0xba20, 16, 16, &timing[3] },
 };
 
 static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
@@ -329,9 +328,6 @@ static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
 	.oobfree = { }
 };
 
-/* Define a default flash type setting serve as flash detecting only */
-#define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
diff --git a/include/linux/platform_data/mtd-nand-pxa3xx.h b/include/linux/platform_data/mtd-nand-pxa3xx.h
index ac4ea2e641c7..25538cfeee26 100644
--- a/include/linux/platform_data/mtd-nand-pxa3xx.h
+++ b/include/linux/platform_data/mtd-nand-pxa3xx.h
@@ -17,15 +17,10 @@ struct pxa3xx_nand_timing {
 };
 
 struct pxa3xx_nand_flash {
-	char		*name;
 	uint32_t	chip_id;
-	unsigned int	page_per_block; /* Pages per block (PG_PER_BLK) */
-	unsigned int	page_size;	/* Page size in bytes (PAGE_SZ) */
-	unsigned int	flash_width;	/* Width of Flash memory (DWIDTH_M) */
-	unsigned int	dfc_width;	/* Width of flash controller(DWIDTH_C) */
-	unsigned int	num_blocks;	/* Number of physical blocks in Flash */
-
-	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
+	unsigned int	flash_width;    /* Width of Flash memory (DWIDTH_M) */
+	unsigned int	dfc_width;      /* Width of flash controller(DWIDTH_C) */
+	struct pxa3xx_nand_timing *timing; /* NAND Flash timing */
 };
 
 /*
-- 
2.6.1
