From: b32955@freescale.com (Huang Shijie)
Date: Fri, 14 Jun 2013 16:06:22 +0800
Subject: [PATCH 1/4] mtd: gpmi: decouple the chip select from the DMA channel
In-Reply-To: <1371197185-27491-1-git-send-email-b32955@freescale.com>
References: <1371197185-27491-1-git-send-email-b32955@freescale.com>
Message-ID: <1371197185-27491-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decouple the chip select from the DMA channel, we use the DMA channel 0
to accecc all the nand devices.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    6 ++++++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 4f8857f..7d56d87 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -187,6 +187,12 @@ int gpmi_init(struct gpmi_nand_data *this)
 	/* Select BCH ECC. */
 	writel(BM_GPMI_CTRL1_BCH_MODE, r->gpmi_regs + HW_GPMI_CTRL1_SET);
 
+	/*
+	 * Decouple the chip select from dma channel. We use dma0 for all
+	 * the chips.
+	 */
+	writel(BM_GPMI_CTRL1_DECOUPLE_CS, r->gpmi_regs + HW_GPMI_CTRL1_SET);
+
 	gpmi_disable_clk(this);
 	return 0;
 err_out:
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
index 53397cc..82114cd 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
@@ -108,6 +108,9 @@
 #define HW_GPMI_CTRL1_CLR				0x00000068
 #define HW_GPMI_CTRL1_TOG				0x0000006c
 
+#define BP_GPMI_CTRL1_DECOUPLE_CS			24
+#define BM_GPMI_CTRL1_DECOUPLE_CS	(1 << BP_GPMI_CTRL1_DECOUPLE_CS)
+
 #define BP_GPMI_CTRL1_WRN_DLY_SEL			22
 #define BM_GPMI_CTRL1_WRN_DLY_SEL	(0x3 << BP_GPMI_CTRL1_WRN_DLY_SEL)
 #define BF_GPMI_CTRL1_WRN_DLY_SEL(v)  \
-- 
1.7.1
