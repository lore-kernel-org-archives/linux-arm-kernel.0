From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 May 2014 09:56:59 +0200
Subject: [PATCH v2 05/10] clk: berlin: add driver for BG2x complex
 divider cells
In-Reply-To: <1400098522-14770-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140515075659.GP29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2014 at 22:15:16 +0200, Sebastian Hesselbarth wrote :
> +static u8 berlin2_div_get_parent(struct clk_hw *hw)
> +{
> +	struct berlin2_div *div = to_berlin2_div(hw);
> +	struct berlin2_div_map *map = &div->map;
> +	u32 reg;
> +	u8 index = 0;
> +
> +	if (div->lock)
> +		spin_lock(div->lock);
> +
> +	/* PLL_SWITCH == 0 is index 0 */
> +	reg = readl_relaxed(div->base + map->pll_switch_offs);
> +	reg &= BIT(map->pll_switch_shift);
> +	if (reg) {
> +		reg = readl_relaxed(div->base + map->pll_select_offs);
> +		reg >>= map->pll_select_shift;
> +		reg &= PLL_SELECT_MASK;
> +		index = 1 + reg;

After getting more insight, I think we don't need to add 1, see my
comment on the next patchs.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
