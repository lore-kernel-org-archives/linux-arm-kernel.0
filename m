From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 24 May 2010 10:25:54 +0300
Subject: [PATCH 03/20] mtd: pxa3xx_nand: remove the flash info in driver
	structure
In-Reply-To: <AANLkTikU9yabdwx_a5SzpC11v9nowW_zglNHLaswaToB@mail.gmail.com>
References: <AANLkTikU9yabdwx_a5SzpC11v9nowW_zglNHLaswaToB@mail.gmail.com>
Message-ID: <4BFA2A02.2040605@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote:
> From dd45d508745edb24e9e4129077e9f5bd20415a23 Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Mon, 22 Mar 2010 10:33:49 +0800
> Subject: [PATCH] mtd: pxa3xx_nand: remove the flash info in driver structure
> 
> After probe, all info already transfer to driver structure.
> There is no need to keep the original flash info.
> So that we could safely free the flash info in memory, which may grows
> larger when more flash is suported.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |   70 ++++++++++++++++++++++++++--------------
>  1 files changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 5658398..2dfe6d9 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -152,7 +152,6 @@ struct pxa3xx_nand_info {
>  	struct nand_chip	nand_chip;
> 
>  	struct platform_device	 *pdev;
> -	const struct pxa3xx_nand_flash *flash_info;
> 
>  	struct clk		*clk;
>  	void __iomem		*mmio_base;
> @@ -166,6 +165,7 @@ struct pxa3xx_nand_info {
>  	int			drcmr_cmd;
> 
>  	unsigned char		*data_buff;
> +	unsigned char		*oob_buff;
>  	dma_addr_t 		data_buff_phys;
>  	size_t			data_buff_size;
>  	int 			data_dma_ch;
> @@ -184,7 +184,8 @@ struct pxa3xx_nand_info {
>  	int			use_ecc;	/* use HW ECC ? */
>  	int			use_dma;	/* use DMA ? */
> 
> -	size_t			data_size;	/* data size in FIFO */
> +	unsigned int		page_size;	/* page size of attached chip */
> +	unsigned int		data_size;	/* data size in FIFO */
>  	int 			retcode;
>  	struct completion 	cmd_complete;
> 
> @@ -193,6 +194,10 @@ struct pxa3xx_nand_info {
>  	uint32_t		ndcb1;
>  	uint32_t		ndcb2;
> 
> +	/* timing calcuted from setting */
> +	uint32_t		ndtr0cs0;
> +	uint32_t		ndtr1cs0;
> +
>  	/* calculated from pxa3xx_nand_flash data */
>  	size_t		oob_size;
>  	size_t		read_id_bytes;
> @@ -287,6 +292,8 @@ static void pxa3xx_nand_set_timing(struct
> pxa3xx_nand_info *info,
>  		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
>  		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));
> 
> +	info->ndtr0cs0 = ndtr0;
> +	info->ndtr1cs0 = ndtr1;
>  	nand_writel(info, NDTR0CS0, ndtr0);
>  	nand_writel(info, NDTR1CS0, ndtr1);
>  }
> @@ -310,22 +317,29 @@ static int wait_for_event(struct
> pxa3xx_nand_info *info, uint32_t event)
>  	return -ETIMEDOUT;
>  }
> 
> -static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
> -			uint16_t cmd, int column, int page_addr)
> +static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
>  {
> -	const struct pxa3xx_nand_flash *f = info->flash_info;
> +	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
> 
> -	/* calculate data size */
> -	switch (f->page_size) {
> -	case 2048:
> -		info->data_size = (info->use_ecc) ? 2088 : 2112;
> -		break;
> -	case 512:
> -		info->data_size = (info->use_ecc) ? 520 : 528;
> -		break;
> -	default:
> -		return -EINVAL;
> +	info->data_size = info->page_size;
> +	if (!oob_enable) {
> +		info->oob_size = 0;
> +		return;
>  	}
> +	switch (info->page_size) {
> +		case 2048:
> +			info->oob_size = (info->use_ecc) ? 40 : 64;
> +			break;
> +		case 512:
> +			info->oob_size = (info->use_ecc) ? 8 : 16;
> +			break;
> +	}

The OOB-related changes do not seem related to the $SUBJ.

> +}
> +
> +static int prepare_read_prog_cmd(struct pxa3xx_nand_info *info,
> +		uint16_t cmd, int column, int page_addr)
> +{
> +	pxa3xx_set_datasize(info);
> 
>  	/* generate values for NDCBx registers */
>  	info->ndcb0 = cmd | ((cmd & 0xff00) ? NDCB0_DBC : 0);
> @@ -436,6 +450,9 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
>  	case STATE_PIO_WRITING:
>  		__raw_writesl(info->mmio_base + NDDB, info->data_buff,
>  				DIV_ROUND_UP(info->data_size, 4));
> +		if (info->oob_size > 0)
> +			__raw_writesl(info->mmio_base + NDDB, info->oob_buff,
> +					DIV_ROUND_UP(info->oob_size, 4));

The same here.

>  		enable_int(info, NDSR_CS0_BBD | NDSR_CS0_CMDD);
> 
> @@ -448,6 +465,10 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
>  	case STATE_PIO_READING:
>  		__raw_readsl(info->mmio_base + NDDB, info->data_buff,
>  				DIV_ROUND_UP(info->data_size, 4));
> +		if (info->oob_size > 0)
> +			__raw_readsl(info->mmio_base + NDDB, info->oob_buff,
> +					DIV_ROUND_UP(info->oob_size, 4));
> +

Ditto.

>  		break;
>  	default:
>  		printk(KERN_ERR "%s: invalid state %d\n", __func__,
> @@ -462,7 +483,7 @@ static int handle_data_pio(struct pxa3xx_nand_info *info)
>  static void start_data_dma(struct pxa3xx_nand_info *info, int dir_out)
>  {
>  	struct pxa_dma_desc *desc = info->data_desc;
> -	int dma_len = ALIGN(info->data_size, 32);
> +	int dma_len = ALIGN(info->data_size + info->oob_size, 32);

ditto

>  	desc->ddadr = DDADR_STOP;
>  	desc->dcmd = DCMD_ENDIRQEN | DCMD_WIDTH4 | DCMD_BURST32 | dma_len;
> @@ -857,6 +878,8 @@ static int pxa3xx_nand_config_flash(struct
> pxa3xx_nand_info *info,
>  	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */
> 
>  	/* calculate flash information */
> +	info->page_size = f->page_size;
> +	info->oob_buff = info->data_buff + f->page_size;

And here as well

>  	info->oob_size = (f->page_size == 2048) ? 64 : 16;
>  	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
> 
> @@ -881,7 +904,6 @@ static int pxa3xx_nand_config_flash(struct
> pxa3xx_nand_info *info,
>  	info->reg_ndcr = ndcr;
> 
>  	pxa3xx_nand_set_timing(info, &f->timing);
> -	info->flash_info = f;
>  	return 0;
>  }
> 
> @@ -917,7 +939,6 @@ static int pxa3xx_nand_detect_config(struct
> pxa3xx_nand_info *info)
>  	default_flash.dfc_width = ndcr & NDCR_DWIDTH_C ? 16 : 8;
> 
>  	/* set info fields needed to __readid */
> -	info->flash_info = &default_flash;
>  	info->read_id_bytes = (default_flash.page_size == 2048) ? 4 : 2;
>  	info->reg_ndcr = ndcr;
> 
> @@ -1047,10 +1068,9 @@ static struct nand_ecclayout hw_largepage_ecclayout = {
>  static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
>  				 struct pxa3xx_nand_info *info)
>  {
> -	const struct pxa3xx_nand_flash *f = info->flash_info;
>  	struct nand_chip *this = &info->nand_chip;
> 
> -	this->options = (f->flash_width == 16) ? NAND_BUSWIDTH_16: 0;
> +	this->options = (info->reg_ndcr & NDCR_DWIDTH_C) ? NAND_BUSWIDTH_16: 0;
> 
>  	this->waitfunc		= pxa3xx_nand_waitfunc;
>  	this->select_chip	= pxa3xx_nand_select_chip;
> @@ -1066,9 +1086,9 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
>  	this->ecc.hwctl		= pxa3xx_nand_ecc_hwctl;
>  	this->ecc.calculate	= pxa3xx_nand_ecc_calculate;
>  	this->ecc.correct	= pxa3xx_nand_ecc_correct;
> -	this->ecc.size		= f->page_size;
> +	this->ecc.size		= info->page_size;
> 
> -	if (f->page_size == 2048)
> +	if (info->page_size == 2048)
>  		this->ecc.layout = &hw_largepage_ecclayout;
>  	else
>  		this->ecc.layout = &hw_smallpage_ecclayout;
> @@ -1076,7 +1096,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
>  	this->chip_delay = 25;
>  }
> 
> -static int pxa3xx_nand_probe(struct platform_device *pdev)
> +static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)
>  {
>  	struct pxa3xx_nand_platform_data *pdata;
>  	struct pxa3xx_nand_info *info;
> @@ -1264,9 +1284,11 @@ static int pxa3xx_nand_resume(struct
> platform_device *pdev)
>  	struct mtd_info *mtd = (struct mtd_info *)platform_get_drvdata(pdev);
>  	struct pxa3xx_nand_info *info = mtd->priv;
> 
> +	nand_writel(info, NDTR0CS0, info->ndtr0cs0);
> +	nand_writel(info, NDTR1CS0, info->ndtr1cs0);
>  	clk_enable(info->clk);
> 
> -	return pxa3xx_nand_config_flash(info, info->flash_info);
> +	return 0;
>  }
>  #else
>  #define pxa3xx_nand_suspend	NULL


-- 
Sincerely yours,
Mike.
