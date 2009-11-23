From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 23 Nov 2009 00:07:02 +0000
Subject: [PATCH 4/8] S3C64xx: add HSMMC2 support
In-Reply-To: <b2e8f9f70911200404s7f6e38ebt4798075683208071@mail.gmail.com>
References: <b2e8f9f70911200404s7f6e38ebt4798075683208071@mail.gmail.com>
Message-ID: <20091123000701.GF4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 01:04:04PM +0100, Maurus Cuelenaere wrote:
> This adds support for the third SDHCI controller.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c6400/s3c6400.c          |    1 +
>  arch/arm/mach-s3c6410/cpu.c              |    1 +
>  arch/arm/plat-s3c/Kconfig                |    5 ++
>  arch/arm/plat-s3c/Makefile               |    1 +
>  arch/arm/plat-s3c/dev-hsmmc2.c           |   68 ++++++++++++++++++++++++++++++
>  arch/arm/plat-s3c/include/plat/sdhci.h   |   25 +++++++++++
>  arch/arm/plat-s3c64xx/setup-sdhci-gpio.c |   20 +++++++++
>  7 files changed, 121 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c/dev-hsmmc2.c
> 
> diff --git a/arch/arm/mach-s3c6400/s3c6400.c b/arch/arm/mach-s3c6400/s3c6400.c
> index b42bdd0..d876ee5 100644
> --- a/arch/arm/mach-s3c6400/s3c6400.c
> +++ b/arch/arm/mach-s3c6400/s3c6400.c
> @@ -45,6 +45,7 @@ void __init s3c6400_map_io(void)
> 
>  	s3c6400_default_sdhci0();
>  	s3c6400_default_sdhci1();
> +	s3c6400_default_sdhci2();
> 
>  	/* the i2c devices are directly compatible with s3c2440 */
>  	s3c_i2c0_setname("s3c2440-i2c");
> diff --git a/arch/arm/mach-s3c6410/cpu.c b/arch/arm/mach-s3c6410/cpu.c
> index 9b67c66..522c086 100644
> --- a/arch/arm/mach-s3c6410/cpu.c
> +++ b/arch/arm/mach-s3c6410/cpu.c
> @@ -58,6 +58,7 @@ void __init s3c6410_map_io(void)
>  	/* initialise device information early */
>  	s3c6410_default_sdhci0();
>  	s3c6410_default_sdhci1();
> +	s3c6410_default_sdhci2();
> 
>  	/* the i2c devices are directly compatible with s3c2440 */
>  	s3c_i2c0_setname("s3c2440-i2c");
> diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
> index 8931c5f..57e685b 100644
> --- a/arch/arm/plat-s3c/Kconfig
> +++ b/arch/arm/plat-s3c/Kconfig
> @@ -178,6 +178,11 @@ config S3C_DEV_HSMMC1
>  	help
>  	  Compile in platform device definitions for HSMMC channel 1
> 
> +config S3C_DEV_HSMMC2
> +	bool
> +	help
> +	  Compile in platform device definitions for HSMMC channel 2
> +
>  config S3C_DEV_I2C1
>  	bool
>  	help
> diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
> index 3c09109..50444da 100644
> --- a/arch/arm/plat-s3c/Makefile
> +++ b/arch/arm/plat-s3c/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_HAVE_PWM)		+= pwm.o
> 
>  obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
>  obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
> +obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
>  obj-y				+= dev-i2c0.o
>  obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
>  obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
> diff --git a/arch/arm/plat-s3c/dev-hsmmc2.c b/arch/arm/plat-s3c/dev-hsmmc2.c
> new file mode 100644
> index 0000000..49b6b68
> --- /dev/null
> +++ b/arch/arm/plat-s3c/dev-hsmmc2.c
> @@ -0,0 +1,68 @@
> +/* linux/arch/arm/plat-s3c/dev-hsmmc2.c
> + *
> + * Copyright (c) 2008 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *	http://armlinux.simtec.co.uk/

flattering as it is to see my copyright on other people's code, this
isn't right.

Either:

> + * Based on arch/arm/plat-s3c/dev-hsmmc1.c

or better

> + * Based on arch/arm/plat-s3c/dev-hsmmc1.c
> + * original file Copyright (c) 2008 Simtec Electronics

and add your own copyright.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
