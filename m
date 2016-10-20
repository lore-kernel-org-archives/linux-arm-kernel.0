From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 20 Oct 2016 20:55:02 +0300
Subject: [PATCH v2 1/3] mtd: s3c2410: make ecc mode configurable via
 platform data
In-Reply-To: <1476906725-22613-2-git-send-email-sergio.prado@e-labworks.com>
References: <1476906725-22613-1-git-send-email-sergio.prado@e-labworks.com>
 <1476906725-22613-2-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161020175502.GB7119@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 05:52:03PM -0200, Sergio Prado wrote:
> Removing CONFIG_MTD_NAND_S3C2410_HWECC option and adding a ecc_mode
> field in the drivers's platform data structure so it can be selectable
> via platform data.
> 
> Also setting this field to NAND_ECC_SOFT in all boards using this
> driver since none of them had CONFIG_MTD_NAND_S3C2410_HWECC enabled.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  arch/arm/mach-s3c24xx/common-smdk.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-anubis.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-at2440evb.c         |   1 +
>  arch/arm/mach-s3c24xx/mach-bast.c              |   1 +
>  arch/arm/mach-s3c24xx/mach-gta02.c             |   1 +
>  arch/arm/mach-s3c24xx/mach-jive.c              |   1 +
>  arch/arm/mach-s3c24xx/mach-mini2440.c          |   1 +
>  arch/arm/mach-s3c24xx/mach-osiris.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-qt2410.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-rx1950.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-rx3715.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-vstms.c             |   1 +
>  arch/arm/mach-s3c64xx/mach-hmt.c               |   1 +
>  arch/arm/mach-s3c64xx/mach-mini6410.c          |   1 +
>  arch/arm/mach-s3c64xx/mach-real6410.c          |   1 +

You missed cc-ing Samsung Soc maintainers on v2 and these files belong
to this tree. Please, don't forget next time.

The change itself looks atomic so I guess these files cannot go through
separate tree. In that case:

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


>  drivers/mtd/nand/Kconfig                       |   9 --
>  drivers/mtd/nand/s3c2410.c                     | 119 +++++++++++++------------
>  include/linux/platform_data/mtd-nand-s3c2410.h |   6 +-
>  18 files changed, 79 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
> index e9fbcc91c5c0..9e0bc46e90ec 100644
> --- a/arch/arm/mach-s3c24xx/common-smdk.c
> +++ b/arch/arm/mach-s3c24xx/common-smdk.c
> @@ -171,6 +171,7 @@
>  	.twrph1		= 20,
>  	.nr_sets	= ARRAY_SIZE(smdk_nand_sets),
>  	.sets		= smdk_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* devices we initialise */
> diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
> index d03df0df01fa..029ef1b58925 100644
> --- a/arch/arm/mach-s3c24xx/mach-anubis.c
> +++ b/arch/arm/mach-s3c24xx/mach-anubis.c
> @@ -223,6 +223,7 @@ static void anubis_nand_select(struct s3c2410_nand_set *set, int slot)
>  	.nr_sets	= ARRAY_SIZE(anubis_nand_sets),
>  	.sets		= anubis_nand_sets,
>  	.select_chip	= anubis_nand_select,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* IDE channels */
> diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
> index 9ae170fef2a7..7b28eb623fc1 100644
> --- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
> +++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
> @@ -114,6 +114,7 @@
>  	.twrph1		= 40,
>  	.nr_sets	= ARRAY_SIZE(at2440evb_nand_sets),
>  	.sets		= at2440evb_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* DM9000AEP 10/100 ethernet controller */
> diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
> index ed07cf392d4b..5185036765db 100644
> --- a/arch/arm/mach-s3c24xx/mach-bast.c
> +++ b/arch/arm/mach-s3c24xx/mach-bast.c
> @@ -299,6 +299,7 @@ static void bast_nand_select(struct s3c2410_nand_set *set, int slot)
>  	.nr_sets	= ARRAY_SIZE(bast_nand_sets),
>  	.sets		= bast_nand_sets,
>  	.select_chip	= bast_nand_select,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* DM9000 */
> diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
> index 27ae6877550f..b0ed401da3a3 100644
> --- a/arch/arm/mach-s3c24xx/mach-gta02.c
> +++ b/arch/arm/mach-s3c24xx/mach-gta02.c
> @@ -443,6 +443,7 @@ static void gta02_udc_vbus_draw(unsigned int ma)
>  	.twrph1		= 15,
>  	.nr_sets	= ARRAY_SIZE(gta02_nand_sets),
>  	.sets		= gta02_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  
> diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
> index 7d99fe8f6157..895aca225952 100644
> --- a/arch/arm/mach-s3c24xx/mach-jive.c
> +++ b/arch/arm/mach-s3c24xx/mach-jive.c
> @@ -232,6 +232,7 @@
>  	.twrph1		= 40,
>  	.sets		= jive_nand_sets,
>  	.nr_sets	= ARRAY_SIZE(jive_nand_sets),
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static int __init jive_mtdset(char *options)
> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
> index ec60bd4a1646..71af8d2fd320 100644
> --- a/arch/arm/mach-s3c24xx/mach-mini2440.c
> +++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
> @@ -287,6 +287,7 @@
>  	.nr_sets	= ARRAY_SIZE(mini2440_nand_sets),
>  	.sets		= mini2440_nand_sets,
>  	.ignore_unset_ecc = 1,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* DM9000AEP 10/100 ethernet controller */
> diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
> index 2f6fdc326835..70b0eb7d3134 100644
> --- a/arch/arm/mach-s3c24xx/mach-osiris.c
> +++ b/arch/arm/mach-s3c24xx/mach-osiris.c
> @@ -238,6 +238,7 @@ static void osiris_nand_select(struct s3c2410_nand_set *set, int slot)
>  	.nr_sets	= ARRAY_SIZE(osiris_nand_sets),
>  	.sets		= osiris_nand_sets,
>  	.select_chip	= osiris_nand_select,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* PCMCIA control and configuration */
> diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
> index 984516e8307a..868c82087403 100644
> --- a/arch/arm/mach-s3c24xx/mach-qt2410.c
> +++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
> @@ -284,6 +284,7 @@
>  	.twrph1		= 20,
>  	.nr_sets	= ARRAY_SIZE(qt2410_nand_sets),
>  	.sets		= qt2410_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  /* UDC */
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
> index 25a139bb9826..e86ad6a68a0b 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -611,6 +611,7 @@ static void rx1950_set_mmc_power(unsigned char power_mode, unsigned short vdd)
>  	.twrph1 = 15,
>  	.nr_sets = ARRAY_SIZE(rx1950_nand_sets),
>  	.sets = rx1950_nand_sets,
> +	.ecc_mode = NAND_ECC_SOFT,
>  };
>  
>  static struct s3c2410_udc_mach_info rx1950_udc_cfg __initdata = {
> diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
> index cf55196f89ca..a39fb9780dd3 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx3715.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
> @@ -164,6 +164,7 @@
>  	.twrph1		= 15,
>  	.nr_sets	= ARRAY_SIZE(rx3715_nand_sets),
>  	.sets		= rx3715_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static struct platform_device *rx3715_devices[] __initdata = {
> diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
> index b4460d5f7011..f5e6322145fa 100644
> --- a/arch/arm/mach-s3c24xx/mach-vstms.c
> +++ b/arch/arm/mach-s3c24xx/mach-vstms.c
> @@ -117,6 +117,7 @@
>  	.twrph1		= 20,
>  	.nr_sets	= ARRAY_SIZE(vstms_nand_sets),
>  	.sets		= vstms_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static struct platform_device *vstms_devices[] __initdata = {
> diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
> index bc7dc1fcbf7d..59b5531f1987 100644
> --- a/arch/arm/mach-s3c64xx/mach-hmt.c
> +++ b/arch/arm/mach-s3c64xx/mach-hmt.c
> @@ -204,6 +204,7 @@ static void hmt_bl_exit(struct device *dev)
>  	.twrph1		= 40,
>  	.nr_sets	= ARRAY_SIZE(hmt_nand_sets),
>  	.sets		= hmt_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static struct gpio_led hmt_leds[] = {
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> index ae999fb3fe6d..a3e3e25728b4 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -142,6 +142,7 @@
>  	.twrph1		= 40,
>  	.nr_sets	= ARRAY_SIZE(mini6410_nand_sets),
>  	.sets		= mini6410_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static struct s3c_fb_pd_win mini6410_lcd_type0_fb_win = {
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index 4e240ffa7ac7..d6b3ffd7704b 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -194,6 +194,7 @@
>  	.twrph1		= 40,
>  	.nr_sets	= ARRAY_SIZE(real6410_nand_sets),
>  	.sets		= real6410_nand_sets,
> +	.ecc_mode       = NAND_ECC_SOFT,
>  };
>  
>  static struct platform_device *real6410_devices[] __initdata = {
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 7b7a887b4709..9748f3580d4b 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -179,15 +179,6 @@ config MTD_NAND_S3C2410_DEBUG
>  	help
>  	  Enable debugging of the S3C NAND driver
>  
> -config MTD_NAND_S3C2410_HWECC
> -	bool "Samsung S3C NAND Hardware ECC"
> -	depends on MTD_NAND_S3C2410
> -	help
> -	  Enable the use of the controller's internal ECC generator when
> -	  using NAND. Early versions of the chips have had problems with
> -	  incorrect ECC generation, and if using these, the default of
> -	  software ECC is preferable.
> -
>  config MTD_NAND_NDFC
>  	tristate "NDFC NanD Flash Controller"
>  	depends on 4xx
> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index d459c19d78de..371db0d48135 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -497,7 +497,6 @@ static int s3c2412_nand_devready(struct mtd_info *mtd)
>  
>  /* ECC handling functions */
>  
> -#ifdef CONFIG_MTD_NAND_S3C2410_HWECC
>  static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
>  				     u_char *read_ecc, u_char *calc_ecc)
>  {
> @@ -649,7 +648,6 @@ static int s3c2440_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
>  
>  	return 0;
>  }
> -#endif
>  
>  /* over-ride the standard functions for a little more speed. We can
>   * use read/write block to move the data buffers to/from the controller
> @@ -858,50 +856,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>  	nmtd->info	   = info;
>  	nmtd->set	   = set;
>  
> -#ifdef CONFIG_MTD_NAND_S3C2410_HWECC
> -	chip->ecc.calculate = s3c2410_nand_calculate_ecc;
> -	chip->ecc.correct   = s3c2410_nand_correct_data;
> -	chip->ecc.mode	    = NAND_ECC_HW;
> -	chip->ecc.strength  = 1;
> -
> -	switch (info->cpu_type) {
> -	case TYPE_S3C2410:
> -		chip->ecc.hwctl	    = s3c2410_nand_enable_hwecc;
> -		chip->ecc.calculate = s3c2410_nand_calculate_ecc;
> -		break;
> -
> -	case TYPE_S3C2412:
> -		chip->ecc.hwctl     = s3c2412_nand_enable_hwecc;
> -		chip->ecc.calculate = s3c2412_nand_calculate_ecc;
> -		break;
> -
> -	case TYPE_S3C2440:
> -		chip->ecc.hwctl     = s3c2440_nand_enable_hwecc;
> -		chip->ecc.calculate = s3c2440_nand_calculate_ecc;
> -		break;
> -	}
> -#else
> -	chip->ecc.mode	    = NAND_ECC_SOFT;
> -	chip->ecc.algo	= NAND_ECC_HAMMING;
> -#endif
> -
> -	if (set->disable_ecc)
> -		chip->ecc.mode	= NAND_ECC_NONE;
> -
> -	switch (chip->ecc.mode) {
> -	case NAND_ECC_NONE:
> -		dev_info(info->device, "NAND ECC disabled\n");
> -		break;
> -	case NAND_ECC_SOFT:
> -		dev_info(info->device, "NAND soft ECC\n");
> -		break;
> -	case NAND_ECC_HW:
> -		dev_info(info->device, "NAND hardware ECC\n");
> -		break;
> -	default:
> -		dev_info(info->device, "NAND ECC UNKNOWN\n");
> -		break;
> -	}
> +	chip->ecc.mode = info->platform->ecc_mode;
>  
>  	/* If you use u-boot BBT creation code, specifying this flag will
>  	 * let the kernel fish out the BBT from the NAND, and also skip the
> @@ -923,28 +878,72 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>   *
>   * The internal state is currently limited to the ECC state information.
>  */
> -static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
> +static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
>  				     struct s3c2410_nand_mtd *nmtd)
>  {
>  	struct nand_chip *chip = &nmtd->chip;
>  
> -	dev_dbg(info->device, "chip %p => page shift %d\n",
> -		chip, chip->page_shift);
> +	switch (chip->ecc.mode) {
>  
> -	if (chip->ecc.mode != NAND_ECC_HW)
> -		return;
> +	case NAND_ECC_NONE:
> +		dev_info(info->device, "ECC disabled\n");
> +		break;
> +
> +	case NAND_ECC_SOFT:
> +		/*
> +		 * This driver expects Hamming based ECC when ecc_mode is set
> +		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
> +		 * avoid adding an extra ecc_algo field to s3c2410_platform_nand.
> +		 */
> +		chip->ecc.algo = NAND_ECC_HAMMING;
> +		dev_info(info->device, "soft ECC\n");
> +		break;
> +
> +	case NAND_ECC_HW:
> +		chip->ecc.calculate = s3c2410_nand_calculate_ecc;
> +		chip->ecc.correct   = s3c2410_nand_correct_data;
> +		chip->ecc.strength  = 1;
> +
> +		switch (info->cpu_type) {
> +		case TYPE_S3C2410:
> +			chip->ecc.hwctl	    = s3c2410_nand_enable_hwecc;
> +			chip->ecc.calculate = s3c2410_nand_calculate_ecc;
> +			break;
> +
> +		case TYPE_S3C2412:
> +			chip->ecc.hwctl     = s3c2412_nand_enable_hwecc;
> +			chip->ecc.calculate = s3c2412_nand_calculate_ecc;
> +			break;
> +
> +		case TYPE_S3C2440:
> +			chip->ecc.hwctl     = s3c2440_nand_enable_hwecc;
> +			chip->ecc.calculate = s3c2440_nand_calculate_ecc;
> +			break;
> +		}
> +
> +		dev_dbg(info->device, "chip %p => page shift %d\n",
> +			chip, chip->page_shift);
>  
>  		/* change the behaviour depending on whether we are using
>  		 * the large or small page nand device */
> +		if (chip->page_shift > 10) {
> +			chip->ecc.size	    = 256;
> +			chip->ecc.bytes	    = 3;
> +		} else {
> +			chip->ecc.size	    = 512;
> +			chip->ecc.bytes	    = 3;
> +			mtd_set_ooblayout(nand_to_mtd(chip), &s3c2410_ooblayout_ops);
> +		}
>  
> -	if (chip->page_shift > 10) {
> -		chip->ecc.size	    = 256;
> -		chip->ecc.bytes	    = 3;
> -	} else {
> -		chip->ecc.size	    = 512;
> -		chip->ecc.bytes	    = 3;
> -		mtd_set_ooblayout(nand_to_mtd(chip), &s3c2410_ooblayout_ops);
> +		dev_info(info->device, "hardware ECC\n");
> +		break;
> +
> +	default:
> +		dev_err(info->device, "invalid ECC mode!\n");
> +		return -EINVAL;
>  	}
> +
> +	return 0;
>  }
>  
>  /* s3c24xx_nand_probe
> @@ -1046,7 +1045,9 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
>  						 NULL);
>  
>  		if (nmtd->scan_res == 0) {
> -			s3c2410_nand_update_chip(info, nmtd);
> +			err = s3c2410_nand_update_chip(info, nmtd);
> +			if (err < 0)
> +				goto exit_error;
>  			nand_scan_tail(mtd);
>  			s3c2410_nand_add_partition(info, nmtd, sets);
>  		}
> diff --git a/include/linux/platform_data/mtd-nand-s3c2410.h b/include/linux/platform_data/mtd-nand-s3c2410.h
> index c55e42ee57fa..729af13d1773 100644
> --- a/include/linux/platform_data/mtd-nand-s3c2410.h
> +++ b/include/linux/platform_data/mtd-nand-s3c2410.h
> @@ -12,9 +12,10 @@
>  #ifndef __MTD_NAND_S3C2410_H
>  #define __MTD_NAND_S3C2410_H
>  
> +#include <linux/mtd/nand.h>
> +
>  /**
>   * struct s3c2410_nand_set - define a set of one or more nand chips
> - * @disable_ecc:	Entirely disable ECC - Dangerous
>   * @flash_bbt: 		Openmoko u-boot can create a Bad Block Table
>   *			Setting this flag will allow the kernel to
>   *			look for it at boot time and also skip the NAND
> @@ -31,7 +32,6 @@
>   * a warning at boot time.
>   */
>  struct s3c2410_nand_set {
> -	unsigned int		disable_ecc:1;
>  	unsigned int		flash_bbt:1;
>  
>  	unsigned int		options;
> @@ -51,6 +51,8 @@ struct s3c2410_platform_nand {
>  
>  	unsigned int	ignore_unset_ecc:1;
>  
> +	nand_ecc_modes_t	ecc_mode;
> +
>  	int			nr_sets;
>  	struct s3c2410_nand_set *sets;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
