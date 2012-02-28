From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 28 Feb 2012 13:01:14 -0800
Subject: [PATCH v3 04/10] arm/tegra: Fix PWM clock programming
In-Reply-To: <1329923841-32017-5-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-5-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E52@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> PWM clock source registers in Tegra 2 have different clock source selection bit
> fields than other registers.  PWM clock source bits in CLK_SOURCE_PWM_0 register
> are located at bit field bit[30:28] while others are at bit field bit[31:30] in
> their respective clock source register.
> 
> This patch updates the clock programming to correctly reflect that, by adding a
> flag to indicate the alternate bit field format and checking for it when
> selecting a clock source (parent clock).

tegra30_clocks.c needs this change too, although on Tegra30, it's bits
29:28 for the PWM, and bits 31:30 for non-PWM.

> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c

+#define PERIPH_CLK_SOURCE_4BIT_MASK	(7<<28)
+#define PERIPH_CLK_SOURCE_4BIT_SHIFT	28

Why is this (and the flag that enables it) called "4 bit"; the existing
code supports a 2-bit mux field (4-values), whereas this new code supports
a 3-bit field (potentially 8 values, but only 5 actually assigned).
Can this be renamed something more accurate, especially since on Tegra30
the difference is only the bit position of the field, not the number of
bits in the field.

> @@ -908,9 +910,16 @@ static void tegra2_periph_clk_init(struct clk *c)
>  	u32 val = clk_readl(c->reg);
>  	const struct clk_mux_sel *mux = NULL;
>  	const struct clk_mux_sel *sel;
> +	u32 shift;
> +
> +	if (c->flags & PERIPH_SOURCE_CLK_4BIT)
> +		shift = PERIPH_CLK_SOURCE_4BIT_SHIFT;
> +	else
> +		shift = PERIPH_CLK_SOURCE_SHIFT;

I think you should assign a "mask" variable here too...

> +
>  	if (c->flags & MUX) {
>  		for (sel = c->inputs; sel->input != NULL; sel++) {
> -			if (val >> PERIPH_CLK_SOURCE_SHIFT == sel->value)
> +			if (val >> shift == sel->value)
>  				mux = sel;

Because in the new case, bit 31 isn't part of the field, so just
shifting doesn't isolate the mux field. In practice, this probably isn't
an issue since bit 31 is undefined, but better to be safe than sorry...

-- 
nvpublic
