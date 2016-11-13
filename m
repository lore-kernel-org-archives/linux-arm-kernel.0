From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 13 Nov 2016 11:48:33 +0800
Subject: [PATCH 2/10] clk: sunxi-ng: nkm: Deal with fixed post dividers
In-Reply-To: <f8333c3a1f3308fcebd87bfc3710ce605f9bb595.1478625788.git-series.maxime.ripard@free-electrons.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <f8333c3a1f3308fcebd87bfc3710ce605f9bb595.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64YW+7Grr4NvjuhsDNM2bF_fuhTkdW6Hs1=MXK2LFne0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 1:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

It'd be better if you mentioned what clock needs this.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 17 ++++++++++++++---
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 9b840a47a94d..fd3c6a9d987c 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -75,7 +75,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
>                                         unsigned long parent_rate)
>  {
>         struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
> -       unsigned long n, m, k;
> +       unsigned long rate, n, m, k;
>         u32 reg;
>
>         reg = readl(nkm->common.base + nkm->common.reg);
> @@ -89,7 +89,11 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
>         m = reg >> nkm->m.shift;
>         m &= (1 << nkm->m.width) - 1;
>
> -       return parent_rate * (n + 1) * (k + 1) / (m + 1);
> +       rate = parent_rate * (n + 1) * (k + 1) / (m + 1);
> +       if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate /= nkm->fixed_post_div;
> +
> +       return rate;
>  }
>
>  static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> @@ -100,6 +104,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>         struct ccu_nkm *nkm = data;
>         struct _ccu_nkm _nkm;
>
> +       if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate *= nkm->fixed_post_div;
> +
>         _nkm.min_n = nkm->n.min;
>         _nkm.max_n = 1 << nkm->n.width;
>         _nkm.min_k = nkm->k.min;
> @@ -109,7 +116,11 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>
>         ccu_nkm_find_best(parent_rate, rate, &_nkm);
>
> -       return parent_rate * _nkm.n * _nkm.k / _nkm.m;
> +       rate = parent_rate * _nkm.n * _nkm.k / _nkm.m;
> +       if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate = rate / nkm->fixed_post_div;
> +
> +       return rate;
>  }
>

You also need to handle this in the set_rate callback. You might need
to read back
the parent index value to determine if the post divider applies, as
this clock supports
a mux. Or don't support mux + post-div, and leave a TODO note.

ChenYu

>  static int ccu_nkm_determine_rate(struct clk_hw *hw,
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index 34580894f4d1..0f1dbca25719 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -32,6 +32,8 @@ struct ccu_nkm {
>         struct ccu_mult_internal        n;
>         struct ccu_mult_internal        k;
>         struct ccu_div_internal         m;
> +
> +       unsigned int            fixed_post_div;
>         struct ccu_mux_internal mux;
>
>         struct ccu_common       common;
> --
> git-series 0.8.11
