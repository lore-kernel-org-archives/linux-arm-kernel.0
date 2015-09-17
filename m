From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 17 Sep 2015 16:50:59 +0800
Subject: [PATCH v1 3/3] clk: rockchip: add clock controller for rk3036
In-Reply-To: <4606154.zK3r9vHTef@phil>
References: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
 <1440740808-15004-4-git-send-email-zhengxing@rock-chips.com>
 <4606154.zK3r9vHTef@phil>
Message-ID: <55FA7EF3.2010108@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?08?28? 17:54, Heiko Stuebner wrote:
> Hi,
>
> Am Freitag, 28. August 2015, 13:46:48 schrieb Xing Zheng:
>> Add the clock tree definition for the new rk3036 SoC,
>> but there are some issues to be fixed:
>> 1. soc will crash if gpll run rate_change_remuxed
>> 2. rk3036_clk_suspend and rk3036_clk_resume should be done
>>     in clk-rk3036.c
>>
>> ---
>>
>> Changes in v1:
>> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
>>
>>   drivers/clk/rockchip/Makefile          |    1 +
>>   drivers/clk/rockchip/clk-pll.c         |  247 ++++++++++++++-
> please split this into separate patches.
> - addition of the new pll type
> - three patches for binding-document, dt-binding header and clock controller
>    like in "clk: rockchip: add support for the clock-tree of the rk3368"
>    patches 4, 5 and 7:
>    "dt-bindings: add documentation of rk3036 clock controller"
>    "clk: rockchip: add dt-binding header for rk3036"
>    "clk: rockchip: add rk3036 clock controller"
>
>    so you should get in sum 4 clock patches.
>
> [0]http://lists.infradead.org/pipermail/linux-rockchip/2015-July/003394.html
OK.
>>   drivers/clk/rockchip/clk-rk3036.c      |  539
>> ++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.h             |
>> 30 ++
>>   include/dt-bindings/clock/rk3036-cru.h |  247 +++++++++++++++
>>   5 files changed, 1063 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clk/rockchip/clk-rk3036.c
>>   create mode 100644 include/dt-bindings/clock/rk3036-cru.h
>>
>> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
>> index b27edd6..d599829 100644
>> --- a/drivers/clk/rockchip/Makefile
>> +++ b/drivers/clk/rockchip/Makefile
>> @@ -10,6 +10,7 @@ obj-y	+= clk-inverter.o
>>   obj-y	+= clk-mmc-phase.o
>>   obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
>>
>> +obj-y	+= clk-rk3036.o
>>   obj-y	+= clk-rk3188.o
>>   obj-y	+= clk-rk3288.o
>>   obj-y	+= clk-rk3368.o
>> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
>> index 96903ae..cf56826 100644
>> --- a/drivers/clk/rockchip/clk-pll.c
>> +++ b/drivers/clk/rockchip/clk-pll.c
>> @@ -2,6 +2,9 @@
>>    * Copyright (c) 2014 MundoReader S.L.
>>    * Author: Heiko Stuebner<heiko@sntech.de>
>>    *
>> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
>> + * Author: Xing Zheng<zhengxing@rock-chips.com>
>> + *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License as published by
>>    * the Free Software Foundation; either version 2 of the License, or
>> @@ -48,6 +51,8 @@ struct rockchip_clk_pll {
>>   #define to_rockchip_clk_pll_nb(nb) \
>>   			container_of(nb, struct rockchip_clk_pll, clk_nb)
>>
>> +static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll);
>> +
>>   static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
>>   			    struct rockchip_clk_pll *pll, unsigned long rate)
>>   {
>> @@ -90,6 +95,11 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll
>> *pll) unsigned int val;
>>   	int delay = 24000000, ret;
>>
>> +	/* the plls of rk3036 wait lock */
>> +	if (pll->type == pll_rk3036 || pll->lock_offset == -1) {
>> +		return rockchip_rk3036_pll_wait_lock(pll);
>> +	}
>> +
> according to the rk3036 trm I have the GRF_SOC_STATUS0 [6:4] also contains the
> pll lock status like on the other socs. So you could just use the default
> mechanism of asking the GRF lock status like the other socs do, without
> needing to override the wait_lock .
Oh, sorry, I missed this advice. I will check and test on next version.
>
>>   	while (delay>  0) {
>>   		ret = regmap_read(grf, pll->lock_offset,&val);
>>   		if (ret) {
>> @@ -305,6 +315,235 @@ static void rockchip_rk3066_pll_init(struct clk_hw
>> *hw) rockchip_rk3066_pll_set_rate(hw, drate, prate);
>>   	}
>>   }
>> +/**
>> + * PLL used in RK3036
>> + */
>> +
>> +#define RK3036_PLL_RESET_DELAY(nr)	((nr * 500) / 24 + 1)
>> +
>> +#define RK3036_PLLCON(i)			(i * 0x4)
>> +#define RK3036_PLLCON0_FBDIV_MASK		0xfff
>> +#define RK3036_PLLCON0_FBDIV_SHIFT		0
>> +#define RK3036_PLLCON0_POSTDIV1_MASK		0x7
>> +#define RK3036_PLLCON0_POSTDIV1_SHIFT		12
>> +#define RK3036_PLLCON1_REFDIV_MASK		0x3f
>> +#define RK3036_PLLCON1_REFDIV_SHIFT		0
>> +#define RK3036_PLLCON1_POSTDIV2_MASK		0x7
>> +#define RK3036_PLLCON1_POSTDIV2_SHIFT		6
>> +#define RK3036_PLLCON1_DSMPD_MASK		0x1
>> +#define RK3036_PLLCON1_DSMPD_SHIFT		12
>> +#define RK3036_PLLCON2_FRAC_MASK		0xffffff
>> +#define RK3036_PLLCON2_FRAC_SHIFT		0
>> +
>> +#define RK3036_MODECON				0x40
>> +#define RK3036_MODECON_AWM			(1<<  0)  /* apll work mode */
>> +
>> +#define RK3036_PLLCON0_BYPASS			(1<<  15)
>> +#define RK3036_PLLCON1_LOCK_STATUS		(1<<  10)
>> +#define RK3036_PLLCON1_RESET			(1<<  14)
>> +
>> +static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll)
>> +{
>> +	u32 pllcon;
>> +	int delay = 24000000;
>> +
>> +	/* poll check the lock status in rk3036 xPLLCON1 */
>> +	while (delay>  0) {
>> +		pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
>> +		if (pllcon&  RK3036_PLLCON1_LOCK_STATUS)
>> +			return 0;
>> +
>> +		delay--;
>> +	}
>> +
>> +	pr_err("%s: timeout waiting for pll to lock\n", __func__);
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
>> +						     unsigned long prate)
>> +{
>> +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
>> +	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
>> +	u64 rate64 = prate;
>> +	u32 pllcon;
>> +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(0));
>> +	fbdiv = ((pllcon>>  RK3036_PLLCON0_FBDIV_SHIFT)&
>> RK3036_PLLCON0_FBDIV_MASK); +	postdiv1 = ((pllcon>>
>> RK3036_PLLCON0_POSTDIV1_SHIFT)&  RK3036_PLLCON0_POSTDIV1_MASK); +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
>> +	refdiv = ((pllcon>>  RK3036_PLLCON1_REFDIV_SHIFT)&
>> RK3036_PLLCON1_REFDIV_MASK); +	postdiv2 = ((pllcon>>
>> RK3036_PLLCON1_POSTDIV2_SHIFT)&  RK3036_PLLCON1_POSTDIV2_MASK); +	dsmpd =
>> ((pllcon>>  RK3036_PLLCON1_DSMPD_SHIFT)&  RK3036_PLLCON1_DSMPD_MASK); +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(2));
>> +	frac = ((pllcon>>  RK3036_PLLCON2_FRAC_SHIFT)&  RK3036_PLLCON2_FRAC_MASK);
>> +
>> +	rate64 *= fbdiv;
>> +	do_div(rate64, refdiv);
>> +
>> +	if (dsmpd == 0) {
>> +		/* fractional mode */
>> +		u64 frac_rate64 = prate * frac;
>> +
>> +		do_div(frac_rate64, refdiv);
>> +		rate64 += frac_rate64>>  24;
>> +	}
>> +
>> +	do_div(rate64, postdiv1);
>> +	do_div(rate64, postdiv2);
>> +
>> +	return (unsigned long)rate64;
>> +}
>> +
>> +static int rockchip_rk3036_pll_set_rate(struct clk_hw *hw, unsigned long
>> drate, +					unsigned long prate)
>> +{
>> +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
>> +	const struct rockchip_pll_rate_table *rate;
>> +	unsigned long old_rate = rockchip_rk3036_pll_recalc_rate(hw, prate);
>> +	struct regmap *grf = rockchip_clk_get_grf();
>> +	struct clk_mux *pll_mux =&pll->pll_mux;
>> +	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
>> +	int rate_change_remuxed = 0;
>> +	int cur_parent;
>> +	int ret;
>> +
>> +	if (IS_ERR(grf)) {
>> +		pr_debug("%s: grf regmap not available, aborting rate change\n",
>> +			 __func__);
>> +		return PTR_ERR(grf);
>> +	}
>> +
>> +	pr_debug("%s: changing %s from %lu to %lu with a parent rate of %lu\n",
>> +		 __func__, __clk_get_name(hw->clk), old_rate, drate, prate);
>> +
>> +	/* Get required rate settings from table */
>> +	rate = rockchip_get_pll_settings(pll, drate);
>> +	if (!rate) {
>> +		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
>> +			drate, __clk_get_name(hw->clk));
>> +		return -EINVAL;
>> +	}
>> +
>> +	pr_debug("%s: rate settings for %lu fbdiv: %d, postdiv1: %d, refdiv: %d,
>> postdiv2: %d, dsmpd: %d, frac: %d\n", +		__func__, rate->rate,
>> +		rate->fbdiv, rate->postdiv1, rate->refdiv, rate->postdiv2, rate-
>> dsmpd,
>> rate->frac); +
>> +	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
>> +	if (cur_parent == PLL_MODE_NORM) {
>> +		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
>> +		rate_change_remuxed = 1;
>> +	}
>> +
>> +	/* enter reset mode */
>> +	writel(HIWORD_UPDATE(1, RK3036_PLLCON1_RESET, 0), pll->reg_base +
>> RK3036_PLLCON(1)); +
>> +	/* update pll values */
>> +	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MASK,
>> +					  RK3036_PLLCON0_FBDIV_SHIFT) |
>> +		       HIWORD_UPDATE(rate->postdiv1, RK3036_PLLCON0_POSTDIV1_MASK,
>> +					     RK3036_PLLCON0_POSTDIV1_SHIFT),
>> +		       pll->reg_base + RK3036_PLLCON(0));
>> +
>> +	writel_relaxed(HIWORD_UPDATE(rate->refdiv, RK3036_PLLCON1_REFDIV_MASK,
>> +						   RK3036_PLLCON1_REFDIV_SHIFT) |
>> +		       HIWORD_UPDATE(rate->postdiv2, RK3036_PLLCON1_POSTDIV2_MASK,
>> +						     RK3036_PLLCON1_POSTDIV2_SHIFT) |
>> +		       HIWORD_UPDATE(rate->dsmpd, RK3036_PLLCON1_DSMPD_MASK,
>> +						  RK3036_PLLCON1_DSMPD_SHIFT),
>> +		       pll->reg_base + RK3036_PLLCON(1));
>> +
>> +	writel_relaxed(HIWORD_UPDATE(rate->frac, RK3036_PLLCON2_FRAC_MASK,
>> +						 RK3036_PLLCON2_FRAC_SHIFT),
>> +		       pll->reg_base + RK3036_PLLCON(2));
>> +
>> +	/* recover normal mode and wait the reset_delay */
>> +	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_RESET, 0), pll->reg_base +
>> RK3036_PLLCON(1)); +	udelay(RK3036_PLL_RESET_DELAY(rate->refdiv));
>> +
>> +	/* wait for the pll to lock */
>> +	ret = rockchip_pll_wait_lock(pll);
>> +	if (ret) {
>> +		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
>> +			__func__, old_rate);
>> +		rockchip_rk3036_pll_set_rate(hw, old_rate, prate);
>> +	}
>> +
>> +#if 0 /* FIXME: soc will crash if gpll run here */
>> +	if (rate_change_remuxed)
>> +		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_NORM);
>> +#endif
> please don't leave commented code ("if 0") around and we should of course find
> out what is failing beforehand, so this can be enabled again.
>
> Because as the code stands now, you're running on the gpll all the time.
Done.
>> +
>> +	return ret;
>> +}
>> +static void rockchip_rk3036_pll_init(struct clk_hw *hw)
>> +{
>> +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
>> +	const struct rockchip_pll_rate_table *rate;
>> +	unsigned int fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac;
>> +	unsigned long drate;
>> +	u32 pllcon;
>> +
>> +	if (!(pll->flags&  ROCKCHIP_PLL_SYNC_RATE))
>> +		return;
>> +
>> +	drate = __clk_get_rate(hw->clk);
>> +	rate = rockchip_get_pll_settings(pll, drate);
>> +
>> +	/* when no rate setting for the current rate, rely on clk_set_rate */
>> +	if (!rate)
>> +		return;
>> +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(0));
>> +	fbdiv = ((pllcon>>  RK3036_PLLCON0_FBDIV_SHIFT)&
>> RK3036_PLLCON0_FBDIV_MASK); +	postdiv1 = ((pllcon>>
>> RK3036_PLLCON0_POSTDIV1_SHIFT)&  RK3036_PLLCON0_POSTDIV1_MASK); +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
>> +	refdiv = ((pllcon>>  RK3036_PLLCON1_REFDIV_SHIFT)&
>> RK3036_PLLCON1_REFDIV_MASK); +	postdiv2 = ((pllcon>>
>> RK3036_PLLCON1_POSTDIV2_SHIFT)&  RK3036_PLLCON1_POSTDIV2_MASK); +	dsmpd =
>> ((pllcon>>  RK3036_PLLCON1_DSMPD_SHIFT)&  RK3036_PLLCON1_DSMPD_MASK); +
>> +	pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(2));
>> +	frac = ((pllcon>>  RK3036_PLLCON2_FRAC_SHIFT)&  RK3036_PLLCON2_FRAC_MASK);
>> +
>> +	pr_info("%s: pll %s@%lu: Hz\n", __func__, __clk_get_name(hw->clk), drate);
>> +	pr_info("old - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd:
>> %d, frac: %d\n", +		fbdiv, postdiv1, refdiv, postdiv2, dsmpd, frac);
>> +	pr_info("new - fbdiv: %d, postdiv1: %d, refdiv: %d, postdiv2: %d, dsmpd:
>> %d, frac: %d\n", +		rate->fbdiv, rate->postdiv1, rate->refdiv,
>> rate->postdiv2, rate->dsmpd, rate->frac);
> please don't leave pr_info calls for debug messages in the code, like in the
> rk3066 pll-type these should be pr_debug.
Done.
>> +
>> +	if (rate->fbdiv != fbdiv || rate->postdiv1 != postdiv1 || rate->refdiv !=
>> refdiv || +		rate->postdiv2 != postdiv2 || rate->dsmpd != dsmpd ||
>> rate->frac != frac) { +		struct clk *parent = __clk_get_parent(hw->clk);
>> +		unsigned long prate;
>> +
>> +		if (!parent) {
>> +			pr_warn("%s: parent of %s not available\n",
>> +				__func__, __clk_get_name(hw->clk));
>> +			return;
>> +		}
>> +
>> +		pr_info("%s: pll %s: rate params do not match rate table,
> adjusting\n",
>> +			 __func__, __clk_get_name(hw->clk));
>> +		prate = __clk_get_rate(parent);
>> +		rockchip_rk3036_pll_set_rate(hw, drate, prate);
>> +	}
>> +}
>> +static const struct clk_ops rockchip_rk3036_pll_clk_norate_ops = {
>> +	.recalc_rate = rockchip_rk3036_pll_recalc_rate,
>> +	.round_rate = rockchip_pll_round_rate,
>> +	.set_rate = rockchip_rk3036_pll_set_rate,
>> +	.init = rockchip_rk3036_pll_init,
>> +};
> the ops for plls without rate table should not contain round_rate and set_rate
> callbacks, as without rate-table you of course cannot set any rate
Done.
>> +
>> +static const struct clk_ops rockchip_rk3036_pll_clk_ops = {
>> +	.recalc_rate = rockchip_rk3036_pll_recalc_rate,
>> +	.round_rate = rockchip_pll_round_rate,
>> +	.set_rate = rockchip_rk3036_pll_set_rate,
>> +	.init = rockchip_rk3036_pll_init,
>> +};
> The rk3036 pll-type also has a powerdown function it seems (xPLL_CON1[13]), so
> you can also add appropriate enable, disable and is_enabled callbacks for both
> ops structs.
Done.
>>   static const struct clk_ops rockchip_rk3066_pll_clk_norate_ops = {
>>   	.recalc_rate = rockchip_rk3066_pll_recalc_rate,
>> @@ -385,6 +624,12 @@ struct clk *rockchip_clk_register_pll(enum
>> rockchip_pll_type pll_type, else
>>   			init.ops =&rockchip_rk3066_pll_clk_ops;
>>   		break;
>> +	case pll_rk3036:
>> +		if (!pll->rate_table)
>> +			init.ops =&rockchip_rk3036_pll_clk_norate_ops;
>> +		else
>> +			init.ops =&rockchip_rk3036_pll_clk_ops;
>> +		break;
>>   	default:
>>   		pr_warn("%s: Unknown pll type for pll clk %s\n",
>>   			__func__, name);
>> @@ -408,7 +653,7 @@ struct clk *rockchip_clk_register_pll(enum
>> rockchip_pll_type pll_type, pll_mux->lock = lock;
>>   	pll_mux->hw.init =&init;
>>
>> -	if (pll_type == pll_rk3066)
>> +	if (pll_type == pll_rk3066 || pll_type == pll_rk3036)
>>   		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
>>
>>   	pll_clk = clk_register(NULL,&pll->hw);
>> diff --git a/drivers/clk/rockchip/clk-rk3036.c
>> b/drivers/clk/rockchip/clk-rk3036.c new file mode 100644
>> index 0000000..19cdf0e
>> --- /dev/null
>> +++ b/drivers/clk/rockchip/clk-rk3036.c
>> @@ -0,0 +1,539 @@
>> +/*
>> + * Copyright (c) 2014 MundoReader S.L.
>> + * Author: Heiko Stuebner<heiko@sntech.de>
>> + *
>> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
>> + * Author: Xing Zheng<zhengxing@rock-chips.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include<linux/clk-provider.h>
>> +#include<linux/of.h>
>> +#include<linux/of_address.h>
>> +#include<linux/syscore_ops.h>
>> +#include<dt-bindings/clock/rk3036-cru.h>
>> +#include "clk.h"
>> +
>> +enum rk3036_plls {
>> +	apll, dpll, gpll,
>> +};
>> +
>> +static struct rockchip_pll_rate_table rk3036_pll_rates[] = {
>> +	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
>> +	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1512000000, 1, 63, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1488000000, 1, 62, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1464000000, 1, 61, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1440000000, 1, 60, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1416000000, 1, 59, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1392000000, 1, 58, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1368000000, 1, 57, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1344000000, 1, 56, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1320000000, 1, 55, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1296000000, 1, 54, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1272000000, 1, 53, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1248000000, 1, 52, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1200000000, 1, 50, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1188000000, 2, 99, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1104000000, 1, 46, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1100000000, 12, 550, 1, 1, 1, 0),
>> +	RK3036_PLL_RATE(1008000000, 1, 84, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE(1000000000, 6, 500, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 984000000, 1, 82, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 960000000, 1, 80, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 936000000, 1, 78, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 912000000, 1, 76, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 900000000, 4, 300, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 888000000, 1, 74, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 864000000, 1, 72, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 840000000, 1, 70, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 816000000, 1, 68, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 800000000, 6, 400, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 700000000, 6, 350, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 696000000, 1, 58, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 600000000, 1, 75, 3, 1, 1, 0),
>> +	RK3036_PLL_RATE( 594000000, 2, 99, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 504000000, 1, 63, 3, 1, 1, 0),
>> +	RK3036_PLL_RATE( 500000000, 6, 250, 2, 1, 1, 0),
>> +	RK3036_PLL_RATE( 408000000, 1, 68, 2, 2, 1, 0),
>> +	RK3036_PLL_RATE( 312000000, 1, 52, 2, 2, 1, 0),
>> +	RK3036_PLL_RATE( 216000000, 1, 72, 4, 2, 1, 0),
>> +	RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
>> +	RK3036_PLL_RATE(0, 1, 0, 1, 1, 1, 0),
>> +	{ /* sentinel */ },
>> +};
>> +
>> +#define RK3036_DIV_CPU_MASK		0x1f
>> +#define RK3036_DIV_CPU_SHIFT		8
>> +
>> +#define RK3036_DIV_PERI_MASK		0xf
>> +#define RK3036_DIV_PERI_SHIFT		0
>> +#define RK3036_DIV_ACLK_MASK		0x7
>> +#define RK3036_DIV_ACLK_SHIFT		4
>> +#define RK3036_DIV_HCLK_MASK		0x3
>> +#define RK3036_DIV_HCLK_SHIFT		8
>> +#define RK3036_DIV_PCLK_MASK		0x7
>> +#define RK3036_DIV_PCLK_SHIFT		12
>> +
>> +#define RK3036_CLKSEL1(_core_periph_div)					\
>> +	{									\
>> +		.reg = RK2928_CLKSEL_CON(1),					\
>> +		.val = HIWORD_UPDATE(_core_periph_div, RK3036_DIV_PERI_MASK,	\
>> +				RK3036_DIV_PERI_SHIFT)				\
>> +	}
>> +
>> +#define RK3036_CPUCLK_RATE(_prate, _core_periph_div)			\
>> +	{								\
>> +		.prate = _prate,					\
>> +		.divs = {						\
>> +			RK3036_CLKSEL1(_core_periph_div),		\
>> +		},							\
>> +	}
>> +
>> +static struct rockchip_cpuclk_rate_table rk3036_cpuclk_rates[] __initdata =
>> { +	RK3036_CPUCLK_RATE(816000000, 4),
>> +	RK3036_CPUCLK_RATE(600000000, 4),
>> +	RK3036_CPUCLK_RATE(312000000, 4),
>> +};
> this seems to be missing divider settings for aclk_core? I only see the core-
> periph ones (for pclk_dbg) but not for aclk_core that is also sourced from the
> cpuclk?
Yes, I will check them again.
>
>> +
>> +static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
>> +	.core_reg = RK2928_CLKSEL_CON(0),
>> +	.div_core_shift = 0,
>> +	.div_core_mask = 0x1f,
>> +	.mux_core_shift = 7,
>> +};
>> +
>> +PNAME(mux_pll_p)		= { "xin24m", "xin24m" };
>> +
>> +PNAME(mux_armclk_p)		= { "apll", "gpll_armclk" };
>> +PNAME(mux_busclk_p)		= { "apll", "dpll_cpu", "gpll_cpu" };
>> +PNAME(mux_ddrphy_p)		= { "dpll_ddr", "gpll_ddr" };
>> +PNAME(mux_pll_src_3plls_p)	= { "apll", "dpll", "gpll" };
>> +PNAME(mux_timer_p)		= { "xin24m", "pclk_peri_src" };
>> +
>> +PNAME(mux_pll_src_apll_gpll_dpll_usb480m_p)	= { "apll", "gpll", "dpll"
>> "usb480m" }; +
>> +PNAME(mux_mmc_src_p)	= { "apll", "gpll", "dpll", "xin24m" };
>> +PNAME(mux_i2s_pre_p)	= { "i2s_src", "i2s_frac", "ext_i2s", "xin12m" };
>> +PNAME(mux_i2s_clkout_p)	= { "i2s_pre", "xin12m" };
>> +PNAME(mux_spdif_p)	= { "spdif_src", "spdif_frac", "xin12m" };
>> +PNAME(mux_uart0_p)	= { "uart0_src", "uart0_frac", "xin24m" };
>> +PNAME(mux_uart1_p)	= { "uart1_src", "uart1_frac", "xin24m" };
>> +PNAME(mux_uart2_p)	= { "uart2_src", "uart2_frac", "xin24m" };
>> +PNAME(mux_mac_p)	= { "mac_pll_src", "ext_gmac" };
>> +PNAME(mux_dclk_p)	= { "dclk_lcdc", "dclk_hdmi_src" };
>> +
>> +static struct rockchip_pll_clock rk3036_pll_clks[] __initdata = {
>> +	[apll] = PLL(pll_rk3036, PLL_APLL, "apll", mux_pll_p, 0,
>> RK2928_PLL_CON(0), +		     RK2928_MODE_CON, 0, 10, 0, rk3036_pll_rates),
>> +	[dpll] = PLL(pll_rk3036, PLL_DPLL, "dpll", mux_pll_p, 0,
>> RK2928_PLL_CON(4), +		     RK2928_MODE_CON, 4, 10, 0, NULL),
>> +	[gpll] = PLL(pll_rk3036, PLL_GPLL, "gpll", mux_pll_p, 0,
>> RK2928_PLL_CON(12), +		     RK2928_MODE_CON, 12, 10,
>> ROCKCHIP_PLL_SYNC_RATE, rk3036_pll_rates), +};
>> +
>> +#define MFLAGS CLK_MUX_HIWORD_MASK
>> +#define DFLAGS CLK_DIVIDER_HIWORD_MASK
>> +#define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
>> +
>> +static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
>> +	/*
>> +	 * Clock-Architecture Diagram 1
>> +	 */
>> +
>> +	/* PD_CORE */
>> +	GATE(0, "gpll_armclk", "gpll", CLK_IGNORE_UNUSED,
>> +			RK2928_CLKGATE_CON(0), 6, GFLAGS),
>> +
>> +	/* PD_DDR */
>> +	GATE(0, "dpll_ddr", "dpll", CLK_IGNORE_UNUSED,
>> +			RK2928_CLKGATE_CON(0), 2, GFLAGS),
>> +	GATE(0, "gpll_ddr", "gpll", 0,
>> +			RK2928_CLKGATE_CON(0), 8, GFLAGS),
>> +	COMPOSITE_NOGATE(0, "ddrphy2x", mux_ddrphy_p, CLK_IGNORE_UNUSED,
>> +			RK2928_CLKSEL_CON(26), 8, 1, MFLAGS, 0, 2,
>> +					DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
> please keep the formatting. With the big number of clock definitions, reading
> is easier if everything stays in one place without additional line-breaks.
> So please move the "DFLAGS | ..." part up into the previous line. (same if
> this occures somewhere lese)
Done.
>
>> +
>> +	/* PD_CORE */
>> +	COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IGNORE_UNUSED,
>> +			RK2928_CLKSEL_CON(1), 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
>> +			RK2928_CLKGATE_CON(0), 7, GFLAGS),
>> +	COMPOSITE_NOMUX(0, "aclk_core_pre", "armclk", 0,
>> +			RK2928_CLKSEL_CON(1), 4, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
>> +			RK2928_CLKGATE_CON(0), 7, GFLAGS),
>> +
>> +	/* PD_CPU (BUS) */
>> +	GATE(0, "dpll_cpu", "dpll", 0, RK2928_CLKGATE_CON(10), 8, GFLAGS),
>> +	GATE(0, "gpll_cpu", "gpll", 0, RK2928_CLKGATE_CON(0), 1, GFLAGS),
>> +	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_busclk_p, 0,
>> +			RK2928_CLKSEL_CON(0), 14, 2, MFLAGS, 8, 5, DFLAGS),
>> +	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", 0, RK2928_CLKGATE_CON(0), 3,
>> GFLAGS), +	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", 0,
>> +			RK2928_CLKSEL_CON(1), 12, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
>> +			RK2928_CLKGATE_CON(0), 5, GFLAGS),
>> +	COMPOSITE_NOMUX(HCLK_CPU, "hclk_cpu", "aclk_cpu_src", 0,
>> +			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS | CLK_DIVIDER_READ_ONLY,
>> +			RK2928_CLKGATE_CON(0), 4, GFLAGS),
>> +
>> +	/* PD_PERI */
>> +	COMPOSITE(0, "aclk_peri_src", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 0, GFLAGS),
>> +
>> +	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
>> +			RK2928_CLKGATE_CON(2), 1, GFLAGS),
>> +	/* pclk_peri_src is soure for timers */
>> +	DIV(0, "pclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
>> +			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS |
> CLK_DIVIDER_POWER_OF_TWO),
>> +	GATE(PCLK_PERI, "pclk_peri", "pclk_peri_src", 0,
>> +			RK2928_CLKGATE_CON(2), 3, GFLAGS),
>> +	/* hclk_peri_src is soure for sclk_macref_out */
>> +	DIV(0, "hclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
>> +			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
>> +	GATE(HCLK_PERI, "hclk_peri", "hclk_peri_src", 0,
>> +			RK2928_CLKGATE_CON(2), 2, GFLAGS),
>> +
>> +	/* PD_TIMER */
>> +	COMPOSITE_NODIV(SCLK_TIMER0, "sclk_timer0", mux_timer_p, 0,
>> +			RK2928_CLKSEL_CON(2), 4, 1, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 0, GFLAGS),
>> +	COMPOSITE_NODIV(SCLK_TIMER1, "sclk_timer1", mux_timer_p, 0,
>> +			RK2928_CLKSEL_CON(2), 5, 1, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 1, GFLAGS),
>> +	COMPOSITE_NODIV(SCLK_TIMER2, "sclk_timer2", mux_timer_p, 0,
>> +			RK2928_CLKSEL_CON(2), 6, 1, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 4, GFLAGS),
>> +	COMPOSITE_NODIV(SCLK_TIMER3, "sclk_timer3", mux_timer_p, 0,
>> +			RK2928_CLKSEL_CON(2), 7, 1, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 5, GFLAGS),
>> +
>> +	/* PD_UART */
>> +	MUX(0, "uart_pll_clk", mux_pll_src_apll_gpll_dpll_usb480m_p, 0,
>> +			RK2928_CLKSEL_CON(13), 10, 2, MFLAGS),
>> +	COMPOSITE_NOMUX(0, "uart0_src", "uart_pll_clk", 0,
>> +			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 8, GFLAGS),
>> +	COMPOSITE_NOMUX(0, "uart1_src", "uart_pll_clk", 0,
>> +			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 8, GFLAGS),
>> +	COMPOSITE_NOMUX(0, "uart2_src", "uart_pll_clk", 0,
>> +			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 8, GFLAGS),
>> +	COMPOSITE_FRAC(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(17), 0,
>> +			RK2928_CLKGATE_CON(1), 9, GFLAGS),
>> +	COMPOSITE_FRAC(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(18), 0,
>> +			RK2928_CLKGATE_CON(1), 11, GFLAGS),
>> +	COMPOSITE_FRAC(0, "uart2_frac", "uart2_src", CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(19), 0,
>> +			RK2928_CLKGATE_CON(1), 13, GFLAGS),
>> +	MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(13), 8, 2, MFLAGS),
>> +	MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(14), 8, 2, MFLAGS),
>> +	MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(15), 8, 2, MFLAGS),
>> +
>> +	/* PD_VIDEO */
>> +	COMPOSITE(0, "aclk_vcodec", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(32), 14, 2, MFLAGS, 8, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(3), 11, GFLAGS),
>> +
>> +	COMPOSITE(0, "aclk_hvec", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(20), 0, 2, MFLAGS, 2, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(10), 6, GFLAGS),
>> +
>> +	/* PD_VIO */
>> +	COMPOSITE(0, "aclk_disp1_pre", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(1), 4, GFLAGS),
>> +	COMPOSITE(0, "hclk_disp_pre", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(30), 14, 2, MFLAGS, 8, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(0), 11, GFLAGS),
>> +	COMPOSITE(DCLK_LCDC, "dclk_lcdc", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(28), 0, 2, MFLAGS, 8, 8, DFLAGS,
>> +			RK2928_CLKGATE_CON(3), 2, GFLAGS),
>> +
>> +	/* MMC */
>> +	COMPOSITE_NODIV(0, "sclk_sdmmc_src", mux_mmc_src_p, 0,
>> +			RK2928_CLKSEL_CON(12), 8, 2, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 11, GFLAGS),
>> +	DIV(SCLK_SDMMC, "sclk_sdmmc", "sclk_sdmmc_src", 0,
>> +			RK2928_CLKSEL_CON(11), 0, 7, DFLAGS),
>> +
>> +	COMPOSITE_NODIV(0, "sclk_sdio_src", mux_mmc_src_p, 0,
>> +			RK2928_CLKSEL_CON(12), 10, 2, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 13, GFLAGS),
>> +	DIV(SCLK_SDIO, "sclk_sdio", "sclk_sdio_src", 0,
>> +			RK2928_CLKSEL_CON(11), 8, 7, DFLAGS),
>> +
>> +	COMPOSITE(SCLK_EMMC, "sclk_emmc", mux_mmc_src_p, 0,
>> +			RK2928_CLKSEL_CON(12), 12, 2, MFLAGS, 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 14, GFLAGS),
>> +
>> +	MMC(SCLK_SDMMC_DRV,    "sdmmc_drv",    "sclk_sdmmc", RK3036_SDMMC_CON0,
>> 1), +	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc",
>> RK3036_SDMMC_CON1, 0), +
>> +	MMC(SCLK_SDIO_DRV,    "sdio_drv",    "sclk_sdio", RK3036_SDIO_CON0, 1),
>> +	MMC(SCLK_SDIO_SAMPLE, "sdio_sample", "sclk_sdio", RK3036_SDIO_CON1, 0),
>> +
>> +	MMC(SCLK_EMMC_DRV,     "emmc_drv",     "sclk_emmc",  RK3036_EMMC_CON0,
>> 1), +	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",
>> RK3036_EMMC_CON1,  0), +
>> +	/* I2S */
>> +	COMPOSITE(0, "i2s_src", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(3), 14, 1, MFLAGS, 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(0), 9, GFLAGS),
>> +	COMPOSITE_FRAC(0, "i2s_frac", "i2s_src", CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(7), 0,
>> +			RK2928_CLKGATE_CON(0), 10, GFLAGS),
>> +	MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS),
>> +	COMPOSITE_NODIV(SCLK_I2S_OUT, "i2s_clkout", mux_i2s_clkout_p, 0,
>> +			RK2928_CLKSEL_CON(4), 12, 1, MFLAGS,
>> +			RK2928_CLKGATE_CON(0), 13, GFLAGS),
>> +	GATE(SCLK_I2S, "sclk_i2s", "i2s_pre", CLK_SET_RATE_PARENT,
>> +			RK2928_CLKGATE_CON(0), 14, GFLAGS),
>> +
>> +	COMPOSITE(0, "spdif_src", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(5), 10, 2, MFLAGS, 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 10, GFLAGS),
>> +	COMPOSITE_FRAC(0, "spdif_frac", "spdif_src", 0,
>> +			RK2928_CLKSEL_CON(9), 0,
>> +			RK2928_CLKGATE_CON(2), 12, GFLAGS),
>> +	MUX(SCLK_SPDIF, "sclk_spdif", mux_spdif_p, 0,
>> +			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS),
>> +	/* USB */
>> +	GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
>> +			RK2928_CLKGATE_CON(1), 5, GFLAGS),
>> +
>> +	/* GPU */
> some of these comments are redundant ... if the clock is already named
> sclk_gpu a comment GPU above does not help any :-)
>
> Same for SPI, NANDC and everything else you might find.
Done.
>
>> +	COMPOSITE(SCLK_GPU, "sclk_gpu", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(34), 8, 2, MFLAGS, 0, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(3), 13, GFLAGS),
>> +
>> +	/* SPI */
>> +	COMPOSITE(SCLK_SPI, "sclk_spi", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(25), 8, 2, MFLAGS, 0, 7, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 9, GFLAGS),
>> +
>> +	/* NANDC */
>> +	COMPOSITE(SCLK_NANDC, "sclk_nandc", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(16), 8, 2, MFLAGS, 10, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(10), 4, GFLAGS),
>> +
>> +	/* SFC */
>> +	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_pll_src_apll_gpll_dpll_usb480m_p, 0,
>> +			RK2928_CLKSEL_CON(16), 0, 2, MFLAGS, 2, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(10), 5, GFLAGS),
>> +
>> +	/* MAC */
>> +	COMPOSITE_NOGATE(0, "mac_pll_src", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(21), 0, 2, MFLAGS, 4, 5, DFLAGS),
>> +	/* for clk_mac_ref&  clk_mac_refout */
>> +	MUX(SCLK_MACREF, "mac_clk_ref", mux_mac_p, CLK_SET_RATE_PARENT,
>> +			RK2928_CLKSEL_CON(21), 3, 1, MFLAGS),
>> +
>> +	COMPOSITE_NOMUX(SCLK_MAC, "mac_clk", "mac_clk_ref", 0,
>> +			RK2928_CLKSEL_CON(21), 9, 5, DFLAGS,
>> +			RK2928_CLKGATE_CON(2), 6, GFLAGS),
>> +
> The hdmi diagram is actually labeled "Clock Architecture Diagram 2"
Done.
>> +	/* HDMI */
>> +	/* total clks: pin_sys_clk / pin_sck / pin_mclk / pin_vclk /
>> pin_vclk_pllref */ +	/* the same with dclk_lcdc */
>> +	COMPOSITE(0, "dclk_hdmi_src", mux_pll_src_3plls_p, 0,
>> +			RK2928_CLKSEL_CON(28), 0, 2, MFLAGS, 8, 8, DFLAGS,
>> +			RK2928_CLKGATE_CON(3), 2, GFLAGS),
>> +	/* hdmi dclk from dclk_lcdc directly */
>> +	MUX(SCLK_HDMI, "dclk_hdmi", mux_dclk_p, 0,
>> +			RK2928_CLKSEL_CON(31), 0, 1, MFLAGS),
>> +
>> +	/*
>> +	 * Clock-Architecture Diagram 2
> The gates are in Diagram 3 in the RK3036 TRM I have
Done.
>
>> +	 */
>> +
>> +	/* aclk_cpu gates */
>> +	GATE(0, "sclk_intmem", "aclk_cpu", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(4), 12, GFLAGS), +	GATE(0, "aclk_strc_sys", "aclk_cpu",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 10, GFLAGS), +
>> +	/* hclk_cpu gates */
>> +	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(5), 6, GFLAGS), +
>> +	/* pclk_cpu gates */
>> +	GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 4,
>> GFLAGS), +	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_cpu", 0,
>> RK2928_CLKGATE_CON(5), 7, GFLAGS), +	GATE(ACLK_VCODEC, "pclk_acodec",
>> "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS), +	GATE(PCLK_HDMI,
>> "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS), +
>> +	/* aclk_vio gates */
>> +	GATE(ACLK_VIO, "aclk_vio", "aclk_disp1_pre", 0,
>> +			RK2928_CLKGATE_CON(6), 13, GFLAGS),
>> +	GATE(ACLK_LCDC, "aclk_lcdc", "aclk_disp1_pre", 0,
>> +			RK2928_CLKGATE_CON(9), 6, GFLAGS),
>> +
>> +	GATE(HCLK_VIO_BUS, "hclk_vio_bus", "hclk_disp_pre", 0,
>> +			RK2928_CLKGATE_CON(6), 12, GFLAGS),
>> +	GATE(HCLK_LCDC, "hclk_lcdc", "hclk_disp_pre", 0,
>> +			RK2928_CLKGATE_CON(9), 5, GFLAGS),
>> +
>> +	/* aclk_video gates */
>> +	GATE(HCLK_LCDC, "hclk_vcodec", "hclk_disp_pre", 0,
>> +			RK2928_CLKGATE_CON(3), 12, GFLAGS),
>> +
>> +	/* xin24m gates */
>> +	GATE(SCLK_PVTM_CORE, "sclk_pvtm_core", "xin24m", 0,
>> RK2928_CLKGATE_CON(10), 0, GFLAGS), +	GATE(SCLK_PVTM_GPU, "sclk_pvtm_gpu",
>> "xin24m", 0, RK2928_CLKGATE_CON(10), 1, GFLAGS), +
>> +	/* aclk_peri gates */
>> +	GATE(0, "aclk_peri_axi_matrix", "aclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(4), 3, GFLAGS), +	GATE(0, "aclk_cpu_peri", "aclk_peri",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 2, GFLAGS), +	GATE(ACLK_DMAC2,
>> "aclk_dmac2", "aclk_peri", 0, RK2928_CLKGATE_CON(5), 1, GFLAGS), +	GATE(0,
>> "aclk_peri_niu", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 15,
>> GFLAGS), +
>> +	/* hclk_peri gates */
>> +	GATE(0, "hclk_peri_matrix", "hclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(4), 0, GFLAGS), +	GATE(0, "hclk_usb_peri", "hclk_peri",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS), +	GATE(0,
>> "hclk_peri_arbi", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9),
>> 14, GFLAGS), +	GATE(HCLK_NANDC, "hclk_nandc", "hclk_peri", 0,
>> RK2928_CLKGATE_CON(5), 9, GFLAGS), +	GATE(HCLK_SDMMC, "hclk_sdmmc",
>> "hclk_peri", 0, RK2928_CLKGATE_CON(5), 10, GFLAGS), +	GATE(HCLK_SDIO,
>> "hclk_sdio", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 11, GFLAGS),
>> +	GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 0,
>> GFLAGS), +	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(5), 13, GFLAGS), +	GATE(HCLK_OTG1, "hclk_otg1",
>> "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 13, GFLAGS),
>> +	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(7), 2, GFLAGS), +	GATE(0, "hclk_sfc", "hclk_peri",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS), +	GATE(0,
>> "hclk_mac", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 15,
>> GFLAGS), +
>> +	/* pclk_peri gates */
>> +	GATE(0, "pclk_peri_matrix", "pclk_peri", CLK_IGNORE_UNUSED,
>> RK2928_CLKGATE_CON(4), 1, GFLAGS), +	GATE(0, "pclk_efuse", "pclk_peri",
>> CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 2, GFLAGS), +	GATE(PCLK_TIMER,
>> "pclk_timer0", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 7, GFLAGS),
>> +	GATE(PCLK_PWM, "pclk_pwm", "pclk_peri", 0, RK2928_CLKGATE_CON(7), 10,
>> GFLAGS), +	GATE(PCLK_SPI, "pclk_spi", "pclk_peri", 0,
>> RK2928_CLKGATE_CON(7), 12, GFLAGS), +	GATE(PCLK_WDT, "pclk_wdt",
>> "pclk_peri", 0, RK2928_CLKGATE_CON(7), 15, GFLAGS), +	GATE(PCLK_UART0,
>> "pclk_uart0", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 0, GFLAGS),
>> +	GATE(PCLK_UART1, "pclk_uart1", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 1,
>> GFLAGS), +	GATE(PCLK_UART2, "pclk_uart2", "pclk_peri", 0,
>> RK2928_CLKGATE_CON(8), 2, GFLAGS), +	GATE(PCLK_I2C0, "pclk_i2c0",
>> "pclk_peri", 0, RK2928_CLKGATE_CON(8), 4, GFLAGS), +	GATE(PCLK_I2C1,
>> "pclk_i2c1", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 5, GFLAGS),
>> +	GATE(PCLK_I2C2, "pclk_i2c2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 6,
>> GFLAGS), +	GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_peri", 0,
>> RK2928_CLKGATE_CON(8), 9, GFLAGS), +	GATE(PCLK_GPIO1, "pclk_gpio1",
>> "pclk_peri", 0, RK2928_CLKGATE_CON(8), 10, GFLAGS), +	GATE(PCLK_GPIO2,
>> "pclk_gpio2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS), +};
>> +
>> +static const char *const rk3036_critical_clocks[] __initconst = {
>> +	"aclk_cpu",
>> +	"aclk_peri",
>> +	"hclk_peri",
>> +};
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static void __iomem *rk3036_cru_base;
>> +
>> +/* Some CRU registers will be reset in maskrom when the system
>> + * wakes up from fastboot.
>> + * So save them before suspend, restore them after resume.
>> + */
>> +
>> +static int rk3036_clk_suspend(void)
>> +{
>> +	/* TODO */
>> +
>> +	return 0;
>> +}
>> +
>> +static void rk3036_clk_resume(void)
>> +{
>> +	/* TODO */
>> +}
>> +
>> +static struct syscore_ops rk3036_clk_syscore_ops = {
>> +	.suspend = rk3036_clk_suspend,
>> +	.resume = rk3036_clk_resume,
>> +};
>> +
>> +static void rk3036_clk_sleep_init(void __iomem *reg_base)
>> +{
>> +	rk3036_cru_base = reg_base;
>> +	register_syscore_ops(&rk3036_clk_syscore_ops);
>> +}
>> +
>> +#else /* CONFIG_PM_SLEEP */
>> +static void rk3036_clk_sleep_init(void __iomem *reg_base) {}
>> +#endif
> please don't add empty "TODO" functions. If you want to work on suspend later,
> just leave this stuff out completely and add it when time comes.
Done.
>
>> +
>> +static void __init rk3036_clk_init(struct device_node *np)
>> +{
>> +	void __iomem *reg_base;
>> +	struct clk *clk;
>> +
>> +	reg_base = of_iomap(np, 0);
>> +	if (!reg_base) {
>> +		pr_err("%s: could not map cru region\n", __func__);
>> +		return;
>> +	}
>> +
>> +	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
>> +
>> +	/* xin12m is created by an cru-internal divider */
>> +	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
>> +	if (IS_ERR(clk))
>> +		pr_warn("%s: could not register clock xin12m: %ld\n",
>> +			__func__, PTR_ERR(clk));
>> +
>> +	clk = clk_register_fixed_factor(NULL, "usb480m", "xin24m", 0, 20, 1);
>> +	if (IS_ERR(clk))
>> +		pr_warn("%s: could not register clock usb480m: %ld\n",
>> +			__func__, PTR_ERR(clk));
>> +
>> +	clk = clk_register_fixed_factor(NULL, "ddrphy", "ddrphy2x", 0, 1, 2);
>> +	if (IS_ERR(clk))
>> +		pr_warn("%s: could not register clock ddrphy: %ld\n",
>> +			__func__, PTR_ERR(clk));
>> +
>> +	clk = clk_register_fixed_factor(NULL, "hclk_vcodec_pre",
>> +					"aclk_vcodec", 0, 1, 4);
>> +	if (IS_ERR(clk))
>> +		pr_warn("%s: could not register clock hclk_vcodec_pre: %ld\n",
>> +			__func__, PTR_ERR(clk));
>> +
>> +	clk = clk_register_fixed_factor(NULL, "sclk_macref_out",
>> +					"hclk_peri_src", 0, 1, 2);
>> +	if (IS_ERR(clk))
>> +		pr_warn("%s: could not register clock sclk_macref_out: %ld\n",
>> +			__func__, PTR_ERR(clk));
>> +
>> +	rockchip_clk_register_plls(rk3036_pll_clks,
>> +				   ARRAY_SIZE(rk3036_pll_clks),
>> +				   -1);
>> +	rockchip_clk_register_branches(rk3036_clk_branches,
>> +				  ARRAY_SIZE(rk3036_clk_branches));
>> +	rockchip_clk_protect_critical(rk3036_critical_clocks,
>> +				      ARRAY_SIZE(rk3036_critical_clocks));
>> +
>> +	rockchip_clk_register_armclk(ARMCLK, "armclk",
>> +			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
>> +			&rk3036_cpuclk_data, rk3036_cpuclk_rates,
>> +			ARRAY_SIZE(rk3036_cpuclk_rates));
>> +
>> +	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
>> +				  ROCKCHIP_SOFTRST_HIWORD_MASK);
>> +
>> +	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST);
>> +	rk3036_clk_sleep_init(reg_base);
>> +}
>> +CLK_OF_DECLARE(rk3036_cru, "rockchip,rk3036-cru", rk3036_clk_init);
>> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
>> index dc8ecb2..6603c07 100644
>> --- a/drivers/clk/rockchip/clk.h
>> +++ b/drivers/clk/rockchip/clk.h
>> @@ -2,6 +2,9 @@
>>    * Copyright (c) 2014 MundoReader S.L.
>>    * Author: Heiko Stuebner<heiko@sntech.de>
>>    *
>> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
>> + * Author: Xing Zheng<zhengxing@rock-chips.com>
>> + *
>>    * based on
>>    *
>>    * samsung/clk.h
>> @@ -40,6 +43,13 @@ struct clk;
>>   #define RK2928_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
>>   #define RK2928_MISC_CON		0x134
>>
>> +#define RK3036_SDMMC_CON0		0x144
>> +#define RK3036_SDMMC_CON1		0x148
>> +#define RK3036_SDIO_CON0		0x14c
>> +#define RK3036_SDIO_CON1		0x150
>> +#define RK3036_EMMC_CON0		0x154
>> +#define RK3036_EMMC_CON1		0x158
>> +
>>   #define RK3288_PLL_CON(x)		RK2928_PLL_CON(x)
>>   #define RK3288_MODE_CON			0x50
>>   #define RK3288_CLKSEL_CON(x)		((x) * 0x4 + 0x60)
>> @@ -75,6 +85,7 @@ struct clk;
>>
>>   enum rockchip_pll_type {
>>   	pll_rk3066,
>> +	pll_rk3036,
>>   };
>>
>>   #define RK3066_PLL_RATE(_rate, _nr, _nf, _no)	\
>> @@ -95,12 +106,31 @@ enum rockchip_pll_type {
>>   	.nb = _nb,						\
>>   }
>>
>> +#define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
>> +			_postdiv2, _dsmpd, _frac)		\
>> +{								\
>> +	.rate	= _rate##U,					\
>> +	.fbdiv = _fbdiv,					\
>> +	.postdiv1 = _postdiv1,					\
>> +	.refdiv = _refdiv,					\
>> +	.postdiv2 = _postdiv2,					\
>> +	.dsmpd = _dsmpd,					\
>> +	.frac = _frac,						\
>> +}
>> +
>>   struct rockchip_pll_rate_table {
>>   	unsigned long rate;
>>   	unsigned int nr;
>>   	unsigned int nf;
>>   	unsigned int no;
>>   	unsigned int nb;
>> +	/* for RK3036 */
>> +	unsigned int fbdiv;
>> +	unsigned int postdiv1;
>> +	unsigned int refdiv;
>> +	unsigned int postdiv2;
>> +	unsigned int dsmpd;
>> +	unsigned int frac;
>>   };
>>
>>   /**
>> diff --git a/include/dt-bindings/clock/rk3036-cru.h
>> b/include/dt-bindings/clock/rk3036-cru.h new file mode 100644
>> index 0000000..085e4c3
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/rk3036-cru.h
>> @@ -0,0 +1,247 @@
>> +/*
>> + * Copyright (c) 2014 MundoReader S.L.
>> + * Author: Heiko Stuebner<heiko@sntech.de>
>> + *
>> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
>> + * Author: Xing Zheng<zhengxing@rock-chips.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +/* core clocks */
>> +#define PLL_APLL		1
>> +#define PLL_DPLL		2
>> +#define PLL_GPLL		3
>> +#define ARMCLK			4
>> +
>> +/* sclk gates (special clocks) */
>> +#define SCLK_GPU		64
>> +#define SCLK_SPI		65
>> +#define SCLK_SDMMC		68
>> +#define SCLK_SDIO		69
>> +#define SCLK_EMMC		71
>> +#define SCLK_NANDC		76
>> +#define SCLK_UART0		77
>> +#define SCLK_UART1		78
>> +#define SCLK_UART2		79
>> +#define SCLK_I2S		82
>> +#define SCLK_SPDIF		83
>> +#define SCLK_TIMER0		85
>> +#define SCLK_TIMER1		86
>> +#define SCLK_TIMER2		87
>> +#define SCLK_TIMER3		88
>> +#define SCLK_OTGPHY0		93
>> +#define SCLK_OTGPHY1		94
>> +#define SCLK_LCDC		100
>> +#define SCLK_HDMI		109
>> +#define SCLK_HEVC		111
>> +#define SCLK_I2S_OUT		113
>> +#define SCLK_SDMMC_DRV		114
>> +#define SCLK_SDIO_DRV		115
>> +#define SCLK_EMMC_DRV		117
>> +#define SCLK_SDMMC_SAMPLE	118
>> +#define SCLK_SDIO_SAMPLE	119
>> +#define SCLK_EMMC_SAMPLE	121
>> +#define SCLK_PVTM_CORE          123
>> +#define SCLK_PVTM_GPU           124
>> +#define SCLK_PVTM_VIDEO         125
>> +#define SCLK_MAC		151
>> +#define SCLK_MACREF		152
>> +#define SCLK_SFC		160
>> +
>> +#define DCLK_LCDC		190
>> +
>> +/* aclk gates */
>> +#define ACLK_DMAC2		194
>> +#define ACLK_LCDC		197
>> +#define ACLK_VIO		203
>> +#define ACLK_VCODEC		208
>> +#define ACLK_CPU		209
>> +#define ACLK_PERI		210
>> +
>> +/* pclk gates */
>> +#define PCLK_GPIO0		320
>> +#define PCLK_GPIO1		321
>> +#define PCLK_GPIO2		322
>> +#define PCLK_GRF		329
>> +#define PCLK_I2C0		332
>> +#define PCLK_I2C1		333
>> +#define PCLK_I2C2		334
>> +#define PCLK_SPI		338
>> +#define PCLK_UART0		341
>> +#define PCLK_UART1		342
>> +#define PCLK_UART2		343
>> +#define PCLK_PWM		350
>> +#define PCLK_TIMER		353
>> +#define PCLK_HDMI		360
>> +#define PCLK_CPU		362
>> +#define PCLK_PERI		363
>> +#define PCLK_DDRUPCTL		364
>> +#define PCLK_WDT		368
>> +
>> +/* hclk gates */
>> +#define HCLK_OTG0		449
>> +#define HCLK_OTG1		450
>> +#define HCLK_NANDC		453
>> +#define HCLK_SDMMC		456
>> +#define HCLK_SDIO		457
>> +#define HCLK_EMMC		459
>> +#define HCLK_I2S		462
>> +#define HCLK_LCDC		465
>> +#define HCLK_ROM		467
>> +#define HCLK_VIO_BUS		472
>> +#define HCLK_VCODEC		476
>> +#define HCLK_CPU		477
>> +#define HCLK_PERI		478
>> +
>> +#define CLK_NR_CLKS		(HCLK_PERI + 1)
>> +
>> +/* soft-reset indices */
>> +#define SRST_CORE0		0
>> +#define SRST_CORE1		1
>> +#define SRST_0RES2		2
>> +#define SRST_0RES3		3
>> +#define SRST_CORE0_DBG		4
>> +#define SRST_CORE1_DBG		5
>> +#define SRST_0RES6		6
>> +#define SRST_0RES7		7
>> +#define SRST_CORE0_POR		8
>> +#define SRST_CORE1_POR		9
>> +#define SRST_0RES10		10
>> +#define SRST_0RES11		11
>> +#define SRST_L2C		12
>> +#define SRST_TOPDBG		13
>> +#define SRST_STRC_SYS_A		14
>> +#define SRST_PD_CORE_NIU	15
>> +
>> +#define SRST_TIMER2		16
>> +#define SRST_CPUSYS_H		17
>> +#define SRST_1RES2		18
>> +#define SRST_AHB2APB_H		19
>> +#define SRST_TIMER3		20
>> +#define SRST_INTMEM		21
>> +#define SRST_ROM		22
>> +#define SRST_PERI_NIU		23
>> +#define SRST_I2S		24
>> +#define SRST_DDR_PLL		25
>> +#define SRST_GPU_DLL		26
>> +#define SRST_TIMER0		27
>> +#define SRST_TIMER1		28
>> +#define SRST_CORE_DLL		29
>> +#define SRST_EFUSE_P		30
>> +#define SRST_ACODEC_P		31
>> +
>> +#define SRST_GPIO0		32
>> +#define SRST_GPIO1		33
>> +#define SRST_GPIO2		34
>> +#define SRST_2RES3		35
>> +#define SRST_2RES4		36
>> +#define SRST_2RES5		37
>> +#define SRST_2RES6		38
>> +#define SRST_UART0		39
>> +#define SRST_UART1		40
>> +#define SRST_UART2		41
>> +#define SRST_2RES10		42
>> +#define SRST_I2C0		43
>> +#define SRST_I2C1		44
>> +#define SRST_I2C2		45
>> +#define SRST_2RES14		46
>> +#define SRST_SFC		47
>> +
>> +#define SRST_PWM0		48
>> +#define SRST_3RES1		49
>> +#define SRST_3RES2		50
>> +#define SRST_DAP		51
>> +#define SRST_DAP_SYS		52
>> +#define SRST_3RES5		53
>> +#define SRST_3RES6		54
>> +#define SRST_GRF		55
>> +#define SRST_3RES8		56
>> +#define SRST_PERIPHSYS_A	57
>> +#define SRST_PERIPHSYS_H	58
>> +#define SRST_PERIPHSYS_P	59
>> +#define SRST_3RES12		60
>> +#define SRST_CPU_PERI		61
>> +#define SRST_EMEM_PERI		62
>> +#define SRST_USB_PERI		63
>> +
>> +#define SRST_DMA2		64
>> +#define SRST_4RES1		65
>> +#define SRST_MAC		66
>> +#define SRST_4RES3		67
>> +#define SRST_NANDC		68
>> +#define SRST_USBOTG0		69
>> +#define SRST_4RES6		70
>> +#define SRST_OTGC0		71
>> +#define SRST_USBOTG1		72
>> +#define SRST_4RES9		73
>> +#define SRST_OTGC1		74
>> +#define SRST_4RES11		75
>> +#define SRST_4RES12		76
>> +#define SRST_4RES13		77
>> +#define SRST_4RES14		78
>> +#define SRST_DDRMSCH		79
>> +
>> +#define SRST_5RES0		80
>> +#define SRST_MMC0		81
>> +#define SRST_SDIO		82
>> +#define SRST_EMMC		83
>> +#define SRST_SPI0		84
>> +#define SRST_5RES5		85
>> +#define SRST_WDT		86
>> +#define SRST_5RES7		87
>> +#define SRST_DDRPHY		88
>> +#define SRST_DDRPHY_P		89
>> +#define SRST_DDRCTRL		90
>> +#define SRST_DDRCTRL_P		91
>> +#define SRST_5RES12		92
>> +#define SRST_5RES13		93
>> +#define SRST_5RES14		94
>> +#define SRST_5RES15		95
>> +
>> +#define SRST_HDMI_P		96
>> +#define SRST_6RES1		97
>> +#define SRST_6RES2		98
>> +#define SRST_VIO_BUS_H		99
>> +#define SRST_6RES4		100
>> +#define SRST_6RES5		101
>> +#define SRST_6RES6		102
>> +#define SRST_UTMI0		103
>> +#define SRST_UTMI1		104
>> +#define SRST_USBPOR		105
>> +#define SRST_6RES10		106
>> +#define SRST_6RES11		107
>> +#define SRST_6RES12		108
>> +#define SRST_6RES13		109
>> +#define SRST_6RES14		110
>> +#define SRST_6RES15		111
>> +
>> +#define SRST_VCODEC_A		112
>> +#define SRST_VCODEC_H		113
>> +#define SRST_VIO1_A		114
>> +#define SRST_HEVC		115
>> +#define SRST_VCODEC_NIU_A	116
>> +#define SRST_LCDC1_A		117
>> +#define SRST_LCDC1_H		118
>> +#define SRST_LCDC1_D		119
>> +#define SRST_GPU		120
>> +#define SRST_7RES9		121
>> +#define SRST_GPU_NIU_A		122
>> +#define SRST_7RES11		123
>> +#define SRST_7RES12		124
>> +#define SRST_7RES13		125
>> +#define SRST_7RES14		126
>> +#define SRST_7RES15		127
> please don't add reserved (aka unused) reset slots. Of course the numbering
> stays the same, so just drop the xRESy lines from the definition.
> Same for all xRESy entries in this file.
>
>
>> +
>> +#define SRST_8RES0		128
>> +#define SRST_8RES1		129
>> +#define SRST_8RES2		130
>> +#define SRST_DBG_P		131
Done.
