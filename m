From: rogerq@ti.com (Roger Quadros)
Date: Wed, 1 Oct 2014 12:32:09 +0300
Subject: [PATCH] nand: omap2: fix building with CONFIG_MTD_NAND_OMAP_BCH=m
In-Reply-To: <1811108.CcWEs0vKNL@wuerfel>
References: <1811108.CcWEs0vKNL@wuerfel>
Message-ID: <542BCA19.8050603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Brian,

On 09/30/2014 03:04 PM, Arnd Bergmann wrote:
> If the OMAP nand driver is built-in but the BCH driver is a module,
> we get a link-time error:
> 
> drivers/built-in.o: In function `omap_elm_correct_data':
> :(.text+0x174e88): undefined reference to `elm_decode_bch_error_page'
> drivers/built-in.o: In function `omap_nand_probe':
> :(.text+0x175b48): undefined reference to `elm_config'
> 
> There are two possible ways to deal with this, either prevent that
> configuration in Kconfig or make sure we don't reference the ELM
> driver in this case.
> 
> This patch picks the second approach, which makes it possible to
> use the ELM driver in other modules while still having the OMAP
> NAND driver built-in.

With this patch NAND probe on DRA7xx fails like so

[    2.077313] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    2.083842] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xca
[    2.090524] nand: Micron MT29F2G16ABAEAWP
[    2.094728] nand: 256MiB, SLC, page size: 2048, OOB size: 64
[    2.100745] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
[    2.109764] omap2-nand: probe of omap2-nand.0 failed with error -38

OMAP NAND driver is the only user of the ELM module and we want it
to be usable in all possible configurations when enabled.

Let's pick either one of the below patches instead

http://article.gmane.org/gmane.linux.ports.arm.omap/118488
OR
http://article.gmane.org/gmane.linux.ports.arm.omap/118847

cheers,
-roger

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 93af53b8633c ("nand: omap2: Remove horrible ifdefs to fix module probe")
> 
> diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
> index b8686c00f15f..cbca66ce7c10 100644
> --- a/include/linux/platform_data/elm.h
> +++ b/include/linux/platform_data/elm.h
> @@ -42,7 +42,7 @@ struct elm_errorvec {
>  	int error_loc[16];
>  };
>  
> -#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
> +#if defined(CONFIG_MTD_NAND_OMAP_BCH) || (defined(CONFIG_MTD_NAND_OMAP_BCH_MODULE) && defined(MODULE))
>  void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>  		struct elm_errorvec *err_vec);
>  int elm_config(struct device *dev, enum bch_ecc bch_type,
> 
