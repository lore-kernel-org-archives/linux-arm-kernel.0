From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 27 Aug 2015 11:30:35 +0200
Subject: [PATCH] clk: at91: add audio pll clock driver
In-Reply-To: <1438337864-27949-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438337864-27949-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150827113035.072cccb5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, 31 Jul 2015 12:17:44 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> This new clock driver set allows to have a fractional divided clock
> that would generate a precise clock particularly suitable for
> audio applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formula,
> they are handled by two different drivers.
> Each of them would modify the rate of the main audio pll parent.

Hm, not sure allowing both children to modify the parent clk rate is
a good idea, but let's see how it works.

> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt       |  38 +++
>  drivers/clk/at91/Makefile                          |   2 +
>  drivers/clk/at91/clk-audio-pll-pad.c               | 220 +++++++++++++++++
>  drivers/clk/at91/clk-audio-pll-pmc.c               | 171 ++++++++++++++
>  drivers/clk/at91/clk-audio-pll.c                   | 261 +++++++++++++++++++++
>  drivers/clk/at91/pmc.c                             |  14 ++
>  drivers/clk/at91/pmc.h                             |   7 +
>  include/linux/clk/at91_pmc.h                       |  25 ++
>  8 files changed, 738 insertions(+)
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll.c
> 

[...]

> +
> +static int clk_audio_pll_compute_qdpad(unsigned long q_rate, unsigned long rate,
> +				       unsigned long *qd, u8 *div, u8 *ext_div)
> +{
> +	unsigned long tmp_qd;
> +	unsigned long rem2, rem3;
> +	unsigned long ldiv, lext_div;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	tmp_qd = q_rate / rate;
> +	if (!tmp_qd || tmp_qd > AUDIO_PLL_QDPAD_MAX)
> +		return -EINVAL;

Do you really want to return an error in this case?
I mean, you're calling this function from ->round_rate(), and
->round_rate() is supposed to find the closest rate, not to return an
error if the rate is too low or to high.
ITOH, you're calling the same function from ->set_rate(), which is
supposed to complain if the requested rate is not exactly met.

Maybe you can deal with that by passing an additional argument to this
function. Something like:

	tmp_qd = q_rate / rate;

	if (!strict) {
		if (!tmp_qd)
			tmp_qd = 1;
		else if (tmp_qd > AUDIO_PLL_QDPAD_MAX)
			tmp_qd = AUDIO_PLL_QDPAD_MAX;
	}

	if (!tmp_qd || tmp_qd > AUDIO_PLL_QDPAD_MAX)
		return -EINVAL;

> +
> +	if (tmp_qd <= AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX) {
> +		ldiv = 1;
> +		lext_div = tmp_qd;
> +	} else {
> +		rem2 = tmp_qd % 2;
> +		rem3 = tmp_qd % 3;
> +
> +		if (rem3 == 0 ||
> +		    tmp_qd > AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX * 2 ||
> +		    rem3 < rem2) {
> +			ldiv = 3;
> +			lext_div = tmp_qd / 3;
> +		} else {
> +			ldiv = 2;
> +			lext_div = tmp_qd >> 1;
> +		}
> +	}
> +
> +	pr_debug("A PLL/PAD: %s, qd = %lu (div = %lu, ext_div = %lu)\n",
> +		 __func__, ldiv * lext_div, ldiv, lext_div);
> +
> +	/* if we were given variable to store, we can provide them */
> +	if (qd)
> +		*qd = ldiv * lext_div;
> +	if (div && ext_div) {
> +		/* we can cast here as we verified the bounds just above */
> +		*div = (u8)ldiv;
> +		*ext_div = (u8)lext_div;
> +	}
> +
> +	return 0;
> +}
> +
> +static long clk_audio_pll_pad_round_rate(struct clk_hw *hw, unsigned long rate,
> +					 unsigned long *parent_rate)

I thought we were trying to get rid of the ->round_rate() function in
favor of the ->determine_rate() one (which is more flexible), but maybe
I'm wrong. Stephen, Mike, what's your opinion?

> +{
> +	struct clk *pclk = __clk_get_parent(hw->clk);
> +	long best_rate = -EINVAL;
> +	unsigned long best_parent_rate = 0;
> +	unsigned long tmp_qd;
> +
> +	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n",
> +		 __func__, rate, *parent_rate);
> +
> +	if (clk_audio_pll_compute_qdpad(AUDIO_PLL_REFERENCE_FOUT, rate,
> +					&tmp_qd, NULL, NULL))
> +		return -EINVAL;

You're calculating your divisor based on the AUDIO_PLL_REFERENCE_FOUT
value...

> +
> +	best_parent_rate = __clk_round_rate(pclk, rate * tmp_qd);

... and then asking your parent to adapt its rate based on the returned
divisor. Wouldn't it be preferable to search for the best parent rate
when choosing the divisor?

> +	best_rate = best_parent_rate / tmp_qd;
> +
> +	pr_debug("A PLL/PAD: %s, best_rate = %ld, best_parent_rate = %lu\n",
> +		 __func__, best_rate, best_parent_rate);
> +
> +	*parent_rate = best_parent_rate;
> +	return best_rate;
> +}

[...]

> +
> +static long clk_audio_pll_pmc_round_rate(struct clk_hw *hw, unsigned long rate,
> +					 unsigned long *parent_rate)
> +{
> +	struct clk *pclk = __clk_get_parent(hw->clk);
> +	long best_rate = -EINVAL;
> +	unsigned long best_parent_rate = 0;
> +	unsigned long tmp_qd;
> +
> +	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n",
> +		 __func__, rate, *parent_rate);
> +
> +	if (clk_audio_pll_compute_qdpmc(AUDIO_PLL_REFERENCE_FOUT, rate, &tmp_qd))
> +		return -EINVAL;
> +
> +	best_parent_rate = __clk_round_rate(pclk, rate * tmp_qd);

Ditto.

BTW, I'm not sure this is safe to allow both pll-audio children to
change their parent rate. What will happen if one of them change the
pll-audio rate while the other is still using it?

> +	best_rate = best_parent_rate / tmp_qd;
> +
> +	pr_debug("A PLL/PMC: %s, best_rate = %ld, best_parent_rate = %lu (qd = %lu)\n",
> +		 __func__, best_rate, best_parent_rate, tmp_qd - 1);
> +
> +	*parent_rate = best_parent_rate;
> +	return best_rate;
> +}

[...]

> +
> +#define to_clk_audio_frac(hw) container_of(hw, struct clk_audio_frac, hw)
> +
> +/* make sure that pll is in reset state beforehand */
> +static int clk_audio_pll_prepare(struct clk_hw *hw)
> +{
> +	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
> +	struct at91_pmc *pmc = fck->pmc;
> +	u32 tmp;
> +
> +	pmc_lock(pmc);
> +	tmp = pmc_read(pmc, AT91_PMC_AUDIO_PLL0) & ~AT91_PMC_AUDIO_PLL_RESETN;
> +	pmc_write(pmc, AT91_PMC_AUDIO_PLL0, tmp);
> +	pmc_unlock(pmc);

Nothing sleeps in this code, so you could move everything in your
->enable() function.

> +	return 0;
> +}
> +
> +static void clk_audio_pll_unprepare(struct clk_hw *hw)
> +{
> +	clk_audio_pll_prepare(hw);

Ditto.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
