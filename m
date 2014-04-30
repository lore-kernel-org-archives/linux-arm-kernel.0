From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 30 Apr 2014 12:52:43 +0200
Subject: [PATCH 134/222] ARM: imx: keep PLLs in bypass while they're
 locking
In-Reply-To: <E1WdeWp-0007MD-Vr@rmk-PC.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <E1WdeWp-0007MD-Vr@rmk-PC.arm.linux.org.uk>
Message-ID: <5360D5FB.2080209@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.04.2014 13:42, Russell King wrote:
> Keep the PLL bypassed while we prepare a clock by powering up the PLL,
> otherwise we can end up with improper output/gitches which prevents
> further operation.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/mach-imx/clk-pllv3.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
> index 61364050fccd..3776f974d1dc 100644
> --- a/arch/arm/mach-imx/clk-pllv3.c
> +++ b/arch/arm/mach-imx/clk-pllv3.c
> @@ -273,9 +273,10 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
>   	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>   	unsigned long min_rate = parent_rate * 27;
>   	unsigned long max_rate = parent_rate * 54;
> -	u32 val, div;
> +	u32 val, newval, div;
>   	u32 mfn, mfd = 1000000;
>   	s64 temp64;
> +	int ret;
>
>   	if (rate < min_rate || rate > max_rate)
>   		return -EINVAL;
> @@ -287,13 +288,27 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
>   	mfn = temp64;
>
>   	val = readl_relaxed(pll->base);
> -	val &= ~pll->div_mask;
> -	val |= div;
> -	writel_relaxed(val, pll->base);
> +
> +	/* set the PLL into bypass mode */
> +	newval = val | BM_PLL_BYPASS;
> +	writel_relaxed(newval, pll->base);
> +
> +	/* configure the new frequency */
> +	newval &= ~pll->div_mask;
> +	newval |= div;
> +	writel_relaxed(newval, pll->base);
>   	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
> -	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
> +	writel(mfd, pll->base + PLL_DENOM_OFFSET);
>
> -	return clk_pllv3_wait_lock(pll);
> +	ret = clk_pllv3_wait_lock(pll);
> +	if (ret == 0 && val & BM_PLL_POWER) {

I'm no expert on this, so sorry if I'm wrong ;)

But regarding the check 'val & BM_PLL_POWER' here:

Reading the manual, it seems that both PLL4_AUDIO & PLL5_VIDEO don't 
have a POWER bit, instead they have a POWERDOWN at bit 12. So for 
PLL4_AUDIO & PLL5_VIDEO 'val & BM_PLL_POWER' would mean not powered up?

Maybe the check should be done anywhere else, e.g. in clk_pllv3_set_rate()?

Best regards

Dirk
