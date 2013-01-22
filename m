From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Jan 2013 10:28:31 -0800
Subject: [PATCH 1/2] clk: divider: prepare for minimum divider
In-Reply-To: <d20165dfc67970c3429b9d95ac9631015f8b2396.1358870920.git.afzal@ti.com>
References: <d20165dfc67970c3429b9d95ac9631015f8b2396.1358870920.git.afzal@ti.com>
Message-ID: <50FEDA4F.4060405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/13 08:39, Afzal Mohammed wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a9204c6..0b34992 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
>  
>  static struct clk *_register_divider(struct device *dev, const char *name,
>  		const char *parent_name, unsigned long flags,
> -		void __iomem *reg, u8 shift, u8 width,
> +		void __iomem *reg, u8 shift, u8 width, u8 min_div,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
>  		spinlock_t *lock)
>  {
> @@ -261,6 +261,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
>  	div->reg = reg;
>  	div->shift = shift;
>  	div->width = width;
> +	div->min_div = min_div;
>  	div->flags = clk_divider_flags;
>  	div->lock = lock;
>  	div->hw.init = &init;
> @@ -284,16 +285,17 @@ static struct clk *_register_divider(struct device *dev, const char *name,
>   * @reg: register address to adjust divider
>   * @shift: number of bits to shift the bitfield
>   * @width: width of the bitfield
> + * @min_div: minimum allowable divider value
>   * @clk_divider_flags: divider-specific flags for this clock
>   * @lock: shared register lock for this clock
>   */
>  struct clk *clk_register_divider(struct device *dev, const char *name,
>  		const char *parent_name, unsigned long flags,
> -		void __iomem *reg, u8 shift, u8 width,
> +		void __iomem *reg, u8 shift, u8 width, u8 min_div,
>  		u8 clk_divider_flags, spinlock_t *lock)
>  {
>  	return _register_divider(dev, name, parent_name, flags, reg, shift,
> -			width, clk_divider_flags, NULL, lock);
> +			width, min_div, clk_divider_flags, NULL, lock);
>  }

Can you make a new function, clk_register_min_divider(), to avoid
disturbing all users of clock dividers that don't have a minimum? Then
the default can be put into the two registration functions in
clk-divider.c and you don't have to change all clock divider users
across the tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
