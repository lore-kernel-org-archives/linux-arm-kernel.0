From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Jan 2016 12:18:09 +0100
Subject: [PATCH] clk: sunxi: Fix mod0 clock calculation to return stable
 results and check divisor size limits
In-Reply-To: <1451323892-13060-1-git-send-email-mweseloh42@gmail.com>
References: <1451323892-13060-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <20160113111809.GA9905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

Sorry for the reviewing delay.

On Mon, Dec 28, 2015 at 06:31:32PM +0100, Marcus Weseloh wrote:
> This patch fixes some problems in the mod0 clock calculation. It has
> the potential to break stuff, as the issues explained below had the
> effect that clk_set_rate would always return successfully, sometimes
> setting a frequency that is higher than the requested value.

That's actually the expected behaviour of clk_set_rate.

clk_set_rate is supposed to adjust the given clock rate to something
that the clock drivers seems fit. It should only return an error in a
case where you can't change the rate at all (because you didn't pass a
valid struct clk pointer, because changing the rate would violate some
clock flags, etc.). Otherwise, clk_set_rate should succeed.

By returning an error code the clock is higher than the one passed,
you violate that expectation, especially since that is relative to the
clock you passed.

It makes sense in your case to never exceed the given rate, it might
not for a different clock in the tree, or even for a different
instance of the same clock. For example, you could very well have
another case in your system where you should not have rates set that
are below the one given because that would prevent the consumer
device to be usable.

This is why the adjustment is left to the clock driver, and is not
enforced by the framework itself, simply because the framework has no
idea how you want to round your clock rate on that particular clock in
your system.

> Code that "accidentally worked" because of this might fail after
> applying this patch.
> 
> The problems in detail:
> 
> 1. If a very low frequency is requested from a high parent clock, the
> divisors "div" and "calcm" might be > 255. This patch changes the type
> of both variables to unsigned int, because the silent cast to u8 will
> result in invalid frequencies and register values.
> 
> 2. The width of the "m" divisor in the clock control registers is only
> 4 bit, but that limitation is not checked when calculating the divisor
> and the resulting frequency. This patch adds a check that m never
> exceeds the field width.
> 
> 3. During a call to clk_set_rate, the sun4i_a10_get_mod0_factors
> function is called multiple times: first to find the best parent and
> frequency, then again to calculate the p and m divisors, passing the
> frequencies returned by the previous call(s). In certain cases
> those chained calls do not result in the best frequency choice.

You know the drill by now :)

You're fixing three different issues, please send three different
patches.

> 
> An example:
> parent_rate = 24Mhz, freq = 1.4Mhz results in p=1, m=9, freq=1333333,3333
> (which gets rounded down to 1333333).
> Calling the function again with parent_rate = 24Mhz and freq = 1333333
> results in p=1, m=10, freq=1200000.
> 
> Rounding up the returned frequency removes this problem.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
>  drivers/clk/sunxi/clk-mod0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
> index d167e1e..d03f099 100644
> --- a/drivers/clk/sunxi/clk-mod0.c
> +++ b/drivers/clk/sunxi/clk-mod0.c
> @@ -31,7 +31,8 @@
>  static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
>  				       u8 *n, u8 *k, u8 *m, u8 *p)
>  {
> -	u8 div, calcm, calcp;
> +	unsigned int div, calcm;
> +	u8 calcp;
>  
>  	/* These clocks can only divide, so we will never be able to achieve
>  	 * frequencies higher than the parent frequency */
> @@ -50,8 +51,10 @@ static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
>  		calcp = 3;
>  
>  	calcm = DIV_ROUND_UP(div, 1 << calcp);
> +	if (calcm > 16)
> +		calcm = 16;
>  
> -	*freq = (parent_rate >> calcp) / calcm;
> +	*freq = DIV_ROUND_UP(parent_rate >> calcp, calcm);

While the two above seems harmless, this one concerns me a bit. Did
you test the various mod0 clock users and made sure that they were
still working as they used to?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160113/75d1b26b/attachment.sig>
