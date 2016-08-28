From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 28 Aug 2016 17:21:08 +0200
Subject: [RFC PATCH] clk: rockchip: rk3399: support pll setting
 automatically
In-Reply-To: <1470144852-20708-1-git-send-email-zhengxing@rock-chips.com>
References: <1470144852-20708-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <4830789.1bI8OsvZy1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing, Elaine,

Am Dienstag, 2. August 2016, 21:34:12 schrieb Xing Zheng:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The goal is that we can configure the most suitable pll params
> automatically.
> 
> If setting freq is not supported in rockchip_pll_rate_table
> rk3399_pll_rates[], we can set pll params automatically.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

first off, I really like that idea of calculating the generic pll frequencies 
instead of duplicating these entries in every soc clock driver.

Please also provide a follow up patch, removing the then unneeded frequencies 
from the rate tables.

I still have some comments inline below:

> ---
> 
>  drivers/clk/rockchip/clk-pll.c |  213
> +++++++++++++++++++++++++++++++++++++--- 1 file changed, 200 insertions(+),
> 13 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 35994e8..08979f9 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -23,6 +23,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/gcd.h>
>  #include "clk.h"
> 
>  #define PLL_MODE_MASK		0x3
> @@ -54,6 +55,200 @@ struct rockchip_clk_pll {
>  #define to_rockchip_clk_pll_nb(nb) \
>  			container_of(nb, struct rockchip_clk_pll, clk_nb)
> 
> +#define MHZ			(1000UL * 1000UL)
> +#define KHZ			(1000UL)
> +
> +/* CLK_PLL_TYPE_RK3066_AUTO type ops */

wouldn't that better be 
/* rk3066 pll frequency ranges */

> +#define PLL_FREF_MIN		(269 * KHZ)
> +#define PLL_FREF_MAX		(2200 * MHZ)
> +
> +#define PLL_FVCO_MIN		(440 * MHZ)
> +#define PLL_FVCO_MAX		(2200 * MHZ)
> +
> +#define PLL_FOUT_MIN		(27500 * KHZ)
> +#define PLL_FOUT_MAX		(2200 * MHZ)
> +
> +#define PLL_NF_MAX		(4096)
> +#define PLL_NR_MAX		(64)
> +#define PLL_NO_MAX		(16)

instead of using a comment, please prefix these constants accordingly, like
	RK3066_PLL_FVCO_MIN
etc, especially as some of those contstraints actually _are different_ between 
implementations. See rk3188 vs. rk3288 for example. With the current static 
rate table we just have matching values already, so never had to care about 
that.

Another idea might be to have the constraints as table in the soc clock-
drivers, similar to how we transfer we handle the rate tables right now.

> +
> +/* CLK_PLL_TYPE_RK3036/3366/3399_AUTO type ops */
> +#define MIN_FOUTVCO_FREQ	(800 * MHZ)
> +#define MAX_FOUTVCO_FREQ	(2000 * MHZ)

same here, RK3036_PLL_FOUTVCO_MIN etc.

> +
> +static struct rockchip_pll_rate_table auto_table;
> +
> +static struct rockchip_pll_rate_table *rk_pll_rate_table_get(void)
> +{
> +	return &auto_table;
> +}
> +
> +static int rockchip_pll_clk_set_postdiv(unsigned long fout_hz,

the rk3036, rk3366, rk3399 pll type won't be the last one Rockchip will use, 
so please add a prefix. Same for everything else below :-) .

> +					u32 *postdiv1,
> +					u32 *postdiv2,
> +					u32 *foutvco)
> +{
> +	unsigned long freq;
> +
> +	if (fout_hz < MIN_FOUTVCO_FREQ) {
> +		for (*postdiv1 = 1; *postdiv1 <= 7; (*postdiv1)++) {
> +			for (*postdiv2 = 1; *postdiv2 <= 7; (*postdiv2)++) {
> +				freq = fout_hz * (*postdiv1) * (*postdiv2);
> +				if (freq >= MIN_FOUTVCO_FREQ &&
> +				    freq <= MAX_FOUTVCO_FREQ) {
> +					*foutvco = freq;
> +					return 0;
> +				}
> +			}
> +			pr_err("CANNOT FIND postdiv1/2 to make fout in range from 800M to
> 2000M,fout = %lu\n", +			       fout_hz);
> +		}
> +	} else {
> +		*postdiv1 = 1;
> +		*postdiv2 = 1;
> +	}
> +	return 0;
> +}
> +
> +static struct rockchip_pll_rate_table *
> +rockchip_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
> +			     unsigned long fin_hz,
> +			     unsigned long fout_hz)
> +{
> +	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
> +	/* FIXME set postdiv1/2 always 1*/
> +	u32 foutvco = fout_hz;
> +	u64 fin_64, frac_64;
> +	u32 f_frac, postdiv1, postdiv2;
> +	unsigned long clk_gcd = 0;
> +
> +	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
> +		return NULL;
> +
> +	rockchip_pll_clk_set_postdiv(fout_hz, &postdiv1, &postdiv2, &foutvco);
> +	rate_table->postdiv1 = postdiv1;
> +	rate_table->postdiv2 = postdiv2;
> +	rate_table->dsmpd = 1;
> +
> +	if (fin_hz / MHZ * MHZ == fin_hz && fout_hz / MHZ * MHZ == fout_hz) {
> +		fin_hz /= MHZ;
> +		foutvco /= MHZ;
> +		clk_gcd = gcd(fin_hz, foutvco);
> +		rate_table->refdiv = fin_hz / clk_gcd;
> +		rate_table->fbdiv = foutvco / clk_gcd;
> +
> +		rate_table->frac = 0;
> +
> +		pr_debug("fin = %lu, fout = %lu, clk_gcd = %lu, refdiv = %u, fbdiv = 
%u,
> postdiv1 = %u, postdiv2 = %u, frac = %u\n", +			 fin_hz, fout_hz, 
clk_gcd,
> rate_table->refdiv,
> +			 rate_table->fbdiv, rate_table->postdiv1,
> +			 rate_table->postdiv2, rate_table->frac);
> +	} else {
> +		pr_debug("frac div running, fin_hz = %lu, fout_hz = %lu, fin_INT_mhz =
> %lu, fout_INT_mhz = %lu\n", +			 fin_hz, fout_hz,
> +			 fin_hz / MHZ * MHZ,
> +			 fout_hz / MHZ * MHZ);
> +		pr_debug("frac get postdiv1 = %u,  postdiv2 = %u, foutvco = %u\n",
> +			 rate_table->postdiv1, rate_table->postdiv2, foutvco);
> +		clk_gcd = gcd(fin_hz / MHZ, foutvco / MHZ);
> +		rate_table->refdiv = fin_hz / MHZ / clk_gcd;
> +		rate_table->fbdiv = foutvco / MHZ / clk_gcd;
> +		pr_debug("frac get refdiv = %u,  fbdiv = %u\n",
> +			 rate_table->refdiv, rate_table->fbdiv);
> +
> +		rate_table->frac = 0;
> +
> +		f_frac = (foutvco % MHZ);
> +		fin_64 = fin_hz;
> +		do_div(fin_64, (u64)rate_table->refdiv);
> +		frac_64 = (u64)f_frac << 24;
> +		do_div(frac_64, fin_64);
> +		rate_table->frac = (u32)frac_64;
> +		if (rate_table->frac > 0)
> +			rate_table->dsmpd = 0;
> +		pr_debug("frac = %x\n", rate_table->frac);
> +	}
> +	return rate_table;
> +}
> +
> +static struct rockchip_pll_rate_table *
> +rockchip_rk3066_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
> +				    unsigned long fin_hz,
> +				    unsigned long fout_hz)
> +{
> +	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
> +	u32 nr, nf, no, nonr;
> +	u32 nr_out, nf_out, no_out;
> +	u32 n;
> +	u32 numerator, denominator;
> +	u64 fref, fvco, fout;
> +	unsigned long clk_gcd = 0;
> +
> +	nr_out = PLL_NR_MAX + 1;
> +	nf_out = 0;
> +	no_out = 0;
> +
> +	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
> +		return NULL;
> +
> +	clk_gcd = gcd(fin_hz, fout_hz);
> +
> +	numerator = fout_hz / clk_gcd;
> +	denominator = fin_hz / clk_gcd;
> +
> +	for (n = 1;; n++) {
> +		nf = numerator * n;
> +		nonr = denominator * n;
> +		if (nf > PLL_NF_MAX || nonr > (PLL_NO_MAX * PLL_NR_MAX))
> +			break;
> +
> +		for (no = 1; no <= PLL_NO_MAX; no++) {
> +			if (!(no == 1 || !(no % 2)))
> +				continue;
> +
> +			if (nonr % no)
> +				continue;
> +			nr = nonr / no;
> +
> +			if (nr > PLL_NR_MAX)
> +				continue;
> +
> +			fref = fin_hz / nr;
> +			if (fref < PLL_FREF_MIN || fref > PLL_FREF_MAX)
> +				continue;
> +
> +			fvco = fref * nf;
> +			if (fvco < PLL_FVCO_MIN || fvco > PLL_FVCO_MAX)
> +				continue;
> +
> +			fout = fvco / no;
> +			if (fout < PLL_FOUT_MIN || fout > PLL_FOUT_MAX)
> +				continue;
> +
> +			/* select the best from all available PLL settings */
> +			if ((no > no_out) ||
> +			    ((no == no_out) && (nr < nr_out))) {
> +				nr_out = nr;
> +				nf_out = nf;
> +				no_out = no;
> +			}
> +		}
> +	}
> +
> +	/* output the best PLL setting */
> +	if ((nr_out <= PLL_NR_MAX) && (no_out > 0)) {
> +		if (rate_table->nr && rate_table->nf && rate_table->no) {
> +			rate_table->nr = nr_out;
> +			rate_table->nf = nf_out;
> +			rate_table->no = no_out;
> +		}
> +	} else {
> +		return NULL;
> +	}
> +
> +	return rate_table;
> +}
> +
>  static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
>  			    struct rockchip_clk_pll *pll, unsigned long rate)
>  {
> @@ -65,24 +260,16 @@ static const struct rockchip_pll_rate_table
> *rockchip_get_pll_settings( return &rate_table[i];
>  	}
> 
> -	return NULL;
> +	if (pll->type == pll_rk3066)

this should be a switch as well, to prepare for other pll types.

> +		return rockchip_rk3066_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
> +	else
> +		return rockchip_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
>  }
> 

Heiko
