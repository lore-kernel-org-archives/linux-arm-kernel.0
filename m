From: leiwen@marvell.com (Lei Wen)
Date: Sun, 6 Jun 2010 21:58:12 +0800
Subject: [PATCH 10/25] pxa3xx_nand: add two chip select
Message-ID: <mailman.18.1276839401.27306.linux-arm-kernel@lists.infradead.org>
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
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c                 |    4 +-
 arch/arm/mach-mmp/avengers_lite.c            |   50 ++
 arch/arm/mach-pxa/cm-x300.c                  |    4 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    4 +-
 arch/arm/mach-pxa/littleton.c                |    4 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    8 +-
 arch/arm/mach-pxa/raumfeld.c                 |    4 +-
 arch/arm/mach-pxa/zylonite.c                 |    4 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    5 +-
 drivers/mtd/nand/pxa3xx_nand.c               |  770 +++++++++++++-------------
 10 files changed, 462 insertions(+), 395 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 244655d..81ad58d 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -126,8 +126,8 @@ static struct mtd_partition aspenite_nand_partitions[] = {

 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= aspenite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
+	.parts[0]	= aspenite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
 };

 static struct i2c_board_info aspenite_i2c_info[] __initdata = {
diff --git a/arch/arm/mach-mmp/avengers_lite.c
b/arch/arm/mach-mmp/avengers_lite.c
index 8c3fa5d..a828b1c 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -32,12 +32,62 @@ static unsigned long
avengers_lite_pin_config_V16F[] __initdata = {
 	GPIO89_UART2_RXD,
 };

+static struct mtd_partition avengers_nand_partitions_0[] = {
+	{
+		.name		= "bootloader",
+		.offset		= 0,
+		.size		= SZ_1M,
+		.mask_flags	= MTD_WRITEABLE,
+	}, {
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= (SZ_2M + SZ_1M),
+	}, {
+		.name		= "mass0",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_48M,
+	}
+};
+
+static struct mtd_partition avengers_nand_partitions_1[] = {
+	{
+		.name		= "reserved",
+		.offset		= 0,
+		.size		= SZ_2M,
+		.mask_flags	= MTD_WRITEABLE,
+	}, {
+		.name		= "filesystem",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_512M,
+	}, {
+		.name		= "mass1",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_16M,
+	}, {
+		.name		= "mass2",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_256M,
+	}
+};
+
+static struct pxa3xx_nand_platform_data avengers_nand_info;
+static void __init avengers_init_flash(void)
+{
+	avengers_nand_info.parts[0] = avengers_nand_partitions_0;
+	avengers_nand_info.nr_parts[0] = ARRAY_SIZE(avengers_nand_partitions_0);
+	avengers_nand_info.parts[1] = avengers_nand_partitions_1;
+	avengers_nand_info.nr_parts[1] = ARRAY_SIZE(avengers_nand_partitions_1);
+	avengers_nand_info.enable_arbiter = 1;
+	pxa168_add_nand(&avengers_nand_info);
+}
+
 static void __init avengers_lite_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(avengers_lite_pin_config_V16F));

 	/* on-chip devices */
 	pxa168_add_uart(2);
+	avengers_init_flash();
 }

 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index fdda6be..ce1f6d3 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -419,8 +419,8 @@ static struct mtd_partition cm_x300_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data cm_x300_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= cm_x300_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(cm_x300_nand_partitions),
+	.parts[0]	= cm_x300_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(cm_x300_nand_partitions),
 };

 static void __init cm_x300_init_nand(void)
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c
b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 199afa2..b33559c 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -188,8 +188,8 @@ static struct mtd_partition colibri_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data colibri_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= colibri_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(colibri_nand_partitions),
+	.parts[0]	= colibri_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(colibri_nand_partitions),
 };

 void __init colibri_pxa3xx_init_nand(void)
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9b90461..717cf92 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -325,8 +325,8 @@ static struct mtd_partition littleton_nand_partitions[] = {

 static struct pxa3xx_nand_platform_data littleton_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= littleton_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(littleton_nand_partitions),
+	.parts[0]	= littleton_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(littleton_nand_partitions),
 };

 static void __init littleton_init_nand(void)
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 462167a..66c2086 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -389,10 +389,10 @@ static struct mtd_partition mxm_8x10_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
-	.enable_arbiter = 1,
-	.keep_config = 1,
-	.parts = mxm_8x10_nand_partitions,
-	.nr_parts = ARRAY_SIZE(mxm_8x10_nand_partitions)
+	.enable_arbiter	= 1,
+	.keep_config	= 1,
+	.parts[0]	= mxm_8x10_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(mxm_8x10_nand_partitions)
 };

 static void __init mxm_8x10_nand_init(void)
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d4b61b3..df75d4d 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -350,8 +350,8 @@ static struct mtd_partition raumfeld_nand_partitions[] = {
 static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
 	.enable_arbiter	= 1,
 	.keep_config	= 1,
-	.parts		= raumfeld_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(raumfeld_nand_partitions),
+	.parts[0]	= raumfeld_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(raumfeld_nand_partitions),
 };

 /**
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index c479cbe..9e5c6cd 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -356,8 +356,8 @@ static struct mtd_partition zylonite_nand_partitions[] = {

 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
 	.enable_arbiter	= 1,
-	.parts		= zylonite_nand_partitions,
-	.nr_parts	= ARRAY_SIZE(zylonite_nand_partitions),
+	.parts[0]	= zylonite_nand_partitions,
+	.nr_parts[0]	= ARRAY_SIZE(zylonite_nand_partitions),
 };

 static void __init zylonite_init_nand(void)
diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 7e5a28f..56015bd 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -4,6 +4,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>

+#define NUM_CHIP_SELECT		(2)
 struct pxa3xx_nand_platform_data {

 	/* the data flash bus is shared between the Static Memory
@@ -15,8 +16,8 @@ struct pxa3xx_nand_platform_data {
 	/* allow platform code to keep OBM/bootloader defined NFC config */
 	int	keep_config;

-	const struct mtd_partition		*parts;
-	unsigned int				nr_parts;
+	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
+	unsigned int				nr_parts[NUM_CHIP_SELECT];

 	const struct pxa3xx_nand_flash * 	flash;
 	size_t					num_flash;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 8628fc1..215677f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -51,11 +51,9 @@
 #define NDCR_DWIDTH_M		(0x1 << 26)
 #define NDCR_PAGE_SZ		(0x1 << 24)
 #define NDCR_NCSX		(0x1 << 23)
-#define NDCR_STOP_ON_UNCOR	(0x1 << 22)
 #define NDCR_ND_MODE		(0x3 << 21)
-#define NDCR_NAND_MODE   	(0x0)
 #define NDCR_CLR_PG_CNT		(0x1 << 20)
-#define NDCR_CLR_ECC		(0x1 << 19)
+#define NDCR_STOP_ON_UNCOR	(0x1 << 19)
 #define NDCR_RD_ID_CNT_MASK	(0x7 << 16)
 #define NDCR_RD_ID_CNT(x)	(((x) << 16) & NDCR_RD_ID_CNT_MASK)

@@ -98,6 +96,8 @@

 #define nand_readl(info, off)		\
 	__raw_readl((info)->mmio_base + (off))
+#define get_mtd_by_info(info)		\
+	(struct mtd_info *)((void *)info - sizeof(struct mtd_info))

 /* error code and state */
 enum {
@@ -158,62 +158,63 @@ struct pxa3xx_nand_flash {

 struct pxa3xx_nand_info {
 	struct nand_chip	nand_chip;
+	/* page size of attached chip */
+	uint16_t		page_size;
+	uint8_t			chip_select;
+	uint8_t			use_ecc;

-	struct nand_hw_control	controller;
-	struct platform_device	 *pdev;
+	/* calculated from pxa3xx_nand_flash data */
+	uint8_t			col_addr_cycles;
+	uint8_t			row_addr_cycles;
+	uint8_t			read_id_bytes;
+
+	/* cached register value */
+	uint32_t		reg_ndcr;
+	uint32_t		ndtr0cs0;
+	uint32_t		ndtr1cs0;
+
+	void			*nand_data;
+};

+struct pxa3xx_nand {
 	struct clk		*clk;
 	void __iomem		*mmio_base;
 	unsigned long		mmio_phys;
+	struct nand_hw_control	controller;
+	struct completion 	cmd_complete;
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
+	dma_addr_t 		data_buff_phys;
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
+	uint32_t		bad_count;
+	unsigned char		*dma_buff;
+	unsigned char		*data_buff;
+	unsigned char		*oob_buff;
+	uint32_t		buf_start;
+	uint32_t		buf_count;
+	uint8_t			total_cmds;

 	/* relate to the command */
+	uint8_t			chip_select;
 	unsigned int		state;
-
 	int			use_ecc;	/* use HW ECC ? */
 	int			use_dma;	/* use DMA ? */
-
-	unsigned int		page_size;	/* page size of attached chip */
-	unsigned int		data_size;	/* data size in FIFO */
 	int 			retcode;
-	struct completion 	cmd_complete;

 	/* generated NDCBx register values */
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
@@ -248,6 +249,7 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 	{ 		0,	0,   0,    0,  0,  0,    0, &timing[0], },
 	{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1], },
 	{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1], },
+	{ "1GiB 8-bit",    0xd3ec, 128, 2048,  8,  8, 4096, &timing[1], },
 	{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1], },
 	{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2], },
 	{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2], },
@@ -256,7 +258,7 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 	{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3], },
 };

-static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
+static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};

 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
@@ -274,9 +276,11 @@ static const char *mtd_names[] = {"pxa3xx_nand-0", NULL};
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
@@ -290,25 +294,26 @@ static void pxa3xx_nand_set_timing(struct
pxa3xx_nand_info *info,

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
-			info->oob_size = (info->use_ecc) ? 40 : 64;
+			nand->oob_size = (nand->use_ecc) ? 40 : 64;
 			break;
 		case 512:
-			info->oob_size = (info->use_ecc) ? 8 : 16;
+			nand->oob_size = (nand->use_ecc) ? 8 : 16;
 			break;
 	}
 }
@@ -319,22 +324,24 @@ static void pxa3xx_set_datasize(struct
pxa3xx_nand_info *info)
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
-	ndcr |= info->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
+	ndcr |= nand->use_ecc ? NDCR_ECC_EN : 0;
+	ndcr |= nand->use_dma ? NDCR_DMA_EN : NDCR_STOP_ON_UNCOR;
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
@@ -342,146 +349,149 @@ static void pxa3xx_nand_stop(struct
pxa3xx_nand_info *info)
 	/* wait RUN bit in NDCR become 0 */
 	do {
 		/* clear status bits */
-		nand_writel(info, NDSR, NDSR_MASK);
-		ndcr = nand_readl(info, NDCR);
+		nand_writel(nand, NDSR, NDSR_MASK);
+		ndcr = nand_readl(nand, NDCR);
 		udelay(1);
 	} while ((ndcr & NDCR_ND_RUN) && (timeout -- > 0));

 	if (timeout <= 0) {
 		ndcr &= ~(NDCR_ND_RUN);
-		nand_writel(info, NDCR, ndcr);
+		nand_writel(nand, NDCR, ndcr);
 	}
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
-	if (info->state & STATE_IS_WRITE) {
-		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
-				DIV_ROUND_UP(info->data_size, 4));
-		if (info->oob_size > 0)
-			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
-					DIV_ROUND_UP(info->oob_size, 4));
+	if (nand->state & STATE_IS_WRITE) {
+		__raw_writesl(nand->mmio_base + NDDB, nand->data_buff,
+				DIV_ROUND_UP(nand->data_size, 4));
+		if (nand->oob_size > 0)
+			__raw_writesl(nand->mmio_base + NDDB, nand->oob_buff,
+					DIV_ROUND_UP(nand->oob_size, 4));

 	}
 	else {
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
 	}
 }

-static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
+static void start_data_dma(struct pxa3xx_nand *nand, int dir_out)
 {
-	struct pxa_dma_desc *desc = info->data_desc;
-	int dma_len = ALIGN(info->data_size + info->oob_size, 32);
+	struct pxa_dma_desc *desc = nand->data_desc;
+	int dma_len = ALIGN(nand->data_size + nand->oob_size, 32);

 	desc->ddadr = DDADR_STOP;
 	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;

 	if (dir_out) {
-		desc->dsadr = info->data_buff_phys;
-		desc->dtadr = info->mmio_phys + NDDB;
+		desc->dsadr = nand->data_buff_phys;
+		desc->dtadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCSRCADDR | DCMD_FLOWTRG;
 	} else {
-		desc->dtadr = info->data_buff_phys;
-		desc->dsadr = info->mmio_phys + NDDB;
+		desc->dtadr = nand->data_buff_phys;
+		desc->dsadr = nand->mmio_phys + NDDB;
 		desc->dcmd |= DCMD_INCTRGADDR | DCMD_FLOWSRC;
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

-	enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
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

-		info->state |= STATE_DATA_PROCESSING;
+		nand->state |= STATE_DATA_PROCESSING;
 		/* whether use dma to transfer data */
-		if (info->use_dma) {
-			disable_int(info, NDSR_WRDREQ);
-			start_data_dma(info, 0);
+		if (nand->use_dma) {
+			disable_int(nand, NDCR_INT_MASK);
+			start_data_dma(nand, nand->state & STATE_IS_WRITE);
 			goto NORMAL_IRQ_EXIT;
 		} else
-			handle_data_pio(info);
+			handle_data_pio(nand);

-		info->state |= STATE_DATA_DONE;
+		nand->state |= STATE_DATA_DONE;
 	}
-	if (status & NDSR_CS0_CMDD) {
-		info->state |= STATE_CMD_DONE;
+	if (status & cmd_done) {
+		nand->state |= STATE_CMD_DONE;
 		is_completed = 1;
 	}
-	if (status & NDSR_FLASH_RDY)
-		info->state |= STATE_READY;
-	if (status & NDSR_CS0_PAGED)
-		info->state |= STATE_PAGE_DONE;
+	if (status & ready)
+		nand->state |= STATE_READY;
+	if (status & page_done)
+		nand->state |= STATE_PAGE_DONE;

 	if (status & NDSR_WRCMDREQ) {
-		nand_writel(info, NDSR, NDSR_WRCMDREQ);
+		nand_writel(nand, NDSR, NDSR_WRCMDREQ);
 		status &= ~NDSR_WRCMDREQ;
-		info->state |= STATE_CMD_WAIT_DONE;
-		nand_writel(info, NDCB0, info->ndcb0);
-		nand_writel(info, NDCB0, info->ndcb1);
-		nand_writel(info, NDCB0, info->ndcb2);
+		nand->state |= STATE_CMD_WAIT_DONE;
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
@@ -490,40 +500,48 @@ static inline int is_buf_blank(uint8_t *buf, size_t len)
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
+	ndcb0 = (nand->chip_select) ? NDCB0_CSEL : 0;;
 	addr_cycle = 0;
 	exec_cmd = 1;

 	/* reset data and oob column point to handle data */
-	info->buf_start		= 0;
-	info->buf_count		= 0;
-	info->oob_size		= 0;
-	info->use_ecc		= 0;
+	nand->buf_start		= 0;
+	nand->buf_count		= 0;
+	nand->ndcb0		= ndcb0;
+	nand->data_size		= 0;
+	nand->oob_size		= 0;
+	nand->use_ecc		= 0;
+	nand->use_dma		= 0;
+	nand->state		= 0;
+	nand->command		= command;

 	switch (command) {
 	case NAND_CMD_READ0:
 	case NAND_CMD_PAGEPROG:
-		info->use_ecc = 1;
+		nand->use_ecc = info->use_ecc;
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
 	addr_cycle = NDCB0_ADDR_CYC(info->row_addr_cycles
 			+ info->col_addr_cycles);

@@ -533,16 +551,16 @@ static int prepare_command_pool(struct
pxa3xx_nand_info *info, int command,

 		cmd  = cmdset.read1;
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
@@ -550,35 +568,35 @@ static int prepare_command_pool(struct
pxa3xx_nand_info *info, int command,
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
 		if (unlikely(info->page_size < PAGE_CHUNK_SIZE)) {
-			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
+			nand->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);

-			info->ndcb2 = 0;
+			nand->ndcb2 = 0;
 		}
 		else {
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
-		if (is_buf_blank(info->data_buff, (mtd->writesize + mtd->oobsize))) {
+		if (is_buf_blank(nand->data_buff, (mtd->writesize + mtd->oobsize))) {
 			exec_cmd = 0;
 			break;
 		}

 		cmd = cmdset.program;
-		info->state |= STATE_IS_WRITE;
-		info->ndcb0 |= NDCB0_CMD_TYPE(0x1)
+		nand->state |= STATE_IS_WRITE;
+		nand->ndcb0 |= NDCB0_CMD_TYPE(0x1)
 				| NDCB0_AUTO_RS
 				| NDCB0_ST_ROW_EN
 				| NDCB0_DBC
@@ -588,38 +606,38 @@ static int prepare_command_pool(struct
pxa3xx_nand_info *info, int command,

 	case NAND_CMD_READID:
 		cmd = cmdset.read_id;
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
 		cmd = cmdset.read_status;
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
 		cmd = cmdset.erase;
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
 		cmd = cmdset.reset;
-		info->ndcb0 |= NDCB0_CMD_TYPE(5)
+		nand->ndcb0 |= NDCB0_CMD_TYPE(5)
 				| cmd;

 		break;
@@ -630,7 +648,7 @@ static int prepare_command_pool(struct
pxa3xx_nand_info *info, int command,

 	default:
 		exec_cmd = 0;
-		printk(KERN_ERR "pxa3xx-nand: non-supported command %x\n", command);
+		dev_err(&nand->pdev->dev, "non-supported command %x\n", command);
 		break;
 	}

@@ -641,6 +659,7 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 				int column, int page_addr)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;
 	int ret, exec_cmd;

 	/* if this is a x16 device ,then convert the input
@@ -650,32 +669,40 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info
*mtd, unsigned command,
 	if (info->reg_ndcr & NDCR_DWIDTH_M)
 		column /= 2;

-	exec_cmd = prepare_command_pool(info, command, column, page_addr);
+	/* reset timing */
+	if (nand->chip_select != info->chip_select) {
+		nand->chip_select = info->chip_select;
+		nand_writel(nand, NDTR0CS0, info->ndtr0cs0);
+		nand_writel(nand, NDTR1CS0, info->ndtr1cs0);
+	}
+
+	exec_cmd = prepare_command_pool(nand, command, column, page_addr);
 	if (exec_cmd) {
-		init_completion(&info->cmd_complete);
-		info->state |= STATE_CMD_PREPARED;
-		pxa3xx_nand_start(info);
+		init_completion(&nand->cmd_complete);
+		nand->state |= STATE_CMD_PREPARED;
+		pxa3xx_nand_start(nand);

-		ret = wait_for_completion_timeout(&info->cmd_complete,
+		ret = wait_for_completion_timeout(&nand->cmd_complete,
 				CHIP_DELAY_TIMEOUT);
 		if (!ret) {
-			printk(KERN_ERR "Wait time out!!!\n");
+			dev_err(&nand->pdev->dev, "Wait time out!!!\n");
 		}
 		/* Stop State Machine for next command cycle */
-		pxa3xx_nand_stop(info);
-		disable_int(info, NDCR_INT_MASK);
-		info->state &= ~STATE_CMD_PREPARED;
+		pxa3xx_nand_stop(nand);
+		disable_int(nand, NDCR_INT_MASK);
+		nand->state &= ~STATE_CMD_PREPARED;
 	}
 }

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
@@ -683,11 +710,12 @@ static uint8_t pxa3xx_nand_read_byte(struct mtd_info *mtd)
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
@@ -695,20 +723,22 @@ static u16 pxa3xx_nand_read_word(struct mtd_info *mtd)
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
@@ -725,10 +755,11 @@ static void pxa3xx_nand_select_chip(struct
mtd_info *mtd, int chip)
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
@@ -742,47 +773,16 @@ static int pxa3xx_nand_waitfunc(struct mtd_info
*mtd, struct nand_chip *this)
 	return 0;
 }

-static void pxa3xx_nand_ecc_hwctl(struct mtd_info *mtd, int mode)
-{
-	return;
-}
-
-static int pxa3xx_nand_ecc_calculate(struct mtd_info *mtd,
-		const uint8_t *dat, uint8_t *ecc_code)
-{
-	return 0;
-}
-
-static int pxa3xx_nand_ecc_correct(struct mtd_info *mtd,
-		uint8_t *dat, uint8_t *read_ecc, uint8_t *calc_ecc)
-{
-	struct pxa3xx_nand_info *info = mtd->priv;
-	/*
-	 * Any error include ERR_SEND_CMD, ERR_DBERR, ERR_BUSERR, we
-	 * consider it as a ecc error which will tell the caller the
-	 * read fail We have distinguish all the errors, but the
-	 * nand_read_ecc only check this function return value
-	 *
-	 * Corrected (single-bit) errors must also be noted.
-	 */
-	if (info->retcode == ERR_SBERR)
-		return 1;
-	else if (info->retcode != ERR_NONE)
-		return -1;
-
-	return 0;
-}
-
 static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 				    const struct pxa3xx_nand_flash *f)
 {
-	struct platform_device *pdev = info->pdev;
+	struct pxa3xx_nand *nand = info->nand_data;
+	struct platform_device *pdev = nand->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	uint32_t ndcr = 0;

 	/* calculate flash information */
 	info->page_size = f->page_size;
-	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;

 	/* calculate addressing information */
@@ -804,19 +804,24 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	ndcr |= NDCR_SPARE_EN; /* enable spare by default */

 	info->reg_ndcr = ndcr;
+	info->use_ecc = 1;

 	pxa3xx_nand_set_timing(info, f->timing);
 	return 0;
 }

-static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
+static int pxa3xx_nand_detect_config(struct pxa3xx_nand *nand)
 {
-	uint32_t ndcr = nand_readl(info, NDCR);
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	uint32_t ndcr = nand_readl(nand, NDCR);

-	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
+	if (nand->chip_select > 0) {
+		printk(KERN_ERR "We could not detect configure if two cs is supported!!\n");
+		BUG();
+	}
 	info->reg_ndcr = ndcr & ~(NDCR_INT_MASK | NDCR_ECC_EN | NDCR_DMA_EN
| NDCR_ND_RUN);
-	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
-	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
+	info->ndtr0cs0 = nand_readl(nand, NDTR0CS0);
+	info->ndtr1cs0 = nand_readl(nand, NDTR1CS0);

 	return 0;
 }
@@ -826,62 +831,40 @@ static int pxa3xx_nand_detect_config(struct
pxa3xx_nand_info *info)
  * data buffer and the DMA descriptor
  */
 #define MAX_BUFF_SIZE	PAGE_SIZE
-
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

 static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		struct nand_chip *chip, uint8_t *buf, int page)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
+	struct pxa3xx_nand *nand = info->nand_data;

 	chip->read_buf(mtd, buf, mtd->writesize);
 	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);

-	if (info->retcode == ERR_SBERR) {
-		switch (info->use_ecc) {
+	if (nand->retcode == ERR_SBERR) {
+		switch (nand->use_ecc) {
 			case 1:
-				mtd->ecc_stats.corrected ++;
+				mtd->ecc_stats.corrected++;
 				break;

 			case 0:
 			default:
 				break;
 		}
-	}
-	else if (info->retcode == ERR_DBERR) {
+	} else if (nand->retcode == ERR_DBERR) {
 		int buf_blank;

 		buf_blank = is_buf_blank(buf, mtd->writesize);
@@ -901,20 +884,19 @@ static void pxa3xx_nand_write_page_hwecc(struct
mtd_info *mtd,

 static void pxa3xx_nand_erase_cmd(struct mtd_info *mtd, int page)
 {
-	struct nand_chip *chip = mtd->priv;
 	/* Send commands to erase a block */
-	chip->cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
+	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_ERASE1, -1, page);
 }

-static int __devinit pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
+static int __devinit pxa3xx_nand_sensing(struct pxa3xx_nand *nand)
 {
-	struct mtd_info *mtd = info->mtd;
-	struct nand_chip *chip = mtd->priv;
+	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
+	struct mtd_info *mtd = get_mtd_by_info(info);

 	/* use the common timing to make a try */
 	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
-	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
-	if (info->state & STATE_READY)
+	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
+	if (nand->state & STATE_READY)
 		return 1;
 	else
 		return 0;
@@ -923,7 +905,8 @@ static int __devinit pxa3xx_nand_sensing(struct
pxa3xx_nand_info *info)
 static int __devinit pxa3xx_nand_scan(struct mtd_info *mtd)
 {
 	struct pxa3xx_nand_info *info = mtd->priv;
-	struct platform_device *pdev = info->pdev;
+	struct pxa3xx_nand *nand = info->nand_data;
+	struct platform_device *pdev = nand->pdev;
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct nand_flash_dev pxa3xx_flash_ids[2] = {{NULL,}, {NULL,}};
 	const struct pxa3xx_nand_flash *f = NULL;
@@ -933,28 +916,23 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 	int i, ret;

 	if (pdata->keep_config) {
-		if (pxa3xx_nand_detect_config(info) == 0)
+		if (pxa3xx_nand_detect_config(nand) == 0)
 			goto KEEP_CONFIG;
 	}

-	ret = pxa3xx_nand_sensing(info);
+	ret = pxa3xx_nand_sensing(nand);
 	if (!ret) {
-		kfree(mtd);
-		info->mtd = NULL;
-		printk(KERN_INFO "There is no nand chip on cs 0!\n");
-
+		free_cs_resource(info, nand->chip_select);
 		return -EINVAL;
 	}

 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
-	id = *((uint16_t *)(info->data_buff));
+	id = *((uint16_t *)(nand->data_buff));
 	if (id != 0)
-		printk(KERN_INFO "Detect a flash id %x\n", id);
+		dev_info(&nand->pdev->dev, "Detect a flash id %x\n", id);
 	else {
-		kfree(mtd);
-		info->mtd = NULL;
-		printk(KERN_WARNING "Read out ID 0, potential timing set wrong!!\n");
-
+		dev_warn(&nand->pdev->dev, "Read out ID 0, potential timing set wrong!!\n");
+		free_cs_resource(info, nand->chip_select);
 		return -EINVAL;
 	}

@@ -970,10 +948,8 @@ static int __devinit pxa3xx_nand_scan(struct mtd_info *mtd)
 	}

 	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
-		kfree(mtd);
-		info->mtd = NULL;
-		printk(KERN_ERR "ERROR!! flash not defined!!!\n");
-
+		dev_err(&nand->pdev->dev, "ERROR!! flash not defined!!!\n");
+		free_cs_resource(info, nand->chip_select);
 		return -EINVAL;
 	}

@@ -990,15 +966,15 @@ KEEP_CONFIG:
 		return -ENODEV;
 	/* calculate addressing information */
 	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
-	info->oob_buff = info->data_buff + mtd->writesize;
 	if ((mtd->size >> chip->page_shift) > 65536)
 		info->row_addr_cycles = 3;
 	else
 		info->row_addr_cycles = 2;
-	mtd->name = mtd_names[0];
+	info->page_size = mtd->writesize;
+	mtd->name = mtd_names[nand->chip_select];
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.size = mtd->writesize;
-	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16: 0;
+	chip->options |= (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16: 0;
 	chip->options |= NAND_NO_READRDY;
 	chip->options |= NAND_USE_FLASH_BBT;

@@ -1010,49 +986,25 @@ static int alloc_nand_resource(struct
platform_device *pdev)
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
+	nand = kzalloc(sizeof(struct pxa3xx_nand), GFP_KERNEL);
+	if (!nand) {
 		dev_err(&pdev->dev, "failed to allocate memory\n");
 		return -ENOMEM;
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
-	chip->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
-	chip->ecc.calculate	= pxa3xx_nand_ecc_calculate;
-	chip->ecc.correct	= pxa3xx_nand_ecc_correct;
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
-	chip->erase_cmd		= pxa3xx_nand_erase_cmd;
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
@@ -1060,7 +1012,7 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		ret = -ENXIO;
 		goto fail_put_clk;
 	}
-	info->drcmr_dat = r->start;
+	nand->drcmr_dat = r->start;

 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (r == NULL) {
@@ -1068,14 +1020,7 @@ static int alloc_nand_resource(struct
platform_device *pdev)
 		ret = -ENXIO;
 		goto fail_put_clk;
 	}
-	info->drcmr_cmd = r->start;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource defined\n");
-		ret = -ENXIO;
-		goto fail_put_clk;
-	}
+	nand->drcmr_cmd = r->start;

 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
@@ -1091,80 +1036,142 @@ static int alloc_nand_resource(struct
platform_device *pdev)
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
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource defined\n");
+		ret = -ENXIO;
+		goto fail_put_clk;
+	}

 	ret = request_irq(irq, pxa3xx_nand_irq, IRQF_DISABLED,
-			  pdev->name, info);
+			  pdev->name, nand);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
+		ret = -ENXIO;
+		goto fail_free_irq;
+	}
+
+	platform_set_drvdata(pdev, nand);
+	spin_lock_init(&nand->controller.lock);
+	init_waitqueue_head(&nand->controller.wq);
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
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
+		chip->erase_cmd		= pxa3xx_nand_erase_cmd;
+	}
+
+	if (use_dma == 0) {
+		nand->data_buff = kmalloc(MAX_BUFF_SIZE, GFP_KERNEL);
+		if (nand->data_buff == NULL) {
+			ret = -ENOMEM;
+			goto fail_free_buf;
+		}
+		goto success_exit;
+	}
+
+	nand->data_buff = dma_alloc_coherent(&pdev->dev, MAX_BUFF_SIZE,
+			&nand->data_buff_phys, GFP_KERNEL);
+	if (nand->data_buff == NULL) {
+		dev_err(&pdev->dev, "failed to allocate dma buffer\n");
+		ret = -ENOMEM;
 		goto fail_free_buf;
 	}

-	platform_set_drvdata(pdev, info);
+	nand->data_desc = (void *)nand->data_buff + data_desc_offset;
+	nand->data_desc_addr = nand->data_buff_phys + data_desc_offset;
+	nand->data_dma_ch = pxa_request_dma("nand-data", DMA_PRIO_LOW,
+			pxa3xx_nand_data_dma_irq, nand);
+	if (nand->data_dma_ch < 0) {
+		dev_err(&pdev->dev, "failed to request data dma\n");
+		ret = -ENXIO;
+		goto fail_free_buf;
+	}
+success_exit:
 	return 0;

 fail_free_buf:
-	free_irq(irq, info);
-	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
-		dma_free_coherent(&pdev->dev, info->data_buff_size,
-			info->data_buff, info->data_buff_phys);
-	} else
-		kfree(info->data_buff);
-fail_free_io:
-	iounmap(info->mmio_base);
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
+		info = nand->info[cs];
+		free_cs_resource(info, cs);
+	}
+fail_free_irq:
+	free_irq(irq, nand);
+	iounmap(nand->mmio_base);
 fail_free_res:
 	release_mem_region(r->start, resource_size(r));
 fail_put_clk:
-	clk_disable(info->clk);
-	clk_put(info->clk);
-fail_free_mtd:
-	kfree(mtd);
+	clk_disable(nand->clk);
+	clk_put(nand->clk);
+fail_alloc:
+	kfree(nand);
 	return ret;
 }

 static int pxa3xx_nand_remove(struct platform_device *pdev)
 {
-	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = info->mtd;
+	struct pxa3xx_nand *nand = platform_get_drvdata(pdev);
+	struct pxa3xx_nand_info *info;
+	struct mtd_info *mtd;
 	struct resource *r;
-	int irq;
+	int irq, cs;

 	platform_set_drvdata(pdev, NULL);

-	del_mtd_device(mtd);
-	del_mtd_partitions(mtd);
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0)
-		free_irq(irq, info);
-	if (use_dma) {
-		pxa_free_dma(info->data_dma_ch);
-		dma_free_writecombine(&pdev->dev, info->data_buff_size,
-				info->data_buff, info->data_buff_phys);
-	} else
-		kfree(info->data_buff);
-
-	iounmap(info->mmio_base);
+		free_irq(irq, nand);
+
+	iounmap(nand->mmio_base);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(r->start, resource_size(r));
-
-	clk_disable(info->clk);
-	clk_put(info->clk);
-
-	kfree(mtd);
+	clk_disable(nand->clk);
+	clk_put(nand->clk);
+
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
+		info = nand->info[cs];
+		if (!info)
+			continue;
+		mtd = get_mtd_by_info(info);
+		del_mtd_partitions(mtd);
+		del_mtd_device(mtd);
+		free_cs_resource(info, cs);
+	}
 	return 0;
 }

@@ -1172,7 +1179,11 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 {
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
-	int ret;
+	struct pxa3xx_nand *nand;
+	struct mtd_info *mtd;
+	static const char *probes[] = { "cmdlinepart", NULL };
+	struct mtd_partition *parts;
+	int nr_parts, ret, cs, probe_success = 0;

 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1184,25 +1195,30 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 	if (ret)
 		return ret;

-	info = platform_get_drvdata(pdev);
-	if (pxa3xx_nand_scan(info->mtd)) {
-		dev_err(&pdev->dev, "failed to scan nand\n");
-		pxa3xx_nand_remove(pdev);
-		return -ENODEV;
-	}
-
-	if (mtd_has_cmdlinepart()) {
-		static const char *probes[] = { "cmdlinepart", NULL };
-		struct mtd_partition *parts;
-		int nr_parts;
-
-		nr_parts = parse_mtd_partitions(info->mtd, probes, &parts, 0);
-
-		if (nr_parts)
-			return add_mtd_partitions(info->mtd, parts, nr_parts);
+	nand = platform_get_drvdata(pdev);
+	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
+		info = nand->info[cs];
+		mtd = get_mtd_by_info(info);
+		if (pxa3xx_nand_scan(mtd)) {
+			dev_err(&pdev->dev, "failed to scan cs#%d nand\n", cs);
+			continue;
+		}
+		nr_parts = 0;
+		if (mtd_has_cmdlinepart()) {
+			nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
+			if (nr_parts)
+				ret = add_mtd_partitions(mtd, parts, nr_parts);
+		}
+		if (!nr_parts)
+			ret = add_mtd_partitions(mtd, pdata->parts[cs],
+					pdata->nr_parts[cs]);
+		if (!ret)
+			probe_success = 1;
 	}

-	return add_mtd_partitions(info->mtd, pdata->parts, pdata->nr_parts);
+	if (!probe_success)
+		pxa3xx_nand_remove(pdev);
+	return ret;
 }

 #ifdef CONFIG_PM
-- 
1.7.0.4
