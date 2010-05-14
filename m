From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 14 May 2010 12:37:57 +0200
Subject: [PATCH 1/4] pxa/colibri270: Refactor board definition file
In-Reply-To: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
References: <1273544818-22305-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100514103757.GN30807@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 04:26:55AM +0200, Marek Vasut wrote:

[...]

> -/*
> - * NOR flash
> - */
> +/******************************************************************************
> + * NOR Flash
> + ******************************************************************************/
> +#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
>  static struct mtd_partition colibri_partitions[] = {
>  	{
>  		.name =		"Bootloader",
>  		.offset =	0x00000000,
>  		.size =		0x00040000,
> -		.mask_flags =	MTD_WRITEABLE  /* force read-only */
> +		.mask_flags =	MTD_WRITEABLE	/* force read-only */
>  	}, {
>  		.name =		"Kernel",
>  		.offset =	0x00040000,
> @@ -90,42 +93,50 @@ static struct platform_device colibri_pxa270_flash_device = {
>  	.num_resources = 1,
>  };
>  
> -/*
> - * DM9000 Ethernet
> - */
> -#if defined(CONFIG_DM9000)
> -static struct resource dm9000_resources[] = {
> +static void __init colibri_pxa270_nor_init(void)
> +{
> +	platform_device_register(&colibri_pxa270_flash);

Erm ...

arch/arm/mach-pxa/colibri-pxa270.c: In function 'colibri_pxa270_nor_init':
arch/arm/mach-pxa/colibri-pxa270.c:131: error: 'colibri_pxa270_flash' undeclared (first use in this function)
arch/arm/mach-pxa/colibri-pxa270.c:131: error: (Each undeclared identifier is reported only once
arch/arm/mach-pxa/colibri-pxa270.c:131: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-pxa/colibri-pxa270.o] Error 1
make: *** [arch/arm/mach-pxa] Error 2
make: *** Waiting for unfinished jobs....

Eric, is that patch already queued?

I can send a trivial fix up - or should Marek send a new version of this
patch?

Daniel
