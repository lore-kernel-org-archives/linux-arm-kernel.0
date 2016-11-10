From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Nov 2016 14:18:10 +0800
Subject: [PATCH 1/10] clk: sunxi-ng: multiplier: Add fractionnal support
In-Reply-To: <b3d3436c03e0597de205f674061892dbc9498a7e.1478625788.git-series.maxime.ripard@free-electrons.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <b3d3436c03e0597de205f674061892dbc9498a7e.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65SbPfk4=+Uw2f+JQKQCp9+XW-P3tG=CNq+YW_AmMbb3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 1:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Nit: Typo in the subject ("fractional"). Maybe mention what clock on what SoC
needs this in the commit message?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/clk/sunxi-ng/ccu_mult.c | 8 ++++++++
>  drivers/clk/sunxi-ng/ccu_mult.h | 2 ++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
> index 678b6cb49f01..826302464650 100644
> --- a/drivers/clk/sunxi-ng/ccu_mult.c
> +++ b/drivers/clk/sunxi-ng/ccu_mult.c
> @@ -75,6 +75,9 @@ static unsigned long ccu_mult_recalc_rate(struct clk_hw *hw,
>         unsigned long val;
>         u32 reg;
>
> +       if (ccu_frac_helper_is_enabled(&cm->common, &cm->frac))
> +               return ccu_frac_helper_read_rate(&cm->common, &cm->frac);
> +
>         reg = readl(cm->common.base + cm->common.reg);
>         val = reg >> cm->mult.shift;
>         val &= (1 << cm->mult.width) - 1;
> @@ -102,6 +105,11 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
>         unsigned long flags;
>         u32 reg;
>
> +       if (ccu_frac_helper_has_rate(&cm->common, &cm->frac, rate))
> +               return ccu_frac_helper_set_rate(&cm->common, &cm->frac, rate);
> +       else
> +               ccu_frac_helper_disable(&cm->common, &cm->frac);
> +
>         ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
>                                                 &parent_rate);
>
> diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
> index c1a2134bdc71..bd2e38b5a32a 100644
> --- a/drivers/clk/sunxi-ng/ccu_mult.h
> +++ b/drivers/clk/sunxi-ng/ccu_mult.h
> @@ -2,6 +2,7 @@
>  #define _CCU_MULT_H_
>
>  #include "ccu_common.h"
> +#include "ccu_frac.h"
>  #include "ccu_mux.h"
>
>  struct ccu_mult_internal {
> @@ -23,6 +24,7 @@ struct ccu_mult_internal {
>  struct ccu_mult {
>         u32                     enable;
>
> +       struct ccu_frac_internal        frac;
>         struct ccu_mult_internal        mult;
>         struct ccu_mux_internal mux;
>         struct ccu_common       common;
> --
> git-series 0.8.11
