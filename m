From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 7 Jan 2010 20:11:11 -0500
Subject: [RFC, PATCH 6/7] arm/icst307: use common struct clk,
	unify realview and versatile clocks
In-Reply-To: <1262907852.738282.3449449719.6.gpush@pororo>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262907852.738282.3449449719.6.gpush@pororo>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089619@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 07, 2010 4:44 PM, Jeremy Kerr wrote:
> Both the realview and versatile platforms use an icst307 clock, but have
> their own clock structures.
> 
> This change introduces a struct icst307_clk, which is common between
> realview and versatile. This allows us to take out the platform-specific
> clock defintions.
> 
> Tested on versatile, compiled only on realview.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---

[snip]

> +unsigned long clk_icst307_get_rate(struct clk *clk)
> +{
> +	return to_clk_icst307(clk)->rate;
> +}
> +
> +long clk_icst307_round_rate(struct clk *clk, unsigned long rate)

I think the return value here should be 'unsigned long'

> +{
> +	const struct icst307_params *params = &to_clk_icst307(clk)->params;
> +	struct icst307_vco vco;

Add a whitespace here please.

> +	vco = icst307_khz_to_vco(params, rate / 1000);
> +	return icst307_khz(params, vco) * 1000;
> +}
> +
> +int clk_icst307_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk_icst307 *v_clk = to_clk_icst307(clk);
> +	struct icst307_vco vco;
> +
> +	vco = icst307_khz_to_vco(&v_clk->params, rate / 1000);
> +	v_clk->rate = icst307_khz(&v_clk->params, vco) * 1000;
> +	v_clk->setvco(v_clk, vco);
> +
> +	return 0;
> +}

Could struct icst307_vco be part of struct clk_icst307?

If so, clk_icst307_set_rate could use clk_icst307_round_rate like this:

int clk_icst307_set_rate(struct clk *clk, unsigned long rate)
{
	struct clk_icst307 *v_clk = to_clk_icst307(clk);

	v_clk->rate = clk_icst307_round_rate(clk, rate);
	v_clk->setvco(v_clk);

	return 0;
}

Regards,
Hartley
