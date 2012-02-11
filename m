From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sat, 11 Feb 2012 20:52:06 +0100
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F36C6E6.8020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 02/11/2012 06:34 PM, Kukjin Kim wrote:
> This patch adds clock-exynos5.c for EXYNOS5250 now
> and that can be used for other EXYNOS5 SoCs later.
>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   arch/arm/mach-exynos/clock-exynos5.c           | 1252 ++++++++++++++++++++++++
>   arch/arm/mach-exynos/include/mach/regs-clock.h |   62 ++
>   arch/arm/plat-s5p/clock.c                      |   36 +
>   arch/arm/plat-samsung/include/plat/s5p-clock.h |    6 +
>   4 files changed, 1356 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-exynos/clock-exynos5.c
>
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> new file mode 100644
> index 0000000..9d2e7f0
> --- /dev/null
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -0,0 +1,1252 @@
> +/*
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Clock support for EXYNOS5 SoCs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
...
> +static struct clk exynos5_init_clocks_off[] = {
> +	{
> +		.name		= "timers",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  24),
> +	}, {
> +		.name		= "rtc",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peris_ctrl,
> +		.ctrlbit	= (1<<  20),
> +	}, {
> +		.name		= "hsmmc",
> +		.devname	= "s3c-sdhci.0",
> +		.parent		=&exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  12),
> +	}, {
> +		.name		= "hsmmc",
> +		.devname	= "s3c-sdhci.1",
> +		.parent		=&exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  13),
> +	}, {
> +		.name		= "hsmmc",
> +		.devname	= "s3c-sdhci.2",
> +		.parent		=&exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  14),
> +	}, {
> +		.name		= "hsmmc",
> +		.devname	= "s3c-sdhci.3",
> +		.parent		=&exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  15),
> +	}, {
> +		.name		= "dwmci",
> +		.parent		=&exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  16),
> +	}, {
> +		.name		= "sata",
> +		.devname	= "ahci",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  6),
> +	}, {
> +		.name		= "sata_phy",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  24),
> +	}, {
> +		.name		= "sata_phy_i2c",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  25),
> +	}, {
> +		.name		= "mfc",
> +		.devname	= "s5p-mfc",
> +		.enable		= exynos5_clk_ip_mfc_ctrl,
> +		.ctrlbit	= (1<<  0),
> +	}, {
> +		.name		= "hdmi",
> +		.devname	= "exynos4-hdmi",
> +		.enable		= exynos5_clk_ip_disp1_ctrl,
> +		.ctrlbit	= (1<<  6),
> +	}, {
> +		.name		= "mixer",
> +		.devname	= "s5p-mixer",
> +		.enable		= exynos5_clk_ip_disp1_ctrl,
> +		.ctrlbit	= (1<<  5),
> +	}, {
> +		.name		= "jpeg",
> +		.enable		= exynos5_clk_ip_gen_ctrl,
> +		.ctrlbit	= (1<<  2),
> +	}, {
> +		.name		= "dsim0",
> +		.enable		= exynos5_clk_ip_disp1_ctrl,
> +		.ctrlbit	= (1<<  3),
> +	}, {
> +		.name		= "iis",
> +		.devname	= "samsung-i2s.1",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  20),
> +	}, {
> +		.name		= "iis",
> +		.devname	= "samsung-i2s.2",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  21),
> +	}, {
> +		.name		= "pcm",
> +		.devname	= "samsung-pcm.1",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  22),
> +	}, {
> +		.name		= "pcm",
> +		.devname	= "samsung-pcm.2",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  23),
> +	}, {
> +		.name		= "spdif",
> +		.devname	= "samsung-spdif",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  26),
> +	}, {
> +		.name		= "ac97",
> +		.devname	= "samsung-ac97",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  27),
> +	}, {
> +		.name		= "usbhost",
> +		.enable		= exynos5_clk_ip_fsys_ctrl ,
> +		.ctrlbit	= (1<<  18),
> +	}, {
> +		.name		= "usbotg",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  7),
> +	}, {
> +		.name		= "gps",
> +		.enable		= exynos5_clk_ip_gps_ctrl,
> +		.ctrlbit	= ((1<<  3) | (1<<  2) | (1<<  0)),
> +	}, {
> +		.name		= "nfcon",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  22),
> +	}, {
> +		.name		= "iop",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= ((1<<  30) | (1<<  26) | (1<<  23)),
> +	}, {
> +		.name		= "core_iop",
> +		.enable		= exynos5_clk_ip_core_ctrl,
> +		.ctrlbit	= ((1<<  21) | (1<<  3)),
> +	}, {
> +		.name		= "mcu_iop",
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1<<  0),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.0",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  6),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.1",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  7),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.2",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  8),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.3",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  9),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.4",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  10),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.5",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  11),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.6",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  12),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-i2c.7",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  13),
> +	}, {
> +		.name		= "i2c",
> +		.devname	= "s3c2440-hdmiphy-i2c",
> +		.parent		=&exynos5_clk_aclk_66.clk,
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  14),
> +	}
> +};
> +
> +static struct clk exynos5_init_clocks_on[] = {
> +	{
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.0",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  0),
> +	}, {
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.1",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  1),
> +	}, {
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.2",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  2),
> +	}, {
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.3",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  3),
> +	}, {
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.4",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  4),
> +	}, {
> +		.name		= "uart",
> +		.devname	= "s5pv210-uart.5",
> +		.enable		= exynos5_clk_ip_peric_ctrl,
> +		.ctrlbit	= (1<<  5),
> +	}
> +};
> +
> +static struct clk exynos5_clk_pdma0 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.0",
> +	.enable		= exynos5_clk_ip_gen_ctrl,
> +	.ctrlbit	= (1<<  4),
> +};
> +
> +static struct clk exynos5_clk_pdma1 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.1",
> +	.enable		= exynos5_clk_ip_fsys_ctrl,
> +	.ctrlbit	= (1<<  1),
> +};
> +
> +static struct clk exynos5_clk_pdma2 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.2",
> +	.enable		= exynos5_clk_ip_fsys_ctrl,
> +	.ctrlbit	= (1<<  1),
> +};
> +
> +struct clk *exynos5_clkset_group_list[] = {
> +	[0] =&clk_ext_xtal_mux,
> +	[1] = NULL,
> +	[2] =&exynos5_clk_sclk_hdmi24m,
> +	[3] =&exynos5_clk_sclk_dptxphy,
> +	[4] =&exynos5_clk_sclk_usbphy,
> +	[5] =&exynos5_clk_sclk_hdmiphy,
> +	[6] =&exynos5_clk_mout_mpll_user.clk,
> +	[7] =&exynos5_clk_mout_epll.clk,
> +	[8] =&exynos5_clk_sclk_vpll.clk,
> +	[9] =&exynos5_clk_mout_cpll.clk,
> +};
> +
> +struct clksrc_sources exynos5_clkset_group = {
> +	.sources	= exynos5_clkset_group_list,
> +	.nr_sources	= ARRAY_SIZE(exynos5_clkset_group_list),
> +};
> +
> +/* Possible clock sources for aclk_266_gscl_sub Mux */
> +static struct clk *clk_src_gscl_266_list[] = {
> +	[0] =&clk_ext_xtal_mux,
> +	[1] =&exynos5_clk_aclk_266.clk,
> +};
> +
> +static struct clksrc_sources clk_src_gscl_266 = {
> +	.sources	= clk_src_gscl_266_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_gscl_266_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_mmc0 = {
> +	.clk		= {
> +		.name		= "dout_mmc0",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 0, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS1, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_mmc1 = {
> +	.clk		= {
> +		.name		= "dout_mmc1",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 4, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS1, .shift = 16, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_mmc2 = {
> +	.clk		= {
> +		.name		= "dout_mmc2",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 8, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_mmc3 = {
> +	.clk		= {
> +		.name		= "dout_mmc3",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 12, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 16, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_dout_mmc4 = {
> +	.clk		= {
> +		.name		= "dout_mmc4",
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 16, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS3, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_uart0 = {
> +	.clk	= {
> +		.name		= "uclk1",
> +		.devname	= "exynos4210-uart.0",
> +		.enable		= exynos5_clksrc_mask_peric0_ctrl,
> +		.ctrlbit	= (1<<  0),
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC0, .shift = 0, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC0, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_uart1 = {
> +	.clk	= {
> +		.name		= "uclk1",
> +		.devname	= "exynos4210-uart.1",
> +		.enable		= exynos5_clksrc_mask_peric0_ctrl,
> +		.ctrlbit	= (1<<  4),
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC0, .shift = 4, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC0, .shift = 4, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_uart2 = {
> +	.clk	= {
> +		.name		= "uclk1",
> +		.devname	= "exynos4210-uart.2",
> +		.enable		= exynos5_clksrc_mask_peric0_ctrl,
> +		.ctrlbit	= (1<<  8),
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC0, .shift = 8, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC0, .shift = 8, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_uart3 = {
> +	.clk	= {
> +		.name		= "uclk1",
> +		.devname	= "exynos4210-uart.3",
> +		.enable		= exynos5_clksrc_mask_peric0_ctrl,
> +		.ctrlbit	= (1<<  12),
> +	},
> +	.sources =&exynos5_clkset_group,
> +	.reg_src = { .reg = EXYNOS5_CLKSRC_PERIC0, .shift = 12, .size = 4 },
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_PERIC0, .shift = 12, .size = 4 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_mmc0 = {
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.0",
> +		.parent		=&exynos5_clk_dout_mmc0.clk,
> +		.enable		= exynos5_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1<<  0),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS1, .shift = 8, .size = 8 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_mmc1 = {
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.1",
> +		.parent         =&exynos5_clk_dout_mmc1.clk,
> +		.enable		= exynos5_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1<<  4),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS1, .shift = 24, .size = 8 },
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_mmc2 = {
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.2",
> +		.parent         =&exynos5_clk_dout_mmc2.clk,
> +		.enable		= exynos5_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1<<  8),
> +	},
> +};
> +
> +static struct clksrc_clk exynos5_clk_sclk_mmc3 = {
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 8, .size = 8 },
> +	.clk	= {
> +		.name		= "sclk_mmc",
> +		.devname	= "s3c-sdhci.3",
> +		.parent         =&exynos5_clk_dout_mmc3.clk,
> +		.enable		= exynos5_clksrc_mask_fsys_ctrl,
> +		.ctrlbit	= (1<<  12),
> +	},
> +	.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS2, .shift = 24, .size = 8 },
> +};
> +
> +static struct clksrc_clk exynos5_clksrcs[] = {


How about eliminating this array by defining each clock separately and
creating an array of struct clk_lookup out of it ? This would be much
more straightforward and would ease consolidation of the clocks among
various Samsung platforms.

Same goes for exynos5_init_clocks_off[] and exynos5_init_clocks_on[]
arrays.

> +	{
> +		.clk	= {
> +			.name		= "sclk_dwmci",
> +			.parent         =&exynos5_clk_dout_mmc4.clk,
> +			.enable		= exynos5_clksrc_mask_fsys_ctrl,
> +			.ctrlbit	= (1<<  16),
> +		},
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS3, .shift = 8, .size = 8 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_fimd",
> +			.devname	= "s3cfb.1",

I thought adding the devname field was just a temporary solution to
enable DT platforms. Could we please not copy this pattern to the new
platforms ? Device names are normally used with the CLKDEV_INIT() macro.

> +			.enable		= exynos5_clksrc_mask_disp1_0_ctrl,
> +			.ctrlbit	= (1<<  0),
> +		},
> +		.sources =&exynos5_clkset_group,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_DISP1_0, .shift = 0, .size = 4 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_DISP1_0, .shift = 0, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "aclk_266_gscl",
> +		},
> +		.sources =&clk_src_gscl_266,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_TOP3, .shift = 8, .size = 1 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_g3d",
> +			.devname	= "mali-t604.0",
> +			.enable		= exynos5_clk_block_ctrl,
> +			.ctrlbit	= (1<<  1),
> +		},
> +		.sources =&exynos5_clkset_aclk,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_TOP0, .shift = 20, .size = 1 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24, .size = 3 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_gscl_wrap",
> +			.devname	= "s5p-mipi-csis.0",
> +			.enable		= exynos5_clksrc_mask_gscl_ctrl,
> +			.ctrlbit	= (1<<  24),
> +		},
> +		.sources =&exynos5_clkset_group,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_GSCL, .shift = 24, .size = 4 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_GSCL, .shift = 24, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_gscl_wrap",
> +			.devname	= "s5p-mipi-csis.1",
> +			.enable		= exynos5_clksrc_mask_gscl_ctrl,
> +			.ctrlbit	= (1<<  28),
> +		},
> +		.sources =&exynos5_clkset_group,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_GSCL, .shift = 28, .size = 4 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_GSCL, .shift = 28, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_cam0",
> +			.enable		= exynos5_clksrc_mask_gscl_ctrl,
> +			.ctrlbit	= (1<<  16),
> +		},
> +		.sources =&exynos5_clkset_group,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_GSCL, .shift = 16, .size = 4 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_GSCL, .shift = 16, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_cam1",
> +			.enable		= exynos5_clksrc_mask_gscl_ctrl,
> +			.ctrlbit	= (1<<  20),
> +		},
> +		.sources =&exynos5_clkset_group,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_GSCL, .shift = 20, .size = 4 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_GSCL, .shift = 20, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_jpeg",
> +			.parent		=&exynos5_clk_mout_cpll.clk,
> +		},
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_GEN, .shift = 4, .size = 3 },
> +	},
> +};
> +
> +/* Clock initialization code */
> +static struct clksrc_clk *exynos5_sysclks[] = {
> +	&exynos5_clk_mout_apll,
> +	&exynos5_clk_sclk_apll,
> +	&exynos5_clk_mout_bpll,
> +	&exynos5_clk_mout_bpll_user,
> +	&exynos5_clk_mout_cpll,
> +	&exynos5_clk_mout_epll,
> +	&exynos5_clk_mout_mpll,
> +	&exynos5_clk_mout_mpll_user,
> +	&exynos5_clk_vpllsrc,
> +	&exynos5_clk_sclk_vpll,
> +	&exynos5_clk_mout_cpu,
> +	&exynos5_clk_dout_armclk,
> +	&exynos5_clk_dout_arm2clk,
> +	&exynos5_clk_cdrex,
> +	&exynos5_clk_aclk_400,
> +	&exynos5_clk_aclk_333,
> +	&exynos5_clk_aclk_266,
> +	&exynos5_clk_aclk_200,
> +	&exynos5_clk_aclk_166,
> +	&exynos5_clk_aclk_66_pre,
> +	&exynos5_clk_aclk_66,
> +	&exynos5_clk_dout_mmc0,
> +	&exynos5_clk_dout_mmc1,
> +	&exynos5_clk_dout_mmc2,
> +	&exynos5_clk_dout_mmc3,
> +	&exynos5_clk_dout_mmc4,
> +	&exynos5_clk_aclk_acp,
> +	&exynos5_clk_pclk_acp,
> +};
> +
> +static struct clk *exynos5_clk_cdev[] = {
> +	&exynos5_clk_pdma0,
> +	&exynos5_clk_pdma1,
> +	&exynos5_clk_pdma2,
> +};
> +
> +static struct clksrc_clk *exynos5_clksrc_cdev[] = {
> +	&exynos5_clk_sclk_uart0,
> +	&exynos5_clk_sclk_uart1,
> +	&exynos5_clk_sclk_uart2,
> +	&exynos5_clk_sclk_uart3,
> +	&exynos5_clk_sclk_mmc0,
> +	&exynos5_clk_sclk_mmc1,
> +	&exynos5_clk_sclk_mmc2,
> +	&exynos5_clk_sclk_mmc3,
> +};
> +
> +static struct clk_lookup exynos5_clk_lookup[] = {
> +	CLKDEV_INIT("exynos4210-uart.0", "clk_uart_baud0",&exynos5_clk_sclk_uart0.clk),
> +	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0",&exynos5_clk_sclk_uart1.clk),
> +	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0",&exynos5_clk_sclk_uart2.clk),
> +	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0",&exynos5_clk_sclk_uart3.clk),
> +	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2",&exynos5_clk_sclk_mmc0.clk),
> +	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2",&exynos5_clk_sclk_mmc1.clk),
> +	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2",&exynos5_clk_sclk_mmc2.clk),
> +	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2",&exynos5_clk_sclk_mmc3.clk),
> +	CLKDEV_INIT("dma-pl330.0", "apb_pclk",&exynos5_clk_pdma0),
> +	CLKDEV_INIT("dma-pl330.1", "apb_pclk",&exynos5_clk_pdma1),
> +	CLKDEV_INIT("dma-pl330.2", "apb_pclk",&exynos5_clk_pdma2),

How about defining all data for the clkdev like this, i.e. removing all
'devname' occurences above ?

> +};
> +
> +static unsigned long exynos5_epll_get_rate(struct clk *clk)
> +{
> +	return clk->rate;
> +}
> +
> +static struct clk *exynos5_clks[] __initdata = {
> +	&exynos5_clk_sclk_hdmi27m,
> +	&exynos5_clk_sclk_hdmiphy,
> +	&clk_fout_bpll,
> +	&clk_fout_cpll,
> +	&exynos5_clk_armclk,
> +};
> +
...
> +void __init_or_cpufreq exynos5_setup_clocks(void)
> +{
> +	struct clk *xtal_clk;
> +	unsigned long apll;
> +	unsigned long bpll;
> +	unsigned long cpll;
> +	unsigned long mpll;
> +	unsigned long epll;
> +	unsigned long vpll;
> +	unsigned long vpllsrc;
> +	unsigned long xtal;
> +	unsigned long armclk;
> +	unsigned long mout_cdrex;
> +	unsigned long aclk_400;
> +	unsigned long aclk_333;
> +	unsigned long aclk_266;
> +	unsigned long aclk_200;
> +	unsigned long aclk_166;
> +	unsigned long aclk_66;
> +	unsigned int ptr;
> +
> +	printk(KERN_DEBUG "%s: registering clocks\n", __func__);

pr_debug

> +
> +	xtal_clk = clk_get(NULL, "xtal");
> +	BUG_ON(IS_ERR(xtal_clk));
> +
> +	xtal = clk_get_rate(xtal_clk);
> +
> +	xtal_rate = xtal;
> +
> +	clk_put(xtal_clk);
> +
> +	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);

pr_debug

> +
> +	apll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS5_APLL_CON0));
> +	bpll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS5_BPLL_CON0));
> +	cpll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS5_CPLL_CON0));
> +	mpll = s5p_get_pll35xx(xtal, __raw_readl(EXYNOS5_MPLL_CON0));
> +	epll = s5p_get_pll36xx(xtal, __raw_readl(EXYNOS5_EPLL_CON0),
> +			__raw_readl(EXYNOS5_EPLL_CON1));
> +
> +	vpllsrc = clk_get_rate(&exynos5_clk_vpllsrc.clk);
> +	vpll = s5p_get_pll36xx(vpllsrc, __raw_readl(EXYNOS5_VPLL_CON0),
> +			__raw_readl(EXYNOS5_VPLL_CON1));
> +
> +	clk_fout_apll.ops =&exynos5_fout_apll_ops;
> +	clk_fout_bpll.rate = bpll;
> +	clk_fout_cpll.rate = cpll;
> +	clk_fout_mpll.rate = mpll;
> +	clk_fout_epll.rate = epll;
> +	clk_fout_vpll.rate = vpll;
> +
> +	printk(KERN_INFO "EXYNOS5: PLL settings, A=%ld, B=%ld, C=%ld\n"

pr_info

> +			"M=%ld, E=%ld V=%ld",
> +			apll, bpll, cpll, mpll, epll, vpll);
> +
> +	armclk = clk_get_rate(&exynos5_clk_armclk);
> +	mout_cdrex = clk_get_rate(&exynos5_clk_cdrex.clk);
> +
> +	aclk_400 = clk_get_rate(&exynos5_clk_aclk_400.clk);
> +	aclk_333 = clk_get_rate(&exynos5_clk_aclk_333.clk);
> +	aclk_266 = clk_get_rate(&exynos5_clk_aclk_266.clk);
> +	aclk_200 = clk_get_rate(&exynos5_clk_aclk_200.clk);
> +	aclk_166 = clk_get_rate(&exynos5_clk_aclk_166.clk);
> +	aclk_66 = clk_get_rate(&exynos5_clk_aclk_66.clk);
> +
> +	printk(KERN_INFO "EXYNOS5: ARMCLK=%ld, CDREX=%ld, ACLK400=%ld\n"

pr_info

> +			"ACLK333=%ld, ACLK266=%ld, ACLK200=%ld\n"
> +			"ACLK166=%ld, ACLK66=%ld\n",
> +			armclk, mout_cdrex, aclk_400,
> +			aclk_333, aclk_266, aclk_200,
> +			aclk_166, aclk_66);
> +
> +
> +	clk_fout_epll.ops =&exynos5_epll_ops;
> +
> +	if (clk_set_parent(&exynos5_clk_mout_epll.clk,&clk_fout_epll))
> +		printk(KERN_ERR "Unable to set parent %s of clock %s.\n",

pr_err

> +				clk_fout_epll.name, exynos5_clk_mout_epll.clk.name);
> +
> +	clk_set_rate(&exynos5_clk_sclk_apll.clk, 100000000);

100000000UL ?

> +	clk_set_rate(&exynos5_clk_aclk_266.clk, 300000000);
> +
> +	clk_set_rate(&exynos5_clk_aclk_acp.clk, 267000000);
> +	clk_set_rate(&exynos5_clk_pclk_acp.clk, 134000000);
> +
> +	for (ptr = 0; ptr<  ARRAY_SIZE(exynos5_clksrcs); ptr++)
> +		s3c_set_clksrc(&exynos5_clksrcs[ptr], true);
> +}
> +
> +void __init exynos5_register_clocks(void)
> +{
> +	int ptr;
> +
> +	s3c24xx_register_clocks(exynos5_clks, ARRAY_SIZE(exynos5_clks));
> +
> +	for (ptr = 0; ptr<  ARRAY_SIZE(exynos5_sysclks); ptr++)
> +		s3c_register_clksrc(exynos5_sysclks[ptr], 1);
> +
> +	for (ptr = 0; ptr<  ARRAY_SIZE(exynos5_sclk_tv); ptr++)
> +		s3c_register_clksrc(exynos5_sclk_tv[ptr], 1);
> +
> +	for (ptr = 0; ptr<  ARRAY_SIZE(exynos5_clksrc_cdev); ptr++)
> +		s3c_register_clksrc(exynos5_clksrc_cdev[ptr], 1);
> +
> +	s3c_register_clksrc(exynos5_clksrcs, ARRAY_SIZE(exynos5_clksrcs));
> +	s3c_register_clocks(exynos5_init_clocks_on, ARRAY_SIZE(exynos5_init_clocks_on));
> +
> +	s3c24xx_register_clocks(exynos5_clk_cdev, ARRAY_SIZE(exynos5_clk_cdev));
> +	for (ptr = 0; ptr<  ARRAY_SIZE(exynos5_clk_cdev); ptr++)
> +		s3c_disable_clocks(exynos5_clk_cdev[ptr], 1);
> +
> +	s3c_register_clocks(exynos5_init_clocks_off, ARRAY_SIZE(exynos5_init_clocks_off));
> +	s3c_disable_clocks(exynos5_init_clocks_off, ARRAY_SIZE(exynos5_init_clocks_off));
> +	clkdev_add_table(exynos5_clk_lookup, ARRAY_SIZE(exynos5_clk_lookup));

This clock registration is pretty messy right now and yet we're
copy/pasting it from one platform to the other. IMHO possibly all
clocks should be registered like the exynos5_clk_lookup array.

It would be easy to create a replacement for s3c24xx_register_clock()
function, not relying on struct clk::devname.

> +
> +	register_syscore_ops(&exynos5_clock_syscore_ops);
> +	s3c_pwmclk_init();
> +}

--

Thanks,
Sylwester
