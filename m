From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 22:46:17 +0800
Subject: [linux-sunxi] [PATCH v4 2/3] clk: sunxi-ng: nkm: add support for
 fixed post-divider
In-Reply-To: <20170812124352.24148-3-icenowy@aosc.io>
References: <20170812124352.24148-1-icenowy@aosc.io>
 <20170812124352.24148-3-icenowy@aosc.io>
Message-ID: <CAGb2v65k6viZ2Y6nwQERAD9xYTjVGBmpnb9m17JkbJXJMpYteA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 8:43 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> SATA PLL on Allwinner R40 is of type (parent) * N * K / M / 6 where 6 is
> the fixed post-divider.
>
> Add post-divider support for NKM type clock.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 22 +++++++++++++++++++---
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 44b16dc8fea6..ce7f03737ad5 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c

[...]

> @@ -139,6 +152,9 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>         unsigned long flags;
>         u32 reg;
>
> +       if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +               rate /= nkm->fixed_post_div;

This should be

        rate *= nkm->fixed_post_div;

Fixed and applied.

ChenYu

> +
>         _nkm.min_n = nkm->n.min ?: 1;
>         _nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
>         _nkm.min_k = nkm->k.min ?: 1;

[...]
