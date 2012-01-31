From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 20:20:44 +0900
Subject: [PATCH v2 2/2] S3C24XX: move spi-s3c24xx platdata out of mach
In-Reply-To: <201201271040.08945.heiko@sntech.de>
References: <201201082222.11305.heiko@sntech.de>
 <01b201ccdccb$d6923680$83b6a380$%kim@samsung.com>
 <201201271040.08945.heiko@sntech.de>
Message-ID: <04a101cce00a$5fcee0b0$1f6ca210$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> spi.h now only contains the definition of the platform data structure
> for the driver in spi-s3c24xx.c . Therefore it does not need to stay
> in include/mach but can instead live in linux/spi/s3c24xx.h .
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Sorry for messing up, but it seems I forgot to readd the moved spi header
> in the original submission of the second patch, which I noticed just now.
> As your cleanup-s3c24xx branch is not pushed out yet, could you please
> replace it with this one, which adds the forgotten file.
> 
OK, I replaced with this. And I'm not sure Grant is ok on this.

Grant, this looks ok to me and I'd like to apply this in samsung tree.
So if any problem to send this via samsung tree, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>  arch/arm/mach-s3c2410/include/mach/spi.h |   27
--------------------------
> -
>  arch/arm/mach-s3c2440/mach-gta02.c       |    2 +-
>  drivers/spi/spi-s3c24xx.c                |    2 +-
>  include/linux/spi/s3c24xx.h              |   26
++++++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 29 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c2410/include/mach/spi.h
>  create mode 100644 include/linux/spi/s3c24xx.h
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/spi.h b/arch/arm/mach-
> s3c2410/include/mach/spi.h
> deleted file mode 100644
> index 2a686c0..0000000
> --- a/arch/arm/mach-s3c2410/include/mach/spi.h
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/* arch/arm/mach-s3c2410/include/mach/spi.h
> - *
> - * Copyright (c) 2006 Simtec Electronics
> - *	Ben Dooks <ben@simtec.co.uk>
> - *
> - * S3C2410 - SPI Controller platform_device info
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __ASM_ARCH_SPI_H
> -#define __ASM_ARCH_SPI_H __FILE__
> -
> -struct s3c2410_spi_info {
> -	int			 pin_cs;	/* simple gpio cs */
> -	unsigned int		 num_cs;	/* total chipselects */
> -	int			 bus_num;       /* bus number to use. */
> -
> -	unsigned int		 use_fiq:1;	/* use fiq */
> -
> -	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
> -	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
> -};
> -
> -#endif /* __ASM_ARCH_SPI_H */
> diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-
> s3c2440/mach-gta02.c
> index 5859e60..cf270f5 100644
> --- a/arch/arm/mach-s3c2440/mach-gta02.c
> +++ b/arch/arm/mach-s3c2440/mach-gta02.c
> @@ -38,6 +38,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/s3c24xx.h>
> 
>  #include <linux/mmc/host.h>
> 
> @@ -73,7 +74,6 @@
>  #include <mach/regs-gpioj.h>
>  #include <mach/fb.h>
> 
> -#include <mach/spi.h>
>  #include <plat/usb-control.h>
>  #include <mach/regs-mem.h>
>  #include <mach/hardware.h>
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index fc06453..8ee7d79 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -24,10 +24,10 @@
> 
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_bitbang.h>
> +#include <linux/spi/s3c24xx.h>
>  #include <linux/module.h>
> 
>  #include <plat/regs-spi.h>
> -#include <mach/spi.h>
> 
>  #include <plat/fiq.h>
>  #include <asm/fiq.h>
> diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
> new file mode 100644
> index 0000000..c23b923
> --- /dev/null
> +++ b/include/linux/spi/s3c24xx.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2006 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *
> + * S3C2410 - SPI Controller platform_device info
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __LINUX_SPI_S3C24XX_H
> +#define __LINUX_SPI_S3C24XX_H __FILE__
> +
> +struct s3c2410_spi_info {
> +	int			 pin_cs;	/* simple gpio cs */
> +	unsigned int		 num_cs;	/* total chipselects */
> +	int			 bus_num;       /* bus number to use. */
> +
> +	unsigned int		 use_fiq:1;	/* use fiq */
> +
> +	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
> +	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
> +};
> +
> +#endif /* __LINUX_SPI_S3C24XX_H */
> --
> 1.7.5.4
