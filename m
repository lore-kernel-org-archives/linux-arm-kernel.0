From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 May 2012 08:58:22 +0200
Subject: [PATCH v9 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1338038677-6752-4-git-send-email-josh.wu@atmel.com>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
 <1338038677-6752-4-git-send-email-josh.wu@atmel.com>
Message-ID: <20120528065822.GL3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:24 Sat 26 May     , Josh Wu wrote:
> The Programmable Multibit ECC (PMECC) controller is a programmable binary
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
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  drivers/mtd/nand/atmel_nand.c     |  761 ++++++++++++++++++++++++++++++++++++-
>  drivers/mtd/nand/atmel_nand_ecc.h |  116 ++++++
>  2 files changed, 876 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 9a9bfbf..ddcf1ed 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -15,6 +15,8 @@
>   *     		(u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
>   *     (C) Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
>   *
> + *  Add Programmable Multibit ECC support for various AT91 SoC
> + *     (C) Copyright 2012 ATMEL, Hong Xu
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -77,6 +79,21 @@ static struct nand_ecclayout atmel_oobinfo_small = {
>  	},
>  };
>  
> +/* a structure includes datas for PMECC computation */
> +struct atmel_pmecc_data {
> +	int16_t			partial_syn[2 * PMECC_MAX_ERROR_NB + 1];
> +	int16_t			si[2 * PMECC_MAX_ERROR_NB + 1];
> +
> +	/* Sigma table */
> +	int16_t		smu[PMECC_MAX_ERROR_NB + 2][2 * PMECC_MAX_ERROR_NB + 1];
you still hardcode the array in the struct

and if the pmecc evolve we will have to touch again
please allocate them
> +	/* polynomal order */
> +	int16_t			lmu[PMECC_MAX_ERROR_NB + 1];
> +
> +	int			mu[PMECC_MAX_ERROR_NB + 1];
> +	int			dmu[PMECC_MAX_ERROR_NB + 1];
> +	int			delta[PMECC_MAX_ERROR_NB + 1];
> +};
> +
>  struct atmel_nand_host {
>  	struct nand_chip	nand_chip;
>  	struct mtd_info		mtd;
> @@ -92,8 +109,25 @@ struct atmel_nand_host {
>  	bool			has_pmecc;
>  	u8			pmecc_corr_cap;
>  	u16			pmecc_sector_size;
> +
> +	int			pmecc_bytes_per_sector;
> +	int			pmecc_sector_number;
> +	int			pmecc_degree;	/* Degree of remainders */
> +	int			pmecc_cw_len;	/* Length of codeword */
> +
> +	void __iomem		*pmerrloc_base;
> +	void __iomem		*pmecc_rom_base;
> +
> +	/* lookup table for alpha_to and index_of */
> +	void __iomem		*pmecc_alpha_to;
> +	void __iomem		*pmecc_index_of;
> +
> +	/* data for pmecc computation */
> +	struct atmel_pmecc_data	*pmecc_data;
>  };
>  
> +static struct nand_ecclayout atmel_pmecc_oobinfo;
> +
>  static int cpu_has_dma(void)
>  {
>  	return cpu_is_at91sam9rl() || cpu_is_at91sam9g45();
> @@ -287,6 +321,708 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
>  }
>  
>  /*
> + * Return number of ecc bytes per sector according to sector size and
> + * correction capability
> + *
> + * Following table shows what at91 PMECC supported:
> + * Correction Capability	Sector_512_bytes	Sector_1024_bytes
> + * =====================	================	=================
> + *                2-bits                 4-bytes                  4-bytes
> + *                4-bits                 7-bytes                  7-bytes
> + *                8-bits                13-bytes                 14-bytes
> + *               12-bits                20-bytes                 21-bytes
> + *               24-bits                39-bytes                 42-bytes
> + */
> +static int pmecc_get_ecc_bytes(int cap, int sector_size)
> +{
> +	int m = 12 + sector_size / 512;
> +	return (m * cap + 7) / 8;
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
> +	layout->oobfree[0].offset = 2;
> +	layout->oobfree[0].length =
> +		oobsize - ecc_len - layout->oobfree[0].offset;
> +}
> +
> +static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
> +{
> +	void __iomem *p;
> +
> +	switch (host->pmecc_sector_size) {
> +	case 512:
> +		p = host->pmecc_rom_base + PMECC_LOOKUP_TABLE_OFFSET_512 +
> +			PMECC_LOOKUP_TABLE_SIZE_512 * sizeof(int16_t);
> +		break;
> +	case 1024:
> +		p = host->pmecc_rom_base + PMECC_LOOKUP_TABLE_OFFSET_1024 +
> +			PMECC_LOOKUP_TABLE_SIZE_1024 * sizeof(int16_t);
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	return p;
> +}
> +
> +static void __iomem *pmecc_get_index_of(struct atmel_nand_host *host)
this is a __dev_init function plese check the other too

btw you need to use __dev_init and not __init
> +{
> +	void __iomem *p;
> +
> +	switch (host->pmecc_sector_size) {
> +	case 512:
> +		p = host->pmecc_rom_base + PMECC_LOOKUP_TABLE_OFFSET_512;
> +		break;
> +	case 1024:
> +		p = host->pmecc_rom_base + PMECC_LOOKUP_TABLE_OFFSET_1024;
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
> +	for (i = 0; i < host->pmecc_corr_cap; i++) {
> +		value = pmecc_readl_rem_relaxed(host->ecc, sector, i / 2);
> +		value = (i & 1) ? (value & 0xffff0000) >> 16 : value & 0xffff;
simplify by 
		if (i & 1)
			val >>= 16;
		value &= 0xffff;

> +		host->pmecc_data->partial_syn[(2 * i) + 1] = (int16_t)value;
> +	}
> +}
> +
> +static void pmecc_substitute(struct mtd_info *mtd)
> +{
> +	int16_t			*si;
> +	int			i, j;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +	int16_t __iomem		*alpha_to = host->pmecc_alpha_to;
> +	int16_t __iomem		*index_of = host->pmecc_index_of;
> +	int16_t			*partial_syn = host->pmecc_data->partial_syn;
> +
> +	/* si[] is a table that holds the current syndrome value,
> +	 * an element of that table belongs to the field
> +	 */
> +	si = host->pmecc_data->si;
> +
> +	for (i = 1; i < 2 * PMECC_MAX_ERROR_NB; i++)
> +		si[i] = 0;
please use memset
> +
> +	/* Computation 2t syndromes based on S(x) */
> +	/* Odd syndromes */
> +	for (i = 1; i < 2 * host->pmecc_corr_cap; i += 2) {
> +		si[i] = 0;
shy this you already init the array at 0 before
> +		for (j = 0; j < host->pmecc_degree; j++) {
> +			if (partial_syn[i] & ((unsigned short)0x1 << j))
> +				si[i] = readw_relaxed(alpha_to + i * j) ^ si[i];
> +		}
> +	}
> +	/* Even syndrome = (Odd syndrome) ** 2 */
> +	for (i = 2; i <= 2 * host->pmecc_corr_cap; i += 2) {
> +		j = i / 2;
> +		if (si[j] == 0)
here if {
} else {
}
> +			si[i] = 0;
> +		else {
> +			int16_t tmp;
missing blank line
> +			tmp = readw_relaxed(index_of + si[j]);
> +			tmp = (tmp * 2) % host->pmecc_cw_len;
> +			si[i] = readw_relaxed(alpha_to + tmp);
> +		}
> +	}
> +
> +	return;
> +}
> +
> +static void pmecc_get_sigma(struct mtd_info *mtd)
> +{
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +
> +	int		i, j, k;
> +	uint32_t	dmu_0_count, tmp;
> +	int16_t		(*smu)[2 * PMECC_MAX_ERROR_NB + 1];
> +	int16_t		*lmu = host->pmecc_data->lmu;
> +	int16_t		*si = host->pmecc_data->si;
> +	int		*mu = host->pmecc_data->mu;
> +	int		*dmu = host->pmecc_data->dmu;	  /* Discrepancy */
> +	int		*delta = host->pmecc_data->delta; /* Delta order */
> +	int		cw_len = host->pmecc_cw_len;
> +	int16_t		cap = host->pmecc_corr_cap;
> +
> +	int16_t __iomem	*index_of = host->pmecc_index_of;
> +	int16_t __iomem	*alpha_to = host->pmecc_alpha_to;
> +
> +	/* index of largest delta */
> +	int ro;
> +	int largest;
> +	int diff;
> +
> +	dmu_0_count = 0;
> +	smu = host->pmecc_data->smu;
> +
> +	/* First Row */
> +
> +	/* Mu */
> +	mu[0] = -1;
> +
> +	memset(&smu[0][0], 0,
> +		sizeof(int16_t) * (2 * PMECC_MAX_ERROR_NB + 1));
> +	smu[0][0] = 1;
> +
> +	/* discrepancy set to 1 */
> +	dmu[0] = 1;
> +	/* polynom order set to 0 */
> +	lmu[0] = 0;
> +	delta[0]  = (mu[0] * 2 - lmu[0]) >> 1;
> +
> +	/* Second Row */
> +
> +	/* Mu */
> +	mu[1]  = 0;
> +	/* Sigma(x) set to 1 */
> +	memset(&smu[1][0], 0,
> +		sizeof(int16_t) * (2 * PMECC_MAX_ERROR_NB + 1));
> +	smu[1][0] = 1;
> +
> +	/* discrepancy set to S1 */
> +	dmu[1] = si[1];
> +
> +	/* polynom order set to 0 */
> +	lmu[1] = 0;
> +
> +	delta[1]  = (mu[1] * 2 - lmu[1]) >> 1;
> +
> +	/* Init the Sigma(x) last row */
> +	memset(&smu[cap + 1][0], 0,
> +		sizeof(int16_t) * (2 * PMECC_MAX_ERROR_NB + 1));
> +
> +	for (i = 1; i <= cap; i++) {
> +		mu[i+1] = i << 1;
> +		/* Begin Computing Sigma (Mu+1) and L(mu) */
> +		/* check if discrepancy is set to 0 */
> +		if (dmu[i] == 0) {
> +			dmu_0_count++;
> +
> +			tmp = ((cap - (lmu[i] >> 1) - 1) / 2);
> +			if ((cap - (lmu[i] >> 1) - 1) & 0x1)
> +				tmp += 2;
> +			else
> +				tmp += 1;
> +
> +			if (dmu_0_count == tmp) {
> +				for (j = 0; j <= (lmu[i] >> 1) + 1; j++)
> +					smu[cap + 1][j] = smu[i][j];
> +				lmu[cap + 1] = lmu[i];
> +				return;
> +			}
> +
> +			/* copy polynom */
> +			for (j = 0; j <= lmu[i] >> 1; j++)
> +				smu[i + 1][j] = smu[i][j];
> +
> +			/* copy previous polynom order to the next */
> +			lmu[i + 1] = lmu[i];
> +		} else {
> +			ro = 0;
> +			largest = -1;
> +			/* find largest delta with dmu != 0 */
> +			for (j = 0; j < i; j++) {
> +				if ((dmu[j]) && (delta[j] > largest)) {
> +					largest = delta[j];
> +					ro = j;
> +				}
> +			}
> +
> +			/* compute difference */
> +			diff = (mu[i] - mu[ro]);
> +
> +			/* Compute degree of the new smu polynomial */
> +			if ((lmu[i] >> 1) > ((lmu[ro] >> 1) + diff))
> +				lmu[i + 1] = lmu[i];
> +			else
> +				lmu[i + 1] = ((lmu[ro] >> 1) + diff) * 2;
> +
> +			/* Init smu[i+1] with 0 */
> +			for (k = 0; k < (2 * PMECC_MAX_ERROR_NB + 1); k++)
> +				smu[i+1][k] = 0;
> +
> +			/* Compute smu[i+1] */
> +			for (k = 0; k <= lmu[ro] >> 1; k++) {
> +				int16_t a, b, c;
> +
> +				if (!(smu[ro][k] && dmu[i]))
> +					continue;
> +				a = readw_relaxed(index_of + dmu[i]);
> +				b = readw_relaxed(index_of + dmu[ro]);
> +				c = readw_relaxed(index_of + smu[ro][k]);
> +				tmp = a + (cw_len - b) + c;
> +				a = readw_relaxed(alpha_to + tmp % cw_len);
> +				smu[i + 1][k + diff] = a;
> +			}
> +
> +			for (k = 0; k <= lmu[i] >> 1; k++)
> +				smu[i + 1][k] ^= smu[i][k];
> +		}
> +
> +		/* End Computing Sigma (Mu+1) and L(mu) */
> +		/* In either case compute delta */
> +		delta[i + 1]  = (mu[i + 1] * 2 - lmu[i + 1]) >> 1;
> +
> +		/* Do not compute discrepancy for the last iteration */
> +		if (i >= cap)
> +			continue;
> +
> +		for (k = 0 ; k <= (lmu[i + 1] >> 1); k++) {
> +			tmp = 2 * (i - 1);
> +			if (k == 0)
> +				dmu[i + 1] = si[tmp + 3];
> +			else if (smu[i+1][k] && si[tmp + 3 - k]) {
> +				int16_t a, b, c;
> +				a = readw_relaxed(index_of + smu[i + 1][k]);
> +				b = si[2 * (i - 1) + 3 - k];
> +				c = readw_relaxed(index_of + b);
> +				tmp = a + c;
> +				tmp %= cw_len;
> +				dmu[i + 1] = readw_relaxed(alpha_to + tmp) ^
> +					dmu[i + 1];
> +			}
> +		}
> +	}
> +
> +	return;
> +}
> +
> +static int pmecc_err_location(struct mtd_info *mtd)
> +{
> +	int			i;
> +	int			err_nbr;	/* number of error */
> +	int			roots_nbr;	/* number of roots */
> +	int			sector_size;
> +	uint32_t		val;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +	int			timeout_count = 0;
> +	int			cap = host->pmecc_corr_cap;
> +
> +	err_nbr = 0;
> +	sector_size = host->pmecc_sector_size;
> +
> +	pmerrloc_writel(host->pmerrloc_base, ELDIS, PMERRLOC_DISABLE);
> +
> +	for (i = 0; i <= host->pmecc_data->lmu[cap + 1] >> 1; i++) {
> +		pmerrloc_writel_sigma_relaxed(host->pmerrloc_base, i,
> +				      host->pmecc_data->smu[cap + 1][i]);
> +		err_nbr++;
> +	}
> +
> +	val = (err_nbr - 1) << 16;
> +	if (sector_size == 1024)
> +		val |= 1;
> +
> +	pmerrloc_writel(host->pmerrloc_base, ELCFG, val);
> +	pmerrloc_writel(host->pmerrloc_base, ELEN,
> +			sector_size * 8 + host->pmecc_degree * cap);
> +
> +	while (!(pmerrloc_readl_relaxed(host->pmerrloc_base, ELISR)
> +		 & PMERRLOC_CALC_DONE)) {
> +		if (unlikely(timeout_count++ > PMECC_MAX_TIMEOUT_COUNT))
> +			return -1;	/* Time out */
> +		cpu_relax();
> +	}
> +
> +	roots_nbr = (pmerrloc_readl_relaxed(host->pmerrloc_base, ELISR)
> +		& PMERRLOC_ERR_NUM_MASK) >> 8;
> +	/* Number of roots == degree of smu hence <= cap */
> +	if (roots_nbr == host->pmecc_data->lmu[cap + 1] >> 1)
> +		return err_nbr - 1;
> +
> +	/* Number of roots does not match the degree of smu
> +	 * unable to correct error */
> +	return -1;
> +}
> +
> +static void pmecc_correct_data(struct mtd_info *mtd, uint8_t *buf,
> +		int extra_bytes, int err_nbr)
> +{
> +	int			i = 0;
> +	int			byte_pos, bit_pos;
> +	int			sector_size, ecc_size;
> +	uint32_t		tmp;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +
> +	sector_size = host->pmecc_sector_size;
> +	ecc_size = nand_chip->ecc.bytes;
> +
> +	while (err_nbr) {
> +		tmp = pmerrloc_readl_el_relaxed(host->pmerrloc_base, i) - 1;
> +		byte_pos = tmp / 8;
> +		bit_pos  = tmp % 8;
> +		dev_info(host->dev, "PMECC correction, byte_pos: %d bit_pos: %d\n",
> +					byte_pos, bit_pos);
> +
> +		if (byte_pos < (sector_size + extra_bytes)) {
> +			tmp = sector_size +
> +				pmecc_readl_relaxed(host->ecc, SADDR);
> +
> +			if (byte_pos < tmp)
> +				*(buf + byte_pos) ^= (1 << bit_pos);
> +			else
> +				*(buf + byte_pos + ecc_size) ^= (1 << bit_pos);
> +		}
> +
> +		i++;
> +		err_nbr--;
> +	}
> +
> +	return;
> +}
> +
> +static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
> +	u8 *ecc)
> +{
> +	int			i, err_nbr;
> +	uint8_t			*buf_pos;
> +	int			eccbytes;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +
> +	eccbytes = nand_chip->ecc.bytes;
> +	for (i = 0; i < eccbytes; i++)
> +		if (ecc[i] != 0xff)
> +			goto normal_check;
> +	/* Erased page, return OK */
> +	return 0;
> +
> +normal_check:
> +	for (i = 0; i < host->pmecc_sector_number; i++) {
> +		err_nbr = 0;
> +		if (pmecc_stat & 0x1) {
> +			buf_pos = buf + i * host->pmecc_sector_size;
> +
> +			pmecc_gen_syndrome(mtd, i);
> +			pmecc_substitute(mtd);
> +			pmecc_get_sigma(mtd);
> +
> +			err_nbr = pmecc_err_location(mtd);
> +			if (err_nbr == -1) {
> +				dev_err(host->dev, "PMECC: Too many errors\n");
> +				mtd->ecc_stats.failed++;
> +				return -EIO;
> +			} else {
> +				pmecc_correct_data(mtd, buf_pos, 0, err_nbr);
> +				mtd->ecc_stats.corrected += err_nbr;
> +			}
> +		}
> +		pmecc_stat >>= 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
> +		struct nand_chip *chip, uint8_t *buf, int page)
> +{
> +	uint32_t		stat;
> +	int			timeout_count = 0;
> +	int			eccsize = chip->ecc.size;
> +	uint8_t			*oob = chip->oob_poi;
> +	struct atmel_nand_host	*host = chip->priv;
> +	uint32_t		*eccpos = chip->ecc.layout->eccpos;
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> +	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG)
> +		& ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +
> +	chip->read_buf(mtd, buf, eccsize);
> +	chip->read_buf(mtd, oob, mtd->oobsize);
> +
> +	while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
> +		if (unlikely(timeout_count++ > PMECC_MAX_TIMEOUT_COUNT))
> +			return -EIO;	/* Time out */
> +		cpu_relax();
> +	}
> +
> +	stat = pmecc_readl_relaxed(host->ecc, ISR);
> +	if (stat != 0) {
> +		if (pmecc_correction(mtd, stat, buf, &oob[eccpos[0]]) != 0)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void atmel_nand_pmecc_write_page(struct mtd_info *mtd,
> +		struct nand_chip *chip, const uint8_t *buf)
> +{
> +	int			i, j;
> +	int			timeout_count = 0;
> +	struct atmel_nand_host	*host = chip->priv;
> +	uint32_t		*eccpos = chip->ecc.layout->eccpos;
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> +
> +	pmecc_writel(host->ecc, CFG, (pmecc_readl_relaxed(host->ecc, CFG) |
> +		PMECC_CFG_WRITE_OP) & ~PMECC_CFG_AUTO_ENABLE);
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +
> +	chip->write_buf(mtd, (u8 *)buf, mtd->writesize);
> +
> +	while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
> +		if (unlikely(timeout_count++ > PMECC_MAX_TIMEOUT_COUNT)) {
> +			dev_err(host->dev, "PMECC: Timeout to get ECC value.\n");
> +			return;	/* Time out */
> +		}
> +		cpu_relax();
> +	}
> +
> +	for (i = 0; i < host->pmecc_sector_number; i++) {
> +		for (j = 0; j < host->pmecc_bytes_per_sector; j++) {
> +			int pos;
> +
> +			pos = i * host->pmecc_bytes_per_sector + j;
> +			chip->oob_poi[eccpos[pos]] =
> +				pmecc_readb_ecc_relaxed(host->ecc, i, j);
> +		}
> +	}
> +	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	return;
> +}
> +
> +static void atmel_pmecc_core_init(struct mtd_info *mtd)
> +{
> +	uint32_t		val = 0;
> +	struct nand_chip	*nand_chip = mtd->priv;
> +	struct atmel_nand_host	*host = nand_chip->priv;
> +	struct nand_ecclayout	*ecc_layout;
> +
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> +
> +	switch (host->pmecc_corr_cap) {
> +	case 2:
> +		val = PMECC_CFG_BCH_ERR2;
> +		break;
> +	case 4:
> +		val = PMECC_CFG_BCH_ERR4;
> +		break;
> +	case 8:
> +		val = PMECC_CFG_BCH_ERR8;
> +		break;
> +	case 12:
> +		val = PMECC_CFG_BCH_ERR12;
> +		break;
> +	case 24:
> +		val = PMECC_CFG_BCH_ERR24;
> +		break;
> +	}
> +
> +	if (host->pmecc_sector_size == 512)
> +		val |= PMECC_CFG_SECTOR512;
> +	else if (host->pmecc_sector_size == 1024)
> +		val |= PMECC_CFG_SECTOR1024;
> +
> +	switch (host->pmecc_sector_number) {
> +	case 1:
> +		val |= PMECC_CFG_PAGE_1SECTOR;
> +		break;
> +	case 2:
> +		val |= PMECC_CFG_PAGE_2SECTORS;
> +		break;
> +	case 4:
> +		val |= PMECC_CFG_PAGE_4SECTORS;
> +		break;
> +	case 8:
> +		val |= PMECC_CFG_PAGE_8SECTORS;
> +		break;
> +	}
> +
> +	val |= (PMECC_CFG_READ_OP | PMECC_CFG_SPARE_DISABLE
> +		| PMECC_CFG_AUTO_DISABLE);
> +	pmecc_writel(host->ecc, CFG, val);
> +
> +	ecc_layout = nand_chip->ecc.layout;
> +	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
> +	pmecc_writel(host->ecc, SADDR, ecc_layout->eccpos[0]);
> +	pmecc_writel(host->ecc, EADDR,
> +			ecc_layout->eccpos[ecc_layout->eccbytes - 1]);
> +	/* See datasheet about PMECC Clock Control Register */
> +	pmecc_writel(host->ecc, CLK, 2);
> +	pmecc_writel(host->ecc, IDR, 0xff);
> +	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> +}
> +
> +static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
> +					 struct atmel_nand_host *host)
> +{
> +	int			cap, sector_size, err_no;
> +	struct mtd_info		*mtd;
> +	struct nand_chip	*nand_chip;
> +	struct resource		*regs;
> +	struct resource		*regs_pmerr, *regs_rom;
> +
> +	cap = host->pmecc_corr_cap;
> +	sector_size = host->pmecc_sector_size;
> +	dev_info(host->dev, "Initialize PMECC params, cap: %d, sector: %d\n",
> +		 cap, sector_size);
> +
> +	/* Sanity check */
> +	if ((sector_size != 512) && (sector_size != 1024)) {
> +		dev_err(host->dev,
> +			"Unsupported PMECC sector size: %d; should be 512 or 1024 bytes\n",
> +			sector_size);
> +		return -EINVAL;
> +	}
> +	if ((cap != 2) && (cap != 4) && (cap != 8) && (cap != 12) &&
> +	    (cap != 24)) {
> +		dev_err(host->dev,
> +			"Unsupported PMECC correction capability, should be 2, 4, 8, 12 or 24\n");
> +		return -EINVAL;
> +	}
> +
> +	nand_chip = &host->nand_chip;
> +	mtd = &host->mtd;
> +
> +	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* By default */
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!regs) {
> +		dev_warn(host->dev,
> +			"Can't get I/O resource regs, rolling back on software ECC\n");
> +		return 0;
> +	}
> +
> +	host->ecc = ioremap(regs->start, resource_size(regs));
> +	if (host->ecc == NULL) {
> +		dev_err(host->dev, "ioremap failed\n");
> +		err_no = -EIO;
> +		goto err_pmecc_ioremap;
> +	}
> +
> +	regs_pmerr = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	regs_rom = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +	if (regs_pmerr && regs_rom) {
> +		host->pmerrloc_base = ioremap(regs_pmerr->start,
> +			resource_size(regs_pmerr));
> +		host->pmecc_rom_base = ioremap(regs_rom->start,
> +			resource_size(regs_rom));
> +
> +		if (host->pmerrloc_base && host->pmecc_rom_base) {
> +			nand_chip->ecc.mode = NAND_ECC_HW;
> +			nand_chip->ecc.read_page =
> +				atmel_nand_pmecc_read_page;
> +			nand_chip->ecc.write_page =
> +				atmel_nand_pmecc_write_page;
> +		} else {
> +			dev_err(host->dev,
> +				"Can not get I/O resource for PMECC controller!\n");
> +			err_no = -EIO;
> +			goto err_pmloc_ioremap;
> +		}
> +	}
> +
> +	/* ECC is calculated for the whole page (1 step) */
> +	nand_chip->ecc.size = mtd->writesize;
> +
> +	/* set ECC page size and oob layout */
> +	switch (mtd->writesize) {
> +	case 2048:
> +		host->pmecc_degree = PMECC_GF_DIMENSION_13;
> +		host->pmecc_cw_len = (1 << host->pmecc_degree) - 1;
> +		host->pmecc_corr_cap = cap;
> +		host->pmecc_sector_number = mtd->writesize / sector_size;
> +		host->pmecc_bytes_per_sector = pmecc_get_ecc_bytes(
> +			cap, sector_size);
> +		host->pmecc_alpha_to = pmecc_get_alpha_to(host);
> +		host->pmecc_index_of = pmecc_get_index_of(host);
> +
> +		nand_chip->ecc.steps = 1;
> +		nand_chip->ecc.strength = cap;
> +		nand_chip->ecc.bytes = host->pmecc_bytes_per_sector *
> +				       host->pmecc_sector_number;
> +		if (nand_chip->ecc.bytes > mtd->oobsize - 2) {
> +			dev_err(host->dev, "No room for ECC bytes\n");
> +			err_no = -EINVAL;
> +			goto err;
> +		}
> +		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
> +					mtd->oobsize,
> +					nand_chip->ecc.bytes);
> +		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
> +		break;
> +	case 512:
> +	case 1024:
> +	case 4096:
> +		/* TODO */
> +		dev_warn(host->dev,
> +			"Unsupported page size for PMECC, use Software ECC\n");
> +	default:
> +		/* page size not handled by HW ECC */
> +		/* switching back to soft ECC */
> +		nand_chip->ecc.mode = NAND_ECC_SOFT;
> +		nand_chip->ecc.calculate = NULL;
> +		nand_chip->ecc.correct = NULL;
> +		nand_chip->ecc.hwctl = NULL;
> +		nand_chip->ecc.read_page = NULL;
> +		nand_chip->ecc.write_page = NULL;
> +		nand_chip->ecc.postpad = 0;
> +		nand_chip->ecc.prepad = 0;
> +		nand_chip->ecc.bytes = 0;
> +		err_no = 0;
> +		goto err;
> +	}
> +
> +	/* Allocate data for PMECC computation */
> +	host->pmecc_data = kzalloc(sizeof(struct atmel_pmecc_data), GFP_KERNEL);
why do you always allocate the pmecc_data?

you need to allocate it only if you use it

Best Regards,
J.
> +	if (!host->pmecc_data) {
> +		dev_err(host->dev,
> +				"Cannot allocate memory for PMECC computation!\n");
> +		err_no = -ENOMEM;
> +		goto err;
> +	}
> +
> +	atmel_pmecc_core_init(mtd);
> +
> +	return 0;
> +
> +err:
> +err_pmloc_ioremap:
> +	iounmap(host->ecc);
> +	if (host->pmerrloc_base)
> +		iounmap(host->pmerrloc_base);
> +	if (host->pmecc_rom_base)
> +		iounmap(host->pmecc_rom_base);
> +err_pmecc_ioremap:
> +	return err_no;
> +}
> +
> +/*
>   * Calculate HW ECC
>   *
>   * function called after a write
> @@ -720,7 +1456,11 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	if (nand_chip->ecc.mode == NAND_ECC_HW) {
> -		res = atmel_hw_nand_init_params(pdev, host);
> +		if (host->has_pmecc)
> +			res = atmel_pmecc_nand_init_params(pdev, host);
> +		else
> +			res = atmel_hw_nand_init_params(pdev, host);
> +
>  		if (res != 0)
>  			goto err_hw_ecc;
>  	}
> @@ -741,6 +1481,12 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>  err_scan_tail:
>  	if (host->ecc)
>  		iounmap(host->ecc);
> +	if (host->has_pmecc) {
no need to check if you have teh pmecc

if it's no the case pmerrloc_base will be NULLo

don't you need to disable it in the error path?

Best Regards,
J.
