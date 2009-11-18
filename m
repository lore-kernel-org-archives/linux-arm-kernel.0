From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 18 Nov 2009 22:05:35 +0000
Subject: [PATCH 14/19] ARM: S5PC1XX: add support for s5pc110 gpio
In-Reply-To: <1258551194-16018-15-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-15-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091118220535.GA4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 02:33:09PM +0100, Marek Szyprowski wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
> on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
> This patch adds gpiolib support for S5PC110 sub-platform.

Hmm, another file with Byungho Min <bhmin@samsung.com> in and no signoff
from this person.
 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
>  arch/arm/mach-s5pc110/include/mach/gpio.h      |  149 +++++++++++++
>  arch/arm/mach-s5pc110/include/plat/regs-gpio.h |   65 ++++++
>  arch/arm/plat-s5pc1xx/gpiolib.c                |  266 ++++++++++++++++++++++++
>  arch/arm/plat-s5pc1xx/irq-gpio.c               |  110 ++++++++++
>  4 files changed, 590 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5pc110/include/mach/gpio.h
>  create mode 100644 arch/arm/mach-s5pc110/include/plat/regs-gpio.h
> 
> diff --git a/arch/arm/mach-s5pc110/include/mach/gpio.h b/arch/arm/mach-s5pc110/include/mach/gpio.h
> new file mode 100644
> index 0000000..f83e5c9
> --- /dev/null
> +++ b/arch/arm/mach-s5pc110/include/mach/gpio.h
> @@ -0,0 +1,149 @@
> +/* arch/arm/mach-s5pc110/include/mach/gpio.h
> + *
> + * Copyright 2009 Samsung Electronics Co.
> + *	Byungho Min <bhmin@samsung.com>
> + *
> + * S5PC110 - GPIO lib support
> + *
> + * Base on mach-s3c6400/include/mach/gpio.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#define gpio_get_value	__gpio_get_value
> +#define gpio_set_value	__gpio_set_value
> +#define gpio_cansleep	__gpio_cansleep
> +#define gpio_to_irq	__gpio_to_irq
> +
> +/* GPIO bank sizes */
> +#define S5PC110_GPIO_A0_NR	(8)
> +#define S5PC110_GPIO_A1_NR	(8)
> +#define S5PC110_GPIO_B_NR	(8)
> +#define S5PC110_GPIO_C0_NR	(8)
> +#define S5PC110_GPIO_C1_NR	(8)
> +#define S5PC110_GPIO_D0_NR	(8)
> +#define S5PC110_GPIO_D1_NR	(8)
> +#define S5PC110_GPIO_E0_NR	(8)
> +#define S5PC110_GPIO_E1_NR	(8)
> +#define S5PC110_GPIO_F0_NR	(8)
> +#define S5PC110_GPIO_F1_NR	(8)
> +#define S5PC110_GPIO_F2_NR	(8)
> +#define S5PC110_GPIO_F3_NR	(8)
> +#define S5PC110_GPIO_G0_NR	(8)
> +#define S5PC110_GPIO_G1_NR	(8)
> +#define S5PC110_GPIO_G2_NR	(8)
> +#define S5PC110_GPIO_G3_NR	(8)
> +#define S5PC110_GPIO_H0_NR	(8)
> +#define S5PC110_GPIO_H1_NR	(8)
> +#define S5PC110_GPIO_H2_NR	(8)
> +#define S5PC110_GPIO_H3_NR	(8)
> +#define S5PC110_GPIO_I_NR	(8)
> +#define S5PC110_GPIO_J0_NR	(8)
> +#define S5PC110_GPIO_J1_NR	(8)
> +#define S5PC110_GPIO_J2_NR	(8)
> +#define S5PC110_GPIO_J3_NR	(8)
> +#define S5PC110_GPIO_J4_NR	(8)
> +#define S5PC110_GPIO_MP0_1_NR	(8)
> +#define S5PC110_GPIO_MP0_2_NR	(8)
> +#define S5PC110_GPIO_MP0_3_NR	(8)
> +#define S5PC110_GPIO_MP0_4_NR	(8)
> +#define S5PC110_GPIO_MP0_5_NR	(8)
> +#define S5PC110_GPIO_MP0_6_NR	(8)
> +
> +/* GPIO bank numbes */
> +
> +/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
> + * space for debugging purposes so that any accidental
> + * change from one gpio bank to another can be caught.
> +*/
> +
> +#define S5PC1XX_GPIO_NEXT(__gpio) \
> +	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
> +
> +enum s5pc110_gpio_number {
> +	S5PC110_GPIO_A0_START	= 0,
> +	S5PC110_GPIO_A1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_A0),
> +	S5PC110_GPIO_B_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_A1),
> +	S5PC110_GPIO_C0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_B),
> +	S5PC110_GPIO_C1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_C0),
> +	S5PC110_GPIO_D0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_C1),
> +	S5PC110_GPIO_D1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_D0),
> +	S5PC110_GPIO_E0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_D1),
> +	S5PC110_GPIO_E1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_E0),
> +	S5PC110_GPIO_F0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_E1),
> +	S5PC110_GPIO_F1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F0),
> +	S5PC110_GPIO_F2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F1),
> +	S5PC110_GPIO_F3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F2),
> +	S5PC110_GPIO_G0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F3),
> +	S5PC110_GPIO_G1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G0),
> +	S5PC110_GPIO_G2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G1),
> +	S5PC110_GPIO_G3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G2),
> +	S5PC110_GPIO_H0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G3),
> +	S5PC110_GPIO_H1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H0),
> +	S5PC110_GPIO_H2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H1),
> +	S5PC110_GPIO_H3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H2),
> +	S5PC110_GPIO_I_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H3),
> +	S5PC110_GPIO_J0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_I),
> +	S5PC110_GPIO_J1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J0),
> +	S5PC110_GPIO_J2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J1),
> +	S5PC110_GPIO_J3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J2),
> +	S5PC110_GPIO_J4_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J3),
> +	S5PC110_GPIO_MP0_1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J4),
> +	S5PC110_GPIO_MP0_2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_1),
> +	S5PC110_GPIO_MP0_3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_2),
> +	S5PC110_GPIO_MP0_4_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_3),
> +	S5PC110_GPIO_MP0_5_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_4),
> +	S5PC110_GPIO_MP0_6_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_5),
> +	S5PC110_GPIO_END        = S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_6),
> +};
> +
> +#define S5PC110_GPA0(_nr)	(S5PC110_GPIO_A0_START + (_nr))
> +#define S5PC110_GPA1(_nr)	(S5PC110_GPIO_A1_START + (_nr))
> +#define S5PC110_GPB(_nr)	(S5PC110_GPIO_B_START + (_nr))
> +#define S5PC110_GPC0(_nr)	(S5PC110_GPIO_C0_START + (_nr))
> +#define S5PC110_GPC1(_nr)	(S5PC110_GPIO_C1_START + (_nr))
> +#define S5PC110_GPD0(_nr)	(S5PC110_GPIO_D0_START + (_nr))
> +#define S5PC110_GPD1(_nr)	(S5PC110_GPIO_D1_START + (_nr))
> +#define S5PC110_GPE0(_nr)	(S5PC110_GPIO_E0_START + (_nr))
> +#define S5PC110_GPE1(_nr)	(S5PC110_GPIO_E1_START + (_nr))
> +#define S5PC110_GPF0(_nr)	(S5PC110_GPIO_F0_START + (_nr))
> +#define S5PC110_GPF1(_nr)	(S5PC110_GPIO_F1_START + (_nr))
> +#define S5PC110_GPF2(_nr)	(S5PC110_GPIO_F2_START + (_nr))
> +#define S5PC110_GPF3(_nr)	(S5PC110_GPIO_F3_START + (_nr))
> +#define S5PC110_GPG0(_nr)	(S5PC110_GPIO_G0_START + (_nr))
> +#define S5PC110_GPG1(_nr)	(S5PC110_GPIO_G1_START + (_nr))
> +#define S5PC110_GPG2(_nr)	(S5PC110_GPIO_G2_START + (_nr))
> +#define S5PC110_GPG3(_nr)	(S5PC110_GPIO_G3_START + (_nr))
> +#define S5PC110_GPH0(_nr)	(S5PC110_GPIO_H0_START + (_nr))
> +#define S5PC110_GPH1(_nr)	(S5PC110_GPIO_H1_START + (_nr))
> +#define S5PC110_GPH2(_nr)	(S5PC110_GPIO_H2_START + (_nr))
> +#define S5PC110_GPH3(_nr)	(S5PC110_GPIO_H3_START + (_nr))
> +#define S5PC110_GPI(_nr)	(S5PC110_GPIO_I_START + (_nr))
> +#define S5PC110_GPJ0(_nr)	(S5PC110_GPIO_J0_START + (_nr))
> +#define S5PC110_GPJ1(_nr)	(S5PC110_GPIO_J1_START + (_nr))
> +#define S5PC110_GPJ2(_nr)	(S5PC110_GPIO_J2_START + (_nr))
> +#define S5PC110_GPJ3(_nr)	(S5PC110_GPIO_J3_START + (_nr))
> +#define S5PC110_GPJ4(_nr)	(S5PC110_GPIO_J4_START + (_nr))
> +#define S5PC110_MP0_1(_nr)	(S5PC110_GPIO_MP0_1_START + (_nr))
> +#define S5PC110_MP0_2(_nr)	(S5PC110_GPIO_MP0_2_START + (_nr))
> +#define S5PC110_MP0_3(_nr)	(S5PC110_GPIO_MP0_3_START + (_nr))
> +#define S5PC110_MP0_4(_nr)	(S5PC110_GPIO_MP0_4_START + (_nr))
> +#define S5PC110_MP0_5(_nr)	(S5PC110_GPIO_MP0_5_START + (_nr))
> +#define S5PC110_MP0_6(_nr)	(S5PC110_GPIO_MP0_6_START + (_nr))
> +
> +/* It used the end of the S5PC100 gpios */
> +#define S3C_GPIO_END		S5PC110_GPIO_END
> +
> +/* define the number of gpios we need to the one after the MP05() range */
> +#define ARCH_NR_GPIOS		(S5PC110_GPIO_END + 1)
> +
> +/* Common compatibility defines */
> +#define S5PC1XX_GPIO_EINT_SFN	S3C_GPIO_SFN(0xf)
> +#define S5PC1XX_GPH0(n)		S5PC110_GPH0(n)
> +#define S5PC1XX_GPH1(n)		S5PC110_GPH1(n)
> +#define S5PC1XX_GPH2(n)		S5PC110_GPH2(n)
> +#define S5PC1XX_GPH3(n)		S5PC110_GPH3(n)
> +
> +#include <asm-generic/gpio.h>
> diff --git a/arch/arm/mach-s5pc110/include/plat/regs-gpio.h b/arch/arm/mach-s5pc110/include/plat/regs-gpio.h
> new file mode 100644
> index 0000000..24663b8
> --- /dev/null
> +++ b/arch/arm/mach-s5pc110/include/plat/regs-gpio.h
> @@ -0,0 +1,65 @@
> +/* linux/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
> + *
> + * Copyright 2009 Samsung Electronics Co.
> + *      Byungho Min <bhmin@samsung.com>
> + *
> + * S5PC110 - GPIO register definitions
> + */
> +
> +#ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
> +#define __ASM_PLAT_S5PC1XX_REGS_GPIO_H __FILE__
> +
> +#include <mach/map.h>
> +
> +/* S5PC110 */
> +#define S5PC110_GPIO_BASE	S5PC1XX_VA_GPIO
> +#define S5PC110_GPA0_BASE	(S5PC110_GPIO_BASE + 0x0000)
> +#define S5PC110_GPA1_BASE	(S5PC110_GPIO_BASE + 0x0020)
> +#define S5PC110_GPB_BASE	(S5PC110_GPIO_BASE + 0x0040)
> +#define S5PC110_GPC0_BASE	(S5PC110_GPIO_BASE + 0x0060)
> +#define S5PC110_GPC1_BASE	(S5PC110_GPIO_BASE + 0x0080)
> +#define S5PC110_GPD0_BASE	(S5PC110_GPIO_BASE + 0x00A0)
> +#define S5PC110_GPD1_BASE	(S5PC110_GPIO_BASE + 0x00C0)
> +#define S5PC110_GPE0_BASE	(S5PC110_GPIO_BASE + 0x00E0)
> +#define S5PC110_GPE1_BASE	(S5PC110_GPIO_BASE + 0x0100)
> +#define S5PC110_GPF0_BASE	(S5PC110_GPIO_BASE + 0x0120)
> +#define S5PC110_GPF1_BASE	(S5PC110_GPIO_BASE + 0x0140)
> +#define S5PC110_GPF2_BASE	(S5PC110_GPIO_BASE + 0x0160)
> +#define S5PC110_GPF3_BASE	(S5PC110_GPIO_BASE + 0x0180)
> +#define S5PC110_GPG0_BASE	(S5PC110_GPIO_BASE + 0x01A0)
> +#define S5PC110_GPG1_BASE	(S5PC110_GPIO_BASE + 0x01C0)
> +#define S5PC110_GPG2_BASE	(S5PC110_GPIO_BASE + 0x01E0)
> +#define S5PC110_GPG3_BASE	(S5PC110_GPIO_BASE + 0x0200)
> +#define S5PC110_GPH0_BASE	(S5PC110_GPIO_BASE + 0x0C00)
> +#define S5PC110_GPH1_BASE	(S5PC110_GPIO_BASE + 0x0C20)
> +#define S5PC110_GPH2_BASE	(S5PC110_GPIO_BASE + 0x0C40)
> +#define S5PC110_GPH3_BASE	(S5PC110_GPIO_BASE + 0x0C60)
> +#define S5PC110_GPI_BASE	(S5PC110_GPIO_BASE + 0x0220)
> +#define S5PC110_GPJ0_BASE	(S5PC110_GPIO_BASE + 0x0240)
> +#define S5PC110_GPJ1_BASE	(S5PC110_GPIO_BASE + 0x0260)
> +#define S5PC110_GPJ2_BASE	(S5PC110_GPIO_BASE + 0x0280)
> +#define S5PC110_GPJ3_BASE	(S5PC110_GPIO_BASE + 0x02A0)
> +#define S5PC110_GPJ4_BASE	(S5PC110_GPIO_BASE + 0x02C0)
> +#define S5PC110_MP0_1_BASE	(S5PC110_GPIO_BASE + 0x02E0)
> +#define S5PC110_MP0_2_BASE	(S5PC110_GPIO_BASE + 0x0300)
> +#define S5PC110_MP0_3_BASE	(S5PC110_GPIO_BASE + 0x0320)
> +#define S5PC110_MP0_4_BASE	(S5PC110_GPIO_BASE + 0x0340)
> +#define S5PC110_MP0_5_BASE	(S5PC110_GPIO_BASE + 0x0360)
> +#define S5PC110_EXT_INT_BASE	(S5PC110_GPIO_BASE + 0x0E00)
> +#define S5PC110_PDNEN		(S5PC110_GPIO_BASE + 0x0F80)
> +#define S5PC100_PDNEN_NORMAL	(0 << 0)
> +
> +#define S5PC110_PDNEN_CFG_PDNEN	(1 << 1)
> +#define S5PC110_PDNEN_CFG_AUTO	(0 << 1)
> +#define S5PC110_PDNEN_POWERDOWN	(1 << 0)
> +#define S5PC110_PDNEN_NORMAL	(0 << 0)
> +
> +/* Common part */
> +#define S5PC1XX_EINT_BASE	(S5PC110_EXT_INT_BASE)
> +
> +#define S5PC1XX_GPx_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
> +#define S5PC1XX_GPx_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
> +#define S5PC1XX_GPx_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
> +
> +#endif /* __ASM_PLAT_S5PC1XX_REGS_GPIO_H */
> +
> diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/plat-s5pc1xx/gpiolib.c
> index 60bf31d..2cd095c 100644
> --- a/arch/arm/plat-s5pc1xx/gpiolib.c
> +++ b/arch/arm/plat-s5pc1xx/gpiolib.c
> @@ -453,6 +453,272 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
>  #define s5pc1xx_gpio_chips s5pc100_gpio_chips
>  
>  #endif
> +
> +#ifdef CONFIG_CPU_S5PC110

this amount of #ifdef screams seperate file.

> +static struct s3c_gpio_chip s5pc110_gpio_chips[] = {
> +	{
> +		.base	= S5PC110_GPA0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPA0(0),
> +			.ngpio	= S5PC110_GPIO_A0_NR,
> +			.label	= "GPA0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPA1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPA1(0),
> +			.ngpio	= S5PC110_GPIO_A1_NR,
> +			.label	= "GPA1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPB_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPB(0),
> +			.ngpio	= S5PC110_GPIO_B_NR,
> +			.label	= "GPB",
> +		},
> +	}, {
> +		.base	= S5PC110_GPC0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPC0(0),
> +			.ngpio	= S5PC110_GPIO_C0_NR,
> +			.label	= "GPC0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPC1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPC1(0),
> +			.ngpio	= S5PC110_GPIO_C1_NR,
> +			.label	= "GPC1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPD0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPD0(0),
> +			.ngpio	= S5PC110_GPIO_D0_NR,
> +			.label	= "GPD0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPD1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPD1(0),
> +			.ngpio	= S5PC110_GPIO_D1_NR,
> +			.label	= "GPD1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPE0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPE0(0),
> +			.ngpio	= S5PC110_GPIO_E0_NR,
> +			.label	= "GPE0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPE1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPE1(0),
> +			.ngpio	= S5PC110_GPIO_E1_NR,
> +			.label	= "GPE1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPF0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPF0(0),
> +			.ngpio	= S5PC110_GPIO_F0_NR,
> +			.label	= "GPF0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPF1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPF1(0),
> +			.ngpio	= S5PC110_GPIO_F1_NR,
> +			.label	= "GPF1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPF2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPF2(0),
> +			.ngpio	= S5PC110_GPIO_F2_NR,
> +			.label	= "GPF2",
> +		},
> +	}, {
> +		.base	= S5PC110_GPF3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPF3(0),
> +			.ngpio	= S5PC110_GPIO_F3_NR,
> +			.label	= "GPF3",
> +		},
> +	}, {
> +		.base	= S5PC110_GPG0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPG0(0),
> +			.ngpio	= S5PC110_GPIO_G0_NR,
> +			.label	= "GPG0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPG1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPG1(0),
> +			.ngpio	= S5PC110_GPIO_G1_NR,
> +			.label	= "GPG1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPG2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPG2(0),
> +			.ngpio	= S5PC110_GPIO_G2_NR,
> +			.label	= "GPG2",
> +		},
> +	}, {
> +		.base	= S5PC110_GPG3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPG3(0),
> +			.ngpio	= S5PC110_GPIO_G3_NR,
> +			.label	= "GPG3",
> +		},
> +	}, {
> +		.base	= S5PC110_GPH0_BASE,
> +		.config	= &gpio_cfg_eint,
> +		.chip	= {
> +			.base	= S5PC110_GPH0(0),
> +			.ngpio	= S5PC110_GPIO_H0_NR,
> +			.label	= "GPH0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPH1_BASE,
> +		.config	= &gpio_cfg_eint,
> +		.chip	= {
> +			.base	= S5PC110_GPH1(0),
> +			.ngpio	= S5PC110_GPIO_H1_NR,
> +			.label	= "GPH1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPH2_BASE,
> +		.config	= &gpio_cfg_eint,
> +		.chip	= {
> +			.base	= S5PC110_GPH2(0),
> +			.ngpio	= S5PC110_GPIO_H2_NR,
> +			.label	= "GPH2",
> +		},
> +	}, {
> +		.base	= S5PC110_GPH3_BASE,
> +		.config	= &gpio_cfg_eint,
> +		.chip	= {
> +			.base	= S5PC110_GPH3(0),
> +			.ngpio	= S5PC110_GPIO_H3_NR,
> +			.label	= "GPH3",
> +		},
> +	}, {
> +		.base	= S5PC110_GPI_BASE,
> +		.config	= &gpio_cfg_noint,
> +		.chip	= {
> +			.base	= S5PC110_GPI(0),
> +			.ngpio	= S5PC110_GPIO_I_NR,
> +			.label	= "GPI",
> +		},
> +	}, {
> +		.base	= S5PC110_GPJ0_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPJ0(0),
> +			.ngpio	= S5PC110_GPIO_J0_NR,
> +			.label	= "GPJ0",
> +		},
> +	}, {
> +		.base	= S5PC110_GPJ1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPJ1(0),
> +			.ngpio	= S5PC110_GPIO_J1_NR,
> +			.label	= "GPJ1",
> +		},
> +	}, {
> +		.base	= S5PC110_GPJ2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPJ2(0),
> +			.ngpio	= S5PC110_GPIO_J2_NR,
> +			.label	= "GPJ2",
> +		},
> +	}, {
> +		.base	= S5PC110_GPJ3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPJ3(0),
> +			.ngpio	= S5PC110_GPIO_J3_NR,
> +			.label	= "GPJ3",
> +		},
> +	}, {
> +		.base	= S5PC110_GPJ4_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_GPJ4(0),
> +			.ngpio	= S5PC110_GPIO_J4_NR,
> +			.label	= "GPJ4",
> +		},
> +	}, {
> +		.base	= S5PC110_MP0_1_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_MP0_1(0),
> +			.ngpio	= S5PC110_GPIO_MP0_1_NR,
> +			.label	= "MP0_1",
> +		},
> +	}, {
> +		.base	= S5PC110_MP0_2_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_MP0_2(0),
> +			.ngpio	= S5PC110_GPIO_MP0_2_NR,
> +			.label	= "MP0_2",
> +		},
> +	}, {
> +		.base	= S5PC110_MP0_3_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_MP0_3(0),
> +			.ngpio	= S5PC110_GPIO_MP0_3_NR,
> +			.label	= "MP0_3",
> +		},
> +	}, {
> +		.base	= S5PC110_MP0_4_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_MP0_4(0),
> +			.ngpio	= S5PC110_GPIO_MP0_4_NR,
> +			.label	= "MP0_4",
> +		},
> +	}, {
> +		.base	= S5PC110_MP0_5_BASE,
> +		.config	= &gpio_cfg,
> +		.chip	= {
> +			.base	= S5PC110_MP0_5(0),
> +			.ngpio	= S5PC110_GPIO_MP0_5_NR,
> +			.label	= "MP0_5",
> +		},
> +	},
> +};
> +
> +#define s5pc1xx_gpio_chips s5pc110_gpio_chips
> +
> +#endif
> +
>  /* FIXME move from irq-gpio.c */
>  extern struct irq_chip s5pc1xx_gpioint;
>  extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
> diff --git a/arch/arm/plat-s5pc1xx/irq-gpio.c b/arch/arm/plat-s5pc1xx/irq-gpio.c
> index f5d8dab..b13308f 100644
> --- a/arch/arm/plat-s5pc1xx/irq-gpio.c
> +++ b/arch/arm/plat-s5pc1xx/irq-gpio.c
> @@ -142,6 +142,116 @@ static int s5pc100_group_end = 21;
>  
>  #endif
>  
> +#ifdef CONFIG_CPU_S5PC110

these follwing functions could have had their info added to an extended
gpio structure, say struct s5p_gpio_chip and had a s3c_gpio_chip embededded in
it, which would make the code simpler,

ie:

struct s5p_gpio_chip {
       struct s3c_gpio_chip chip;
       unsigned int 	    gpio_start;
       unsigned int 	    gpio_groupl
};

and then you could have gone chip->info easily.

> +static int s5pc110_get_start(unsigned int group)
> +{
> +	switch (group) {
> +	case 0: return S5PC110_GPIO_A0_START;
> +	case 1: return S5PC110_GPIO_A1_START;
> +	case 2: return S5PC110_GPIO_B_START;
> +	case 3: return S5PC110_GPIO_C0_START;
> +	case 4: return S5PC110_GPIO_C1_START;
> +	case 5: return S5PC110_GPIO_D0_START;
> +	case 6: return S5PC110_GPIO_D1_START;
> +	case 7: return S5PC110_GPIO_E0_START;
> +	case 8: return S5PC110_GPIO_E1_START;
> +	case 9: return S5PC110_GPIO_F0_START;
> +	case 10: return S5PC110_GPIO_F1_START;
> +	case 11: return S5PC110_GPIO_F2_START;
> +	case 12: return S5PC110_GPIO_F3_START;
> +	case 13: return S5PC110_GPIO_G0_START;
> +	case 14: return S5PC110_GPIO_G1_START;
> +	case 15: return S5PC110_GPIO_G2_START;
> +	case 16: return S5PC110_GPIO_G3_START;
> +	case 17: return S5PC110_GPIO_J0_START;
> +	case 18: return S5PC110_GPIO_J1_START;
> +	case 19: return S5PC110_GPIO_J2_START;
> +	case 20: return S5PC110_GPIO_J3_START;
> +	case 21: return S5PC110_GPIO_J4_START;
> +	case 22: return S5PC110_GPIO_MP0_1_START;
> +	case 23: return S5PC110_GPIO_MP0_2_START;
> +	case 24: return S5PC110_GPIO_MP0_3_START;
> +	case 25: return S5PC110_GPIO_MP0_4_START;
> +	case 26: return S5PC110_GPIO_MP0_5_START;
> +	default:
> +		BUG();
> +	}
> +	return -EINVAL;
> +}
> +
> +static int s5pc110_get_group(unsigned int irq)
> +{
> +	irq -= S3C_IRQ_GPIO(0);
> +
> +	switch (irq) {
> +	case S5PC110_GPIO_A0_START ... S5PC110_GPIO_A1_START - 1:
> +		return 0;
> +	case S5PC110_GPIO_A1_START ... S5PC110_GPIO_B_START - 1:
> +		return 1;
> +	case S5PC110_GPIO_B_START ... S5PC110_GPIO_C0_START - 1:
> +		return 2;
> +	case S5PC110_GPIO_C0_START ... S5PC110_GPIO_C1_START - 1:
> +		return 3;
> +	case S5PC110_GPIO_C1_START ... S5PC110_GPIO_D0_START - 1:
> +		return 4;
> +	case S5PC110_GPIO_D0_START ... S5PC110_GPIO_D1_START - 1:
> +		return 5;
> +	case S5PC110_GPIO_D1_START ... S5PC110_GPIO_E0_START - 1:
> +		return 6;
> +	case S5PC110_GPIO_E0_START ... S5PC110_GPIO_E1_START - 1:
> +		return 7;
> +	case S5PC110_GPIO_E1_START ... S5PC110_GPIO_F0_START - 1:
> +		return 8;
> +	case S5PC110_GPIO_F0_START ... S5PC110_GPIO_F1_START - 1:
> +		return 9;
> +	case S5PC110_GPIO_F1_START ... S5PC110_GPIO_F2_START - 1:
> +		return 10;
> +	case S5PC110_GPIO_F2_START ... S5PC110_GPIO_F3_START - 1:
> +		return 11;
> +	case S5PC110_GPIO_F3_START ... S5PC110_GPIO_G0_START - 1:
> +		return 12;
> +	case S5PC110_GPIO_G0_START ... S5PC110_GPIO_G1_START - 1:
> +		return 13;
> +	case S5PC110_GPIO_G1_START ... S5PC110_GPIO_G2_START - 1:
> +		return 14;
> +	case S5PC110_GPIO_G2_START ... S5PC110_GPIO_G3_START - 1:
> +		return 15;
> +	case S5PC110_GPIO_G3_START ... S5PC110_GPIO_H0_START - 1:
> +		return 16;
> +	case S5PC110_GPIO_J0_START ... S5PC110_GPIO_J1_START - 1:
> +		return 17;
> +	case S5PC110_GPIO_J1_START ... S5PC110_GPIO_J2_START - 1:
> +		return 18;
> +	case S5PC110_GPIO_J2_START ... S5PC110_GPIO_J3_START - 1:
> +		return 19;
> +	case S5PC110_GPIO_J3_START ... S5PC110_GPIO_J4_START - 1:
> +		return 20;
> +	case S5PC110_GPIO_J4_START ... S5PC110_GPIO_MP0_1_START - 1:
> +		return 21;
> +	case S5PC110_GPIO_MP0_1_START ... S5PC110_GPIO_MP0_2_START - 1:
> +		return 22;
> +	case S5PC110_GPIO_MP0_2_START ... S5PC110_GPIO_MP0_3_START - 1:
> +		return 23;
> +	case S5PC110_GPIO_MP0_3_START ... S5PC110_GPIO_MP0_4_START - 1:
> +		return 24;
> +	case S5PC110_GPIO_MP0_4_START ... S5PC110_GPIO_MP0_5_START - 1:
> +		return 25;
> +	case S5PC110_GPIO_MP0_5_START ... S5PC110_GPIO_MP0_6_START - 1:
> +		return 26;
> +	default:
> +		BUG();
> +	}
> +	return -EINVAL;
> +}
> +
> +static int s5pc110_group_end = 27;
> +
> +#define s5pc1xx_get_group s5pc110_get_group
> +#define s5pc1xx_get_start s5pc110_get_start
> +#define s5pc1xx_group_end s5pc110_group_end
> +
> +#endif
> +
>  static int s5pc1xx_get_offset(unsigned int irq)
>  {
>  	struct gpio_chip *chip = get_irq_data(irq);
> -- 
> 1.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
