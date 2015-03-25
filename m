From: tony@atomide.com (Tony Lindgren)
Date: Wed, 25 Mar 2015 16:17:00 -0700
Subject: [PATCHv5 11/35] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
In-Reply-To: <5512D069.4080906@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-12-git-send-email-t-kristo@ti.com>
 <5512D069.4080906@ti.com>
Message-ID: <20150325231659.GD31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150325 08:12]:
> 
> Splits the clock provider init out of the PRM driver and moves it to
> clock driver. This is needed so that once the PRCM drivers are separated,
> they can logically just access the clock driver not needing to go through
> common PRM code. This would be wrong in the case of control module for
> example.
...

> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
... 
> -u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
> +u32 omap2_clk_memmap_readl(void __iomem *reg)
>  {
> -	u32 val;
> +	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> 
> -	if (clk->flags & MEMMAP_ADDRESSING) {
> -		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
> -		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
> -	} else {
> -		val = readl_relaxed(reg);
> -	}
> +	return readl_relaxed(clk_memmaps[r->index] + r->offset);
> +}

The cast from void __iomem *reg to struct clk_omap_reg *r looks still
nasty.. Why don't you add the IO address into struct clk_omap_reg:

struct clk_omap_reg {
	u16 offset;
	u16 index;
	struct regmap *regmap;
	void __iomem *addr;
};
...

Then populate it during init and then have the clock code use it
directly if available? Then it seems you would not need the
static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS] at all?

Regards,

Tony
