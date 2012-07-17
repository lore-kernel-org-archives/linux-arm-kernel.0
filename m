From: b32955@freescale.com (Huang Shijie)
Date: Tue, 17 Jul 2012 14:14:02 +0800
Subject: [PATCH v3] mtd: gpmi: fix the compiler warnings
In-Reply-To: <1342451569.7270.11.camel@brekeke>
References: <1342451569.7270.11.camel@brekeke>
Message-ID: <1342505642-31109-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix the compiler warnings.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
v2 --> v3:
         sorry, I missed the "set but not used" warnings.
	 This patch is based on the patch:
	  "[PATCH v4 2/2] mtd: gpmi: change the code for clocks".
v1 --> v2:
         fix the "no modifiers for allocation" warnings by the smatch
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    4 ++--
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   20 ++++++++------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    4 ++--
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 6bb0998..2289cf8 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -26,7 +26,7 @@
 #include "gpmi-regs.h"
 #include "bch-regs.h"
 
-struct timing_threshod timing_default_threshold = {
+static struct timing_threshod timing_default_threshold = {
 	.max_data_setup_cycles       = (BM_GPMI_TIMING0_DATA_SETUP >>
 						BP_GPMI_TIMING0_DATA_SETUP),
 	.internal_data_setup_in_ns   = 0,
@@ -738,7 +738,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
 	struct timing_threshod *nfc = &timing_default_threshold;
-	unsigned char  *gpmi_regs = r->gpmi_regs;
+	void __iomem *gpmi_regs = r->gpmi_regs;
 	unsigned int   clock_period_in_ns;
 	uint32_t       reg;
 	unsigned int   dll_wait_time_in_us;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 8c0d2f0..c46be6c 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -317,7 +317,7 @@ acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
 	struct platform_device *pdev = this->pdev;
 	struct resources *res = &this->resources;
 	struct resource *r;
-	void *p;
+	void __iomem *p;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
 	if (!r) {
@@ -424,8 +424,8 @@ static int __devinit acquire_dma_channels(struct gpmi_nand_data *this)
 	struct platform_device *pdev = this->pdev;
 	struct resource *r_dma;
 	struct device_node *dn;
-	int dma_channel;
-	unsigned int ret;
+	u32 dma_channel;
+	int ret;
 	struct dma_chan *dma_chan;
 	dma_cap_mask_t mask;
 
@@ -732,12 +732,12 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 	struct device *dev = this->dev;
 
 	/* [1] Allocate a command buffer. PAGE_SIZE is enough. */
-	this->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA);
+	this->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
 	if (this->cmd_buffer == NULL)
 		goto error_alloc;
 
 	/* [2] Allocate a read/write data buffer. PAGE_SIZE is enough. */
-	this->data_buffer_dma = kzalloc(PAGE_SIZE, GFP_DMA);
+	this->data_buffer_dma = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
 	if (this->data_buffer_dma == NULL)
 		goto error_alloc;
 
@@ -1260,7 +1260,6 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
 	unsigned int page;
-	loff_t byte;
 	uint8_t *buffer = chip->buffers->databuf;
 	int saved_chip_number;
 	int found_an_ncb_fingerprint = false;
@@ -1277,9 +1276,8 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	dev_dbg(dev, "Scanning for an NCB fingerprint...\n");
 
 	for (stride = 0; stride < search_area_size_in_strides; stride++) {
-		/* Compute the page and byte addresses. */
+		/* Compute the page addresses. */
 		page = stride * rom_geo->stride_size_in_pages;
-		byte = page   * mtd->writesize;
 
 		dev_dbg(dev, "Looking for a fingerprint in page 0x%x\n", page);
 
@@ -1321,7 +1319,6 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	unsigned int block;
 	unsigned int stride;
 	unsigned int page;
-	loff_t       byte;
 	uint8_t      *buffer = chip->buffers->databuf;
 	int saved_chip_number;
 	int status;
@@ -1370,9 +1367,8 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	/* Loop through the first search area, writing NCB fingerprints. */
 	dev_dbg(dev, "Writing NCB fingerprints...\n");
 	for (stride = 0; stride < search_area_size_in_strides; stride++) {
-		/* Compute the page and byte addresses. */
+		/* Compute the page addresses. */
 		page = stride * rom_geo->stride_size_in_pages;
-		byte = page   * mtd->writesize;
 
 		/* Write the first page of the current stride. */
 		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
@@ -1527,7 +1523,7 @@ static int gpmi_scan_bbt(struct mtd_info *mtd)
 	return nand_default_bbt(mtd);
 }
 
-void gpmi_nfc_exit(struct gpmi_nand_data *this)
+static void gpmi_nfc_exit(struct gpmi_nand_data *this)
 {
 	nand_release(&this->mtd);
 	gpmi_free_dma_buffer(this);
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 1547a60..1f61217 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -24,8 +24,8 @@
 
 #define GPMI_CLK_MAX 5 /* MX6Q needs five clocks */
 struct resources {
-	void          *gpmi_regs;
-	void          *bch_regs;
+	void __iomem  *gpmi_regs;
+	void __iomem  *bch_regs;
 	unsigned int  bch_low_interrupt;
 	unsigned int  bch_high_interrupt;
 	unsigned int  dma_low_channel;
-- 
1.7.0.4
