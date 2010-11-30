From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 17:39:22 +0100
Subject: [PATCH 09/15] ARM: mxs: Add clock support
In-Reply-To: <1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101130163922.GT20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

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
Hmm, I would have used an approach that is quickly switchable to the
generic clock stuff posted a few times here.  But probably already too
late.  So it's up to you to decide when to switch (or if at all).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
