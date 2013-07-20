From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 20 Jul 2013 13:16:39 +0200
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
In-Reply-To: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
References: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130720111639.GA29785@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 12:29:35PM +0400, Alexander Shiyan wrote:
> This patch implements frequency change for i.MX pllv1.
> Selection of the values of the registers is not optimal, since is
> made by simple enumeration of all possible values.

You do not mention why you want to adjust the rate. Normally we've been
happy with the static values from the bootloader.

> -static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
> -		unsigned long parent_rate)
> +static unsigned long _clk_pllv1_recalc_rate(unsigned int mfi, unsigned int mfn,
> +					    unsigned int mfd, unsigned int pd,
> +					    unsigned long parent_rate)
>  {
> -	struct clk_pllv1 *pll = to_clk_pllv1(hw);
> -	long long ll;
> -	int mfn_abs;
> -	unsigned int mfi, mfn, mfd, pd;
> -	u32 reg;
>  	unsigned long rate;
> -
> -	reg = readl(pll->base);
> +	int mfn_abs = mfn;
> +	long long ll;
>  
>  	/*
>  	 * Get the resulting clock rate from a PLL register value and the input
> @@ -47,15 +45,6 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
>  	 *                        pd + 1
>  	 */
>  
> -	mfi = (reg >> 10) & 0xf;
> -	mfn = reg & 0x3ff;
> -	mfd = (reg >> 16) & 0x3ff;
> -	pd =  (reg >> 26) & 0xf;
> -
> -	mfi = mfi <= 5 ? 5 : mfi;
> -
> -	mfn_abs = mfn;
> -
>  	/*
>  	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
>  	 * 2's complements number
> @@ -78,8 +67,99 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
>  	return ll;
>  }
>  
> +static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_pllv1 *pll = to_clk_pllv1(hw);
> +	unsigned int mfi, mfn, mfd, pd;
> +	u32 reg = readl(pll->base);
> +
> +	/* Avoid i.MX27 TO2 SPCTL0 bug */
> +	if (cpu_is_mx27() && (mx27_revision() == IMX_CHIP_REVISION_2_0))
> +		writel(reg, pll->base);

I remember this was fixed and got lost. If you want to have fixed it
again this should be a separate paatch along with a description of the
bug in the commit log.

> +
> +	mfi = (reg >> 10) & 0xf;
> +	mfn = reg & 0x3ff;
> +	mfd = (reg >> 16) & 0x3ff;
> +	pd =  (reg >> 26) & 0xf;
> +
> +	mfi = mfi <= 5 ? 5 : mfi;
> +
> +	return _clk_pllv1_recalc_rate(mfi, mfn, mfd, pd, parent_rate);
> +}
> +
> +static void _clk_pllv1_set_rate(unsigned long rate, unsigned long parent_rate,
> +				unsigned int *reg)
> +{
> +	unsigned int pd, mfi, mfn, mfd, mfn_offs = 0;
> +	long tmp, res, best = 0;
> +
> +	pd = (parent_rate * 2 * 5) / rate;
> +	if (pd > 15)
> +		pd = 15;
> +	mfi = rate / (parent_rate * 2 * (pd + 1));
> +	if (mfi < 5)
> +		mfi = 5;
> +	if (mfi < 15) {
> +		tmp = parent_rate * 2;
> +		tmp /= pd + 1;
> +		tmp *= mfi;
> +		if (tmp / parent_rate) {
> +			mfi++;
> +			/* Use negative values */
> +			mfn_offs = 0x200;
> +		}
> +	} else if (mfi > 15)
> +		mfi = 15;

Use braces on both branches here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
