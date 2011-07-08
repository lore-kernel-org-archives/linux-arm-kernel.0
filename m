From: leiwen@marvell.com (Lei Wen)
Date: Fri, 08 Jul 2011 16:00:09 -0000
Subject: [PATCH] MTD: pxa3xx_nand: enable multiple chip select support
Message-ID: <1308712645-5986-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current pxa3xx_nand controller has two chip select which
both be workable. This patch enable this feature.

Update platform driver to support this feature.

Another notice should be taken that:
When you want to use this feature, you should not enable the
keep configuration feature, for two chip select could be
attached with different nand chip. The different page size
and timing requirement make the keep configuration impossible.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c                 |    5 +-
 arch/arm/mach-pxa/cm-x300.c                  |    5 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
 arch/arm/mach-pxa/littleton.c                |    5 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
 arch/arm/mach-pxa/raumfeld.c                 |    5 +-
 arch/arm/mach-pxa/zylonite.c                 |    5 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    8 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  735 +++++++++++++++-----------
 9 files changed, 444 insertions(+), 338 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..b6589d6 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -167,8 +167,9 @@ static struct mtd_partition aspenite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= aspenite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
+	.cs_num = 1,
+	.parts[0]	= aspenite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
 };
 
 static struct i2c_board_info aspenite_i2c_info[] __initdata = {
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index b2248e7..d67eb7b 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -423,8 +423,9 @@ static struct mtd_partition cm_x300_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data cm_x300_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= cm_x300_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(cm_x300_nand_partitions),
+	.cs_num		= 1,
+	.parts[0]	= cm_x300_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(cm_x300_nand_partitions),
 };
 
 static void __init cm_x300_init_nand(void)
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 3f9be41..ff7a07b 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -139,8 +139,9 @@ static struct mtd_partition colibri_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data colibri_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= colibri_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(colibri_nand_partitions),
+	.cs_num		= 1,
+	.parts[0]	= colibri_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(colibri_nand_partitions),
 };
 
 void __init colibri_pxa3xx_init_nand(void)
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index e5e326d..6eaf852 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -325,8 +325,9 @@ static struct mtd_partition littleton_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data littleton_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= littleton_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(littleton_nand_partitions),
+	.cs_num		= 1,
+	.parts[0]	= littleton_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(littleton_nand_partitions),
 };
 
 static void __init littleton_init_nand(void)
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index b5a8fd3..e7ce135 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -389,10 +389,11 @@ static struct mtd_partition mxm_8x10_nand_partitions[] = {
 };
 
 static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
-	.enable_arbiter = 1,
-	.keep_config = 1,
-	.parts = mxm_8x10_nand_partitions,
-	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions)
+	.enable_arbiter	= 1,
+	.keep_config	= 1,
+	.cs_num		= 1,
+	.parts[0]	= mxm_8x10_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(mxm_8x10_nand_partitions)
 };
 
 static void __init mxm_8x10_nand_init(void)
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d130f77..a54846d 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -349,8 +349,9 @@ static struct mtd_partition raumfeld_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= raumfeld_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(raumfeld_nand_partitions),
+	.cs_num		= 1,
+	.parts[0]	= raumfeld_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(raumfeld_nand_partitions),
 };
 
 /**
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 5821185..ea4752a 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -366,8 +366,9 @@ static struct mtd_partition zylonite_nand_partitions[] = {
 
 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= zylonite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
+	.cs_num		= 1,
+	.parts[0]	= zylonite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(zylonite_nand_partitions),
 };
 
 static void __init zylonite_init_nand(void)
diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 442301f..34a3f52 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -41,6 +41,8 @@ struct pxa3xx_nand_flash {
 	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
 };
 
+/* The max num of chip select current support */
+#define NUM_CHIP_SELECT		(2)
 struct pxa3xx_nand_platform_data {
 
 	/* the data flash bus is shared between the Static Memory
@@ -52,8 +54,10 @@ struct pxa3xx_nand_platform_data {
 	/* allow platform code to keep OBM/bootloader defined NFC config */
 	int	keep_config;
 
-	const struct mtd_partition		*parts;
-	unsigned int				nr_parts;
+	/* indicate how many chip select would be used for this platform */
+	int	cs_num;
+	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
+	unsigned int				nr_parts[NUM_CHIP_SELECT];
 
 	const struct pxa3xx_nand_flash * 	flash;
 	size_t					num_flash;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 30689cc..259b8d5 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -92,11 +92,13 @@
 #define NDCB0_ADDR_CYC_SHIFT	(16)
 
 /* macros for registers read/write */
-#define nand_writel(info, off, val)	\
-	__raw_writel((val), (info)->mmio_base + (off))
+#define nand_writel(nand, off, val)	\
+	__raw_writel((val), (nand)->mmio_base + (off))
 
-#define nand_readl(info, off)		\
-	__raw_readl((info)->mmio_base + (off))
+#define nand_readl(nand, off)		\
+	__raw_readl((nand)->mmio_base + (off))
+#define get_mtd_by_info(info)		\
+	(struct mtd_info *)((void *)info - sizeof(struct mtd_info))
 
 /* error code and state */
 enum {
@@ -110,6 +112,7 @@ enum {
 
 enum {
 	STATE_IDLE = 0,
+	STATE_PREPARED,
 	STATE_CMD_HANDLE,
 	STATE_DMA_READING,
 	STATE_DMA_WRITING,
@@ -123,63 +126,63 @@ enum {
 struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;
 
-	struct nand_hw_control	controller;
-	struct platform_device	 *pdev;
 	struct pxa3xx_nand_cmdset *cmdset;
+	/* page size of attached chip */
+	uint16_t		page_size;
+	uint8_t			chip_select;
+	uint8_t			use_ecc;
+
+	/* calculated from pxa3xx_nand_flash data */
+	uint8_t			col_addr_cycles;
+	uint8_t			row_addr_cycles;
+	uint8_t			read_id_bytes;
+
+	/* cached register value */
+	uint32_t		reg_ndcr;
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
 
+	void			*nand_data;
+};
+
+struct pxa3xx_nand {
 	struct clk		*clk;
 	void __iomem		*mmio_base;
 	unsigned long		mmio_phys;
+	struct nand_hw_control	controller;
+	struct completion	cmd_complete;
+	struct platform_device	 *pdev;
 
-	unsigned int 		buf_start;
-	unsigned int		buf_count;
-
-	struct mtd_info         *mtd;
 	/* DMA information */
 	int			drcmr_dat;
 	int			drcmr_cmd;
-
-	unsigned char		*data_buff;
-	unsigned char		*oob_buff;
-	dma_addr_t 		data_buff_phys;
-	size_t			data_buff_size;
 	int 			data_dma_ch;
-	struct pxa_dma_desc	*data_desc;
+	dma_addr_t		data_buff_phys;
 	dma_addr_t 		data_desc_addr;
+	struct pxa_dma_desc	*data_desc;
 
-	uint32_t		reg_ndcr;
-
-	/* saved column/page_addr during CMD_SEQIN */
-	int			seqin_column;
-	int			seqin_page_addr;
+	struct pxa3xx_nand_info *info[NUM_CHIP_SELECT];
+	uint32_t		command;
+	uint16_t		data_size;	/* data size in FIFO */
+	uint16_t		oob_size;
+	unsigned char		*data_buff;
+	unsigned char		*oob_buff;
+	uint32_t		buf_start;
+	uint32_t		buf_count;
 
 	/* relate to the command */
 	unsigned int		state;
-
+	uint8_t			chip_select;
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
 	int			is_ready;
-
-	unsigned int		page_size;	/* page size of attached chip */
-	unsigned int		data_size;	/* data size in FIFO */
 	int 			retcode;
-	struct completion 	cmd_complete;
 
 	/* generated NDCBx register values */
+	uint8_t			total_cmds;
 	uint32_t		ndcb0;
 	uint32_t		ndcb1;
 	uint32_t		ndcb2;
-
-	/* timing calcuted from setting */
-	uint32_t		ndtr0cs0;
-	uint32_t		ndtr1cs0;
-
-	/* calculated from pxa3xx_nand_flash data */
-	size_t		oob_size;
-	size_t		read_id_bytes;
-
-	unsigned int	col_addr_cycles;
-	unsigned int	row_addr_cycles;
 };
 
 static int use_dma = 1;
@@ -225,7 +228,7 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 /* Define a default flash type setting serve as flash detecting only */
 #define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
 
-const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
 
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
@@ -244,9 +247,11 @@ const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 				   const struct pxa3xx_nand_timing *t)
 {
-	unsigned long nand_clk = clk_get_rate(info->clk);
+	struct pxa3xx_nand *nand = info->nand_data;
+	unsigned long nand_clk;
 	uint32_t ndtr0, ndtr1;
 
+	nand_clk = clk_get_rate(nand->clk);
 	ndtr0 = NDTR0_tCH(ns2cycle(t->tCH, nand_clk)) |
 		NDTR0_tCS(ns2cycle(t->tCS, nand_clk)) |
 		NDTR0_tWH(ns2cycle(t->tWH, nand_clk)) |
@@ -260,26 +265,27 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
 
 	info->ndtr0cs0 = ndtr0;
 	info->ndtr1cs0 = ndtr1;
-	nand_writel(info, NDTR0CS0, ndtr0);
-	nand_writel(info, NDTR1CS0, ndtr1);
+	nand_writel(nand, NDTR0CS0, ndtr0);
+	nand_writel(nand, NDTR1CS0, ndtr1);
 }
 
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
+	struct pxa3xx_nand *nand = info->nand_data;
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
 
-	info->data_size = info->page_size;
+	nand->data_size = info->page_size;
 	if (!oob_enable) {
-		info->oob_size = 0;
+		nand->oob_size = 0;
 		return;
 	}
 
 	switch (info->page_size) {
 	case 2048:
-		info->oob_size = (info->use_ecc) ? 40 : 64;
+		nand->oob_size = (info->use_ecc) ? 40 : 64;
 		break;
 	case 512:
-		info->oob_size = (info->use_ecc) ? 8 : 16;
+		nand->oob_size = (info->use_ecc) ? 8 : 16;
 		break;
 	}
 }
@@ -290,185 +296,189 @@ static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
  * We enable all the interrupt at the same time, and
  * let pxa3xx_nand_irq to handle all logic.
  */
-static void pxa3xx_nand_start(struct pxa3xx_nand_info *info)
+static void pxa3xx_nand_start(struct pxa3xx_nand *nand)
 {
+	struct pxa3xx_nand_info *info;
 	uint32_t ndcr;
 
+	info = nand->info[nand->chip_select];
 	ndcr = info->reg_ndcr;
-	ndcr |= info->use_ecc ? NDCR_ECC_EN : 0;
-	ndcr |= info->use_dma ? NDCR_DMA_EN : 0;
+	ndcr |= nand->use_ecc ? NDCR_ECC_EN : 0;
+	ndcr |= nand->use_dma ? NDCR_DMA_EN : 0;
 	ndcr |= NDCR_ND_RUN;
 
 	/* clear status bits and run */
-	nand_writel(info, NDCR, 0);
-	nand_writel(info, NDSR, NDSR_MASK);
-	nand_writel(info, NDCR, ndcr);
+	nand_writel(nand, NDCR, 0);
+	nand_writel(nand, NDSR, NDSR_MASK);
+	nand_writel(nand, NDCR, ndcr);
 }
 
-static void pxa3xx_nand_stop(struct pxa3xx_nand_info *info)
+static void pxa3xx_nand_stop(struct pxa3xx_nand *nand)
 {
 	uint32_t ndcr;
 	int timeout = NAND_STOP_DELAY;
 
 	/* wait RUN bit in NDCR become 0 */
-	ndcr = nand_readl(info, NDCR);
+	ndcr = nand_readl(nand, NDCR);
 	while ((ndcr & NDCR_ND_RUN) && (timeout-- > 0)) {
-		ndcr = nand_readl(info, NDCR);
+		ndcr = nand_readl(nand, NDCR);
 		udelay(1);
 	}
 
 	if (timeout <= 0) {
 		ndcr &= ~NDCR_ND_RUN;
-		nand_writel(info, NDCR, ndcr);
+		nand_writel(nand, NDCR, ndcr);
 	}
 	/* clear status bits */
-	nand_writel(info, NDSR, NDSR_MASK);
+	nand_writel(nand, NDSR, NDSR_MASK);
 }
 
-static void enable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
+static void enable_int(struct pxa3xx_nand *nand, uint32_t int_mask)
 {
 	uint32_t ndcr;
 
-	ndcr = nand_readl(info, NDCR);
-	nand_writel(info, NDCR, ndcr & ~int_mask);
+	ndcr = nand_readl(nand, NDCR);
+	nand_writel(nand, NDCR, ndcr & ~int_mask);
 }
 
-static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
+static void disable_int(struct pxa3xx_nand *nand, uint32_t int_mask)
 {
 	uint32_t ndcr;
 
-	ndcr = nand_readl(info, NDCR);
-	nand_writel(info, NDCR, ndcr | int_mask);
+	ndcr = nand_readl(nand, NDCR);
+	nand_writel(nand, NDCR, ndcr | int_mask);
 }
 
-static void handle_data_pio(struct pxa3xx_nand_info *info)
+static void handle_data_pio(struct pxa3xx_nand *nand)
 {
-	switch (info->state) {
+	switch (nand->state) {
 	case STATE_PIO_WRITING:
-		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
-				DIV_ROUND_UP(info->data_size, 4));
-		if (info->oob_size > 0)
-			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
-					DIV_ROUND_UP(info->oob_size, 4));
+		__raw_writesl(nand->mmio_base + NDDB, nand->data_buff,
+				DIV_ROUND_UP(nand->data_size, 4));
+		if (nand->oob_size > 0)
+			__raw_writesl(nand->mmio_base + NDDB, nand->oob_buff,
+					DIV_ROUND_UP(nand->oob_size, 4));
 		break;
 	case STATE_PIO_READING:
-		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
-				DIV_ROUND_UP(info->data_size, 4));
-		if (info->oob_size > 0)
-			__raw_readsl(info->mmio_base + NDDB, info->oob_buff,
-					DIV_ROUND_UP(info->oob_size, 4));
+		__raw_readsl(nand->mmio_base + NDDB, nand->data_buff,
+				DIV_ROUND_UP(nand->data_size, 4));
+		if (nand->oob_size > 0)
+			__raw_readsl(nand->mmio_base + NDDB, nand->oob_buff,
+					DIV_ROUND_UP(nand->oob_size, 4));
 		break;
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
-				info->state);
+				nand->state);
 		BUG();
 	}
 }
 
-static void start_data_dma(struct pxa3xx_nand_info *info)
+static void start_data_dma(struct pxa3xx_nand *nand)
 {
-	struct pxa_dma_desc *desc = info->data_desc;
-	int dma_len = ALIGN(info->data_size + info->oob_size, 32);
+	struct pxa_dma_desc *desc = nand->data_desc;
+	int dma_len = ALIGN(nand->data_size + nand->oob_size, 32);
 
 	desc->ddadr = DDADR_STOP;
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
 
-	switch (info->state) {
+	switch (nand->state) {
 	case STATE_DMA_WRITING:
-		desc->dsadr = info->data_buff_phys;
-		desc->dtadr = info->mmio_phys + NDDB;
+		desc->dsadr = nand->data_buff_phys;
+		desc->dtadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
 		break;
 	case STATE_DMA_READING:
-		desc->dtadr = info->data_buff_phys;
-		desc->dsadr = info->mmio_phys + NDDB;
+		desc->dtadr = nand->data_buff_phys;
+		desc->dsadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
 		break;
 	default:
 		printk(KERN_ERR "%s: invalid state %d\n", __func__,
-				info->state);
+				nand->state);
 		BUG();
 	}
 
-	DRCMR(info->drcmr_dat) = DRCMR_MAPVLD | info->data_dma_ch;
-	DDADR(info->data_dma_ch) = info->data_desc_addr;
-	DCSR(info->data_dma_ch) |= DCSR_RUN;
+	DRCMR(nand->drcmr_dat) = DRCMR_MAPVLD | nand->data_dma_ch;
+	DDADR(nand->data_dma_ch) = nand->data_desc_addr;
+	DCSR(nand->data_dma_ch) |= DCSR_RUN;
 }
 
 static void pxa3xx_nand_data_dma_irq(int channel, void *data)
 {
-	struct pxa3xx_nand_info *info = data;
+	struct pxa3xx_nand *nand = data;
 	uint32_t dcsr;
 
 	dcsr = DCSR(channel);
 	DCSR(channel) = dcsr;
 
 	if (dcsr & DCSR_BUSERR) {
-		info->retcode = ERR_DMABUSERR;
+		nand->retcode = ERR_DMABUSERR;
 	}
 
-	info->state = STATE_DMA_DONE;
-	enable_int(info, NDCR_INT_MASK);
-	nand_writel(info, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
+	nand->state = STATE_DMA_DONE;
+	enable_int(nand, NDCR_INT_MASK);
+	nand_writel(nand, NDSR, NDSR_WRDREQ | NDSR_RDDREQ);
 }
 
 static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
 {
-	struct pxa3xx_nand_info *info = devid;
-	unsigned int status, is_completed = 0;
+	struct pxa3xx_nand *nand = devid;
+	struct pxa3xx_nand_info *info;
+	unsigned int status, is_completed = 0, cs;
+	unsigned int ready, cmd_done, page_done, badblock_detect;
 
-	status = nand_readl(info, NDSR);
+	cs		= nand->chip_select;
+	ready           = (cs) ? NDSR_RDY : NDSR_FLASH_RDY;
+	cmd_done        = (cs) ? NDSR_CS1_CMDD : NDSR_CS0_CMDD;
+	page_done       = (cs) ? NDSR_CS1_PAGED : NDSR_CS0_PAGED;
+	badblock_detect = (cs) ? NDSR_CS1_BBD : NDSR_CS0_BBD;
+	info            = nand->info[cs];
 
+	status = nand_readl(nand, NDSR);
 	if (status & NDSR_DBERR)
-		info->retcode = ERR_DBERR;
+		nand->retcode = ERR_DBERR;
 	if (status & NDSR_SBERR)
-		info->retcode = ERR_SBERR;
+		nand->retcode = ERR_SBERR;
 	if (status & (NDSR_RDDREQ | NDSR_WRDREQ)) {
 		/* whether use dma to transfer data */
-		if (info->use_dma) {
-			disable_int(info, NDCR_INT_MASK);
-			info->state = (status & NDSR_RDDREQ) ?
+		if (nand->use_dma) {
+			disable_int(nand, NDCR_INT_MASK);
+			nand->state = (status & NDSR_RDDREQ) ?
 				      STATE_DMA_READING : STATE_DMA_WRITING;
-			start_data_dma(info);
+			start_data_dma(nand);
 			goto NORMAL_IRQ_EXIT;
 		} else {
-			info->state = (status & NDSR_RDDREQ) ?
+			nand->state = (status & NDSR_RDDREQ) ?
 				      STATE_PIO_READING : STATE_PIO_WRITING;
-			handle_data_pio(info);
+			handle_data_pio(nand);
 		}
 	}
-	if (status & NDSR_CS0_CMDD) {
-		info->state = STATE_CMD_DONE;
+	if (status & cmd_done) {
+		nand->state = STATE_CMD_DONE;
 		is_completed = 1;
 	}
-	if (status & NDSR_FLASH_RDY) {
-		info->is_ready = 1;
-		info->state = STATE_READY;
+	if (status & ready) {
+		nand->is_ready = 1;
+		nand->state = STATE_READY;
 	}
 
 	if (status & NDSR_WRCMDREQ) {
-		nand_writel(info, NDSR, NDSR_WRCMDREQ);
+		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
 		status &= ~NDSR_WRCMDREQ;
-		info->state = STATE_CMD_HANDLE;
-		nand_writel(info, NDCB0, info->ndcb0);
-		nand_writel(info, NDCB0, info->ndcb1);
-		nand_writel(info, NDCB0, info->ndcb2);
+		nand->state = STATE_CMD_HANDLE;
+		nand_writel(nand, NDCB0, nand->ndcb0);
+		nand_writel(nand, NDCB0, nand->ndcb1);
+		nand_writel(nand, NDCB0, nand->ndcb2);
 	}
 
 	/* clear NDSR to let the controller exit the IRQ */
-	nand_writel(info, NDSR, status);
+	nand_writel(nand, NDSR, status);
 	if (is_completed)
-		complete(&info->cmd_complete);
+		complete(&nand->cmd_complete);
 NORMAL_IRQ_EXIT:
 	return IRQ_HANDLED;
 }
 
-static int pxa3xx_nand_dev_ready(struct mtd_info *mtd)
-{
-	struct pxa3xx_nand_info *info = mtd->priv;
-	return (nand_readl(info, NDSR) & NDSR_RDY) ? 1 : 0;
-}
-
 static inline int is_buf_blank(uint8_t *buf, size_t len)
 {
 	for (; len > 0; len--)
@@ -477,42 +487,49 @@ static inline int is_buf_blank(uint8_t *buf, size_t len)
 	return 1;
 }
 
-static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
+static int prepare_command_pool(struct pxa3xx_nand *nand, int command,
 		uint16_t column, int page_addr)
 {
 	uint16_t cmd;
 	int addr_cycle, exec_cmd, ndcb0;
-	struct mtd_info *mtd = info->mtd;
+	struct mtd_info *mtd;
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
 
-	ndcb0 = 0;
+	mtd = get_mtd_by_info(info);
+	ndcb0 = (nand->chip_select) ? NDCB0_CSEL : 0;
 	addr_cycle = 0;
 	exec_cmd = 1;
 
 	/* reset data and oob column point to handle data */
-	info->buf_start		= 0;
-	info->buf_count		= 0;
-	info->oob_size		= 0;
-	info->use_ecc		= 0;
-	info->is_ready		= 0;
-	info->retcode		= ERR_NONE;
+	nand->buf_start		= 0;
+	nand->buf_count		= 0;
+	nand->oob_size		= 0;
+	nand->use_ecc		= 0;
+	nand->is_ready		= 0;
+	nand->retcode		= ERR_NONE;
+	nand->data_size		= 0;
+	nand->use_dma		= 0;
+	nand->command		= command;
 
 	switch (command) {
 	case NAND_CMD_READ0:
 	case NAND_CMD_PAGEPROG:
-		info->use_ecc = 1;
+		nand->use_ecc = 1;
 	case NAND_CMD_READOOB:
 		pxa3xx_set_datasize(info);
+		nand->oob_buff = nand->data_buff + nand->data_size;
+		nand->use_dma = use_dma;
 		break;
 	case NAND_CMD_SEQIN:
 		exec_cmd = 0;
 		break;
 	default:
-		info->ndcb1 = 0;
-		info->ndcb2 = 0;
+		nand->ndcb1 = 0;
+		nand->ndcb2 = 0;
 		break;
 	}
 
-	info->ndcb0 = ndcb0;
+	nand->ndcb0 = ndcb0;
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 				    + info->col_addr_cycles);
 
@@ -521,16 +538,16 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	case NAND_CMD_READ0:
 		cmd = info->cmdset->read1;
 		if (command == NAND_CMD_READOOB)
-			info->buf_start = mtd->writesize + column;
+			nand->buf_start = mtd->writesize + column;
 		else
-			info->buf_start = column;
+			nand->buf_start = column;
 
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE))
-			info->ndcb0 |= NDCB0_CMD_TYPE(0)
+			nand->ndcb0 |= NDCB0_CMD_TYPE(0)
 					| addr_cycle
 					| (cmd & NDCB0_CMD1_MASK);
 		else
-			info->ndcb0 |= NDCB0_CMD_TYPE(0)
+			nand->ndcb0 |= NDCB0_CMD_TYPE(0)
 					| NDCB0_DBC
 					| addr_cycle
 					| cmd;
@@ -538,34 +555,34 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
-			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+			nand->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
 
-			info->ndcb2 = 0;
+			nand->ndcb2 = 0;
 		} else {
-			info->ndcb1 = ((page_addr & 0xFFFF) << 16)
+			nand->ndcb1 = ((page_addr & 0xFFFF) << 16)
 					| (column & 0xFFFF);
 
 			if (page_addr & 0xFF0000)
-				info->ndcb2 = (page_addr & 0xFF0000) >> 16;
+				nand->ndcb2 = (page_addr & 0xFF0000) >> 16;
 			else
-				info->ndcb2 = 0;
+				nand->ndcb2 = 0;
 		}
 
-		info->buf_count = mtd->writesize + mtd->oobsize;
-		memset(info->data_buff, 0xFF, info->buf_count);
+		nand->buf_count = mtd->writesize + mtd->oobsize;
+		memset(nand->data_buff, 0xFF, nand->buf_count);
 
 		break;
 
 	case NAND_CMD_PAGEPROG:
-		if (is_buf_blank(info->data_buff,
+		if (is_buf_blank(nand->data_buff,
 					(mtd->writesize + mtd->oobsize))) {
 			exec_cmd = 0;
 			break;
 		}
 
 		cmd = info->cmdset->program;
-		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+		nand->ndcb0 |= NDCB0_CMD_TYPE(0x1)
 				| NDCB0_AUTO_RS
 				| NDCB0_ST_ROW_EN
 				| NDCB0_DBC
@@ -575,37 +592,37 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 
 	case NAND_CMD_READID:
 		cmd = info->cmdset->read_id;
-		info->buf_count = info->read_id_bytes;
-		info->ndcb0 |= NDCB0_CMD_TYPE(3)
+		nand->buf_count = info->read_id_bytes;
+		nand->ndcb0 |= NDCB0_CMD_TYPE(3)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;
 
-		info->data_size = 8;
+		nand->data_size = 8;
 		break;
 	case NAND_CMD_STATUS:
 		cmd = info->cmdset->read_status;
-		info->buf_count = 1;
-		info->ndcb0 |= NDCB0_CMD_TYPE(4)
+		nand->buf_count = 1;
+		nand->ndcb0 |= NDCB0_CMD_TYPE(4)
 				| NDCB0_ADDR_CYC(1)
 				| cmd;
 
-		info->data_size = 8;
+		nand->data_size = 8;
 		break;
 
 	case NAND_CMD_ERASE1:
 		cmd = info->cmdset->erase;
-		info->ndcb0 |= NDCB0_CMD_TYPE(2)
+		nand->ndcb0 |= NDCB0_CMD_TYPE(2)
 				| NDCB0_AUTO_RS
 				| NDCB0_ADDR_CYC(3)
 				| NDCB0_DBC
 				| cmd;
-		info->ndcb1 = page_addr;
-		info->ndcb2 = 0;
+		nand->ndcb1 = page_addr;
+		nand->ndcb2 = 0;
 
 		break;
 	case NAND_CMD_RESET:
 		cmd = info->cmdset->reset;
-		info->ndcb0 |= NDCB0_CMD_TYPE(5)
+		nand->ndcb0 |= NDCB0_CMD_TYPE(5)
 				| cmd;
 
 		break;
@@ -628,6 +645,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 	int ret, exec_cmd;
 
 	/*
@@ -638,20 +656,32 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	if (info->reg_ndcr & NDCR_DWIDTH_M)
 		column /= 2;
 
-	exec_cmd = prepare_command_pool(info, command, column, page_addr);
+	/*
+	 * There may be different NAND chip hooked to
+	 * different chip select, so check whether
+	 * chip select has been changed, if yes, reset the timing
+	 */
+	if (nand->chip_select != info->chip_select) {
+		nand->chip_select = info->chip_select;
+		nand_writel(nand, NDTR0CS0, info->ndtr0cs0);
+		nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
+	}
+
+	nand->state = STATE_PREPARED;
+	exec_cmd = prepare_command_pool(nand, command, column, page_addr);
 	if (exec_cmd) {
-		init_completion(&info->cmd_complete);
-		pxa3xx_nand_start(info);
+		init_completion(&nand->cmd_complete);
+		pxa3xx_nand_start(nand);
 
-		ret = wait_for_completion_timeout(&info->cmd_complete,
+		ret = wait_for_completion_timeout(&nand->cmd_complete,
 				CHIP_DELAY_TIMEOUT);
 		if (!ret) {
 			printk(KERN_ERR "Wait time out!!!\n");
 			/* Stop State Machine for next command cycle */
-			pxa3xx_nand_stop(info);
+			pxa3xx_nand_stop(nand);
 		}
-		info->state = STATE_IDLE;
 	}
+	nand->state = STATE_IDLE;
 }
 
 static void pxa3xx_nand_write_page_hwecc(struct mtd_info *mtd,
@@ -665,11 +695,12 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int page)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 
 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 
-	if (info->retcode == ERR_SBERR) {
+	if (nand->retcode == ERR_SBERR) {
 		switch (info->use_ecc) {
 		case 1:
 			mtd->ecc_stats.corrected++;
@@ -678,14 +709,14 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		default:
 			break;
 		}
-	} else if (info->retcode == ERR_DBERR) {
+	} else if (nand->retcode == ERR_DBERR) {
 		/*
 		 * for blank page (all 0xff), HW will calculate its ECC as
 		 * 0, which is different from the ECC information within
 		 * OOB, ignore such double bit errors
 		 */
 		if (is_buf_blank(buf, mtd->writesize))
-			info->retcode = ERR_NONE;
+			nand->retcode = ERR_NONE;
 		else
 			mtd->ecc_stats.failed++;
 	}
@@ -696,11 +727,12 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 	char retval = 0xFF;
 
-	if (info->buf_start < info->buf_count)
+	if (nand->buf_start < nand->buf_count)
 		/* Has just send a new command? */
-		retval = info->data_buff[info->buf_start++];
+		retval = nand->data_buff[nand->buf_start++];
 
 	return retval;
 }
@@ -708,11 +740,12 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
 static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 	u16 retval = 0xFFFF;
 
-	if (!(info->buf_start & 0x01) && info->buf_start < info->buf_count) {
-		retval = *((u16 *)(info->data_buff+info->buf_start));
-		info->buf_start += 2;
+	if (!(nand->buf_start & 0x01) && nand->buf_start < nand->buf_count) {
+		retval = *((u16 *)(nand->data_buff+nand->buf_start));
+		nand->buf_start += 2;
 	}
 	return retval;
 }
@@ -720,20 +753,22 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
 static void pxa3xx_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
+	struct pxa3xx_nand *nand = info->nand_data;
+	int real_len = min_t(size_t, len, nand->buf_count - nand->buf_start);
 
-	memcpy(buf, info->data_buff + info->buf_start, real_len);
-	info->buf_start += real_len;
+	memcpy(buf, nand->data_buff + nand->buf_start, real_len);
+	nand->buf_start += real_len;
 }
 
 static void pxa3xx_nand_write_buf(struct mtd_info *mtd,
 		const uint8_t *buf, int len)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	int real_len = min_t(size_t, len, info->buf_count - info->buf_start);
+	struct pxa3xx_nand *nand = info->nand_data;
+	int real_len = min_t(size_t, len, nand->buf_count - nand->buf_start);
 
-	memcpy(info->data_buff + info->buf_start, buf, real_len);
-	info->buf_start += real_len;
+	memcpy(nand->data_buff + nand->buf_start, buf, real_len);
+	nand->buf_start += real_len;
 }
 
 static int pxa3xx_nand_verify_buf(struct mtd_info *mtd,
@@ -750,10 +785,11 @@ static void pxa3xx_nand_select_chip(struct mtd_info *mtd, int chip)
 static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 
 	/* pxa3xx_nand_send_command has waited for command complete */
 	if (this->state == FL_WRITING || this->state == FL_ERASING) {
-		if (info->retcode == ERR_NONE)
+		if (nand->retcode == ERR_NONE)
 			return 0;
 		else {
 			/*
@@ -770,7 +806,8 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
 static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 				    const struct pxa3xx_nand_flash *f)
 {
-	struct platform_device *pdev = info->pdev;
+	struct pxa3xx_nand *nand = info->nand_data;
+	struct platform_device *pdev = nand->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	uint32_t ndcr = 0x0; /* enable all interrupts */
 
@@ -804,6 +841,7 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */
 
 	info->reg_ndcr = ndcr;
+	info->use_ecc = 1;
 
 	pxa3xx_nand_set_timing(info, f->timing);
 	return 0;
@@ -811,15 +849,22 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 
 static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 {
-	uint32_t ndcr = nand_readl(info, NDCR);
+	struct pxa3xx_nand *nand = info->nand_data;
+	uint32_t ndcr = nand_readl(nand, NDCR);
+
+	if (info->chip_select > 0) {
+		printk(KERN_ERR "We could not detect configure"
+				" if more than one cs is supported!!\n");
+		BUG();
+	}
 	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
 	/* set info fields needed to read id */
 	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
 	info->reg_ndcr = ndcr & ~NDCR_INT_MASK;
 	info->cmdset = &default_cmdset;
 
-	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
-	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
+	info->ndtr0cs0 = nand_readl(nand, NDTR0CS0);
+	info->ndtr1cs0 = nand_readl(nand, NDTR1CS0);
 
 	return 0;
 }
@@ -830,50 +875,31 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
  */
 #define MAX_BUFF_SIZE	PAGE_SIZE
 
-static int pxa3xx_nand_init_buff(struct pxa3xx_nand_info *info)
+static void free_cs_resource(struct pxa3xx_nand_info *info, int cs)
 {
-	struct platform_device *pdev = info->pdev;
-	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
-
-	if (use_dma == 0) {
-		info->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
-		if (info->data_buff == NULL)
-			return -ENOMEM;
-		return 0;
-	}
-
-	info->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
-				&info->data_buff_phys, GFP_KERNEL);
-	if (info->data_buff == NULL) {
-		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
-		return -ENOMEM;
-	}
-
-	info->data_buff_size = MAX_BUFF_SIZE;
-	info->data_desc = (void *)info->data_buff + data_desc_offset;
-	info->data_desc_addr = info->data_buff_phys + data_desc_offset;
+	struct pxa3xx_nand *nand;
+	struct mtd_info *mtd;
 
-	info->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
-				pxa3xx_nand_data_dma_irq, info);
-	if (info->data_dma_ch < 0) {
-		dev_err(&pdev->dev, "failed to request data dma\n");
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
-				info->data_buff, info->data_buff_phys);
-		return info->data_dma_ch;
-	}
+	if (!info)
+		return;
 
-	return 0;
+	nand = info->nand_data;
+	mtd = get_mtd_by_info(info);
+	kfree(mtd);
+	nand->info[cs] = NULL;
 }
 
 static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 {
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand *nand = info->nand_data;
+	struct mtd_info *mtd = get_mtd_by_info(info);
 	struct nand_chip *chip = mtd->priv;
 
 	/* use the common timing to make a try */
-	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	if (pxa3xx_nand_config_flash(info, &builtin_flash_types[0]))
+		return 0;
 	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
-	if (info->is_ready)
+	if (nand->is_ready)
 		return 1;
 	else
 		return 0;
@@ -882,7 +908,8 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
 static int pxa3xx_nand_scan(struct mtd_info *mtd)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	struct platform_device *pdev = info->pdev;
+	struct pxa3xx_nand *nand = info->nand_data;
+	struct platform_device *pdev = nand->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
 	const struct pxa3xx_nand_flash *f = NULL;
@@ -891,27 +918,25 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	uint64_t chipsize;
 	int i, ret, num;
 
+	nand->chip_select = info->chip_select;
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
 		goto KEEP_CONFIG;
 
 	ret = pxa3xx_nand_sensing(info);
 	if (!ret) {
-		kfree(mtd);
-		info->mtd = NULL;
-		printk(KERN_INFO "There is no nand chip on cs 0!\n");
+		free_cs_resource(info, nand->chip_select);
+		printk(KERN_INFO "There is no nand chip on cs %d!\n",
+				nand->chip_select);
 
 		return -EINVAL;
 	}
 
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
+	id = *((uint16_t *)(nand->data_buff));
 	if (id != 0)
 		printk(KERN_INFO "Detect a flash id %x\n", id);
 	else {
-		kfree(mtd);
-		info->mtd = NULL;
-		printk(KERN_WARNING "Read out ID 0, potential timing set wrong!!\n");
-
+		free_cs_resource(info, nand->chip_select);
 		return -EINVAL;
 	}
 
@@ -928,14 +953,16 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	}
 
 	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
-		kfree(mtd);
-		info->mtd = NULL;
+		free_cs_resource(info, nand->chip_select);
 		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
 
 		return -EINVAL;
 	}
 
-	pxa3xx_nand_config_flash(info, f);
+	if (pxa3xx_nand_config_flash(info, f)) {
+		printk(KERN_ERR "ERROR! Configure failed\n");
+		return -EINVAL;
+	}
 	pxa3xx_flash_ids[0].name = f->name;
 	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
 	pxa3xx_flash_ids[0].pagesize = f->page_size;
@@ -950,13 +977,13 @@ KEEP_CONFIG:
 	if (nand_scan_ident(mtd, 1, def))
 		return -ENODEV;
 	/* calculate addressing information */
+	nand->oob_buff = nand->data_buff + mtd->writesize;
 	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
-	info->oob_buff = info->data_buff + mtd->writesize;
 	if ((mtd->size >> chip->page_shift) > 65536)
 		info->row_addr_cycles = 3;
 	else
 		info->row_addr_cycles = 2;
-	mtd->name = mtd_names[0];
+	mtd->name = mtd_names[nand->chip_select];
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = info->page_size;
 
@@ -967,51 +994,33 @@ KEEP_CONFIG:
 	return nand_scan_tail(mtd);
 }
 
-static
-struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
+static int alloc_nand_resource(struct platform_device *pdev)
 {
+	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
+	struct pxa3xx_nand *nand;
 	struct resource *r;
-	int ret, irq;
+	int ret, irq, cs;
+	int data_desc_offset = MAX_BUFF_SIZE - sizeof(struct pxa_dma_desc);
 
-	mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct pxa3xx_nand_info),
-			GFP_KERNEL);
-	if (!mtd) {
+	pdata = pdev->dev.platform_data;
+	nand = kzalloc(sizeof(struct mtd_info)
+			+ sizeof(struct pxa3xx_nand_info), GFP_KERNEL);
+	if (!nand) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
-		return NULL;
+		return -ENOMEM;
 	}
 
-	info = (struct pxa3xx_nand_info *)(&mtd[1]);
-	chip = (struct nand_chip *)(&mtd[1]);
-	info->pdev = pdev;
-	info->mtd = mtd;
-	mtd->priv = info;
-	mtd->owner = THIS_MODULE;
-
-	chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
-	chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
-	chip->controller        = &info->controller;
-	chip->waitfunc		= pxa3xx_nand_waitfunc;
-	chip->select_chip	= pxa3xx_nand_select_chip;
-	chip->dev_ready		= pxa3xx_nand_dev_ready;
-	chip->cmdfunc		= pxa3xx_nand_cmdfunc;
-	chip->read_word		= pxa3xx_nand_read_word;
-	chip->read_byte		= pxa3xx_nand_read_byte;
-	chip->read_buf		= pxa3xx_nand_read_buf;
-	chip->write_buf		= pxa3xx_nand_write_buf;
-	chip->verify_buf	= pxa3xx_nand_verify_buf;
-
-	spin_lock_init(&chip->controller->lock);
-	init_waitqueue_head(&chip->controller->wq);
-	info->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(info->clk)) {
+	nand->pdev = pdev;
+	nand->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(nand->clk)) {
 		dev_err(&pdev->dev, "failed to get nand clock\n");
-		ret = PTR_ERR(info->clk);
-		goto fail_free_mtd;
+		ret = PTR_ERR(nand->clk);
+		goto fail_alloc;
 	}
-	clk_enable(info->clk);
+	clk_enable(nand->clk);
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (r == NULL) {
@@ -1019,7 +1028,7 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto fail_put_clk;
 	}
-	info->drcmr_dat = r->start;
+	nand->drcmr_dat = r->start;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (r == NULL) {
@@ -1027,7 +1036,7 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 		ret = -ENXIO;
 		goto fail_put_clk;
 	}
-	info->drcmr_cmd = r->start;
+	nand->drcmr_cmd = r->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -1050,81 +1059,147 @@ struct pxa3xx_nand_info *alloc_nand_resource(struct platform_device *pdev)
 		goto fail_put_clk;
 	}
 
-	info->mmio_base = ioremap(r->start, resource_size(r));
-	if (info->mmio_base == NULL) {
+	nand->mmio_base = ioremap(r->start, resource_size(r));
+	if (nand->mmio_base == NULL) {
 		dev_err(&pdev->dev, "ioremap() failed\n");
 		ret = -ENODEV;
 		goto fail_free_res;
 	}
-	info->mmio_phys = r->start;
-
-	ret = pxa3xx_nand_init_buff(info);
-	if (ret)
-		goto fail_free_io;
+	nand->mmio_phys = r->start;
 
 	/* initialize all interrupts to be disabled */
-	disable_int(info, NDSR_MASK);
+	disable_int(nand, NDSR_MASK);
 
 	ret = request_irq(irq, pxa3xx_nand_irq, IRQF_DISABLED,
-			  pdev->name, info);
+			  pdev->name, nand);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto fail_free_buf;
+		ret = -ENXIO;
+		goto fail_free_io;
+	}
+
+	platform_set_drvdata(pdev, nand);
+
+	spin_lock_init(&nand->controller.lock);
+	init_waitqueue_head(&nand->controller.wq);
+	for (cs = 0; cs < pdata->cs_num; cs++) {
+		mtd = kzalloc(sizeof(struct mtd_info)
+				+ sizeof(struct pxa3xx_nand_info),
+				GFP_KERNEL);
+		if (!mtd) {
+			dev_err(&pdev->dev, "failed to allocate memory\n");
+			ret = -ENOMEM;
+			goto fail_free_irq;
+		}
+
+		info = (struct pxa3xx_nand_info *)(&mtd[1]);
+		info->nand_data = nand;
+		info->chip_select = cs;
+		mtd->priv = info;
+		mtd->owner = THIS_MODULE;
+		nand->info[cs] = info;
+
+		chip = (struct nand_chip *)(&mtd[1]);
+		chip->controller        = &nand->controller;
+		chip->ecc.read_page	= pxa3xx_nand_read_page_hwecc;
+		chip->ecc.write_page	= pxa3xx_nand_write_page_hwecc;
+		chip->waitfunc		= pxa3xx_nand_waitfunc;
+		chip->select_chip	= pxa3xx_nand_select_chip;
+		chip->cmdfunc		= pxa3xx_nand_cmdfunc;
+		chip->read_word		= pxa3xx_nand_read_word;
+		chip->read_byte		= pxa3xx_nand_read_byte;
+		chip->read_buf		= pxa3xx_nand_read_buf;
+		chip->write_buf		= pxa3xx_nand_write_buf;
+		chip->verify_buf	= pxa3xx_nand_verify_buf;
 	}
 
-	platform_set_drvdata(pdev, info);
+	if (use_dma == 0) {
+		nand->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
+		if (nand->data_buff == NULL) {
+			ret = -ENOMEM;
+			goto fail_free_buf;
+		}
+		goto success_exit;
+	}
 
-	return info;
+	nand->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			&nand->data_buff_phys, GFP_KERNEL);
+	if (nand->data_buff == NULL) {
+		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
+		ret = -ENOMEM;
+		goto fail_free_buf;
+	}
 
+	nand->data_desc = (void *)nand->data_buff + data_desc_offset;
+	nand->data_desc_addr = nand->data_buff_phys + data_desc_offset;
+	nand->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
+			pxa3xx_nand_data_dma_irq, nand);
+	if (nand->data_dma_ch < 0) {
+		dev_err(&pdev->dev, "failed to request data dma\n");
+		ret = -ENXIO;
+		goto fail_free_dma_buf;
+	}
+success_exit:
+	return 0;
+
+fail_free_dma_buf:
+	dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
+			nand->data_buff, nand->data_buff_phys);
 fail_free_buf:
-	free_irq(irq, info);
-	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
-			info->data_buff, info->data_buff_phys);
-	} else
-		kfree(info->data_buff);
+	for (cs = 0; cs < pdata->cs_num; cs++) {
+		info = nand->info[cs];
+		free_cs_resource(info, cs);
+	}
+fail_free_irq:
+	free_irq(irq, nand);
 fail_free_io:
-	iounmap(info->mmio_base);
+	iounmap(nand->mmio_base);
 fail_free_res:
 	release_mem_region(r->start, resource_size(r));
 fail_put_clk:
-	clk_disable(info->clk);
-	clk_put(info->clk);
-fail_free_mtd:
-	kfree(mtd);
-	return NULL;
+	clk_disable(nand->clk);
+	clk_put(nand->clk);
+fail_alloc:
+	kfree(nand);
+	return ret;
 }
 
 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand *nand = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_platform_data *pdata;
+	struct pxa3xx_nand_info *info;
+	struct mtd_info *mtd;
 	struct resource *r;
-	int irq;
+	int irq, cs;
 
 	platform_set_drvdata(pdev, NULL);
+	pdata = pdev->dev.platform_data;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0)
-		free_irq(irq, info);
+		free_irq(irq, nand);
 	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
-		dma_free_writecombine(&pdev->dev, info->data_buff_size,
-				info->data_buff, info->data_buff_phys);
+		pxa_free_dma(nand->data_dma_ch);
+		dma_free_writecombine(&pdev->dev, MAX_BUFF_SIZE,
+				nand->data_buff, nand->data_buff_phys);
 	} else
-		kfree(info->data_buff);
+		kfree(nand->data_buff);
 
-	iounmap(info->mmio_base);
+	iounmap(nand->mmio_base);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
 
-	clk_disable(info->clk);
-	clk_put(info->clk);
+	clk_disable(nand->clk);
+	clk_put(nand->clk);
 
-	if (mtd) {
+	for (cs = 0; cs < pdata->cs_num; cs++) {
+		info = nand->info[cs];
+		if (!info)
+			continue;
+		mtd = get_mtd_by_info(info);
 		mtd_device_unregister(mtd);
-		kfree(mtd);
+		free_cs_resource(info, cs);
 	}
 	return 0;
 }
@@ -1134,34 +1209,54 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
 
+	struct pxa3xx_nand *nand;
+	struct mtd_info *mtd;
+	int cs, ret, nr_parts, probe_success;
+
+	probe_success = 0;
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -ENODEV;
 	}
 
-	info = alloc_nand_resource(pdev);
-	if (info == NULL)
+	ret = alloc_nand_resource(pdev);
+	if (ret)
 		return -ENOMEM;
 
-	if (pxa3xx_nand_scan(info->mtd)) {
-		dev_err(&pdev->dev, "failed to scan nand\n");
-		pxa3xx_nand_remove(pdev);
-		return -ENODEV;
-	}
+	nand = platform_get_drvdata(pdev);
+	for (cs = 0; cs < pdata->cs_num; cs++) {
+		info = nand->info[cs];
+		mtd = get_mtd_by_info(info);
+		if (pxa3xx_nand_scan(mtd)) {
+			dev_err(&pdev->dev, "failed to scan nand\n");
+			continue;
+		}
+
+		ret = 0;
+		nr_parts = 0;
+		if (mtd_has_cmdlinepart()) {
+			const char *probes[] = { "cmdlinepart", NULL };
+			struct mtd_partition *parts;
 
-	if (mtd_has_cmdlinepart()) {
-		const char *probes[] = { "cmdlinepart", NULL };
-		struct mtd_partition *parts;
-		int nr_parts;
+			nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
 
-		nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
+			if (nr_parts)
+				ret = mtd_device_register(mtd, parts, nr_parts);
+		}
 
-		if (nr_parts)
-			return mtd_device_register(info->mtd, parts, nr_parts);
+		if (!nr_parts)
+			ret = mtd_device_register(mtd, pdata->parts[cs],
+					pdata->nr_parts[cs]);
+		if (!ret)
+			probe_success = 1;
 	}
 
-	return mtd_device_register(info->mtd, pdata->parts, pdata->nr_parts);
+	if (!probe_success) {
+		pxa3xx_nand_remove(pdev);
+		return -ENODEV;
+	} else
+		return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1183,8 +1278,8 @@ static int pxa3xx_nand_resume(struct platform_device *pdev)
 	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = info->mtd;
 
-	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
-	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
+	nand_writel(nand, NDTR0CS0, info->ndtr0cs0);
+	nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
 	clk_enable(info->clk);
 
 	return 0;
-- 
1.7.0.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
