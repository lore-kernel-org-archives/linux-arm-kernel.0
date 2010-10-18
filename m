From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 22:23:54 +0900
Subject: [PATCH 2/9 v2] ARM: S3C64XX: add nand support for mach-real6410
In-Reply-To: <20100929193134.25307.65614.stgit@darius-desktop>
References: <20100929192354.25307.40197.stgit@darius-desktop>
	<20100929193134.25307.65614.stgit@darius-desktop>
Message-ID: <04a401cb6ec7$b8291b00$287b5100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> Add nand device support and mtd partition table
> for mach-real6410
> 
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> ---
> 
> Changelog since v1:
>  - Changed dependency on other patches
> 
>  arch/arm/mach-s3c64xx/Kconfig         |    1 +
>  arch/arm/mach-s3c64xx/mach-real6410.c |   40
> +++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 3bbd418..e4aede1 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -106,6 +106,7 @@ config MACH_REAL6410
>  	select S3C64XX_SETUP_SDHCI
>  	select S3C_DEV_FB
>  	select S3C64XX_SETUP_FB_24BPP
> +	select S3C_DEV_NAND
>  	help
>  	  Machine support for the CoreWind REAL6410
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
> s3c64xx/mach-real6410.c
> index bed75d2..9fd943d 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -19,6 +19,8 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/dm9000.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
>  #include <linux/types.h>
> @@ -37,6 +39,7 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/fb.h>
> +#include <plat/nand.h>
>  #include <plat/regs-serial.h>
> 
>  #include <video/platform_lcd.h>
> @@ -147,11 +150,47 @@ static struct s3c_fb_platdata real6410_lcd_pdata
> __initdata = {
>  	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>  };
> 
> +static struct mtd_partition real6410_nand_part[] = {
> +	[0] = {
> +		.name	= "uboot",
> +		.size	= SZ_1M,
> +		.offset	= 0,
> +	},
> +	[1] = {
> +		.name	= "kernel",
> +		.size	= SZ_2M,
> +		.offset	= SZ_1M,
> +	},
> +	[2] = {
> +		.name	= "rootfs",
> +		.size	= MTDPART_SIZ_FULL,
> +		.offset	= SZ_1M + SZ_2M,
> +	},
> +};
> +
> +static struct s3c2410_nand_set real6410_nand_sets[] = {
> +	[0] = {
> +		.name		= "nand",
> +		.nr_chips	= 1,
> +		.nr_partitions	= ARRAY_SIZE(real6410_nand_part),
> +		.partitions	= real6410_nand_part,
> +	},
> +};
> +
> +static struct s3c2410_platform_nand real6410_nand_info = {
> +	.tacls		= 25,
> +	.twrph0		= 55,
> +	.twrph1		= 40,
> +	.nr_sets	= ARRAY_SIZE(real6410_nand_sets),
> +	.sets		= real6410_nand_sets,
> +};
> +
>  static struct platform_device *real6410_devices[] __initdata = {
>  	&real6410_device_eth,
>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc1,
>  	&s3c_device_fb,
> +	&s3c_device_nand,
>  };
> 
>  static void __init real6410_map_io(void)
> @@ -249,6 +288,7 @@ static void __init real6410_machine_init(void)
>  		real6410_lcd_pdata.win[0]->win_mode.yres);
> 
>  	s3c_fb_set_platdata(&real6410_lcd_pdata);
> +	s3c_nand_set_platdata(&real6410_nand_info);
> 
>  	/* configure nCS1 width to 16 bits */
> 
Where is 'END' of patch mark?
maybe broken your patch file...?

Others, looks ok to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
