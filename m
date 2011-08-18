From: b32955@freescale.com (Huang Shijie)
Date: Thu, 18 Aug 2011 13:55:12 +0800
Subject: [PATCH v9 1/3] MTD : add the common code for GPMI-NAND controller
	driver
In-Reply-To: <1313581828-16625-2-git-send-email-b32955@freescale.com>
References: <1313581828-16625-1-git-send-email-b32955@freescale.com>
	<1313581828-16625-2-git-send-email-b32955@freescale.com>
Message-ID: <4E4CA940.3040106@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem:
> +static int mil_pre_bbt_scan(struct gpmi_nand_data  *this)
> +{
> +	struct nand_chip *nand = &this->mil.nand;
> +	struct mtd_info *mtd = &this->mil.mtd;
> +	struct nand_ecclayout *layout = nand->ecc.layout;
> +	int error;
> +
> +	/*
> +	 *  fix the ECC layout before the scanning.
> +	 *  We will use all the (page + OOB).
> +	 */
> +	layout->eccbytes = 0;
> +	layout->oobavail = 0;
> +
> +	mtd->oobavail = mtd->oobsize;
Buggy?
It seems mtd->oobavail should be zero here.

thanks.


Huang Shijie
> +
> +	/* Set up swap block-mark, must be set before the mil_set_geometry() */
> +	if (GPMI_IS_MX23(this))
> +		this->swap_block_mark = false;
> +	else
> +		this->swap_block_mark = true;
> +
> +	/* Set up the medium geometry */
> +	error = mil_set_geometry(this);
> +	if (error)
> +		return error;
> +
> +	/* NAND boot init, depends on the mil_set_geometry(). */
> +	return nand_boot_init(this);
> +}
> +
> +static int gpmi_scan_bbt(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd->priv;
> +	struct gpmi_nand_data *this = nand->priv;
> +	int error;
> +
> +	/* Prepare for the BBT scan. */
> +	error = mil_pre_bbt_scan(this);
> +	if (error)
> +		return error;
> +
> +	/* use the default BBT implementation */
> +	return nand_default_bbt(mtd);
> +}
> +
