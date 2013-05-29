From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 May 2013 16:44:18 -0700
Subject: [PATCH v2 2/5] clk: samsung: Add support to register rate_table
 for PLL3xxx
In-Reply-To: <1369834677-20312-3-git-send-email-vikas.sajjan@linaro.org>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-3-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=VDi+SfebiFnPNp8qR__9L=o9TJ+WSPRfRQLX+p+TMmJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas / Yadwinder,

On Wed, May 29, 2013 at 6:37 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>
> This patch defines a common rate_table which will contain recommended p, m, s,
> k values for supported rates that needs to be changed for changing
> corresponding PLL's rate.
>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |    8 ++++----
>  drivers/clk/samsung/clk-exynos5250.c |   14 +++++++-------
>  drivers/clk/samsung/clk-pll.c        |   14 ++++++++++++--
>  drivers/clk/samsung/clk-pll.h        |   33 +++++++++++++++++++++++++++++++--
>  4 files changed, 54 insertions(+), 15 deletions(-)

I also reviewed this in our gerrit
<https://gerrit.chromium.org/gerrit/#/c/56742/>, but I'll summarize
here for the list...

>  struct clk * __init samsung_clk_register_pll35xx(const char *name,
> -                       const char *pname, const void __iomem *base)
> +                       const char *pname, const void __iomem *base,
> +                       const struct samsung_pll_rate_table *rate_table,
> +                       const unsigned int rate_count)

Feels like you should document here that rate_table needs to be sorted
and the sort order.

> +struct samsung_pll_rate_table {
> +       unsigned  int rate;

nit: extra space before "int" should be removed.

Also: you can include rate here if you need a convenient place to
store it (which sadly means that this structure can't be const).
...but I do like Tomasz's idea of actually calculating it.  You can't
know it at compile time since the parent rate comes from the device
tree.

compatible = "samsung,clock-xxti";
clock-frequency = <24000000>;

> +       unsigned int pdiv;
> +       unsigned int mdiv;
> +       unsigned int sdiv;
> +       unsigned int kdiv;

I think kdiv is signed.

-Doug
