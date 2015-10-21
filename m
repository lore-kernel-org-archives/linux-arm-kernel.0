From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 21 Oct 2015 10:29:02 +0200
Subject: [PATCH v4 3/5] mtd: pxa3xx_nand: add helpers to setup the timings
In-Reply-To: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1445416144-9194-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helpers to setup the timings in the pxa3xx driver. These helpers
allow to either make use of the nand framework nand_sdr_timings or the
pxa3xx specific pxa3xx_nand_host, for compatibility reasons.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 122 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 91605c1ee169..54f92837be8a 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -418,6 +418,128 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 	nand_writel(info, NDTR1CS0, ndtr1);
 }
 
+static void pxa3xx_nand_set_sdr_timing(struct pxa3xx_nand_host *host,
+				       const struct nand_sdr_timings *t)
+{
+	struct pxa3xx_nand_info *info = host->info_data;
+	struct nand_chip *chip = &host->chip;
+	unsigned long nand_clk = clk_get_rate(info->clk);
+	uint32_t ndtr0, ndtr1;
+
+	u32 tCH_min = DIV_ROUND_UP(t->tCH_min, 1000);
+	u32 tCS_min = DIV_ROUND_UP(t->tCS_min, 1000);
+	u32 tWH_min = DIV_ROUND_UP(t->tWH_min, 1000);
+	u32 tWP_min = DIV_ROUND_UP(t->tWC_min - t->tWH_min, 1000);
+	u32 tREH_min = DIV_ROUND_UP(t->tREH_min, 1000);
+	u32 tRP_min = DIV_ROUND_UP(t->tRC_min - t->tREH_min, 1000);
+	u32 tR = chip->chip_delay * 1000;
+	u32 tWHR_min = DIV_ROUND_UP(t->tWHR_min, 1000);
+	u32 tAR_min = DIV_ROUND_UP(t->tAR_min, 1000);
+
+	/* fallback to a default value if tR = 0 */
+	if (!tR)
+		tR = 20000;
+
+	ndtr0 = NDTR0_tCH(ns2cycle(tCH_min, nand_clk)) |
+		NDTR0_tCS(ns2cycle(tCS_min, nand_clk)) |
+		NDTR0_tWH(ns2cycle(tWH_min, nand_clk)) |
+		NDTR0_tWP(ns2cycle(tWP_min, nand_clk)) |
+		NDTR0_tRH(ns2cycle(tREH_min, nand_clk)) |
+		NDTR0_tRP(ns2cycle(tRP_min, nand_clk));
+
+	ndtr1 = NDTR1_tR(ns2cycle(tR, nand_clk)) |
+		NDTR1_tWHR(ns2cycle(tWHR_min, nand_clk)) |
+		NDTR1_tAR(ns2cycle(tAR_min, nand_clk));
+
+	info->ndtr0cs0 = ndtr0;
+	info->ndtr1cs0 = ndtr1;
+	nand_writel(info, NDTR0CS0, ndtr0);
+	nand_writel(info, NDTR1CS0, ndtr1);
+}
+
+static int pxa3xx_nand_init_timings_compat(struct pxa3xx_nand_host *host,
+					   unsigned int *flash_width,
+					   unsigned int *dfc_width)
+{
+	struct nand_chip *chip = &host->chip;
+	struct pxa3xx_nand_info *info = host->info_data;
+	const struct pxa3xx_nand_flash *f = NULL;
+	int i, id, ntypes;
+
+	ntypes = ARRAY_SIZE(builtin_flash_types);
+
+	chip->cmdfunc(host->mtd, NAND_CMD_READID, 0x00, -1);
+
+	id = chip->read_byte(host->mtd);
+	id |= chip->read_byte(host->mtd) << 0x8;
+
+	for (i = 0; i < ntypes; i++) {
+		f = &builtin_flash_types[i];
+
+		if (f->chip_id == id)
+			break;
+	}
+
+	if (i == ntypes) {
+		dev_err(&info->pdev->dev, "Error: timings not found\n");
+		return -EINVAL;
+	}
+
+	pxa3xx_nand_set_timing(host, f->timing);
+
+	*flash_width = f->flash_width;
+	*dfc_width = f->dfc_width;
+
+	return 0;
+}
+
+static int pxa3xx_nand_init_timings_onfi(struct pxa3xx_nand_host *host,
+					 int mode)
+{
+	const struct nand_sdr_timings *timings;
+
+	mode = fls(mode) - 1;
+	if (mode < 0)
+		mode = 0;
+
+	timings = onfi_async_timing_mode_to_sdr_timings(mode);
+	if (IS_ERR(timings))
+		return PTR_ERR(timings);
+
+	pxa3xx_nand_set_sdr_timing(host, timings);
+
+	return 0;
+}
+
+static int pxa3xx_nand_init(struct pxa3xx_nand_host *host)
+{
+	struct nand_chip *chip = &host->chip;
+	struct pxa3xx_nand_info *info = host->info_data;
+	unsigned int flash_width = 0, dfc_width = 0;
+	int mode, err;
+
+	mode = onfi_get_async_timing_mode(chip);
+	if (mode == ONFI_TIMING_MODE_UNKNOWN) {
+		err = pxa3xx_nand_init_timings_compat(host, &flash_width,
+						      &dfc_width);
+		if (err)
+			return err;
+
+		if (flash_width == 16) {
+			info->reg_ndcr |= NDCR_DWIDTH_M;
+			chip->options |= NAND_BUSWIDTH_16;
+		}
+
+		info->reg_ndcr |= (dfc_width == 16) ? NDCR_DWIDTH_C : 0;
+	} else {
+		err = pxa3xx_nand_init_timings_onfi(host, mode);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Set the data and OOB size, depending on the selected
  * spare and ECC configuration.
-- 
2.6.2
