From: drinkcat@chromium.org (Nicolas Boichat)
Date: Tue, 13 Nov 2018 08:18:52 -0800
Subject: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
In-Reply-To: <20181106064206.17535-4-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
 <20181106064206.17535-4-weiyi.lu@mediatek.com>
Message-ID: <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> From: Owen Chen <owen.chen@mediatek.com>
>
> 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
>    add a variable to indicate this change and
>    backward-compatible.
> 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
>    1.5Ghz, add a variable to indicate platform-dependent.
>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 10 +++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index f83c2bbb677e..1882221fe994 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -215,7 +215,9 @@ struct mtk_pll_data {
>         const struct clk_ops *ops;
>         u32 rst_bar_mask;
>         unsigned long fmax;
> +       unsigned long fmin;

Minor nit: I'd put fmin before fmax in the structure.

>         int pcwbits;
> +       int pcwibits;
>         uint32_t pcw_reg;
>         int pcw_shift;
>         const struct mtk_pll_div_table *div_table;
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f54e4015b0b1..0ec2c62d9383 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c

I'd add a note next to:
#define INTEGER_BITS            7
to say that this is the default, and can be overridden with pcwibits.

> @@ -69,11 +69,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  {
>         int pcwbits = pll->data->pcwbits;
>         int pcwfbits;
> +       int ibits;
>         u64 vco;
>         u8 c = 0;
>
>         /* The fractional part of the PLL divider. */
> -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
>
>         vco = (u64)fin * pcw;
>
> @@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>                 u32 freq, u32 fin)
>  {
> -       unsigned long fmin = 1000 * MHZ;
> +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;

I'd put parentheses around (1000 * MHZ), to avoid the need to think
about precedence...

>         const struct mtk_pll_div_table *div_table = pll->data->div_table;
>         u64 _pcw;
> +       int ibits;
>         u32 val;
>
>         if (freq > pll->data->fmax)
> @@ -164,7 +167,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>         }
>
>         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
>         do_div(_pcw, fin);
>
>         *pcw = (u32)_pcw;
> --
> 2.18.0
>
