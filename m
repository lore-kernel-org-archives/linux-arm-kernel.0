From: leiwen@marvell.com (Lei Wen)
Date: Mon, 29 Mar 2010 09:18:09 +0800
Subject: [PATCH] mtd: pxa3xx_nand: show the real time used by the controller
Message-ID: <mailman.431.1273818072.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The electronic signal timing is not that simple that we set to timing
register. Sometimes it is difficult to find current timing is not what
NAND chip spec want. So we add show real timing function to give intuitive
check whether current timing meet the need.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    1 +
 drivers/mtd/nand/pxa3xx_nand.c               |  239 ++++++++++++++++++++------
 2 files changed, 189 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 7c99390..c428897 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -15,6 +15,7 @@ struct pxa3xx_nand_platform_data {

 	/* Whether the controller support using naked command set */
 	int	naked_cmd_support;
+	unsigned int RD_CNT_DEL;

 	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
 	unsigned int				nr_parts[NUM_CHIP_SELECT];
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 94702df..56559e1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -90,6 +90,27 @@
 #define NDCR_WRCMDREQM          (0x1)
 #define NDCR_INT_MASK           (0xFFF)

+/* Data Controller Timing Paramter x Register For CSx */
+#define NDTR0_tADL(c)           (min_t(uint32_t, (c), 31) << 27)
+#define NDTR0_SELCNTR           (0x1 << 26)
+#define NDTR0_RD_CNT_DEL_MASK   (0xF << 22)
+#define NDTR0_RD_CNT_DEL(x)     (((x) << 22) & NDTR0_RD_CNT_DEL_MASK)
+#define NDTR0_tCH(c)            (min_t(uint32_t, (c), 7) << 19)
+#define NDTR0_tCS(c)            (min_t(uint32_t, (c), 7) << 16)
+#define NDTR0_tWH(c)            (min_t(uint32_t, (c), 7) << 11)
+#define NDTR0_tWP(c)            (min_t(uint32_t, (c), 7) << 8)
+#define NDTR0_sel_NRE_EDGE      (0x1 << 7)
+#define NDTR0_ETRP              (0x1 << 6)
+#define NDTR0_tRH(c)            (min_t(uint32_t, (c), 7) << 3)
+#define NDTR0_tRP(c)            (min_t(uint32_t, (c), 7) << 0)
+
+#define NDTR1_tR(c)             (min_t(uint32_t, (c), 65535) << 16)
+#define NDTR1_WAIT_MODE         (0x1 << 15)
+#define NDTR1_PRESCALE          (0x1 << 14)
+#define NDTR1_tRHW(c)           (min_t(uint32_t, (c), 3) << 8)
+#define NDTR1_tWHR(c)           (min_t(uint32_t, (c), 15) << 4)
+#define NDTR1_tAR(c)            (min_t(uint32_t, (c), 15) << 0)
+
 #define NDSR_MASK		(0xfff)
 #define NDSR_RDY                (0x1 << 12)
 #define NDSR_FLASH_RDY          (0x1 << 11)
@@ -166,6 +187,7 @@ enum {
 };

 struct pxa3xx_nand_timing {
+	uint32_t	tADL; /* Adress to Write Data delay */
 	uint32_t	tCH;  /* Enable signal hold time */
 	uint32_t	tCS;  /* Enable signal setup time */
 	uint32_t	tWH;  /* ND_nWE high duration */
@@ -173,6 +195,7 @@ struct pxa3xx_nand_timing {
 	uint32_t	tRH;  /* ND_nRE high duration */
 	uint32_t	tRP;  /* ND_nRE pulse width */
 	uint32_t	tR;   /* ND_nWE high to ND_nRE low for read */
+	uint32_t	tRHW; /* delay for next command issue */
 	uint32_t	tWHR; /* ND_nWE high to ND_nRE low for status read */
 	uint32_t	tAR;  /* ND_ALE low to ND_nRE low delay */
 };
@@ -254,6 +277,7 @@ struct pxa3xx_nand {
 	uint8_t			use_ecc;
 	uint8_t			use_dma;
 	uint8_t			wait_mode;
+	uint32_t		RD_CNT_DEL;

 	/* relate to the command */
 	uint32_t		state;
@@ -297,82 +321,194 @@ const static struct pxa3xx_nand_cmdset cmdset = {
  * detect the chip id before we know how to optimize further
  */
 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-{ 0, 0, 0, 0, 0, 0, 0, { 40, 80, 60, 100, 80, 100, 90000, 400, 40, }, },
+{ 0, 0, 0, 0, 0, 0, 0, { 0, 40, 80, 60, 100, 80, 100, 90000, 0, 400, 40, }, },
 { 0x46ec, 32, 512, 16, 16, ECC_HAMMIN, 4096, \
-	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xdaec, 64, 2048, 8, 8, ECC_HAMMIN, 2048, \
-	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xd3ec, 128, 2048, 8, 8, ECC_BCH, 4096, \
-	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xd7ec, 128, 4096, 8, 8, ECC_BCH, 8192, \
-	{ 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
+	{ 0, 10, 0, 20, 40, 30, 40, 11123, 0, 110, 10, }, },
 { 0xa12c, 64, 2048, 8, 8, ECC_HAMMIN, 1024, \
-	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0xb12c, 64, 2048, 16, 16, ECC_HAMMIN, 1024, \
-	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0xdc2c, 64, 2048, 8, 8, ECC_HAMMIN, 4096, \
-	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0xcc2c, 64, 2048, 16, 16, ECC_HAMMIN, 4096, \
-	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+	{ 0, 10, 25, 15, 25, 15, 30, 25000, 0, 60, 10, }, },
 { 0x382c, 128, 4096, 8, 8, ECC_BCH, 2048, \
-	{ 10, 25, 15, 25, 15, 30, 25000, 60, 10, }, },
+	{ 120, 8, 55, 15, 30, 30, 30, 25000, 60, 170, 15, }, },
 { 0xba20, 64, 2048, 16, 16, ECC_HAMMIN, 2048, \
-	{ 10, 35, 15, 25, 15, 25, 25000, 60, 10, }, },
+	{ 0, 10, 35, 15, 25, 15, 25, 25000, 0, 60, 10, }, },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};

-#define NDTR0_tCH(c)	(min((c), 7) << 19)
-#define NDTR0_tCS(c)	(min((c), 7) << 16)
-#define NDTR0_tWH(c)	(min((c), 7) << 11)
-#define NDTR0_tWP(c)	(min((c), 7) << 8)
-#define NDTR0_tRH(c)	(min((c), 7) << 3)
-#define NDTR0_tRP(c)	(min((c), 7) << 0)
-
-#define NDTR1_tR(c)	(min((c), 65535) << 16)
-#define NDTR1_tWHR(c)	(min((c), 15) << 4)
-#define NDTR1_tAR(c)	(min((c), 15) << 0)
+/* convert nano-seconds to nand flash controller clock cycles */
+#define ns2cycle(ns, clk)       (int)(((ns) * (clk / 1000000) / 1000) + 1)

-#define tCH_NDTR0(r)	(((r) >> 19) & 0x7)
-#define tCS_NDTR0(r)	(((r) >> 16) & 0x7)
-#define tWH_NDTR0(r)	(((r) >> 11) & 0x7)
-#define tWP_NDTR0(r)	(((r) >> 8) & 0x7)
-#define tRH_NDTR0(r)	(((r) >> 3) & 0x7)
-#define tRP_NDTR0(r)	(((r) >> 0) & 0x7)
+/* convert nand flash controller clock cycles to nano-seconds */
+#define cycle2ns(cycle, clk)    (cycle * 1000 / (clk / 1000000))

-#define tR_NDTR1(r)	(((r) >> 16) & 0xffff)
-#define tWHR_NDTR1(r)	(((r) >> 4) & 0xf)
-#define tAR_NDTR1(r)	(((r) >> 0) & 0xf)
+/*
+ * This function shows the real timing when NAND controller
+ * send signal to the NAND chip.
+ */
+static void show_real_timing(uint32_t ndtr0, uint32_t ndtr1, unsigned
long nand_clk)
+{
+	uint32_t rtADL, rtCH, rtCS, rtWH, rtWP, rtRH, rtRP;
+	uint32_t rtR, rtRHW, rtWHR, rtAR, tmp;
+
+	rtCH = ((ndtr0 >> 19) & 0x7) + 1;
+	rtCS = ((ndtr0 >> 16) & 0x7) + 1;
+	rtWH = ((ndtr0 >> 11) & 0x7) + 1;
+	rtWP = ((ndtr0 >> 8) & 0x7) + 1;
+	rtADL= (ndtr0 >> 27) & 0x1f;
+	rtRH = ((ndtr0 >> 3) & 0x7) + 1;
+	rtRP = (ndtr0 & NDTR0_ETRP) ? ((0x8 | (ndtr0 & 0x7)) + 1)
+			: ((ndtr0 & 0x7) + 1);
+	rtRHW = (ndtr1 >> 8) & 0x3;
+	rtWHR = (ndtr1 >> 4) & 0xf;
+	rtAR = ndtr1 & 0xf;
+	rtR = (ndtr1 >> 16) & 0xffff;
+
+	if (ndtr1 & NDTR1_PRESCALE)
+		rtR *= 16;
+
+	rtR += rtCH + 2;
+	switch(rtRHW) {
+	case 0:
+		rtRHW = 0;
+		break;
+	case 1:
+		rtRHW = 16;
+		break;
+	case 2:
+		rtRHW = 32;
+		break;
+	case 3:
+		rtRHW = 48;
+		break;
+	}

-/* convert nano-seconds to nand flash controller clock cycles */
-#define ns2cycle(ns, clk)	(int)(((ns) * (clk / 1000000) / 1000) - 1)
+	/*
+	 * TWHR delay=max(tAR, max(0, tWHR-max(tWH, tCH)))
+	 * TAR delay=max(tAR, max(0, tWHR-max(tWH, tCH))) + 2
+	 */
+	if (rtWH > rtCH)
+		tmp = rtWH - 1;
+	else
+		tmp = rtCH - 1;
+	if (rtADL != 0) {
+		rtADL = rtADL - 3 - rtWP;
+		rtADL = rtADL > 0 ? rtADL : 0;
+		rtADL = rtADL + tmp + rtWP + 8;
+	}
+	if (rtWHR < tmp)
+		rtWHR = rtAR;
+	else {
+		if (rtAR > (rtWHR - tmp))
+			rtWHR = rtAR;
+		else
+			rtWHR = rtWHR - tmp;
+	}
+	rtAR = rtWHR + 2;
+	printk("Shows real timing(ns):\n");
+	if (ndtr0 & NDTR0_SELCNTR)
+		printk("NDTR0 SELCNTR is set\n");
+	else
+		printk("NDTR0 SELCNTR is not set\n");
+	if (ndtr0 & NDTR0_RD_CNT_DEL_MASK)
+		printk("Read Strobe delay is %d\n",
+				(ndtr0 & NDTR0_RD_CNT_DEL_MASK) >> 22);
+	else
+		printk("No Read Stobe delay\n");
+	if (ndtr0 & NDTR0_sel_NRE_EDGE)
+		printk("Controller is using falling edge to detect RE\n");
+	else
+		printk("Controller is using rising edge to detect RE\n");

-/* convert nand flash controller clock cycles to nano-seconds */
-#define cycle2ns(c, clk)	((((c) + 1) * 1000000 + clk / 500) / (clk / 1000))
+	if (ndtr1 & NDTR1_WAIT_MODE)
+		printk("NDTR1 wait mode is set\n");
+	else
+		printk("NDTR1 wait mode is not set\n");
+
+	printk("TADL is %ld TCH is %ld TCS is %ld TWH is %ld TWP is %ld TRH is %ld "
+		"TRP is %ld TR is %ld TRHW is %ld TWHR is %ld TAR is %ld\n",
+		cycle2ns(rtADL, nand_clk), cycle2ns(rtCH, nand_clk),
+		cycle2ns(rtCS, nand_clk), cycle2ns(rtWH, nand_clk),
+		cycle2ns(rtWP, nand_clk), cycle2ns(rtRH, nand_clk),
+		cycle2ns(rtRP, nand_clk), cycle2ns(rtR, nand_clk),
+		cycle2ns(rtRHW, nand_clk), cycle2ns(rtWHR, nand_clk),
+		cycle2ns(rtAR, nand_clk));
+}

 static void pxa3xx_nand_set_timing(struct pxa3xx_nand_info *info,
-				   const struct pxa3xx_nand_timing *t)
+			   struct pxa3xx_nand_timing *t, int show_timing)
 {
 	struct pxa3xx_nand *nand = info->nand_data;
 	unsigned long nand_clk;
-	uint32_t ndtr0, ndtr1;
+	uint32_t ndtr0, ndtr1, tRP, tR, tRHW, tADL;

 	nand_clk = clk_get_rate(nand->clk);
-	ndtr0 = NDTR0_tCH(ns2cycle(t->tCH, nand_clk)) |
-		NDTR0_tCS(ns2cycle(t->tCS, nand_clk)) |
-		NDTR0_tWH(ns2cycle(t->tWH, nand_clk)) |
-		NDTR0_tWP(ns2cycle(t->tWP, nand_clk)) |
-		NDTR0_tRH(ns2cycle(t->tRH, nand_clk)) |
-		NDTR0_tRP(ns2cycle(t->tRP, nand_clk));
+	ndtr0 = ndtr1 = 0;
+	tRP = ns2cycle(t->tRP, nand_clk);
+	tRP = (tRP > 0xf) ? 0xf : tRP;
+	if (tRP > 0x7) {
+		ndtr0 |= NDTR0_ETRP;
+		tRP -= 0x7;
+	}
+	tR = ns2cycle(t->tR, nand_clk);
+	if (tR > 0xffff) {
+		ndtr1 |= NDTR1_PRESCALE;
+		tR /= 16;
+	}
+	if (t->tRHW > 0) {
+		tRHW = ns2cycle(t->tRHW, nand_clk);
+		if (tRHW < 16)
+			tRHW = 1;
+		else {
+			if (tRHW < 32)
+				tRHW = 2;
+			else
+				tRHW = 3;
+		}
+	}
+	else
+		tRHW = 0;
+	tADL = (t->tADL > 0) ? ns2cycle(t->tADL, nand_clk) : 0;
+
+	if (nand->RD_CNT_DEL > 0)
+		ndtr0 |= NDTR0_SELCNTR
+			| (NDTR0_RD_CNT_DEL(nand->RD_CNT_DEL - 1));
+
+	ndtr0 |= NDTR0_tADL(tADL)
+		| NDTR0_tCH(ns2cycle(t->tCH, nand_clk))
+		| NDTR0_tCS(ns2cycle(t->tCS, nand_clk))
+		| NDTR0_tWH(ns2cycle(t->tWH, nand_clk))
+		| NDTR0_tWP(ns2cycle(t->tWP, nand_clk))
+		| NDTR0_tRH(ns2cycle(t->tRH, nand_clk))
+		| NDTR0_tRP(tRP)
+		| NDTR0_SELCNTR;
+
+	if (nand->wait_mode)
+		ndtr1 |= NDTR1_WAIT_MODE;
+
+	ndtr1 |= NDTR1_tR(tR)
+		| NDTR1_tRHW(tRHW)
+		| NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk))
+		| NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

-	ndtr1 = NDTR1_tR(ns2cycle(t->tR, nand_clk)) |
-		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
-		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));

-	info->ndtr0cs0 = ndtr0;
-	info->ndtr1cs0 = ndtr1;
 	nand_writel(nand, NDTR0CS0, ndtr0);
 	nand_writel(nand, NDTR1CS0, ndtr1);
+	nand_writel(nand, NDREDEL, 0x0);
+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
+	if (show_timing)
+		show_real_timing(ndtr0, ndtr1, nand_clk);
 }

 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
@@ -1060,7 +1196,7 @@ static int pxa3xx_nand_waitfunc(struct mtd_info
*mtd, struct nand_chip *this)
 }

 static void pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
-				    const struct pxa3xx_nand_flash *f)
+			    struct pxa3xx_nand_flash *f, int show_timing)
 {
 	struct pxa3xx_nand *nand = info->nand_data;
 	struct platform_device *pdev = nand->pdev;
@@ -1125,7 +1261,7 @@ static void pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,

 	info->reg_ndcr = ndcr;

-	pxa3xx_nand_set_timing(info, &f->timing);
+	pxa3xx_nand_set_timing(info, &f->timing, show_timing);
 }

 /* the maximum possible buffer size for large page with OOB data
@@ -1227,7 +1363,7 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand *nand)
 	struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
 	struct mtd_info *mtd = get_mtd_by_info(info);
 	/* use the common timing to make a try */
-	pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
+	pxa3xx_nand_config_flash(info, &builtin_flash_types[0], 0);
 	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
 	if (nand->state & STATE_READY)
 		return 1;
@@ -1270,7 +1406,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)

 		/* find the chip in default list */
 		if (f->chip_id == id) {
-			pxa3xx_nand_config_flash(info, f);
+			pxa3xx_nand_config_flash(info, f, 1);
 			chip->cellinfo = info->data_buff[2];
 			mtd->writesize = f->page_size;
 			mtd->writesize_shift = ffs(mtd->writesize) - 1;
@@ -1556,6 +1692,7 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 		return ret;

 	nand = platform_get_drvdata(pdev);
+	nand->RD_CNT_DEL = pdata->RD_CNT_DEL;
 	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
 		info = nand->info[cs];
 		mtd = get_mtd_by_info(info);
-- 
1.5.6.5
