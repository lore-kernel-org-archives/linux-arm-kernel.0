From: josh.wu@atmel.com (Josh Wu)
Date: Thu,  3 May 2012 20:37:35 +0800
Subject: [PATCH v5] MTD: atmel_nand: Update driver to support Programmable
 Multibit ECC controller
Message-ID: <1336048655-29486-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Programmable Multibit ECC (PMECC) controller is a programmable binary
BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
can be used to support both SLC and MLC NAND Flash devices. It supports to
generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.

To use this driver, the user needs to pass in the correction capability and
the sector size.

This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
YAFFS2, UBIFS and mtd-utils.

Signed-off-by: Hong Xu <hong.xu@atmel.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
Hi, 

Since Hong Xu will not work on pmecc part. so I send out this patch base Hong Xu's latest work.

Changes since v4,
	fix typo and checkpatch warnings.
	fix according to JC's suggestion. replace cpu_is_xxx() with DT
	modify dt binding atmel nand document to add pmecc support.
	tested in sam9263 without break hw ecc.
	add ecc.strength.

 .../devicetree/bindings/mtd/atmel-nand.txt         |    5 +
 drivers/mtd/nand/atmel_nand.c                      |  955 ++++++++++++++++++--
 drivers/mtd/nand/atmel_nand_ecc.h                  |  123 ++-
 3 files changed, 1004 insertions(+), 79 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index a200695..8936175 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -16,9 +16,14 @@ Optional properties:
 - nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
   Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
   "soft_bch".
+- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
+  Controller. Supported values are: 2, 4, 8, 12, 24.
+- atmel,sector-size : sector size for ECC computation. Supported values are:
+  512, 1024.
 - nand-bus-width : 8 or 16 bus width if not present 8
 - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
 
+
 Examples:
 nand0: nand at 40000000,0 {
 	compatible = "atmel,at91rm9200-nand";
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 2165576..0928876 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -15,6 +15,8 @@
  *     		(u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
  *     (C) Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
  *
+ *  Add Programmable Multibit ECC support for various AT91 SoC
+ *     (C) Copyright 2012 ATMEL, Hong Xu
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -28,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_mtd.h>
@@ -42,19 +45,55 @@
 
 #include <mach/cpu.h>
 
+/* Hardware ECC registers */
+#include "atmel_nand_ecc.h"
+
 static int use_dma = 1;
 module_param(use_dma, int, 0);
 
 static int on_flash_bbt = 0;
 module_param(on_flash_bbt, int, 0);
 
-/* Register access macros */
-#define ecc_readl(add, reg)				\
-	__raw_readl(add + ATMEL_ECC_##reg)
-#define ecc_writel(add, reg, value)			\
-	__raw_writel((value), add + ATMEL_ECC_##reg)
+struct atmel_nand_host {
+	struct nand_chip	nand_chip;
+	struct mtd_info		mtd;
+	void __iomem		*io_base;
+	dma_addr_t		io_phys;
+	struct atmel_nand_data	board;
+	struct device		*dev;
+	void __iomem		*ecc;
+
+	struct completion	comp;
+	struct dma_chan		*dma_chan;
+
+	void __iomem		*pmerrloc_base;
+	void __iomem		*rom_base;
+
+	int			cap;	/* Correcting capability */
+	int			ecc_bytes_per_sector;
+	int			degree;	/*Degree of remainders,GF(2**degree)*/
+	int			cw_len;	/*Length of codeword*/
+	int			sector_number;
+
+	/* lookup table for alpha_to and index_of */
+	void __iomem		*alpha_to;
+	void __iomem		*index_of;
 
-#include "atmel_nand_ecc.h"	/* Hardware ECC registers */
+	int16_t			partial_syn[2 * AT_NB_ERROR_MAX + 1];
+	int16_t			si[2 * AT_NB_ERROR_MAX + 1];
+
+	/* Sigma table */
+	int16_t		smu[AT_NB_ERROR_MAX + 2][2 * AT_NB_ERROR_MAX + 1];
+	/* polynomal order */
+	int16_t			lmu[AT_NB_ERROR_MAX + 1];
+
+	int			mu[AT_NB_ERROR_MAX + 1];
+	int			dmu[AT_NB_ERROR_MAX + 1];
+	int			delta[AT_NB_ERROR_MAX + 1];
+
+	u8			correction_cap;
+	u16			sector_size;
+};
 
 /* oob layout for large page size
  * bad block info is on bytes 0 and 1
@@ -82,17 +121,23 @@ static struct nand_ecclayout atmel_oobinfo_small = {
 	},
 };
 
-struct atmel_nand_host {
-	struct nand_chip	nand_chip;
-	struct mtd_info		mtd;
-	void __iomem		*io_base;
-	dma_addr_t		io_phys;
-	struct atmel_nand_data	board;
-	struct device		*dev;
-	void __iomem		*ecc;
+static struct nand_ecclayout atmel_pmecc_oobinfo;
 
-	struct completion	comp;
-	struct dma_chan		*dma_chan;
+/*
+ * Number of ECC bytes per sector is determined by both sector size
+ * and correction capability
+ *
+ * Correction Capability	Sector_512_bytes	Sector_1024_bytes
+ * =====================	================	=================
+ *                2-bits                 4-bytes                  4-bytes
+ *                4-bits                 7-bytes                  7-bytes
+ *                8-bits                13-bytes                 14-bytes
+ *               12-bits                20-bytes                 21-bytes
+ *               24-bits                39-bytes                 42-bytes
+ *
+ */
+static const int ecc_bytes_table[5][2] = {
+	{4, 4}, {7, 7}, {13, 14}, {20, 21}, {39, 42}
 };
 
 static int cpu_has_dma(void)
@@ -288,6 +333,699 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
 }
 
 /*
+ * Return number of ecc bytes per sector according to sector size and
+ * correction capability
+ */
+static int pmecc_get_ecc_bytes(int cap, int sector_size)
+{
+	int i, j;
+
+	switch (cap) {
+	case 2:
+		i = 0;
+		break;
+	case 4:
+		i = 1;
+		break;
+	case 8:
+		i = 2;
+		break;
+	case 12:
+		i = 3;
+		break;
+	case 24:
+		i = 4;
+		break;
+	default:
+		BUG();
+	}
+
+	switch (sector_size) {
+	case 512:
+		j = 0;
+		break;
+	case 1024:
+		j = 1;
+		break;
+	default:
+		BUG();
+	}
+
+	return ecc_bytes_table[i][j];
+}
+
+static void pmecc_config_ecc_layout(struct nand_ecclayout *layout, int oobsize,
+	int ecc_len)
+{
+	int i;
+
+	layout->eccbytes = ecc_len;
+
+	/* ECC will occupy the last ecc_len bytes continuously */
+	for (i = 0; i < ecc_len; i++)
+		layout->eccpos[i] = oobsize - ecc_len + i;
+
+	layout->oobfree[0].offset = 0;
+	layout->oobfree[0].length = oobsize - ecc_len;
+}
+
+static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
+{
+	void __iomem *p;
+
+	switch (host->sector_size) {
+	case 512:
+		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_512 +
+			AT_PMECC_LOOKUP_TABLE_SIZE_512 * sizeof(int16_t);
+		break;
+	case 1024:
+		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_1024 +
+			AT_PMECC_LOOKUP_TABLE_SIZE_1024 * sizeof(int16_t);
+		break;
+	default:
+		BUG();
+	}
+
+	return p;
+}
+
+static void __iomem *pmecc_get_index_of(struct atmel_nand_host *host)
+{
+	void __iomem *p;
+
+	switch (host->sector_size) {
+	case 512:
+		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_512;
+		break;
+	case 1024:
+		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_1024;
+		break;
+	default:
+		BUG();
+	}
+
+	return p;
+}
+
+static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
+{
+	int			i;
+	uint32_t		value;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	/* Fill odd syndromes */
+	for (i = 0; i < host->cap; i++) {
+		value = pmecc_readl_rem(host->ecc, sector, i / 2);
+		value = (i & 1) ? (value & 0xffff0000) >> 16 : value & 0xffff;
+		host->partial_syn[(2 * i) + 1] = (int16_t)value;
+	}
+}
+
+static void pmecc_substitute(struct mtd_info *mtd)
+{
+	int16_t			*si;
+	int			i, j;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+	int16_t __iomem		*alpha_to = host->alpha_to;
+	int16_t __iomem		*index_of = host->index_of;
+	int16_t			*partial_syn = host->partial_syn;
+
+	/* si[] is a table that holds the current syndrome value,
+	 * an element of that table belongs to the field
+	 */
+	si = host->si;
+
+	for (i = 1; i < 2 * AT_NB_ERROR_MAX; i++)
+		si[i] = 0;
+
+	/* Computation 2t syndromes based on S(x) */
+	/* Odd syndromes */
+	for (i = 1; i < 2 * host->cap; i += 2) {
+		si[i] = 0;
+		for (j = 0; j < host->degree; j++) {
+			if (partial_syn[i] & ((unsigned short)0x1 << j))
+				si[i] = readw_relaxed(alpha_to + i * j) ^ si[i];
+		}
+	}
+	/* Even syndrome = (Odd syndrome) ** 2 */
+	for (i = 2; i <= 2 * host->cap; i += 2) {
+		j = i / 2;
+		if (si[j] == 0)
+			si[i] = 0;
+		else {
+			int16_t tmp;
+			tmp = readw_relaxed(index_of + si[j]);
+			tmp = (tmp * 2) % host->cw_len;
+			si[i] = readw_relaxed(alpha_to + tmp);
+		}
+	}
+
+	return;
+}
+
+static void pmecc_get_sigma(struct mtd_info *mtd)
+{
+	int			i, j, k;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	uint32_t		dmu_0_count, tmp;
+	int16_t			*lmu = host->lmu;
+	int16_t			*si = host->si;
+	int			*mu = host->mu;
+	int			*dmu = host->dmu; /*Discrepancy*/
+	int			*delta = host->delta; /*Delta order*/
+	int16_t			cap = host->cap;
+	int16_t __iomem		*index_of = host->index_of;
+	int16_t __iomem		*alpha_to = host->alpha_to;
+
+	/* index of largest delta */
+	int ro;
+	int largest;
+	int diff;
+
+	dmu_0_count = 0;
+
+	/* First Row */
+
+	/* Mu */
+	host->mu[0] = -1;
+
+	memset(&host->smu[0][0], 0,
+		sizeof(int16_t) * (2 * AT_NB_ERROR_MAX + 1));
+	host->smu[0][0] = 1;
+
+	/* discrepancy set to 1 */
+	dmu[0] = 1;
+	/* polynom order set to 0 */
+	lmu[0] = 0;
+	delta[0]  = (host->mu[0] * 2 - lmu[0]) >> 1;
+
+	/* Second Row */
+
+	/* Mu */
+	host->mu[1]  = 0;
+	/* Sigma(x) set to 1 */
+	memset(&host->smu[1][0], 0,
+		sizeof(int16_t) * (2 * AT_NB_ERROR_MAX + 1));
+	host->smu[1][0] = 1;
+
+	/* discrepancy set to S1 */
+	dmu[1] = si[1];
+
+	/* polynom order set to 0 */
+	lmu[1] = 0;
+
+	delta[1]  = (host->mu[1] * 2 - lmu[1]) >> 1;
+
+	/* Init the Sigma(x) last row */
+	memset(&host->smu[cap + 1][0], 0,
+		sizeof(int16_t) * (2 * AT_NB_ERROR_MAX + 1));
+
+	for (i = 1; i <= cap; i++) {
+		host->mu[i+1] = i << 1;
+		/* Begin Computing Sigma (Mu+1) and L(mu) */
+		/* check if discrepancy is set to 0 */
+		if (dmu[i] == 0) {
+			dmu_0_count++;
+
+			tmp = ((cap - (lmu[i] >> 1) - 1) / 2);
+			if ((cap - (lmu[i] >> 1) - 1) & 0x1)
+				tmp += 2;
+			else
+				tmp += 1;
+
+			if (dmu_0_count == tmp) {
+				for (j = 0; j <= (lmu[i] >> 1) + 1; j++)
+					host->smu[cap + 1][j] = host->smu[i][j];
+				lmu[cap + 1] = lmu[i];
+				return;
+			}
+
+			/* copy polynom */
+			for (j = 0; j <= lmu[i] >> 1; j++)
+				host->smu[i + 1][j] = host->smu[i][j];
+
+			/* copy previous polynom order to the next */
+			lmu[i + 1] = lmu[i];
+		} else {
+			ro = 0;
+			largest = -1;
+			/* find largest delta with dmu != 0 */
+			for (j = 0; j < i; j++) {
+				if ((dmu[j]) && (delta[j] > largest)) {
+					largest = delta[j];
+					ro = j;
+				}
+			}
+
+			/* compute difference */
+			diff = (mu[i] - mu[ro]);
+
+			/* Compute degree of the new smu polynomial */
+			if ((lmu[i] >> 1) > ((lmu[ro] >> 1) + diff))
+				lmu[i + 1] = lmu[i];
+			else
+				lmu[i + 1] = ((lmu[ro] >> 1) + diff) * 2;
+
+			/* Init smu[i+1] with 0 */
+			for (k = 0; k < (2 * AT_NB_ERROR_MAX + 1); k++)
+				host->smu[i+1][k] = 0;
+
+			/* Compute smu[i+1] */
+			for (k = 0; k <= lmu[ro] >> 1; k++) {
+				int16_t a, b, c;
+
+				if (!(host->smu[ro][k] && dmu[i]))
+					continue;
+				a = readw_relaxed(index_of + dmu[i]);
+				b = readw_relaxed(index_of + dmu[ro]);
+				c = readw_relaxed(index_of + host->smu[ro][k]);
+				tmp = a + (host->cw_len - b) + c;
+				a = readw_relaxed(alpha_to + tmp % host->cw_len);
+				host->smu[i + 1][k + diff] = a;
+			}
+
+			for (k = 0; k <= lmu[i] >> 1; k++)
+				host->smu[i + 1][k] ^= host->smu[i][k];
+		}
+
+		/* End Computing Sigma (Mu+1) and L(mu) */
+		/* In either case compute delta */
+		delta[i + 1]  = (mu[i + 1] * 2 - lmu[i + 1]) >> 1;
+
+		/* Do not compute discrepancy for the last iteration */
+		if (i >= cap)
+			continue;
+
+		for (k = 0 ; k <= (lmu[i + 1] >> 1); k++) {
+			tmp = 2 * (i - 1);
+			if (k == 0)
+				dmu[i + 1] = si[tmp + 3];
+			else if (host->smu[i+1][k] && si[tmp + 3 - k]) {
+				int16_t a, b, c;
+				a = readw_relaxed(index_of + host->smu[i + 1][k]);
+				b = si[2 * (i - 1) + 3 - k];
+				c = readw_relaxed(index_of + b);
+				tmp = a + c;
+				tmp %= host->cw_len;
+				dmu[i + 1] = readw_relaxed(alpha_to + tmp) ^
+					dmu[i + 1];
+			}
+		}
+	}
+
+	return;
+}
+
+static int pmecc_err_location(struct mtd_info *mtd)
+{
+	int			i;
+	int			err_nbr;	/* number of error */
+	int			roots_nbr;	/* number of roots */
+	int			sector_size;
+	uint32_t		val;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	err_nbr = 0;
+	sector_size = host->sector_size;
+
+	pmerrloc_writel(host->pmerrloc_base, ELDIS, PMERRLOC_DISABLE);
+
+	for (i = 0; i <= host->lmu[host->cap + 1] >> 1; i++) {
+		pmerrloc_writel_sigma(host->pmerrloc_base, i,
+				      host->smu[host->cap + 1][i]);
+		err_nbr++;
+	}
+
+	val = (err_nbr - 1) << 16;
+	if (sector_size == 1024)
+		val |= 1;
+
+	pmerrloc_writel(host->pmerrloc_base, ELCFG, val);
+	pmerrloc_writel(host->pmerrloc_base, ELEN,
+			sector_size * 8 + host->degree * host->cap);
+
+	while (!(pmerrloc_readl(host->pmerrloc_base, ELISR)
+		 & PMERRLOC_CALC_DONE))
+		cpu_relax();
+
+	roots_nbr = (pmerrloc_readl(host->pmerrloc_base, ELISR)
+		& PMERRLOC_ERR_NUM_MASK) >> 8;
+	/* Number of roots == degree of smu hence <= cap */
+	if (roots_nbr == host->lmu[host->cap + 1] >> 1)
+		return err_nbr - 1;
+
+	/* Number of roots does not match the degree of smu
+	 * unable to correct error */
+	return -1;
+}
+
+static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf,
+		int extra_bytes, int err_nbr)
+{
+	int			i = 0;
+	int			byte_pos, bit_pos;
+	int			sector_size, ecc_size;
+	uint32_t		tmp;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	sector_size = host->sector_size;
+	ecc_size = nand_chip->ecc.bytes;
+
+	while (err_nbr) {
+		tmp = pmerrloc_readl_el(host->pmerrloc_base, i) - 1;
+		byte_pos = tmp / 8;
+		bit_pos  = tmp % 8;
+		dev_info(host->dev, "PMECC correction, byte_pos: %d" \
+			 " bit_pos: %d\n", byte_pos, bit_pos);
+
+		if (byte_pos < (sector_size + extra_bytes)) {
+			tmp = sector_size + pmecc_readl(host->ecc, SADDR);
+			if (byte_pos < tmp)
+				*(buf + byte_pos) ^= (1 << bit_pos);
+			else
+				*(buf + byte_pos + ecc_size) ^= (1 << bit_pos);
+		}
+
+		i++;
+		err_nbr--;
+	}
+
+	return;
+}
+
+static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
+	u8 *ecc)
+{
+	int			i, err_nbr;
+	uint8_t			*buf_pos;
+	int			eccbytes;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+
+	eccbytes = nand_chip->ecc.bytes;
+	for (i = 0; i < eccbytes; i++)
+		if (ecc[i] != 0xff)
+			goto normal_check;
+	/* Erased page, return OK */
+	return 0;
+
+normal_check:
+	for (i = 0; i < host->sector_number; i++) {
+		err_nbr = 0;
+		if (pmecc_stat & 0x1) {
+			buf_pos = buf + i * host->sector_size;
+
+			pmecc_gen_syndrome(mtd, i);
+			pmecc_substitute(mtd);
+			pmecc_get_sigma(mtd);
+
+			err_nbr = pmecc_err_location(mtd);
+			if (err_nbr == -1) {
+				dev_err(host->dev, "PMECC: Too many errors\n");
+				mtd->ecc_stats.failed++;
+				return -EIO;
+			} else {
+				pmecc_correct_data(mtd, buf_pos, 0, err_nbr);
+				mtd->ecc_stats.corrected += err_nbr;
+			}
+		}
+		pmecc_stat >>= 1;
+	}
+
+	return 0;
+}
+
+static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
+		struct nand_chip *chip, uint8_t *buf, int32_t page)
+{
+	uint32_t		stat;
+	int			eccsize = chip->ecc.size;
+	uint8_t			*oob = chip->oob_poi;
+	struct atmel_nand_host	*host = chip->priv;
+	uint32_t		*eccpos = chip->ecc.layout->eccpos;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+	pmecc_writel(host->ecc, CFG, (pmecc_readl(host->ecc, CFG)
+		& ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+
+	chip->read_buf(mtd, buf, eccsize);
+	chip->read_buf(mtd, oob, mtd->oobsize);
+
+	while ((pmecc_readl(host->ecc, SR) & PMECC_SR_BUSY))
+		cpu_relax();
+
+	stat = pmecc_readl(host->ecc, ISR);
+	if (stat != 0) {
+		if (pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]) != 0)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static void atmel_nand_pmecc_write_page(struct mtd_info *mtd,
+		struct nand_chip *chip, const uint8_t *buf)
+{
+	int			i, j;
+	struct atmel_nand_host	*host = chip->priv;
+	uint32_t		*eccpos = chip->ecc.layout->eccpos;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+
+	pmecc_writel(host->ecc, CFG, (pmecc_readl(host->ecc, CFG) |
+		PMECC_CFG_WRITE_OP) & ~PMECC_CFG_AUTO_ENABLE);
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
+
+	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
+
+	while ((pmecc_readl(host->ecc, SR) & PMECC_SR_BUSY))
+		cpu_relax();
+
+	for (i = 0; i < host->sector_number; i++) {
+		for (j = 0; j < host->ecc_bytes_per_sector; j++) {
+			int pos;
+
+			pos = i * host->ecc_bytes_per_sector + j;
+			chip->oob_poi[eccpos[pos]] =
+				pmecc_readb_ecc(host->ecc, i, j);
+		}
+	}
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return;
+}
+
+static void atmel_pmecc_core_init(struct mtd_info *mtd)
+{
+	uint32_t		val = 0;
+	struct nand_chip	*nand_chip = mtd->priv;
+	struct atmel_nand_host	*host = nand_chip->priv;
+	struct nand_ecclayout	*ecc_layout;
+
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+
+	switch (host->cap) {
+	case 2:
+		val = PMECC_CFG_BCH_ERR2;
+		break;
+	case 4:
+		val = PMECC_CFG_BCH_ERR4;
+		break;
+	case 8:
+		val = PMECC_CFG_BCH_ERR8;
+		break;
+	case 12:
+		val = PMECC_CFG_BCH_ERR12;
+		break;
+	case 24:
+		val = PMECC_CFG_BCH_ERR24;
+		break;
+	}
+
+	if (host->sector_size == 512)
+		val |= PMECC_CFG_SECTOR512;
+	else if (host->sector_size == 1024)
+		val |= PMECC_CFG_SECTOR1024;
+
+	switch (host->sector_number) {
+	case 1:
+		val |= PMECC_CFG_PAGE_1SECTOR;
+		break;
+	case 2:
+		val |= PMECC_CFG_PAGE_2SECTORS;
+		break;
+	case 4:
+		val |= PMECC_CFG_PAGE_4SECTORS;
+		break;
+	case 8:
+		val |= PMECC_CFG_PAGE_8SECTORS;
+		break;
+	}
+
+	val |= (PMECC_CFG_READ_OP | PMECC_CFG_SPARE_DISABLE
+		| PMECC_CFG_AUTO_DISABLE);
+	pmecc_writel(host->ecc, CFG, val);
+
+	ecc_layout = nand_chip->ecc.layout;
+	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
+	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
+	pmecc_writel(host->ecc, EADDR,
+			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
+	/* See datasheet about PMECC Clock Control Register */
+	pmecc_writel(host->ecc, CLK, 2);
+	pmecc_writel(host->ecc, IDR, 0xff);
+	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
+}
+
+static int __init atmel_pmecc_init_params(struct platform_device *pdev,
+					 struct atmel_nand_host *host)
+{
+	int			cap, sector_size, err_no;
+	struct mtd_info		*mtd;
+	struct nand_chip	*nand_chip;
+	struct resource		*regs;
+	struct resource		*regs_pmerr, *regs_rom;
+
+	cap = host->correction_cap;
+	sector_size = host->sector_size;
+	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
+		 cap, sector_size);
+
+	/* Sanity check */
+	if ((sector_size != 512) && (sector_size != 1024)) {
+		dev_err(host->dev, "Unsupported PMECC sector size: %d; " \
+			"Valid sector size: 512 or 1024 bytes\n", sector_size);
+		return -EINVAL;
+	}
+	if ((cap != 2) && (cap != 4) && (cap != 8) && (cap != 12) &&
+	    (cap != 24)) {
+		dev_err(host->dev, "Unsupported PMECC correction capability," \
+			" Valid one is either 2, 4, 8, 12 or 24\n");
+		return -EINVAL;
+	}
+
+	nand_chip = &host->nand_chip;
+	mtd = &host->mtd;
+
+	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* By default */
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!regs) {
+		dev_warn(host->dev, "Can't get I/O resource regs, " \
+				"rolling back on software ECC\n");
+		return 0;
+	}
+
+	host->ecc = ioremap(regs->start, resource_size(regs));
+	if (host->ecc == NULL) {
+		dev_err(host->dev, "ioremap failed\n");
+		err_no = -EIO;
+		goto err_pmecc_ioremap;
+	}
+
+	regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	if (regs_pmerr && regs_rom) {
+		host->pmerrloc_base = ioremap(regs_pmerr->start,
+			resource_size(regs_pmerr));
+		host->rom_base = ioremap(regs_rom->start,
+			resource_size(regs_rom));
+
+		if (host->pmerrloc_base && host->rom_base) {
+			nand_chip->ecc.mode = NAND_ECC_HW;
+			nand_chip->ecc.read_page =
+				atmel_nand_pmecc_read_page;
+			nand_chip->ecc.write_page =
+				atmel_nand_pmecc_write_page;
+		} else {
+			dev_err(host->dev, "Can not get I/O resource" \
+				" for HW PMECC controller!\n");
+			err_no = -EIO;
+			goto err_pmloc_ioremap;
+		}
+	}
+
+	/* ECC is calculated for the whole page (1 step) */
+	nand_chip->ecc.size = mtd->writesize;
+
+	/* set ECC page size and oob layout */
+	switch (mtd->writesize) {
+	case 2048:
+		host->degree = GF_DIMENSION_13;
+		host->cw_len = (1 << host->degree) - 1;
+		host->cap = cap;
+		host->sector_number = mtd->writesize / sector_size;
+		host->ecc_bytes_per_sector = pmecc_get_ecc_bytes(
+			host->cap, sector_size);
+		host->alpha_to = pmecc_get_alpha_to(host);
+		host->index_of = pmecc_get_index_of(host);
+
+		nand_chip->ecc.steps = 1;
+		nand_chip->ecc.strength = cap;
+		nand_chip->ecc.bytes = host->ecc_bytes_per_sector *
+				       host->sector_number;
+		if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
+			dev_err(host->dev, "No room for ECC bytes\n");
+			err_no = -EINVAL;
+			goto err;
+		}
+		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
+					mtd->oobsize,
+					nand_chip->ecc.bytes);
+		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
+		break;
+	case 512:
+	case 1024:
+	case 4096:
+		/* TODO */
+		dev_warn(host->dev, "Only 2048 page size is currently " \
+			"supported for PMECC, rolling back to Software ECC\n");
+	default:
+		/* page size not handled by HW ECC */
+		/* switching back to soft ECC */
+		nand_chip->ecc.mode = NAND_ECC_SOFT;
+		nand_chip->ecc.calculate = NULL;
+		nand_chip->ecc.correct = NULL;
+		nand_chip->ecc.hwctl = NULL;
+		nand_chip->ecc.read_page = NULL;
+		nand_chip->ecc.write_page = NULL;
+		nand_chip->ecc.postpad = 0;
+		nand_chip->ecc.prepad = 0;
+		nand_chip->ecc.bytes = 0;
+		err_no = 0;
+		goto err;
+	}
+
+	atmel_pmecc_core_init(mtd);
+
+	return 0;
+
+err:
+err_pmloc_ioremap:
+	iounmap(host->ecc);
+	if (host->pmerrloc_base)
+		iounmap(host->pmerrloc_base);
+	if (host->rom_base)
+		iounmap(host->rom_base);
+err_pmecc_ioremap:
+	return err_no;
+}
+
+/*
  * Calculate HW ECC
  *
  * function called after a write
@@ -474,6 +1212,15 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 }
 
 #if defined(CONFIG_OF)
+static int cpu_has_pmecc(void)
+{
+	unsigned long dt_root;
+
+	dt_root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(dt_root, "atmel,at91sam9n12") ||
+		of_flat_dt_is_compatible(dt_root, "atmel,at91sam9x5");
+}
+
 static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 					 struct device_node *np)
 {
@@ -513,9 +1260,27 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 	board->enable_pin = of_get_gpio(np, 1);
 	board->det_pin = of_get_gpio(np, 2);
 
+	if ((board->ecc_mode == NAND_ECC_HW) && cpu_has_pmecc()) {
+		if (of_property_read_u32(np, "atmel,pmecc-cap", &val) != 0) {
+			dev_err(host->dev, "Cannot decide PMECC Capability\n");
+			return -EINVAL;
+		}
+		host->correction_cap = (u8)val;
+
+		if (of_property_read_u32(np, "atmel,sector-size", &val) != 0) {
+			dev_err(host->dev, "Cannot decide PMECC Sector Size\n");
+			return -EINVAL;
+		}
+		host->sector_size = (u16)val;
+	}
+
 	return 0;
 }
 #else
+static int cpu_has_pmecc(void)
+{
+	return 0;
+}
 static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 					 struct device_node *np)
 {
@@ -523,6 +1288,79 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 }
 #endif
 
+static int __init atmel_nand_init_params(struct platform_device *pdev,
+					 struct atmel_nand_host *host)
+{
+	struct resource		*regs;
+	struct mtd_info		*mtd;
+	struct nand_chip	*nand_chip;
+
+	nand_chip = &host->nand_chip;
+	mtd = &host->mtd;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!regs) {
+		dev_err(host->dev, "Can't get I/O resource regs\n" \
+			"Rolling back on software ECC\n");
+	}
+
+	nand_chip->ecc.mode = NAND_ECC_SOFT;
+	if (regs) {
+		host->ecc = ioremap(regs->start, resource_size(regs));
+		if (host->ecc == NULL) {
+			printk(KERN_ERR "atmel_nand: ioremap failed\n");
+			return -EIO;
+		}
+
+		nand_chip->ecc.mode = NAND_ECC_HW;
+		nand_chip->ecc.calculate = atmel_nand_calculate;
+		nand_chip->ecc.correct = atmel_nand_correct;
+		nand_chip->ecc.hwctl = atmel_nand_hwctl;
+		nand_chip->ecc.read_page = atmel_nand_read_page;
+		nand_chip->ecc.bytes = 4;
+		nand_chip->ecc.strength = 1;
+	}
+
+	if (nand_chip->ecc.mode == NAND_ECC_HW) {
+		/* ECC is calculated for the whole page (1 step) */
+		nand_chip->ecc.size = mtd->writesize;
+
+		/* set ECC page size and oob layout */
+		switch (mtd->writesize) {
+		case 512:
+			nand_chip->ecc.layout = &atmel_oobinfo_small;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
+			break;
+		case 1024:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
+			break;
+		case 2048:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
+			break;
+		case 4096:
+			nand_chip->ecc.layout = &atmel_oobinfo_large;
+			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
+			break;
+		default:
+			/* page size not handled by HW ECC */
+			/* switching back to soft ECC */
+			nand_chip->ecc.mode = NAND_ECC_SOFT;
+			nand_chip->ecc.calculate = NULL;
+			nand_chip->ecc.correct = NULL;
+			nand_chip->ecc.hwctl = NULL;
+			nand_chip->ecc.read_page = NULL;
+			nand_chip->ecc.postpad = 0;
+			nand_chip->ecc.prepad = 0;
+			nand_chip->ecc.bytes = 0;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Probe for the NAND device.
  */
@@ -531,7 +1369,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
 	struct nand_chip *nand_chip;
-	struct resource *regs;
 	struct resource *mem;
 	struct mtd_part_parser_data ppdata = {};
 	int res;
@@ -584,28 +1421,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 	nand_chip->ecc.mode = host->board.ecc_mode;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!regs && nand_chip->ecc.mode == NAND_ECC_HW) {
-		printk(KERN_ERR "atmel_nand: can't get I/O resource "
-				"regs\nFalling back on software ECC\n");
-		nand_chip->ecc.mode = NAND_ECC_SOFT;
-	}
-
-	if (nand_chip->ecc.mode == NAND_ECC_HW) {
-		host->ecc = ioremap(regs->start, resource_size(regs));
-		if (host->ecc == NULL) {
-			printk(KERN_ERR "atmel_nand: ioremap failed\n");
-			res = -EIO;
-			goto err_ecc_ioremap;
-		}
-		nand_chip->ecc.calculate = atmel_nand_calculate;
-		nand_chip->ecc.correct = atmel_nand_correct;
-		nand_chip->ecc.hwctl = atmel_nand_hwctl;
-		nand_chip->ecc.read_page = atmel_nand_read_page;
-		nand_chip->ecc.bytes = 4;
-		nand_chip->ecc.strength = 1;
-	}
-
 	nand_chip->chip_delay = 20;		/* 20us command delay time */
 
 	if (host->board.bus_width_16)	/* 16-bit bus width */
@@ -656,41 +1471,14 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 		goto err_scan_ident;
 	}
 
-	if (nand_chip->ecc.mode == NAND_ECC_HW) {
-		/* ECC is calculated for the whole page (1 step) */
-		nand_chip->ecc.size = mtd->writesize;
 
-		/* set ECC page size and oob layout */
-		switch (mtd->writesize) {
-		case 512:
-			nand_chip->ecc.layout = &atmel_oobinfo_small;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
-			break;
-		case 1024:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
-			break;
-		case 2048:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
-			break;
-		case 4096:
-			nand_chip->ecc.layout = &atmel_oobinfo_large;
-			ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
-			break;
-		default:
-			/* page size not handled by HW ECC */
-			/* switching back to soft ECC */
-			nand_chip->ecc.mode = NAND_ECC_SOFT;
-			nand_chip->ecc.calculate = NULL;
-			nand_chip->ecc.correct = NULL;
-			nand_chip->ecc.hwctl = NULL;
-			nand_chip->ecc.read_page = NULL;
-			nand_chip->ecc.postpad = 0;
-			nand_chip->ecc.prepad = 0;
-			nand_chip->ecc.bytes = 0;
-			break;
-		}
+	if (host->board.ecc_mode == NAND_ECC_HW) {
+		if (cpu_has_pmecc())
+			res = atmel_pmecc_init_params(pdev, host);
+		else
+			res = atmel_nand_init_params(pdev, host);
+		if (res != 0)
+			goto err_ecc;
 	}
 
 	/* second phase scan */
@@ -706,6 +1494,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 	if (!res)
 		return res;
 
+err_ecc:
 err_scan_tail:
 err_scan_ident:
 err_no_card:
@@ -713,9 +1502,6 @@ err_no_card:
 	platform_set_drvdata(pdev, NULL);
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
-	if (host->ecc)
-		iounmap(host->ecc);
-err_ecc_ioremap:
 	iounmap(host->io_base);
 err_nand_ioremap:
 	kfree(host);
@@ -734,8 +1520,21 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
 
 	atmel_nand_disable(host);
 
-	if (host->ecc)
-		iounmap(host->ecc);
+	if (host->board.ecc_mode == NAND_ECC_HW) {
+		if (cpu_has_pmecc()) {
+			pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
+			if (host->pmerrloc_base) {
+				pmerrloc_writel(host->pmerrloc_base, ELDIS,
+					PMERRLOC_DISABLE);
+				iounmap(host->pmerrloc_base);
+			}
+			if (host->rom_base)
+				iounmap(host->rom_base);
+		}
+
+		if (host->ecc)
+			iounmap(host->ecc);
+	}
 
 	if (host->dma_chan)
 		dma_release_channel(host->dma_chan);
diff --git a/drivers/mtd/nand/atmel_nand_ecc.h b/drivers/mtd/nand/atmel_nand_ecc.h
index 578c776..315729b 100644
--- a/drivers/mtd/nand/atmel_nand_ecc.h
+++ b/drivers/mtd/nand/atmel_nand_ecc.h
@@ -3,7 +3,7 @@
  * Based on AT91SAM9260 datasheet revision B.
  *
  * Copyright (C) 2007 Andrew Victor
- * Copyright (C) 2007 Atmel Corporation.
+ * Copyright (C) 2007 - 2012 Atmel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -36,4 +36,125 @@
 #define ATMEL_ECC_NPR		0x10			/* NParity register */
 #define		ATMEL_ECC_NPARITY	(0xffff << 0)		/* NParity */
 
+/* Register Access Macros */
+#define ecc_readl(add, reg)				\
+	__raw_readl(add + ATMEL_ECC_##reg)
+#define ecc_writel(add, reg, value)			\
+	__raw_writel((value), add + ATMEL_ECC_##reg)
+
+/* PMECC Register Definitions */
+#define ATMEL_PMECC_CFG			0x000	/* Configuration Register */
+#define		PMECC_CFG_BCH_ERR2		(0 << 0)
+#define		PMECC_CFG_BCH_ERR4		(1 << 0)
+#define		PMECC_CFG_BCH_ERR8		(2 << 0)
+#define		PMECC_CFG_BCH_ERR12		(3 << 0)
+#define		PMECC_CFG_BCH_ERR24		(4 << 0)
+
+#define		PMECC_CFG_SECTOR512		(0 << 4)
+#define		PMECC_CFG_SECTOR1024		(1 << 4)
+
+#define		PMECC_CFG_PAGE_1SECTOR		(0 << 8)
+#define		PMECC_CFG_PAGE_2SECTORS		(1 << 8)
+#define		PMECC_CFG_PAGE_4SECTORS		(2 << 8)
+#define		PMECC_CFG_PAGE_8SECTORS		(3 << 8)
+
+#define		PMECC_CFG_READ_OP		(0 << 12)
+#define		PMECC_CFG_WRITE_OP		(1 << 12)
+
+#define		PMECC_CFG_SPARE_ENABLE		(1 << 16)
+#define		PMECC_CFG_SPARE_DISABLE		(0 << 16)
+
+#define		PMECC_CFG_AUTO_ENABLE		(1 << 20)
+#define		PMECC_CFG_AUTO_DISABLE		(0 << 20)
+
+#define ATMEL_PMECC_SAREA		0x004	/* Spare area size */
+#define ATMEL_PMECC_SADDR		0x008	/* PMECC starting address */
+#define ATMEL_PMECC_EADDR		0x00c	/* PMECC ending address */
+#define ATMEL_PMECC_CLK			0x010	/* PMECC clock control */
+#define		PMECC_CLK_133MHZ		(2 << 0)
+
+#define ATMEL_PMECC_CTRL		0x014	/* PMECC control register */
+#define		PMECC_CTRL_RST			(1 << 0)
+#define		PMECC_CTRL_DATA			(1 << 1)
+#define		PMECC_CTRL_USER			(1 << 2)
+#define		PMECC_CTRL_ENABLE		(1 << 4)
+#define		PMECC_CTRL_DISABLE		(1 << 5)
+
+#define ATMEL_PMECC_SR			0x018	/* PMECC status register */
+#define		PMECC_SR_BUSY			(1 << 0)
+#define		PMECC_SR_ENABLE			(1 << 4)
+
+#define ATMEL_PMECC_IER			0x01c	/* PMECC interrupt enable */
+#define		PMECC_IER_ENABLE		(1 << 0)
+#define ATMEL_PMECC_IDR			0x020	/* PMECC interrupt disable */
+#define		PMECC_IER_DISABLE		(1 << 0)
+#define ATMEL_PMECC_IMR			0x024	/* PMECC interrupt mask */
+#define		PMECC_IER_MASK			(1 << 0)
+#define ATMEL_PMECC_ISR			0x028	/* PMECC interrupt status */
+#define ATMEL_PMECC_ECCx		0x040	/* PMECC ECC x */
+#define ATMEL_PMECC_REMx		0x240	/* PMECC REM x */
+
+/* PMERRLOC Register Definitions */
+#define ATMEL_PMERRLOC_ELCFG		0x000	/* Error location config */
+#define		PMERRLOC_ELCFG_SECTOR_512	(0 << 0)
+#define		PMERRLOC_ELCFG_SECTOR_1024	(1 << 0)
+#define		PMERRLOC_ELCFG_NUM_ERRORS(n)	((n) << 16)
+
+#define ATMEL_PMERRLOC_ELPRIM		0x004	/* Error location primitive */
+#define ATMEL_PMERRLOC_ELEN		0x008	/* Error location enable */
+#define ATMEL_PMERRLOC_ELDIS		0x00c	/* Error location disable */
+#define		PMERRLOC_DISABLE		(1 << 0)
+
+#define ATMEL_PMERRLOC_ELSR		0x010	/* Error location status */
+#define		PMERRLOC_ELSR_BUSY		(1 << 0)
+#define ATMEL_PMERRLOC_ELIER		0x014	/* Error location int enable */
+#define ATMEL_PMERRLOC_ELIDR		0x018	/* Error location int disable */
+#define ATMEL_PMERRLOC_ELIMR		0x01c	/* Error location int mask */
+#define ATMEL_PMERRLOC_ELISR		0x020	/* Error location int status */
+#define		PMERRLOC_ERR_NUM_MASK		(0x1f << 8)
+#define		PMERRLOC_CALC_DONE		(1 << 0)
+#define ATMEL_PMERRLOC_SIGMAx		0x028	/* Error location SIGMA x */
+#define ATMEL_PMERRLOC_ELx		0x08c	/* Error location x */
+
+/* Register access macros for PMECC */
+#define pmecc_readl(addr, reg) \
+	__raw_readl((addr) + ATMEL_PMECC_##reg)
+
+#define pmecc_writel(addr, reg, value) \
+	__raw_writel((value), (addr) + ATMEL_PMECC_##reg)
+
+#define pmecc_readb_ecc(addr, sector, n) \
+	__raw_readb((addr) + ATMEL_PMECC_ECCx + ((sector) * 0x40) + (n))
+
+#define pmecc_readl_rem(addr, sector, n) \
+	__raw_readl((addr) + ATMEL_PMECC_REMx + ((sector) * 0x40) + ((n) * 4))
+
+#define pmerrloc_readl(addr, reg) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_##reg)
+
+#define pmerrloc_writel(addr, reg, value) \
+	__raw_writel((value), (addr) + ATMEL_PMERRLOC_##reg)
+
+#define pmerrloc_writel_sigma(addr, n, value) \
+	__raw_writel((value), (addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+
+#define pmerrloc_readl_sigma(addr, n) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_SIGMAx + ((n) * 4))
+
+#define pmerrloc_readl_el(addr, n) \
+	__raw_readl((addr) + ATMEL_PMERRLOC_ELx + ((n) * 4))
+
+/* Galois field dimension */
+#define GF_DIMENSION_13			13
+#define GF_DIMENSION_14			14
+
+#define AT_NB_ERROR_MAX			25
+#define AT_MAX_ECC_BYTES		42
+#define AT_MAX_NB_SECTOR		8
+
+#define AT_PMECC_LOOKUP_TABLE_OFFSET_512	0x8000
+#define AT_PMECC_LOOKUP_TABLE_SIZE_512		0x2000
+#define AT_PMECC_LOOKUP_TABLE_OFFSET_1024	0x10000
+#define AT_PMECC_LOOKUP_TABLE_SIZE_1024		0x4000
+
 #endif
-- 
1.7.10
