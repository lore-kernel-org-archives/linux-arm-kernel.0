From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 24 May 2010 10:25:45 +0300
Subject: [PATCH 02/20] mtd: pxa3xx_nand: introduce common timing to reduce
	read id times
In-Reply-To: <AANLkTilOX0zNdwYfGrbJ-gJ7M6spBUIQqwZPFvAe4fbr@mail.gmail.com>
References: <AANLkTilOX0zNdwYfGrbJ-gJ7M6spBUIQqwZPFvAe4fbr@mail.gmail.com>
Message-ID: <4BFA29F9.8000400@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote:
> From 35a06a21643049e146aba95057e7fe89c55d4b32 Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Mon, 22 Mar 2010 10:24:48 +0800
> Subject: [PATCH] mtd: pxa3xx_nand: introduce common timing to reduce
> read id times
> 
> We certainly don't need to send read id command times by times, since
> we already know what the id is after the first read id...
> 
> So create a common timing which could ensure it would successfully read id
> out all supported chip. Then follow the build-in table to reconfigure
> the timing.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |   33 +++++++++++++++++----------------
>  1 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index da40b9a..5658398 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -225,7 +225,13 @@ const static struct pxa3xx_nand_cmdset cmdset = {
>  	.lock_status	= 0x007A,
>  };
> 
> +/**
> + * The timing defined in the builtin_flash_types[0]
> + * could be considered as the common timing which is used to
> + * detect the chip id before we know how to optimize further
> + */
>  static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
> +{ 0, 0, 0, 0, 0, 0, { 40, 80, 60, 100, 80, 100, 90000, 400, 40, }, },
>  { 0x46ec, 32, 512, 16, 16, 4096, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
>  { 0xdaec, 64, 2048, 8, 8, 2048, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
>  { 0xd7ec, 128, 4096, 8, 8, 8192, { 10, 0, 20, 40, 30, 40, 11123, 110, 10, }, },
> @@ -850,12 +856,6 @@ static int pxa3xx_nand_config_flash(struct
> pxa3xx_nand_info *info,
>  	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
>  	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */
> 
> -	if (f->page_size != 2048 && f->page_size != 512)
> -		return -EINVAL;
> -
> -	if (f->flash_width != 16 && f->flash_width != 8)
> -		return -EINVAL;
> -
>  	/* calculate flash information */
>  	info->oob_size = (f->page_size == 2048) ? 64 : 16;
>  	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
> @@ -967,23 +967,24 @@ static int pxa3xx_nand_detect_flash(struct
> pxa3xx_nand_info *info,
>  		if (pxa3xx_nand_detect_config(info) == 0)
>  			return 0;
> 
> -	for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {
> +	f = &builtin_flash_types[0];
> +	pxa3xx_nand_config_flash(info, f);
> +	if (__readid(info, &id))
> +		goto fail_detect;
> 
> +	for (i = 1; i < ARRAY_SIZE(builtin_flash_types); i++) {
>  		f = &builtin_flash_types[i];
> -
> -		if (pxa3xx_nand_config_flash(info, f))
> -			continue;
> -
> -		if (__readid(info, &id))
> -			continue;
> -
> -		if (id == f->chip_id)
> +		if (f->chip_id == id) {
> +			dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
> +			pxa3xx_nand_config_flash(info, f);
>  			return 0;
> +		}
>  	}
> 
>  	dev_warn(&info->pdev->dev,
> -		 "failed to detect configured nand flash; found %04x instead of\n",
> +			"failed to detect configured nand flash; found %04x instead of\n",

Instead of what?
And, what if the flash is not listed in the builtin_flash_types? Does it 
really mean it's
-ENODEV?

>  		 id);
> +fail_detect:
>  	return -ENODEV;
>  }
> 


-- 
Sincerely yours,
Mike.
