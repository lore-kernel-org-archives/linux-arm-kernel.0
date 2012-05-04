From: b32955@freescale.com (Huang Shijie)
Date: Fri, 4 May 2012 11:13:02 +0800
Subject: [PATCH 2/2] mtd: gpmi: add gpmi support for mx6q
In-Reply-To: <1336101182-5200-1-git-send-email-b32955@freescale.com>
References: <1336101182-5200-1-git-send-email-b32955@freescale.com>
Message-ID: <1336101182-5200-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi support for mx6q.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig               |    2 +-
 drivers/mtd/nand/gpmi-nand/bch-regs.h  |   42 ++++++++++++++++++++++++-------
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   11 ++++----
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    4 +++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 +
 5 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7d17cec..bf0a28d 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -440,7 +440,7 @@ config MTD_NAND_NANDSIM
 
 config MTD_NAND_GPMI_NAND
         bool "GPMI NAND Flash Controller driver"
-        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
         help
 	 Enables NAND Flash support for IMX23 or IMX28.
 	 The GPMI controller is very powerful, with the help of BCH
diff --git a/drivers/mtd/nand/gpmi-nand/bch-regs.h b/drivers/mtd/nand/gpmi-nand/bch-regs.h
index 4effb8c..a092451 100644
--- a/drivers/mtd/nand/gpmi-nand/bch-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/bch-regs.h
@@ -51,15 +51,26 @@
 
 #define BP_BCH_FLASH0LAYOUT0_ECC0		12
 #define BM_BCH_FLASH0LAYOUT0_ECC0	(0xf << BP_BCH_FLASH0LAYOUT0_ECC0)
-#define BF_BCH_FLASH0LAYOUT0_ECC0(v)		\
-	(((v) << BP_BCH_FLASH0LAYOUT0_ECC0) & BM_BCH_FLASH0LAYOUT0_ECC0)
+#define MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0		11
+#define MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)
+#define BF_BCH_FLASH0LAYOUT0_ECC0(v, x)				\
+	(GPMI_IS_MX6Q(x)					\
+		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT0_ECC0)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT0_ECC0)	\
+		: (((v) << BP_BCH_FLASH0LAYOUT0_ECC0)		\
+			& BM_BCH_FLASH0LAYOUT0_ECC0)		\
+	)
 
 #define BP_BCH_FLASH0LAYOUT0_DATA0_SIZE		0
 #define BM_BCH_FLASH0LAYOUT0_DATA0_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
-#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v)	\
-	(((v) << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)\
-					 & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)
+#define MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE	\
+			(0x3ff << BP_BCH_FLASH0LAYOUT0_DATA0_SIZE)
+#define BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(v, x)				\
+	(GPMI_IS_MX6Q(x)						\
+		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)	\
+		: ((v) & BM_BCH_FLASH0LAYOUT0_DATA0_SIZE)		\
+	)
 
 #define HW_BCH_FLASH0LAYOUT1			0x00000090
 
@@ -72,13 +83,24 @@
 
 #define BP_BCH_FLASH0LAYOUT1_ECCN		12
 #define BM_BCH_FLASH0LAYOUT1_ECCN	(0xf << BP_BCH_FLASH0LAYOUT1_ECCN)
-#define BF_BCH_FLASH0LAYOUT1_ECCN(v)		\
-	(((v) << BP_BCH_FLASH0LAYOUT1_ECCN) & BM_BCH_FLASH0LAYOUT1_ECCN)
+#define MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN		11
+#define MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN	(0x1f << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)
+#define BF_BCH_FLASH0LAYOUT1_ECCN(v, x)				\
+	(GPMI_IS_MX6Q(x)					\
+		? (((v) << MX6Q_BP_BCH_FLASH0LAYOUT1_ECCN)	\
+			& MX6Q_BM_BCH_FLASH0LAYOUT1_ECCN)	\
+		: (((v) << BP_BCH_FLASH0LAYOUT1_ECCN)		\
+			& BM_BCH_FLASH0LAYOUT1_ECCN)		\
+	)
 
 #define BP_BCH_FLASH0LAYOUT1_DATAN_SIZE		0
 #define BM_BCH_FLASH0LAYOUT1_DATAN_SIZE		\
 			(0xfff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
-#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v)	\
-	(((v) << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE) \
-					 & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)
+#define MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE	\
+			(0x3ff << BP_BCH_FLASH0LAYOUT1_DATAN_SIZE)
+#define BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(v, x)				\
+	(GPMI_IS_MX6Q(x)						\
+		? (((v) >> 2) & MX6Q_BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)	\
+		: ((v) & BM_BCH_FLASH0LAYOUT1_DATAN_SIZE)		\
+	)
 #endif
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 5c55c71..a1f4332 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -224,13 +224,13 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	/* Configure layout 0. */
 	writel(BF_BCH_FLASH0LAYOUT0_NBLOCKS(block_count)
 			| BF_BCH_FLASH0LAYOUT0_META_SIZE(metadata_size)
-			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength)
-			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size),
+			| BF_BCH_FLASH0LAYOUT0_ECC0(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT0_DATA0_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT0);
 
 	writel(BF_BCH_FLASH0LAYOUT1_PAGE_SIZE(page_size)
-			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength)
-			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size),
+			| BF_BCH_FLASH0LAYOUT1_ECCN(ecc_strength, this)
+			| BF_BCH_FLASH0LAYOUT1_DATAN_SIZE(block_size, this),
 			r->bch_regs + HW_BCH_FLASH0LAYOUT1);
 
 	/* Set *all* chip selects to use layout 0. */
@@ -805,7 +805,8 @@ int gpmi_is_ready(struct gpmi_nand_data *this, unsigned chip)
 	if (GPMI_IS_MX23(this)) {
 		mask = MX23_BM_GPMI_DEBUG_READY0 << chip;
 		reg = readl(r->gpmi_regs + HW_GPMI_DEBUG);
-	} else if (GPMI_IS_MX28(this)) {
+	} else if (GPMI_IS_MX28(this) || GPMI_IS_MX6Q(this)) {
+		/* MX28 shares the same R/B register as MX6Q. */
 		mask = MX28_BF_GPMI_STAT_READY_BUSY(1 << chip);
 		reg = readl(r->gpmi_regs + HW_GPMI_STAT);
 	} else
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index c351137..4585fb0 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1510,6 +1510,7 @@ err_out:
 static const struct platform_device_id gpmi_ids[] = {
 	{ .name = "imx23-gpmi-nand", .driver_data = IS_MX23, },
 	{ .name = "imx28-gpmi-nand", .driver_data = IS_MX28, },
+	{ .name = "imx6q-gpmi-nand", .driver_data = IS_MX6Q, },
 	{},
 };
 
@@ -1520,6 +1521,9 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 	}, {
 		.compatible = "fsl,imx28-gpmi-nand",
 		.data = (void *)&gpmi_ids[IS_MX28]
+	}, {
+		.compatible = "fsl,imx6q-gpmi-nand",
+		.data = (void *)&gpmi_ids[IS_MX6Q]
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 12fdd77..ce5daa1 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -268,6 +268,8 @@ extern int gpmi_read_page(struct gpmi_nand_data *,
 /* Use the platform_id to distinguish different Archs. */
 #define IS_MX23			0x0
 #define IS_MX28			0x1
+#define IS_MX6Q			0x2
 #define GPMI_IS_MX23(x)		((x)->pdev->id_entry->driver_data == IS_MX23)
 #define GPMI_IS_MX28(x)		((x)->pdev->id_entry->driver_data == IS_MX28)
+#define GPMI_IS_MX6Q(x)		((x)->pdev->id_entry->driver_data == IS_MX6Q)
 #endif
-- 
1.7.0.4
