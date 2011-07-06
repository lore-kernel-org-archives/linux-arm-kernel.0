From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 06 Jul 2011 10:29:16 +0300
Subject: [PATCH 2/4] MTD: pxa3xx_nand: sperate each chip individual info
In-Reply-To: <1309771536-10597-3-git-send-email-leiwen@marvell.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-3-git-send-email-leiwen@marvell.com>
Message-ID: <4E140ECC.2000400@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,


You are going to resubmit the series to merge patches 3 and 4, so

a small nitpick below


On 07/04/11 12:25, Lei Wen wrote:

> For support two chip select, we seperate chip specific info in this
> patch.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |  281 ++++++++++++++++++++++------------------
>  1 files changed, 154 insertions(+), 127 deletions(-)

[...]

>  
>  static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
>  {
> +	struct pxa3xx_nand_host *host = info->host;
>  	uint32_t ndcr = nand_readl(info, NDCR);
> -	info->page_size = ndcr & NDCR_PAGE_SZ ? 2048 : 512;
> -	/* set info fields needed to read id */
> -	info->read_id_bytes = (info->page_size == 2048) ? 4 : 2;
> -	info->reg_ndcr = ndcr & ~NDCR_INT_MASK;
> -	info->cmdset = &default_cmdset;
>  
> -	info->ndtr0cs0 = nand_readl(info, NDTR0CS0);
> -	info->ndtr1cs0 = nand_readl(info, NDTR1CS0);
> +	if (ndcr & NDCR_PAGE_SZ) {
> +		host->page_size = 2048;
> +		host->read_id_bytes = 4;
> +	} else {
> +		host->page_size = 512;
> +		host->read_id_bytes = 2;
> +	}

empty line would be nice here

> +	host->reg_ndcr = ndcr & ~NDCR_INT_MASK;
> +	host->cmdset = &default_cmdset;
> +
> +	host->ndtr0cs0 = nand_readl(info, NDTR0CS0);
> +	host->ndtr1cs0 = nand_readl(info, NDTR1CS0);
>  
>  	return 0;
>  }

[...]

>  
> @@ -933,14 +947,17 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>  	}
>  
>  	if (i >= (ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1)) {
> -		kfree(mtd);
> -		info->mtd = NULL;
> +		host->mtd = NULL;
>  		dev_err(&info->pdev->dev, "ERROR!! flash not defined!!!\n");
>  
>  		return -EINVAL;
>  	}
>  
> -	pxa3xx_nand_config_flash(info, f);
> +	ret = pxa3xx_nand_config_flash(info, f);
> +	if (ret) {
> +		dev_err(&info->pdev->dev, "ERROR! Configure failed\n");
> +		return ret;
> +	}

and here

>  	pxa3xx_flash_ids[0].name = f->name;
>  	pxa3xx_flash_ids[0].id = (f->chip_id >> 8) & 0xffff;
>  	pxa3xx_flash_ids[0].pagesize = f->page_size;
> @@ -955,44 +972,52 @@ KEEP_CONFIG:
>  	if (nand_scan_ident(mtd, 1, def))
>  		return -ENODEV;
>  	/* calculate addressing information */
> -	info->col_addr_cycles = (mtd->writesize >= 2048) ? 2 : 1;
> +	if (mtd->writesize >= 2048)
> +		host->col_addr_cycles = 2;
> +	else
> +		host->col_addr_cycles = 1;

and here

>  	info->oob_buff = info->data_buff + mtd->writesize;
>  	if ((mtd->size >> chip->page_shift) > 65536)
> -		info->row_addr_cycles = 3;
> +		host->row_addr_cycles = 3;
>  	else
> -		info->row_addr_cycles = 2;
> +		host->row_addr_cycles = 2;

also here

>  	mtd->name = mtd_names[0];
>  	chip->ecc.mode = NAND_ECC_HW;
> -	chip->ecc.size = info->page_size;
> +	chip->ecc.size = host->page_size;
>  
> -	chip->options = (info->reg_ndcr & NDCR_DWIDTH_M) ? NAND_BUSWIDTH_16 : 0;
> +	chip->options = 0;
> +	if (host->reg_ndcr & NDCR_DWIDTH_M)
> +		chip->options = NAND_BUSWIDTH_16;
>  	chip->options |= NAND_NO_AUTOINCR;
>  	chip->options |= NAND_NO_READRDY;

here, you can just reorder the bit operations, so you won't need to do options = 0.
And empty line after if, would be great.

>  
>  	return nand_scan_tail(mtd);
>  }
>  

[...]

>  static int pxa3xx_nand_remove(struct platform_device *pdev)
>  {
>  	struct pxa3xx_nand_info *info = platform_get_drvdata(pdev);
> -	struct mtd_info *mtd = info->mtd;
>  	struct resource *r;
>  	int irq;
>  
> +	if (!info)
> +		return 0;

and here (empty line)

apart from that nitpicking, the patch should be fine.

-- 
Regards,
Igor.
