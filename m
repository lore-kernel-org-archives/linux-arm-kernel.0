From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 Jan 2013 14:04:07 +0800
Subject: [PATCH 1/2] mtd: gpmi: set the Golois Field bit for mx6q's BCH
Message-ID: <1359093848-22301-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GF13 can be only used in the following case:
    The ECC data chunk is less then 1K bytes.

In mx23/mx28, the ecc data chunk is 512 bytes. So it is okay.

But in mx6q, we begin to use some large nand chip whose ecc
data chunk maybe 1K bytes long.  So when the data chunk is 1K bytes,
we have to use the GF14.

This patch sets the Golois Field bit when the GF14 is needed.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/bch-regs.h  |   20 ++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    4 ++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    6 ++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
index d67bca5..588f537 100644
--- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
@@ -61,6 +61,16 @@
 			& BM_BCH_FLASH0LAYOUT0_ECC0)		\
 	)
 
+#define MX6Q_BP_BCH_FLASH0LAYOUT0_GF_13_14	10
+#define MX6Q_BM_BCH_FLASH0LAYOUT0_GF_13_14			\
+				(0x1 << MX6Q_BP_BCH_FLASH0LAYOUT0_GF_13_14)
+#define BF_BCH_FLASH0LAYOUT0_GF(v, x)				\
+	((GPMI_IS_MX6Q(x) && ((v) == 14))			\
+		? (((1) << MX6Q_BP_BCH_FLASH0LAYOUT0_GF_13_14)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT0_GF_13_14)	\
+		: 0						\
+	)
+
 #define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
 #define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
@@ -93,6 +103,16 @@
 			& BM_BCH_FLASH0LAYOUT1_ECCN)		\
 	)
 
+#define MX6Q_BP_BCH_FLASH0LAYOUT1_GF_13_14	10
+#define MX6Q_BM_BCH_FLASH0LAYOUT1_GF_13_14			\
+				(0x1 << MX6Q_BP_BCH_FLASH0LAYOUT1_GF_13_14)
+#define BF_BCH_FLASH0LAYOUT1_GF(v, x)				\
+	((GPMI_IS_MX6Q(x) && ((v) == 14))			\
+		? (((1) << MX6Q_BP_BCH_FLASH0LAYOUT1_GF_13_14)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT1_GF_13_14)	\
+		: 0						\
+	)
+
 #define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
 #define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 01cc570..4f8857f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -237,6 +237,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	unsigned int metadata_size;
 	unsigned int ecc_strength;
 	unsigned int page_size;
+	unsigned int gf_len;
 	int ret;
 
 	if (common_nfc_set_geometry(this))
@@ -247,6 +248,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	metadata_size = bch_geo->metadata_size;
 	ecc_strength  = bch_geo->ecc_strength >> 1;
 	page_size     = bch_geo->page_size;
+	gf_len        = bch_geo->gf_len;
 
 	ret = gpmi_enable_clk(this);
 	if (ret)
@@ -268,11 +270,13 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
 			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
 			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT0_GF(gf_len, this)
 			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
 
 	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
 			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT1_GF(gf_len, this)
 			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 38c8b8b..2521678 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -112,10 +112,12 @@ int common_nfc_set_geometry(struct gpmi_nand_data *this)
 	/* The default for the length of Galois Field. */
 	geo->gf_len = 13;
 
-	/* The default for chunk size. There is no oobsize greater then 512. */
+	/* The default for chunk size. */
 	geo->ecc_chunk_size = 512;
-	while (geo->ecc_chunk_size < mtd->oobsize)
+	while (geo->ecc_chunk_size < mtd->oobsize) {
 		geo->ecc_chunk_size *= 2; /* keep C >= O */
+		geo->gf_len = 14;
+	}
 
 	geo->ecc_chunk_count = mtd->writesize / geo->ecc_chunk_size;
 
-- 
1.7.0.4
