From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 03 Jun 2016 14:51:49 +0200
Subject: [RFC PATCH v1 1/6] rockchip: rockchip: add new clock-type for the
 ddrclk
In-Reply-To: <1464947719-6245-2-git-send-email-hl@rock-chips.com>
References: <1464947719-6245-1-git-send-email-hl@rock-chips.com>
 <1464947719-6245-2-git-send-email-hl@rock-chips.com>
Message-ID: <1663829.Hlc2xmNrOy@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. Juni 2016, 17:55:14 schrieb Lin Huang:
> On new rockchip platform(rk3399 etc), there have dcf controller to
> do ddr frequency scaling, and this controller will implement in
> arm-trust-firmware. We add a special clock-type to handle that.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v1:
> - None
> 
>  drivers/clk/rockchip/Makefile  |   1 +
>  drivers/clk/rockchip/clk-ddr.c | 147
> +++++++++++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.c     | 
>  9 +++
>  drivers/clk/rockchip/clk.h     |  27 ++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-ddr.c
> 
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index f47a2fa..b5f2c8e 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -8,6 +8,7 @@ obj-y	+= clk-pll.o
>  obj-y	+= clk-cpu.o
>  obj-y	+= clk-inverter.o
>  obj-y	+= clk-mmc-phase.o
> +obj-y	+= clk-ddr.o
>  obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
> 
>  obj-y	+= clk-rk3036.o
> diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
> new file mode 100644
> index 0000000..5b6630d
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-ddr.c
> @@ -0,0 +1,147 @@
> +/*
> + * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
> + * Author: Lin Huang <hl@rock-chips.com>
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
> + */
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include "clk.h"
> +
> +struct rockchip_ddrclk {
> +	struct clk_hw	hw;
> +	void __iomem	*reg_base;
> +	int		mux_offset;
> +	int		mux_shift;
> +	int		mux_width;
> +	int		mux_flag;
> +	int		div_shift;
> +	int		div_width;
> +	int		div_flag;
> +	spinlock_t	*lock;
> +};
> +
> +#define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk,
> hw)
> +#define val_mask(width)	((1 << (width)) - 1)

maybe use GENMASK?

> +
> +static int rockchip_ddrclk_set_rate(struct clk_hw *hw, unsigned long drate,
> +				    unsigned long prate)
> +{
> +	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(ddrclk->lock, flags);
> +
> +	/* TODO: set ddr rate in bl31 */

I expect this interface to be in existence and merged into the main ATF first.

Right now the whole clock-type does nothing more than a simple COMPOSITE with 
added CLK_DIVIDER_READ_ONLY | CLK_MUX_READ_ONLY.

Also Mike is propably still working in the so called coordinated rate change 
for clocks needing special handling on rate changes, which might provide a 
second approach to this.

So please, first of all get the ATF-interface merged and meanwhile if you need 
to read the clock-rate, just use a regular composite, with the read-only flags.


> +	spin_unlock_irqrestore(ddrclk->lock, flags);
> +
> +	return 0;
> +}
> +
> +static unsigned long
> +rockchip_ddrclk_recalc_rate(struct clk_hw *hw,
> +			    unsigned long parent_rate)
> +{
> +	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
> +	int val;
> +
> +	val = clk_readl(ddrclk->reg_base +
> +			ddrclk->mux_offset) >> ddrclk->div_shift;
> +	val &= val_mask(ddrclk->div_width);
> +
> +	return DIV_ROUND_UP_ULL((u64)parent_rate, val + 1);

return divider_recalc_rate(...)


Heiko
