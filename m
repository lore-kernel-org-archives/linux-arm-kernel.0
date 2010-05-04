From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 04:51:17 +0100
Subject: [PATCH v2 1/2] ARM: S5PV210: Add S5PV210 GPIO support
In-Reply-To: <1272940641-31220-1-git-send-email-kgene.kim@samsung.com>
References: <1272940641-31220-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100504035117.GV6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 11:37:21AM +0900, Kukjin Kim wrote:
> This patch adds GPIOlib support for S5PV210.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Makefile                 |    2 +-
>  arch/arm/mach-s5pv210/gpio.c                   |  495 ++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/gpio.h      |   97 +++++-
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   77 ++++
>  4 files changed, 667 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/gpio.c
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> 
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index 7469d10..cb959ea 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -12,7 +12,7 @@ obj-				:=
>  
>  # Core support for S5PV210 system
>  
> -obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
> +obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o
>  
>  # machine support
>  
> diff --git a/arch/arm/mach-s5pv210/gpio.c b/arch/arm/mach-s5pv210/gpio.c
> new file mode 100644
> index 0000000..88f4802
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/gpio.c
> @@ -0,0 +1,495 @@
> +/* linux/arch/arm/mach-s5pv210/gpio.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - GPIOlib support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <mach/map.h>
> +#include <mach/gpio.h>
> +#include <mach/regs-gpio.h>
> +#include <plat/gpio-core.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/gpio-cfg-helpers.h>
> +
> +static struct s3c_gpio_cfg gpio_cfg = {
> +	.cfg_eint	= 0xf,
> +	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
> +	.set_pull	= s3c_gpio_setpull_updown,
> +	.get_pull	= s3c_gpio_getpull_updown,
> +};
> +
> +static struct s3c_gpio_cfg gpio_cfg_noint = {
> +	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
> +	.set_pull	= s3c_gpio_setpull_updown,
> +	.get_pull	= s3c_gpio_getpull_updown,
> +};
> +
> +static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
> +	{
> +		.base	= S5PV210_GPA0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPA0(0),
> +			.ngpio	= S5PV210_GPIO_A0_NR,
> +			.label	= "GPA0",
> +		},

given that &gpio_cfg is the default, it would have been easier to
make a wrapper for the registration code and have it set any null
config settign to gpio_cfg.

> +	}, {
> +		.base	= S5PV210_GPA1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPA1(0),
> +			.ngpio	= S5PV210_GPIO_A1_NR,
> +			.label	= "GPA1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPB_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPB(0),
> +			.ngpio	= S5PV210_GPIO_B_NR,
> +			.label	= "GPB",
> +		},
> +	}, {
> +		.base	= S5PV210_GPC0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPC0(0),
> +			.ngpio	= S5PV210_GPIO_C0_NR,
> +			.label	= "GPC0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPC1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPC1(0),
> +			.ngpio	= S5PV210_GPIO_C1_NR,
> +			.label	= "GPC1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPD0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPD0(0),
> +			.ngpio	= S5PV210_GPIO_D0_NR,
> +			.label	= "GPD0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPD1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPD1(0),
> +			.ngpio	= S5PV210_GPIO_D1_NR,
> +			.label	= "GPD1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPE0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPE0(0),
> +			.ngpio	= S5PV210_GPIO_E0_NR,
> +			.label	= "GPE0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPE1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPE1(0),
> +			.ngpio	= S5PV210_GPIO_E1_NR,
> +			.label	= "GPE1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPF0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPF0(0),
> +			.ngpio	= S5PV210_GPIO_F0_NR,
> +			.label	= "GPF0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPF1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPF1(0),
> +			.ngpio	= S5PV210_GPIO_F1_NR,
> +			.label	= "GPF1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPF2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPF2(0),
> +			.ngpio	= S5PV210_GPIO_F2_NR,
> +			.label	= "GPF2",
> +		},
> +	}, {
> +		.base	= S5PV210_GPF3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPF3(0),
> +			.ngpio	= S5PV210_GPIO_F3_NR,
> +			.label	= "GPF3",
> +		},
> +	}, {
> +		.base	= S5PV210_GPG0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPG0(0),
> +			.ngpio	= S5PV210_GPIO_G0_NR,
> +			.label	= "GPG0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPG1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPG1(0),
> +			.ngpio	= S5PV210_GPIO_G1_NR,
> +			.label	= "GPG1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPG2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPG2(0),
> +			.ngpio	= S5PV210_GPIO_G2_NR,
> +			.label	= "GPG2",
> +		},
> +	}, {
> +		.base	= S5PV210_GPG3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPG3(0),
> +			.ngpio	= S5PV210_GPIO_G3_NR,
> +			.label	= "GPG3",
> +		},
> +	}, {
> +		.base	= S5PV210_GPH0_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH0(0),
> +			.ngpio	= S5PV210_GPIO_H0_NR,
> +			.label	= "GPH0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPH1_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH1(0),
> +			.ngpio	= S5PV210_GPIO_H1_NR,
> +			.label	= "GPH1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPH2_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH2(0),
> +			.ngpio	= S5PV210_GPIO_H2_NR,
> +			.label	= "GPH2",
> +		},
> +	}, {
> +		.base	= S5PV210_GPH3_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_GPH3(0),
> +			.ngpio	= S5PV210_GPIO_H3_NR,
> +			.label	= "GPH3",
> +		},
> +	}, {
> +		.base	= S5PV210_GPI_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPI(0),
> +			.ngpio	= S5PV210_GPIO_I_NR,
> +			.label	= "GPI",
> +		},
> +	}, {
> +		.base	= S5PV210_GPJ0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPJ0(0),
> +			.ngpio	= S5PV210_GPIO_J0_NR,
> +			.label	= "GPJ0",
> +		},
> +	}, {
> +		.base	= S5PV210_GPJ1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPJ1(0),
> +			.ngpio	= S5PV210_GPIO_J1_NR,
> +			.label	= "GPJ1",
> +		},
> +	}, {
> +		.base	= S5PV210_GPJ2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPJ2(0),
> +			.ngpio	= S5PV210_GPIO_J2_NR,
> +			.label	= "GPJ2",
> +		},
> +	}, {
> +		.base	= S5PV210_GPJ3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPJ3(0),
> +			.ngpio	= S5PV210_GPIO_J3_NR,
> +			.label	= "GPJ3",
> +		},
> +	}, {
> +		.base	= S5PV210_GPJ4_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PV210_GPJ4(0),
> +			.ngpio	= S5PV210_GPIO_J4_NR,
> +			.label	= "GPJ4",
> +		},
> +	}, {
> +		.base	= S5PV210_MP01_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP01(0),
> +			.ngpio	= S5PV210_GPIO_MP01_NR,
> +			.label	= "MP01",
> +		},
> +	}, {
> +		.base	= S5PV210_MP02_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP02(0),
> +			.ngpio	= S5PV210_GPIO_MP02_NR,
> +			.label	= "MP02",
> +		},
> +	}, {
> +		.base	= S5PV210_MP03_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP03(0),
> +			.ngpio	= S5PV210_GPIO_MP03_NR,
> +			.label	= "MP03",
> +		},
> +	}, {
> +		.base	= S5PV210_MP04_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP04(0),
> +			.ngpio	= S5PV210_GPIO_MP04_NR,
> +			.label	= "MP04",
> +		},
> +	}, {
> +		.base	= S5PV210_MP05_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP05(0),
> +			.ngpio	= S5PV210_GPIO_MP05_NR,
> +			.label	= "MP05",
> +		},
> +	}, {
> +		.base	= S5PV210_MP06_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP06(0),
> +			.ngpio	= S5PV210_GPIO_MP06_NR,
> +			.label	= "MP06",
> +		},
> +	}, {
> +		.base	= S5PV210_MP07_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP07(0),
> +			.ngpio	= S5PV210_GPIO_MP07_NR,
> +			.label	= "MP07",
> +		},
> +	}, {
> +		.base	= S5PV210_MP10_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP10(0),
> +			.ngpio	= S5PV210_GPIO_MP10_NR,
> +			.label	= "MP10",
> +		},
> +	}, {
> +		.base	= S5PV210_MP11_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP11(0),
> +			.ngpio	= S5PV210_GPIO_MP11_NR,
> +			.label	= "MP11",
> +		},
> +	}, {
> +		.base	= S5PV210_MP12_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP12(0),
> +			.ngpio	= S5PV210_GPIO_MP12_NR,
> +			.label	= "MP12",
> +		},
> +	}, {
> +		.base	= S5PV210_MP13_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP13(0),
> +			.ngpio	= S5PV210_GPIO_MP13_NR,
> +			.label	= "MP13",
> +		},
> +	}, {
> +		.base	= S5PV210_MP14_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP14(0),
> +			.ngpio	= S5PV210_GPIO_MP14_NR,
> +			.label	= "MP14",
> +		},
> +	}, {
> +		.base	= S5PV210_MP15_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP15(0),
> +			.ngpio	= S5PV210_GPIO_MP15_NR,
> +			.label	= "MP15",
> +		},
> +	}, {
> +		.base	= S5PV210_MP16_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP16(0),
> +			.ngpio	= S5PV210_GPIO_MP16_NR,
> +			.label	= "MP16",
> +		},
> +	}, {
> +		.base	= S5PV210_MP17_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP17(0),
> +			.ngpio	= S5PV210_GPIO_MP17_NR,
> +			.label	= "MP17",
> +		},
> +	}, {
> +		.base	= S5PV210_MP18_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP18(0),
> +			.ngpio	= S5PV210_GPIO_MP18_NR,
> +			.label	= "MP18",
> +		},
> +	}, {
> +		.base	= S5PV210_MP20_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP20(0),
> +			.ngpio	= S5PV210_GPIO_MP20_NR,
> +			.label	= "MP20",
> +		},
> +	}, {
> +		.base	= S5PV210_MP21_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP21(0),
> +			.ngpio	= S5PV210_GPIO_MP21_NR,
> +			.label	= "MP21",
> +		},
> +	}, {
> +		.base	= S5PV210_MP22_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP22(0),
> +			.ngpio	= S5PV210_GPIO_MP22_NR,
> +			.label	= "MP22",
> +		},
> +	}, {
> +		.base	= S5PV210_MP23_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP23(0),
> +			.ngpio	= S5PV210_GPIO_MP23_NR,
> +			.label	= "MP23",
> +		},
> +	}, {
> +		.base	= S5PV210_MP24_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP24(0),
> +			.ngpio	= S5PV210_GPIO_MP24_NR,
> +			.label	= "MP24",
> +		},
> +	}, {
> +		.base	= S5PV210_MP25_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP25(0),
> +			.ngpio	= S5PV210_GPIO_MP25_NR,
> +			.label	= "MP25",
> +		},
> +	}, {
> +		.base	= S5PV210_MP26_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP26(0),
> +			.ngpio	= S5PV210_GPIO_MP26_NR,
> +			.label	= "MP26",
> +		},
> +	}, {
> +		.base	= S5PV210_MP27_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP27(0),
> +			.ngpio	= S5PV210_GPIO_MP27_NR,
> +			.label	= "MP27",
> +		},
> +	}, {
> +		.base	= S5PV210_MP28_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_MP28(0),
> +			.ngpio	= S5PV210_GPIO_MP28_NR,
> +			.label	= "MP28",
> +		},
> +	}, {
> +		.base	= S5PV210_ETC0_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_ETC0(0),
> +			.ngpio	= S5PV210_GPIO_ETC0_NR,
> +			.label	= "ETC0",
> +		},
> +	}, {
> +		.base	= S5PV210_ETC1_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_ETC1(0),
> +			.ngpio	= S5PV210_GPIO_ETC1_NR,
> +			.label	= "ETC1",
> +		},
> +	}, {
> +		.base	= S5PV210_ETC2_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_ETC2(0),
> +			.ngpio	= S5PV210_GPIO_ETC2_NR,
> +			.label	= "ETC2",
> +		},
> +	}, {
> +		.base	= S5PV210_ETC4_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PV210_ETC4(0),
> +			.ngpio	= S5PV210_GPIO_ETC4_NR,
> +			.label	= "ETC4",
> +		},
> +	},
> +};
> +
> +static __init int s5pv210_gpiolib_init(void)
> +{
> +	samsung_gpiolib_add_4bit_chips(s5pv210_gpio_4bit,
> +				       ARRAY_SIZE(s5pv210_gpio_4bit));
> +
> +	return 0;
> +}
> +core_initcall(s5pv210_gpiolib_init);
> diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
> index 533b020..ddbbfc3 100644
> --- a/arch/arm/mach-s5pv210/include/mach/gpio.h
> +++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
> @@ -47,6 +47,39 @@
>  #define S5PV210_GPIO_J3_NR	(8)
>  #define S5PV210_GPIO_J4_NR	(5)
>  
> +#define S5PV210_GPIO_MP01_NR	(8)
> +#define S5PV210_GPIO_MP02_NR	(4)
> +#define S5PV210_GPIO_MP03_NR	(8)
> +#define S5PV210_GPIO_MP04_NR	(8)
> +#define S5PV210_GPIO_MP05_NR	(8)
> +#define S5PV210_GPIO_MP06_NR	(8)
> +#define S5PV210_GPIO_MP07_NR	(8)
> +
> +#define S5PV210_GPIO_MP10_NR	(8)
> +#define S5PV210_GPIO_MP11_NR	(8)
> +#define S5PV210_GPIO_MP12_NR	(8)
> +#define S5PV210_GPIO_MP13_NR	(8)
> +#define S5PV210_GPIO_MP14_NR	(8)
> +#define S5PV210_GPIO_MP15_NR	(8)
> +#define S5PV210_GPIO_MP16_NR	(8)
> +#define S5PV210_GPIO_MP17_NR	(8)
> +#define S5PV210_GPIO_MP18_NR	(7)
> +
> +#define S5PV210_GPIO_MP20_NR	(8)
> +#define S5PV210_GPIO_MP21_NR	(8)
> +#define S5PV210_GPIO_MP22_NR	(8)
> +#define S5PV210_GPIO_MP23_NR	(8)
> +#define S5PV210_GPIO_MP24_NR	(8)
> +#define S5PV210_GPIO_MP25_NR	(8)
> +#define S5PV210_GPIO_MP26_NR	(8)
> +#define S5PV210_GPIO_MP27_NR	(8)
> +#define S5PV210_GPIO_MP28_NR	(7)
> +
> +#define S5PV210_GPIO_ETC0_NR	(6)
> +#define S5PV210_GPIO_ETC1_NR	(8)
> +#define S5PV210_GPIO_ETC2_NR	(8)
> +#define S5PV210_GPIO_ETC4_NR	(6)
> +
>  /* GPIO bank numbers */
>  
>  /* CONFIG_S3C_GPIO_SPACE allows the user to select extra
> @@ -85,6 +118,35 @@ enum s5p_gpio_number {
>  	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
>  	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
>  	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
> +	S5PV210_GPIO_MP01_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
> +	S5PV210_GPIO_MP02_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP01),
> +	S5PV210_GPIO_MP03_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP02),
> +	S5PV210_GPIO_MP04_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP03),
> +	S5PV210_GPIO_MP05_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP04),
> +	S5PV210_GPIO_MP06_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP05),
> +	S5PV210_GPIO_MP07_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP06),
> +	S5PV210_GPIO_MP10_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP07),
> +	S5PV210_GPIO_MP11_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP10),
> +	S5PV210_GPIO_MP12_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP11),
> +	S5PV210_GPIO_MP13_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP12),
> +	S5PV210_GPIO_MP14_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP13),
> +	S5PV210_GPIO_MP15_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP14),
> +	S5PV210_GPIO_MP16_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP15),
> +	S5PV210_GPIO_MP17_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP16),
> +	S5PV210_GPIO_MP18_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP17),
> +	S5PV210_GPIO_MP20_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP18),
> +	S5PV210_GPIO_MP21_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP20),
> +	S5PV210_GPIO_MP22_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP21),
> +	S5PV210_GPIO_MP23_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP22),
> +	S5PV210_GPIO_MP24_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP23),
> +	S5PV210_GPIO_MP25_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP24),
> +	S5PV210_GPIO_MP26_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP25),
> +	S5PV210_GPIO_MP27_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP26),
> +	S5PV210_GPIO_MP28_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP27),
> +	S5PV210_GPIO_ETC0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP28),
> +	S5PV210_GPIO_ETC1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_ETC0),
> +	S5PV210_GPIO_ETC2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_ETC1),
> +	S5PV210_GPIO_ETC4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_ETC2),
>  };
>  
>  /* S5PV210 GPIO number definitions */
> @@ -115,13 +177,42 @@ enum s5p_gpio_number {
>  #define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
>  #define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
>  #define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
> +#define S5PV210_MP01(_nr)	(S5PV210_GPIO_MP01_START + (_nr))
> +#define S5PV210_MP02(_nr)	(S5PV210_GPIO_MP02_START + (_nr))
> +#define S5PV210_MP03(_nr)	(S5PV210_GPIO_MP03_START + (_nr))
> +#define S5PV210_MP04(_nr)	(S5PV210_GPIO_MP04_START + (_nr))
> +#define S5PV210_MP05(_nr)	(S5PV210_GPIO_MP05_START + (_nr))
> +#define S5PV210_MP06(_nr)	(S5PV210_GPIO_MP06_START + (_nr))
> +#define S5PV210_MP07(_nr)	(S5PV210_GPIO_MP07_START + (_nr))
> +#define S5PV210_MP10(_nr)	(S5PV210_GPIO_MP10_START + (_nr))
> +#define S5PV210_MP11(_nr)	(S5PV210_GPIO_MP11_START + (_nr))
> +#define S5PV210_MP12(_nr)	(S5PV210_GPIO_MP12_START + (_nr))
> +#define S5PV210_MP13(_nr)	(S5PV210_GPIO_MP13_START + (_nr))
> +#define S5PV210_MP14(_nr)	(S5PV210_GPIO_MP14_START + (_nr))
> +#define S5PV210_MP15(_nr)	(S5PV210_GPIO_MP15_START + (_nr))
> +#define S5PV210_MP16(_nr)	(S5PV210_GPIO_MP16_START + (_nr))
> +#define S5PV210_MP17(_nr)	(S5PV210_GPIO_MP17_START + (_nr))
> +#define S5PV210_MP18(_nr)	(S5PV210_GPIO_MP18_START + (_nr))
> +#define S5PV210_MP20(_nr)	(S5PV210_GPIO_MP20_START + (_nr))
> +#define S5PV210_MP21(_nr)	(S5PV210_GPIO_MP21_START + (_nr))
> +#define S5PV210_MP22(_nr)	(S5PV210_GPIO_MP22_START + (_nr))
> +#define S5PV210_MP23(_nr)	(S5PV210_GPIO_MP23_START + (_nr))
> +#define S5PV210_MP24(_nr)	(S5PV210_GPIO_MP24_START + (_nr))
> +#define S5PV210_MP25(_nr)	(S5PV210_GPIO_MP25_START + (_nr))
> +#define S5PV210_MP26(_nr)	(S5PV210_GPIO_MP26_START + (_nr))
> +#define S5PV210_MP27(_nr)	(S5PV210_GPIO_MP27_START + (_nr))
> +#define S5PV210_MP28(_nr)	(S5PV210_GPIO_MP28_START + (_nr))
> +#define S5PV210_ETC0(_nr)	(S5PV210_GPIO_ETC0_START + (_nr))
> +#define S5PV210_ETC1(_nr)	(S5PV210_GPIO_ETC1_START + (_nr))
> +#define S5PV210_ETC2(_nr)	(S5PV210_GPIO_ETC2_START + (_nr))
> +#define S5PV210_ETC4(_nr)	(S5PV210_GPIO_ETC4_START + (_nr))
>  
>  /* the end of the S5PV210 specific gpios */
> -#define S5PV210_GPIO_END	(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) + 1)
> +#define S5PV210_GPIO_END	(S5PV210_ETC4(S5PV210_GPIO_ETC4_NR) + 1)
>  #define S3C_GPIO_END		S5PV210_GPIO_END
>  
> -/* define the number of gpios we need to the one after the GPJ4() range */
> -#define ARCH_NR_GPIOS		(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) +	\
> +/* define the number of gpios we need to the one after the ETC4() range */
> +#define ARCH_NR_GPIOS		(S5PV210_ETC4(S5PV210_GPIO_ETC4_NR) +	\
>  				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
>  
>  #include <asm-generic/gpio.h>
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> new file mode 100644
> index 0000000..c78bbeb
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> @@ -0,0 +1,77 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - GPIO register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_GPIO_H
> +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> +
> +#include <mach/map.h>
> +
> +/* Base addresses for each of the banks */
> +
> +#define S5PV210_GPA0_BASE	(S5P_VA_GPIO + 0x000)
> +#define S5PV210_GPA1_BASE	(S5P_VA_GPIO + 0x020)
> +#define S5PV210_GPB_BASE	(S5P_VA_GPIO + 0x040)
> +#define S5PV210_GPC0_BASE	(S5P_VA_GPIO + 0x060)
> +#define S5PV210_GPC1_BASE	(S5P_VA_GPIO + 0x080)
> +#define S5PV210_GPD0_BASE	(S5P_VA_GPIO + 0x0A0)
> +#define S5PV210_GPD1_BASE	(S5P_VA_GPIO + 0x0C0)
> +#define S5PV210_GPE0_BASE	(S5P_VA_GPIO + 0x0E0)
> +#define S5PV210_GPE1_BASE	(S5P_VA_GPIO + 0x100)
> +#define S5PV210_GPF0_BASE	(S5P_VA_GPIO + 0x120)
> +#define S5PV210_GPF1_BASE	(S5P_VA_GPIO + 0x140)
> +#define S5PV210_GPF2_BASE	(S5P_VA_GPIO + 0x160)
> +#define S5PV210_GPF3_BASE	(S5P_VA_GPIO + 0x180)
> +#define S5PV210_GPG0_BASE	(S5P_VA_GPIO + 0x1A0)
> +#define S5PV210_GPG1_BASE	(S5P_VA_GPIO + 0x1C0)
> +#define S5PV210_GPG2_BASE	(S5P_VA_GPIO + 0x1E0)
> +#define S5PV210_GPG3_BASE	(S5P_VA_GPIO + 0x200)
> +#define S5PV210_GPH0_BASE	(S5P_VA_GPIO + 0xC00)
> +#define S5PV210_GPH1_BASE	(S5P_VA_GPIO + 0xC20)
> +#define S5PV210_GPH2_BASE	(S5P_VA_GPIO + 0xC40)
> +#define S5PV210_GPH3_BASE	(S5P_VA_GPIO + 0xC60)
> +#define S5PV210_GPI_BASE	(S5P_VA_GPIO + 0x220)
> +#define S5PV210_GPJ0_BASE	(S5P_VA_GPIO + 0x240)
> +#define S5PV210_GPJ1_BASE	(S5P_VA_GPIO + 0x260)
> +#define S5PV210_GPJ2_BASE	(S5P_VA_GPIO + 0x280)
> +#define S5PV210_GPJ3_BASE	(S5P_VA_GPIO + 0x2A0)
> +#define S5PV210_GPJ4_BASE	(S5P_VA_GPIO + 0x2C0)
> +#define S5PV210_MP01_BASE	(S5P_VA_GPIO + 0x2E0)
> +#define S5PV210_MP02_BASE	(S5P_VA_GPIO + 0x300)
> +#define S5PV210_MP03_BASE	(S5P_VA_GPIO + 0x320)
> +#define S5PV210_MP04_BASE	(S5P_VA_GPIO + 0x340)
> +#define S5PV210_MP05_BASE	(S5P_VA_GPIO + 0x360)
> +#define S5PV210_MP06_BASE	(S5P_VA_GPIO + 0x380)
> +#define S5PV210_MP07_BASE	(S5P_VA_GPIO + 0x3A0)
> +#define S5PV210_MP10_BASE	(S5P_VA_GPIO + 0x3C0)
> +#define S5PV210_MP11_BASE	(S5P_VA_GPIO + 0x3E0)
> +#define S5PV210_MP12_BASE	(S5P_VA_GPIO + 0x400)
> +#define S5PV210_MP13_BASE	(S5P_VA_GPIO + 0x420)
> +#define S5PV210_MP14_BASE	(S5P_VA_GPIO + 0x440)
> +#define S5PV210_MP15_BASE	(S5P_VA_GPIO + 0x460)
> +#define S5PV210_MP16_BASE	(S5P_VA_GPIO + 0x480)
> +#define S5PV210_MP17_BASE	(S5P_VA_GPIO + 0x4A0)
> +#define S5PV210_MP18_BASE	(S5P_VA_GPIO + 0x4C0)
> +#define S5PV210_MP20_BASE	(S5P_VA_GPIO + 0x4E0)
> +#define S5PV210_MP21_BASE	(S5P_VA_GPIO + 0x500)
> +#define S5PV210_MP22_BASE	(S5P_VA_GPIO + 0x520)
> +#define S5PV210_MP23_BASE	(S5P_VA_GPIO + 0x540)
> +#define S5PV210_MP24_BASE	(S5P_VA_GPIO + 0x560)
> +#define S5PV210_MP25_BASE	(S5P_VA_GPIO + 0x580)
> +#define S5PV210_MP26_BASE	(S5P_VA_GPIO + 0x5A0)
> +#define S5PV210_MP27_BASE	(S5P_VA_GPIO + 0x5C0)
> +#define S5PV210_MP28_BASE	(S5P_VA_GPIO + 0x5E0)
> +#define S5PV210_ETC0_BASE	(S5P_VA_GPIO + 0x600)
> +#define S5PV210_ETC1_BASE	(S5P_VA_GPIO + 0x620)
> +#define S5PV210_ETC2_BASE	(S5P_VA_GPIO + 0x640)
> +#define S5PV210_ETC4_BASE	(S5P_VA_GPIO + 0x660)

wasn't there somethign similar to this with the gpio interrupts.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
