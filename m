From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Dec 2010 16:07:18 +0100
Subject: [PATCH 09/15] ARM: mxs: Add clock support
In-Reply-To: <1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101202150718.GS32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 02:49:08PM +0800, Shawn Guo wrote:
> Add clock for MXS-based SoCs, MX23 and MX28.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c          |  521 ++++++++++++++++++++++
>  arch/arm/mach-mxs/clock-mx28.c          |  732 +++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/clock.c               |  201 +++++++++
>  arch/arm/mach-mxs/include/mach/clkdev.h |    7 +
>  arch/arm/mach-mxs/include/mach/clock.h  |   64 +++
>  arch/arm/mach-mxs/regs-clkctrl-mx23.h   |  455 +++++++++++++++++++
>  arch/arm/mach-mxs/regs-clkctrl-mx28.h   |  663 ++++++++++++++++++++++++++++
>  7 files changed, 2643 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/clock-mx23.c
>  create mode 100644 arch/arm/mach-mxs/clock-mx28.c
>  create mode 100644 arch/arm/mach-mxs/clock.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/clkdev.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/clock.h
>  create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx23.h
>  create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx28.h
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> new file mode 100644
> index 0000000..832db0b
> --- /dev/null
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -0,0 +1,521 @@
> +/*
> + * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <asm/clkdev.h>
> +#include <asm/div64.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/clock.h>
> +
> +#include "regs-clkctrl-mx23.h"
> +
> +#define CLKCTRL_BASE_ADDR	MX23_IO_ADDRESS(MX23_CLKCTRL_BASE_ADDR)
> +#define DIGCTRL_BASE_ADDR	MX23_IO_ADDRESS(MX23_DIGCTL_BASE_ADDR)
> +
> +static int _raw_clk_enable(struct clk *clk)
> +{
> +	u32 reg;
> +
> +	if (clk->enable_reg) {
> +		reg = __raw_readl(clk->enable_reg);
> +		reg &= ~(1 << clk->enable_shift);
> +		__raw_writel(reg, clk->enable_reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static void _raw_clk_disable(struct clk *clk)
> +{
> +	u32 reg;
> +
> +	if (clk->enable_reg) {
> +		reg = __raw_readl(clk->enable_reg);
> +		reg |= 1 << clk->enable_shift;
> +		__raw_writel(reg, clk->enable_reg);
> +	}
> +}
> +
> +/*
> + * ref_xtal_clk
> + */
> +static unsigned long ref_xtal_clk_get_rate(struct clk *clk)
> +{
> +	return 24000000;
> +}
> +
> +static struct clk ref_xtal_clk = {
> +	.get_rate = ref_xtal_clk_get_rate,
> +};
> +
> +/*
> + * pll_clk
> + */
> +static unsigned long pll_clk_get_rate(struct clk *clk)
> +{
> +	return 480000000;
> +}
> +
> +static int pll_clk_enable(struct clk *clk)
> +{
> +	__raw_writel(BM_CLKCTRL_PLLCTRL0_POWER |
> +			BM_CLKCTRL_PLLCTRL0_EN_USB_CLKS,
> +			CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLLCTRL0_SET);
> +
> +	/* Only a 10us delay is need. PLLCTRL1 LOCK bitfied is only a timer
> +	 * and is incorrect (excessive). Per definition of the PLLCTRL0
> +	 * POWER field, waiting at least 10us.
> +	 */
> +	udelay(10);
> +
> +	return 0;
> +}
> +
> +static void pll_clk_disable(struct clk *clk)
> +{
> +	__raw_writel(BM_CLKCTRL_PLLCTRL0_POWER |
> +			BM_CLKCTRL_PLLCTRL0_EN_USB_CLKS,
> +			CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLLCTRL0_CLR);
> +}
> +
> +static struct clk pll_clk = {
> +	 .get_rate = pll_clk_get_rate,
> +	 .enable = pll_clk_enable,
> +	 .disable = pll_clk_disable,
> +	 .parent = &ref_xtal_clk,
> +};
> +
> +/*
> + * ref_clk
> + */
> +#define _CLK_GET_RATE_REF(name, sr, ss)					\
> +static unsigned long name##_get_rate(struct clk *clk)			\
> +{									\
> +	unsigned long parent_rate;					\
> +	u32 reg, div;							\
> +									\
> +	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##sr);		\
> +	div = (reg >> BP_CLKCTRL_##sr##_##ss##FRAC) & 0x3f;		\
> +	parent_rate = clk_get_rate(clk->parent);			\
> +									\
> +	return parent_rate * 18 / div;					\
> +}
> +
> +_CLK_GET_RATE_REF(ref_cpu_clk, FRAC, CPU)
> +_CLK_GET_RATE_REF(ref_emi_clk, FRAC, EMI)
> +_CLK_GET_RATE_REF(ref_pix_clk, FRAC, PIX)
> +_CLK_GET_RATE_REF(ref_io_clk, FRAC, IO)
> +
> +#define _DEFINE_CLOCK_REF(name, er, es)					\
> +	static struct clk name = {					\
> +		.enable_reg	= CLKCTRL_BASE_ADDR + HW_CLKCTRL_##er,	\
> +		.enable_shift	= BP_CLKCTRL_##er##_CLKGATE##es,	\
> +		.get_rate	= name##_get_rate,			\
> +		.enable		= _raw_clk_enable,			\
> +		.disable	= _raw_clk_disable,			\
> +		.parent		= &pll_clk,				\
> +	}
> +
> +_DEFINE_CLOCK_REF(ref_cpu_clk, FRAC, CPU);
What happens if get_clock_rate(ref_cpu_clk) is called?:

	ref_cpu_clk_get_rate
		reg = something
		div = something else
		parent_rate = clk_get_rate(clk->parent)
			= pll_clk_get_rate() 
			= 480000000;
		return parent_rate * 18 / div
			= (480000000 * 18) / div
			= 0x202fbf000 / div
			= ...

Note that 0x202fbf000 is too big for an unsigned long so (AFAIK) this is
truncated to 0x02fbf000 / div which is wrong.

The same overflow happens in at least one set_rate function, too.

Either you have to switch to long long or (IMHO preferable) use shifted
values.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
