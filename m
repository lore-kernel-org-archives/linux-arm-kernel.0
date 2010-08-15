From: augulis.darius@gmail.com (Darius Augulis)
Date: Sun, 15 Aug 2010 13:04:18 +0300
Subject: [PATCH v2 4/4] s3c: mach-real6410: add nand support
In-Reply-To: <20100806172259.7695.94667.stgit@darius-desktop>
References: <20100806172033.7695.62041.stgit@darius-desktop>
	<20100806172259.7695.94667.stgit@darius-desktop>
Message-ID: <4C67BBA2.3090204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2010 08:23 PM, Darius Augulis wrote:
> Add nand device support and mtd partition table
> for mach-real6410

Ben, I see other three patches are merged, how about this one?
There where no comments in mailing list, is it ready or not?

>
> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
> ---
>
> Changelog since v1:
>   - Fixed errors reported by checkpatch.pl
>   - Spaces in indentation replaced by TABs
>
>   arch/arm/mach-s3c64xx/Kconfig         |    1 +
>   arch/arm/mach-s3c64xx/mach-real6410.c |   41 +++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index f5c77e5..7ac93ce 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -93,6 +93,7 @@ config MACH_REAL6410
>   	select CPU_S3C6410
>   	select S3C_DEV_HSMMC
>   	select S3C_DEV_HSMMC1
> +	select S3C_DEV_NAND
>   	select S3C64XX_SETUP_SDHCI
>   	help
>   	  Machine support for the CoreWind REAL6410
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index bd52605..7eafb23 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -18,6 +18,8 @@
>   #include<linux/list.h>
>   #include<linux/init.h>
>   #include<linux/dm9000.h>
> +#include<linux/mtd/mtd.h>
> +#include<linux/mtd/partitions.h>
>   #include<linux/serial_core.h>
>   #include<linux/platform_device.h>
>   #include<asm/mach-types.h>
> @@ -28,6 +30,7 @@
>   #include<mach/regs-srom.h>
>   #include<plat/cpu.h>
>   #include<plat/devs.h>
> +#include<plat/nand.h>
>   #include<plat/regs-serial.h>
>
>   #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
> @@ -99,10 +102,46 @@ static struct platform_device real6410_device_eth = {
>   	},
>   };
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
>   static struct platform_device *real6410_devices[] __initdata = {
>   	&real6410_device_eth,
>   	&s3c_device_hsmmc0,
>   	&s3c_device_hsmmc1,
> +	&s3c_device_nand,
>   };
>
>   static void __init real6410_map_io(void)
> @@ -116,6 +155,8 @@ static void __init real6410_machine_init(void)
>   {
>   	u32 cs1;
>
> +	s3c_nand_set_platdata(&real6410_nand_info);
> +
>   	/* configure nCS1 width to 16 bits */
>
>   	cs1 = __raw_readl(S3C64XX_SROM_BW)&
