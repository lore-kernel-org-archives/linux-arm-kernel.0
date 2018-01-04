From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 22:45:18 +0800
Subject: [PATCH 01/11] clk: sunxi-ng: Don't set k if width is 0 for nkmp
 plls
In-Reply-To: <20171230210203.24115-2-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-2-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67B23yUdACijKxosfFG_os5WndiBKX02DGA4PFUkxDx9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 31, 2017 at 5:01 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> For example, A83T have nmp plls which are modelled as nkmp plls. Since k
> is not specified, it has offset 0, shift 0 and lowest value 1. This
> means that LSB bit is always set to 1, which may change clock rate.
>
> Fix that by applying k factor only if k width is greater than 0.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index e58c95787f94..709f528af2b3 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -81,7 +81,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
>                                         unsigned long parent_rate)
>  {
>         struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> -       unsigned long n, m, k, p;
> +       unsigned long n, m, k = 1, p;
>         u32 reg;
>
>         reg = readl(nkmp->common.base + nkmp->common.reg);
> @@ -92,11 +92,13 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
>         if (!n)
>                 n++;
>
> -       k = reg >> nkmp->k.shift;
> -       k &= (1 << nkmp->k.width) - 1;
> -       k += nkmp->k.offset;
> -       if (!k)
> -               k++;
> +       if (nkmp->k.width) {
> +               k = reg >> nkmp->k.shift;
> +               k &= (1 << nkmp->k.width) - 1;
> +               k += nkmp->k.offset;
> +               if (!k)
> +                       k++;
> +       }

The conditional shouldn't be necessary. With nkmp->k.width = 0,
you'd simply get k & 0, which is 0, which then gets bumped up to 1,
unless k.offset > 1, which would be a bug.

>
>         m = reg >> nkmp->m.shift;
>         m &= (1 << nkmp->m.width) - 1;
> @@ -153,12 +155,15 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>
>         reg = readl(nkmp->common.base + nkmp->common.reg);
>         reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> -       reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> +       if (nkmp->k.width)
> +               reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1,
> +                               nkmp->k.shift);
>         reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
>         reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
>
>         reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
> -       reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
> +       if (nkmp->k.width)
> +               reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;

I think a better way would be

        reg |= ((_nkmp.k - nkmp->k.offset) << nkmp->k.shift) &
               GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);

And do this for all the factors, not just k. This pattern is what
regmap_update_bits does, which seems much safer. I wonder what
GENMASK() with a negative value would do though...

ChenYu

>         reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
>         reg |= ilog2(_nkmp.p) << nkmp->p.shift;
>
> --
> 2.15.1
>
