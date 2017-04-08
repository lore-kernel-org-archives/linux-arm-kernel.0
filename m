From: megi@xff.cz (=?UTF-8?Q?Ond=C5=99ej?= Jirman)
Date: Sat, 08 Apr 2017 23:59:48 +0200
Subject: [linux-sunxi] [PATCH 1/5] clk: sunxi-ng: prevent NKMP clocks
 from temporarily get higher freq
In-Reply-To: <20170408185025.53841-2-icenowy@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-2-icenowy@aosc.io>
Message-ID: <1491688788.19320.3.camel@xff.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

I already tried this approach to changing CPUX_PLL and it didn't work
well. I've written a test program for CPUS (additional RISC-V processor
on H3 SoC) for testing various NKMP clock change algorithms, by
randomly changing the PLL frequency. Everything except simply not using
dividers except for P for frequencies < 288MHz just led to crashes of
the main CPU.

It is really hard to rule out crashes just by using the kernel itself,
because it is hard to hit the wrong change in the combination of NKMP
clock factors.

Here's the code for CPUS test program: https://github.com/megous/h3-fir
mware

Your approach is similar to this (increase dividers if necessary, wait
a bit, then change multipliers, wait a bit, and then decrease dividers
if necessary) - which is the approach taken by Allwinner in their code:

https://github.com/megous/h3-firmware/blob/master/clk.c#L683

It sometimes works when done in the kernel, but it is not stable. You
might get a crash only if thermal throttling causes a specific
transition between two particular frequencies. It's hard and tedious to
reproduce. That's why I have written the test program. In the CPUS test
program it crashes the main CPU predictably in about 2 seconds.

You can try it yourself with your exact algorithm. I guess it will be
crashing too.

regards,
  o.j.

Icenowy Zheng p??e v Ne 09. 04. 2017 v 02:50 +0800:
> It seems that on newer SoCs (already observed on A33, H3), when setting
> all NKMP factors at the same time, the multiplier get applied first,
> then the divider get applied. In some situations (e.g. the multiplier
> increased but the divider decreased), this will make the clock
> frequency temporarily higher than both the original frequency and the
> target frequency, which may lead to system hang due to PLL_CPU(X) clock
> usually being a NKMP clock.
> 
> A comparsion between the old divider (M*P) and the new one is added, and
> if the divider get smaller when changing clock, the multiplier will be
> applied first, so that the clock won't go to a frequency higher than
> normal.
> 
> The interval between applying the first group of factors and the second
> group is based on experiments results on an Orange Pi Zero board.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 76 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index e58c95787f94..5da77eb60335 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  
>  #include "ccu_gate.h"
>  #include "ccu_nkmp.h"
> @@ -130,12 +131,49 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
>  	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
>  }
>  
> +static void ccu_nkmp_extract_factors(const struct ccu_nkmp *nkmp,
> +				     struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	_nkmp->n = ((reg >> nkmp->n.shift) & GENMASK(nkmp->n.width - 1, 0))
> +		   + nkmp->n.offset;
> +	_nkmp->k = ((reg >> nkmp->k.shift) & GENMASK(nkmp->k.width - 1, 0))
> +		   + nkmp->k.offset;
> +	_nkmp->m = ((reg >> nkmp->m.shift) & GENMASK(nkmp->m.width - 1, 0))
> +		   + nkmp->m.offset;
> +	_nkmp->p = 1 <<
> +		   ((reg >> nkmp->p.shift) & GENMASK(nkmp->p.width - 1, 0));
> +}
> +
> +static u32 ccu_nkmp_apply_multiplier(const struct ccu_nkmp *nkmp,
> +				     const struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> +	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> +
> +	reg |= (_nkmp->n - nkmp->n.offset) << nkmp->n.shift;
> +	reg |= (_nkmp->k - nkmp->k.offset) << nkmp->k.shift;
> +
> +	return reg;
> +}
> +
> +static u32 ccu_nkmp_apply_divider(const struct ccu_nkmp *nkmp,
> +				  const struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
> +	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
> +
> +	reg |= (_nkmp->m - nkmp->m.offset) << nkmp->m.shift;
> +	reg |= ilog2(_nkmp->p) << nkmp->p.shift;
> +
> +	return reg;
> +}
> +
>  static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long parent_rate)
>  {
>  	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> -	struct _ccu_nkmp _nkmp;
> -	unsigned long flags;
> +	struct _ccu_nkmp _nkmp, _nkmp_old;
> +	unsigned long flags, old_mp, mp;
>  	u32 reg;
>  
>  	_nkmp.min_n = nkmp->n.min ?: 1;
> @@ -152,17 +190,33 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>  	spin_lock_irqsave(nkmp->common.lock, flags);
>  
>  	reg = readl(nkmp->common.base + nkmp->common.reg);
> -	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> -	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> -	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
> -	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
>  
> -	reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
> -	reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
> -	reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
> -	reg |= ilog2(_nkmp.p) << nkmp->p.shift;
> +	ccu_nkmp_extract_factors(nkmp, &_nkmp_old, reg);
> +
> +	old_mp = _nkmp_old.m * _nkmp_old.p;
> +	mp = _nkmp.m * _nkmp.p;
> +
> +	if (mp > old_mp) {
> +		reg = ccu_nkmp_apply_divider(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +
> +		/*
> +		 * This value is decided by experiment results on an
> +		 * Allwinner H2+ board (Orange Pi Zero).
> +		 */
> +		udelay(500);
>  
> -	writel(reg, nkmp->common.base + nkmp->common.reg);
> +		reg = ccu_nkmp_apply_multiplier(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +	} else {
> +		reg = ccu_nkmp_apply_multiplier(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +
> +		udelay(500);
> +
> +		reg = ccu_nkmp_apply_divider(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +	}
>  
>  	spin_unlock_irqrestore(nkmp->common.lock, flags);
>  
> -- 
> 2.12.2
> 
