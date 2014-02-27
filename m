From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 27 Feb 2014 10:58:49 +0100
Subject: [PATCH 1/3] clk: socfpga: Fix integer overflow in clock
 calculation
In-Reply-To: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
References: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140227095849.GL6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:11:10PM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Use 64-bit integer for calculating clock rate. Also use do_div for the
> 64-bit division.
Some details would be interesting, depending on that some clever math
would be a cheaper alternative.
 
> Signed-off-by: Graham Moore <grmoore@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/clk/socfpga/clk-pll.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index 362004e..834b6e9 100644
> --- a/drivers/clk/socfpga/clk-pll.c
> +++ b/drivers/clk/socfpga/clk-pll.c
> @@ -44,7 +44,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>  					 unsigned long parent_rate)
>  {
>  	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
> -	unsigned long divf, divq, vco_freq, reg;
> +	unsigned long divf, divq, reg;
> +	unsigned long long vco_freq;
>  	unsigned long bypass;
>  
>  	reg = readl(socfpgaclk->hw.reg);
> @@ -54,8 +55,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>  
>  	divf = (reg & SOCFPGA_PLL_DIVF_MASK) >> SOCFPGA_PLL_DIVF_SHIFT;
>  	divq = (reg & SOCFPGA_PLL_DIVQ_MASK) >> SOCFPGA_PLL_DIVQ_SHIFT;
> -	vco_freq = parent_rate * (divf + 1);
> -	return vco_freq / (1 + divq);
> +	vco_freq = (unsigned long long)parent_rate * (divf + 1);
> +	do_div(vco_freq, (1 + divq));
> +	return (unsigned long)vco_freq;

You want

	f = some value in [1; 8192]
	q = some value in [1; 64]

	return parent_rate * f / q;

(with mathematic rounding?). Depending on the values not only
parent_rate * f doesn't fit into a 32 bit value, but also
parent_rate * f / q. This isn't catched.

Something like that might work, too:

	i = parent_rate // q
	j = parent_rate % q

	return i * f + j * f / q

j * f cannot overflow because they are in the range [0; 63] and
[1; 8192] respectively. And if i * f overflows your vco_freq above is to
big to fit into an unsigned long, too.

I didn't check with paper and pencil or some testing if the results
match, but I think they do. I'm not sure how the two approaches compare
performance-wise, you use a 64bit division, I'm using two 32 bit
divisions. But I wouldn't be surprised if my approach was faster.
(Also note that gcc -O3 fails to use only two divisions for my algorithm
but uses three instead. There might be a kernel helper that is able to
calculate i and j above with a single division though.)

Also note that the cast in the return statement isn't needed. (It might
be good to have it though to signal that you might loose some bits for
the human reader though.)

(Reference: This is what I looked at:
	$ cat multdiv.c 
	unsigned multdiv_ukl(unsigned parent_rate, unsigned f, unsigned q)
	{
		unsigned i, j;

		i = parent_rate / q;
		j = parent_rate % q;

		return i * f + j * f / q;
	}

	unsigned multdiv_dinguyen(unsigned parent_rate, unsigned f, unsigned q)
	{
		return (unsigned long long)parent_rate * f / q;
	}
	$ arm-gcc -S -o - -O3 multdiv_ukl.c
	[...]
)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
