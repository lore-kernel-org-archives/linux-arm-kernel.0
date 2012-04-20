From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 Apr 2012 10:25:33 +0200
Subject: [PATCH v4 1/2] MTD: atmel_nand: Update driver to support
 Programmable HW ECC controller
In-Reply-To: <1334906788-18704-1-git-send-email-hong.xu@atmel.com>
References: <1334906788-18704-1-git-send-email-hong.xu@atmel.com>
Message-ID: <20120420082533.GX16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:26 Fri 20 Apr     , Hong Xu wrote:
> The Programmable Hardware ECC (PMECC) controller is a programmable binary
> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
> can be used to support both SLC and MLC NAND Flash devices. It supports to
> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
> 
> To use this driver, the user needs to pass in the correction capability and
> the sector size.
> 
> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
> YAFFS2, UBIFS and mtd-utils.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
what is the status on the other soc?
> ---
> Changes since v3,
> 	Rebased on AT91 Nand fixes and DT
> 
>  drivers/mtd/nand/atmel_nand.c     |  955 ++++++++++++++++++++++++++++++++++---
>  drivers/mtd/nand/atmel_nand_ecc.h |  123 ++++-
>  2 files changed, 998 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 2165576..7d494c8 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -15,6 +15,8 @@
>   *     		(u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
>   *     (C) Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
>   *
> + *  Add Programmable Hardware ECC support for various AT91 SoC
> + *     (C) Copyright 2012 ATMEL, Hong Xu
the comment is wrong the hw ecc is already implemented
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -42,19 +44,50 @@
>  
>  #include <mach/cpu.h>
>  
> +/* Hardware ECC registers */
> +#include "atmel_nand_ecc.h"
> +
>  static int use_dma = 1;
>  module_param(use_dma, int, 0);
>  
>  static int on_flash_bbt = 0;
>  module_param(on_flash_bbt, int, 0);
>  
> -/* Register access macros */
> -#define ecc_readl(add, reg)				\
> -	__raw_readl(add + ATMEL_ECC_##reg)
> -#define ecc_writel(add, reg, value)			\
> -	__raw_writel((value), add + ATMEL_ECC_##reg)
> +struct atmel_nand_host {
> +	struct nand_chip	nand_chip;
> +	struct mtd_info		mtd;
> +	void __iomem		*io_base;
> +	dma_addr_t		io_phys;
> +	struct atmel_nand_data	board;
> +	struct device		*dev;
> +	void __iomem		*ecc;
>  
> -#include "atmel_nand_ecc.h"	/* Hardware ECC registers */
> +	struct completion	comp;
> +	struct dma_chan		*dma_chan;
> +
> +	void __iomem		*pmerrloc_base;
> +	void __iomem		*rom_base;
> +
> +	int			cap;	/* Correcting capability */
> +	int			ecc_bytes_per_sector;
> +	int			degree;	/*Degree of remainders,GF(2**degree)*/
> +	int			cw_len;	/*Length of codeword*/
> +	int			sector_number;
> +
> +	/* lookup table for alpha_to and index_of */
> +	void __iomem		*alpha_to;
> +	void __iomem		*index_of;
> +
> +	int16_t			partial_syn[2 * AT_NB_ERROR_MAX + 1];
> +	int16_t			si[2 * AT_NB_ERROR_MAX + 1];
> +
> +	/* Sigma table */
> +	int16_t		smu[AT_NB_ERROR_MAX + 2][2 * AT_NB_ERROR_MAX + 1];
> +	/* polynomal order */
> +	int16_t			lmu[AT_NB_ERROR_MAX + 1];
> +
> +	uint8_t			ecc_table[AT_MAX_ECC_BYTES * AT_MAX_NB_SECTOR];
> +};
>  
>  /* oob layout for large page size
>   * bad block info is on bytes 0 and 1
> @@ -82,17 +115,23 @@ static struct nand_ecclayout atmel_oobinfo_small = {
>  	},
>  };
>  
> -struct atmel_nand_host {
> -	struct nand_chip	nand_chip;
> -	struct mtd_info		mtd;
> -	void __iomem		*io_base;
> -	dma_addr_t		io_phys;
> -	struct atmel_nand_data	board;
> -	struct device		*dev;
> -	void __iomem		*ecc;
> +static struct nand_ecclayout atmel_pmecc_oobinfo;
>  
> -	struct completion	comp;
> -	struct dma_chan		*dma_chan;
> +/*
> + * Number of ECC bytes per sector is determined by both sector size
> + * and correction capability
> + *
> + * Correction Capability	Sector_512_bytes	Sector_1024_bytes
> + * =====================	================	=================
> + *                2-bits                 4-bytes                  4-bytes
> + *                4-bits                 7-bytes                  7-bytes
> + *                8-bits                13-bytes                 14-bytes
> + *               12-bits                20-bytes                 21-bytes
> + *               24-bits                39-bytes                 42-bytes
> + *
> + */
> +static const int ecc_bytes_table[5][2] = {
> +	{4, 4}, {7, 7}, {13, 14}, {20, 21}, {39, 42}
>  };
>  
>  static int cpu_has_dma(void)
> @@ -288,6 +327,718 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
>  }
>  
>  /*
> + * Return number of ecc bytes per sector according to sector size and
> + * correction capability
> + */
> +static int pmecc_get_ecc_bytes(int cap, int sector_size)
> +{
> +	int i, j;
> +
> +	switch (cap) {
> +	case 2:
> +		i = 0;
> +		break;
> +	case 4:
> +		i = 1;
> +		break;
> +	case 8:
> +		i = 2;
> +		break;
> +	case 12:
> +		i = 3;
> +		break;
> +	case 24:
> +		i = 4;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	switch (sector_size) {
> +	case 512:
> +		j = 0;
> +		break;
> +	case 1024:
> +		j = 1;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return ecc_bytes_table[i][j];
> +}
> +
> +static int cpu_has_pmecc(void)
> +{
> +	if (cpu_is_at91sam9x5())
> +		return 1;
this must be pass via DT do not use cpu_is
> +
> +	return 0;
> +}
> +
> +static int pmecc_get_clkctrl(void)
> +{
> +	/* See datasheet about PMECC Clock Control Register */
> +	if (cpu_is_at91sam9x5())
> +		return 2;
> +
> +	return 0;
> +}
> +
> +static void pmecc_config_ecc_layout(struct nand_ecclayout *layout, int oobsize,
> +	int ecc_len)
> +{
> +	int i;
> +
> +	layout->eccbytes = ecc_len;
> +
> +	/* ECC will occupy the last ecc_len bytes continuously */
> +	for (i = 0; i < ecc_len; i++)
> +		layout->eccpos[i] = oobsize - ecc_len + i;
> +
> +	layout->oobfree[0].offset = 0;
> +	layout->oobfree[0].length = oobsize - ecc_len;
> +}
> +
> +static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
> +{
> +	void __iomem *p;
> +
> +	switch (host->board.sector_size) {
> +	case 512:
> +		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_512 +
> +			AT_PMECC_LOOKUP_TABLE_SIZE_512;
> +		break;
> +	case 1024:
> +		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_1024 +
> +			AT_PMECC_LOOKUP_TABLE_SIZE_1024;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return p;
> +}
> +
> +static void __iomem *pmecc_get_index_of(struct atmel_nand_host *host)
> +{
> +	void __iomem *p;
> +
> +	switch (host->board.sector_size) {
> +	case 512:
> +		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_512;
> +		break;
> +	case 1024:
> +		p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_1024;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return p;
> +}
> +
> +static void pmecc_gen_syndrome(struct mtd_info *mtd, int sector)
> +{
> +	int			i;
> +	uint32_t		value;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +
> +	/* Fill odd syndromes */
> +	for (i = 0; i < host->cap; i++) {
> +		value = pmecc_readl_rem(host->ecc, sector, i / 2);
> +		value = (i & 1) ? (value & 0xffff0000) >> 16 : value & 0xffff;
> +		host->partial_syn[(2 * i) + 1] = (int16_t)value;
> +	}
> +}
> +
> +static void pmecc_substitute(struct mtd_info *mtd)
> +{
> +	int16_t			*si;
> +	int			i, j;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +	int16_t __iomem		*alpha_to = host->alpha_to;
> +	int16_t __iomem		*index_of = host->index_of;
> +	int16_t			*partial_syn = host->partial_syn;
> +
> +	/* si[] is a table that holds the current syndrome value,
> +	 * an element of that table belongs to the field
> +	 */
> +	si = host->si;
> +
> +	for (i = 1; i < 2 * AT_NB_ERROR_MAX; i++)
> +		si[i] = 0;
> +
> +	/* Computation 2t syndromes based on S(x) */
> +	/* Odd syndromes */
> +	for (i = 1; i <= 2 * host->cap - 1; i = i + 2) {
i += 2
< without the -1
> +		si[i] = 0;
> +		for (j = 0; j < host->degree; j++) {
> +			if (partial_syn[i] & ((unsigned short)0x1 << j))
> +				si[i] = __raw_readw(alpha_to + i * j) ^ si[i];
use relaxed read/write
> +		}
> +	}
> +	/* Even syndrome = (Odd syndrome) ** 2 */
> +	for (i = 2; i <= 2 * host->cap; i = i + 2) {
> +		j = i / 2;
> +		if (si[j] == 0)
> +			si[i] = 0;
> +		else {
> +			int16_t tmp;
please check your patch with checkpath
> +			tmp = __raw_readw(index_of + si[j]);
> +			tmp = (tmp * 2) % host->cw_len;
> +			si[i] = __raw_readw(alpha_to + tmp);
> +		}
> +	}
> +
> +	return;
> +}
> +
> +static void pmecc_get_sigma(struct mtd_info *mtd)
> +{
> +	int			i, j, k;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +
> +	uint32_t		dmu_0_count, tmp;
> +	int16_t			*lmu = host->lmu;
> +	int16_t			*si = host->si;
> +	int16_t			cap = host->cap;
> +	int16_t __iomem		*index_of = host->index_of;
> +	int16_t __iomem		*alpha_to = host->alpha_to;
> +
> +	/* mu */
> +	int mu[AT_NB_ERROR_MAX + 1];
> +
> +	/* discrepancy */
> +	int dmu[AT_NB_ERROR_MAX + 1];
> +
> +	/* delta order */
> +	int delta[AT_NB_ERROR_MAX + 1];
allocate these
> +
> +	/* index of largest delta */
> +	int ro;
> +	int largest;
> +	int diff;
> +
> +	dmu_0_count = 0;
> +
> +	/* First Row */
> +
> +	/* Mu */
> +	mu[0] = -1;
> +
> +	for (i = 0; i < 2 * AT_NB_ERROR_MAX + 1; i++)
> +		host->smu[0][i] = 0;
use memeset


Best Regards,
J.
