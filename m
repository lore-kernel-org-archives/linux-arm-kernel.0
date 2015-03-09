From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 09 Mar 2015 10:37:09 -0300
Subject: [PATCH v3 4/9] mtd: pxa3xx_nand: rework timings setup
In-Reply-To: <1425555085-29531-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <54FDA205.40407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2015 08:31 AM, Antoine Tenart wrote:
> Use the nand framework helpers: onfi_get_async_timing_mode() and
> onfi_async_timing_mode_to_sdr_timings() to retrieve the timing
> configuration. Then update the pxa3xx timing setup function to use the
> timing configuration retrieved.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c                | 101 ++++++++++++++++++--------
>  include/linux/platform_data/mtd-nand-pxa3xx.h |   2 -
>  2 files changed, 69 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index dc0edbc406bb..4bcfb4cf6fee 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -243,23 +243,16 @@ static bool use_dma = 1;
>  module_param(use_dma, bool, 0444);
>  MODULE_PARM_DESC(use_dma, "enable DMA for data transferring to/from NAND HW");
>  
> -static struct pxa3xx_nand_timing timing[] = {
> -	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
> -	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
> -	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
> -	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
> -};
> -
>  static struct pxa3xx_nand_flash builtin_flash_types[] = {
> -{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0, &timing[0] },
> -{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096, &timing[1] },
> -{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048, &timing[1] },
> -{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },
> -{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024, &timing[2] },
> -{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024, &timing[2] },
> -{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096, &timing[2] },
> -{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2] },
> -{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048, &timing[3] },
> +{ "DEFAULT FLASH",      0,   0, 2048,  8,  8,    0 },
> +{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, 4096 },
> +{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, 2048 },
> +{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192 },
> +{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, 1024 },
> +{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, 1024 },
> +{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, 4096 },
> +{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096 },
> +{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, 2048 },
>  };
>  
>  static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
> @@ -361,22 +354,31 @@ pxa3xx_nand_get_variant(struct platform_device *pdev)
>  }
>  
>  static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
> -				   const struct pxa3xx_nand_timing *t)
> +				   const struct nand_sdr_timings *t)
>  {
>  	struct pxa3xx_nand_info *info = host->info_data;
>  	unsigned long nand_clk = clk_get_rate(info->clk);
>  	uint32_t ndtr0, ndtr1;
> -
> -	ndtr0 = NDTR0_tCH(ns2cycle(t->tCH, nand_clk)) |
> -		NDTR0_tCS(ns2cycle(t->tCS, nand_clk)) |
> -		NDTR0_tWH(ns2cycle(t->tWH, nand_clk)) |
> -		NDTR0_tWP(ns2cycle(t->tWP, nand_clk)) |
> -		NDTR0_tRH(ns2cycle(t->tRH, nand_clk)) |
> -		NDTR0_tRP(ns2cycle(t->tRP, nand_clk));
> -
> -	ndtr1 = NDTR1_tR(ns2cycle(t->tR, nand_clk)) |
> -		NDTR1_tWHR(ns2cycle(t->tWHR, nand_clk)) |
> -		NDTR1_tAR(ns2cycle(t->tAR, nand_clk));
> +	u32 tCH_min = DIV_ROUND_UP(t->tCH_min, 1000);
> +	u32 tCS_min = DIV_ROUND_UP(t->tCS_min, 1000);
> +	u32 tWH_min = DIV_ROUND_UP(t->tWH_min, 1000);
> +	u32 tWP_min = DIV_ROUND_UP(t->tWP_min, 1000);
> +	u32 tREH_min = DIV_ROUND_UP(t->tREH_min, 1000);
> +	u32 tRP_min = DIV_ROUND_UP(t->tRP_min, 1000);
> +	u32 tRST_max = DIV_ROUND_UP_ULL(t->tRST_max, 1000);
> +	u32 tWHR_min = DIV_ROUND_UP(t->tWHR_min, 1000);
> +	u32 tAR_min = DIV_ROUND_UP(t->tAR_min, 1000);
> +
> +	ndtr0 = NDTR0_tCH(ns2cycle(tCH_min, nand_clk)) |
> +		NDTR0_tCS(ns2cycle(tCS_min, nand_clk)) |
> +		NDTR0_tWH(ns2cycle(tWH_min, nand_clk)) |
> +		NDTR0_tWP(ns2cycle(tWP_min, nand_clk)) |
> +		NDTR0_tRH(ns2cycle(tREH_min, nand_clk)) |
> +		NDTR0_tRP(ns2cycle(tRP_min, nand_clk));
> +
> +	ndtr1 = NDTR1_tR(ns2cycle(tRST_max, nand_clk)) |
> +		NDTR1_tWHR(ns2cycle(tWHR_min, nand_clk)) |
> +		NDTR1_tAR(ns2cycle(tAR_min, nand_clk));
>  
>  	info->ndtr0cs0 = ndtr0;
>  	info->ndtr1cs0 = ndtr1;
> @@ -384,6 +386,29 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
>  	nand_writel(info, NDTR1CS0, ndtr1);
>  }
>  
> +static int pxa3xx_nand_init_timings(struct pxa3xx_nand_host *host)
> +{
> +	const struct nand_sdr_timings *timings;
> +	int mode;
> +
> +	mode = onfi_get_async_timing_mode(&host->chip);
> +	if (mode == ONFI_TIMING_MODE_UNKNOWN) {
> +		mode = host->chip.onfi_timing_mode_default;
> +	} else {
> +		mode = fls(mode) - 1;
> +		if (mode < 0)
> +			mode = 0;
> +	}
> +
> +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> +	if (IS_ERR(timings))
> +		return PTR_ERR(timings);
> +
> +	pxa3xx_nand_set_timing(host, timings);
> +
> +	return 0;
> +}
> +
>  /*
>   * Set the data and OOB size, depending on the selected
>   * spare and ECC configuration.
> @@ -1226,7 +1251,6 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
>  
>  	info->reg_ndcr = ndcr;
>  
> -	pxa3xx_nand_set_timing(host, f->timing);
>  	return 0;
>  }
>  
> @@ -1321,20 +1345,28 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
>  }
>  #endif
>  
> -static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
> +static int pxa3xx_nand_sensing(struct pxa3xx_nand_host *host)
>  {
> +	struct pxa3xx_nand_info *info = host->info_data;
>  	struct mtd_info *mtd;
>  	struct nand_chip *chip;
> +	const struct nand_sdr_timings *timings;
>  	int ret;
>  
>  	mtd = info->host[info->cs]->mtd;
>  	chip = mtd->priv;
>  
> -	/* use the common timing to make a try */
>  	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
>  	if (ret)
>  		return ret;
>  
> +	/* use the common timing to make a try */
> +	timings = onfi_async_timing_mode_to_sdr_timings(0);
> +	if (IS_ERR(timings))
> +		return PTR_ERR(timings);
> +
> +	pxa3xx_nand_set_timing(host, timings);
> +
>  	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
>  	ret = chip->waitfunc(mtd, chip);
>  	if (ret & NAND_STATUS_FAIL)
> @@ -1420,6 +1452,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>  	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
>  	const struct pxa3xx_nand_flash *f = NULL;
> +	const struct nand_sdr_timings *timings;
>  	struct nand_chip *chip = mtd->priv;
>  	uint32_t id = -1;
>  	uint64_t chipsize;
> @@ -1432,7 +1465,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>  	/* Set a default chunk size */
>  	info->chunk_size = 512;
>  
> -	ret = pxa3xx_nand_sensing(info);
> +	ret = pxa3xx_nand_sensing(host);
>  	if (ret) {
>  		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
>  			 info->cs);
> @@ -1498,6 +1531,10 @@ KEEP_CONFIG:
>  	if (nand_scan_ident(mtd, 1, def))
>  		return -ENODEV;
>  
> +	ret = pxa3xx_nand_init_timings(host);
> +	if (ret)
> +		dev_err(&info->pdev->dev, "Failed to set timings: %d\n", ret);
> +
>  	if (pdata->flash_bbt) {
>  		/*
>  		 * We'll use a bad block table stored in-flash and don't
> diff --git a/include/linux/platform_data/mtd-nand-pxa3xx.h b/include/linux/platform_data/mtd-nand-pxa3xx.h
> index ac4ea2e641c7..27d8f6354c2a 100644
> --- a/include/linux/platform_data/mtd-nand-pxa3xx.h
> +++ b/include/linux/platform_data/mtd-nand-pxa3xx.h
> @@ -24,8 +24,6 @@ struct pxa3xx_nand_flash {
>  	unsigned int	flash_width;	/* Width of Flash memory (DWIDTH_M) */
>  	unsigned int	dfc_width;	/* Width of flash controller(DWIDTH_C) */
>  	unsigned int	num_blocks;	/* Number of physical blocks in Flash */
> -
> -	struct pxa3xx_nand_timing *timing;	/* NAND Flash timing */
>  };
>  
>  /*
> 

This removes support for setting timing on non-ONFI devices. So, you
either need to keep the code around, or introduce some mechanism to
specify timings on these devices.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
