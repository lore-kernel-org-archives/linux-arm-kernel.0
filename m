From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 08 Aug 2011 12:21:45 +0200
Subject: RFC[PATCH 6/6] ARM: S5P64X0: Add clkdev bus lookup support
In-Reply-To: <1312793277-18689-7-git-send-email-rajeshwari.s@samsung.com>
References: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
	<1312793277-18689-7-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <4E3FB8B9.7050803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 08/08/2011 10:47 AM, Rajeshwari Shinde wrote:
> Bus clock alias names created and added to clkdev which will be used
> by HSMMC driver.
> 
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> ---
>  .../include/mach/s5p64x0-common-sdhci.h            |    2 +
>  arch/arm/mach-s5p64x0/mach-smdk6440.c              |    5 ++
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |    5 ++
>  arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c       |    7 +++
>  arch/arm/plat-samsung/Makefile                     |    1 +
>  arch/arm/plat-samsung/clkdev-busalias.c            |   44 ++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/sdhci.h         |    8 ++++
>  7 files changed, 72 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/clkdev-busalias.c
> 
> diff --git a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
> index a3381f0..b81e6dd 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
> @@ -10,6 +10,8 @@
>  
>  #include <plat/sdhci.h>
>  
> +extern char *hsmmc_busclksrcs[4];
> +
>  extern struct s3c_sdhci_platdata smdk64x0_hsmmc0_pdata;
>  extern struct s3c_sdhci_platdata smdk64x0_hsmmc1_pdata;
>  extern struct s3c_sdhci_platdata smdk64x0_hsmmc2_pdata;
> diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
> index 065977f..ad1b49d 100644
> --- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
> +++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
> @@ -177,6 +177,11 @@ static void __init smdk6440_machine_init(void)
>  	s3c_sdhci2_set_platdata(&smdk64x0_hsmmc2_pdata);
>  
>  	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
> +
> +	/* create alias for clocks required by SDHCI */
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc0, hsmmc_busclksrcs);
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc1, hsmmc_busclksrcs);
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc2, hsmmc_busclksrcs);
>  }
>  
>  MACHINE_START(SMDK6440, "SMDK6440")
> diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
> index 9e6fcef..f3f656e 100644
> --- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
> +++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
> @@ -196,6 +196,11 @@ static void __init smdk6450_machine_init(void)
>  	s3c_sdhci2_set_platdata(&smdk64x0_hsmmc2_pdata);
>  
>  	platform_add_devices(smdk6450_devices, ARRAY_SIZE(smdk6450_devices));
> +
> +	/* create alias for clocks required by SDHCI */
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc0, hsmmc_busclksrcs);
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc1, hsmmc_busclksrcs);
> +	s3c_sdhci_add_busclk_alias(&s3c_device_hsmmc2, hsmmc_busclksrcs);
>  }
>  
>  MACHINE_START(SMDK6450, "SMDK6450")
> diff --git a/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c b/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
> index 03d89f6..9721b2d 100644
> --- a/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
> +++ b/arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
> @@ -14,6 +14,13 @@
>  
>  #include <mach/s5p64x0-common-sdhci.h>
>  
> +char *hsmmc_busclksrcs[4] = {
> +	[0] = NULL,
> +	[1] = NULL,
> +	[2] = "sclk_mmc", /* mmc bus clock */
> +	[3] = NULL,
> +};
> +
>  struct s3c_sdhci_platdata smdk64x0_hsmmc0_pdata __initdata = {
>  	.cd_type        = S3C_SDHCI_CD_NONE,
>  	.clk_type       = S3C_SDHCI_CLK_DIV_EXTERNAL,
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 853764b..0aae4fa 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
>  # devices
>  
>  obj-y				+= platformdata.o
> +obj-y				+= clkdev-busalias.o
>  
>  obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
>  obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
> diff --git a/arch/arm/plat-samsung/clkdev-busalias.c b/arch/arm/plat-samsung/clkdev-busalias.c
> new file mode 100644
> index 0000000..3e085a2
> --- /dev/null
> +++ b/arch/arm/plat-samsung/clkdev-busalias.c
> @@ -0,0 +1,44 @@
> +/* linux/arch/arm/plat-samsung/clkdev_busalias.c
> + *
> + * Copyright (c) 2011 Simtec Electronics
> + *	http://www.samsung.com

Is this a correct copyright notice?

> + *
> + * Helper function to add clkdev bus clocks alias names.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +
> +#include <plat/sdhci.h>
> +
> +#define MAX_BUS_CLK (4)
> +
> +void s3c_sdhci_add_busclk_alias(struct platform_device *pdev,
> +				char **mmc_busclks)
> +{
> +	int clk_cnt = 0, ptr;
> +	char devname[14];
> +
> +	sprintf(devname, "s3c-sdhci.%d", pdev->id);
> +
> +	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
> +		char *bus_name = mmc_busclks[ptr];
> +
> +		if (bus_name != NULL) {
> +			char name[14];
> +			sprintf(name, "mmc_busclk.%d", ptr);
> +			clk_add_alias(name, devname, bus_name,
> +					&pdev->dev);
> +			clk_cnt++;
> +		}
> +	}
> +
> +	if (clk_cnt == 0)
> +		dev_err(&pdev->dev, "No MMC bus clocks!");
> +}


Can you explain why these aliases are needed ?
That seems redundant to me, as the clock 'con_id's could be properly created
right away when registering the clock with clkdev.


> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
> index dde13aa..4933b6a 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -131,6 +131,14 @@ extern void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
>  extern void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
>  extern void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
>  
> +/*
> + * s3c_sdhci_set_busclk - Add alias to bus clocks supported, for clkdev support.
> + * @pdev: platform device to which the busclks are to be initialised.
> + * @mmc_busclks: Bus clocks suppored by SDHCI
> +*/
> +extern void s3c_sdhci_add_busclk_alias(struct platform_device *pdev,
> +					char **mmc_busclks);
> +
>  /* S3C2416 SDHCI setup */
>  
>  #ifdef CONFIG_S3C2416_SETUP_SDHCI

-- 
Sylwester Nawrocki
Samsung Poland R&D Center
