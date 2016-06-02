From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 20:02:54 -0500
Subject: [PATCH 03/34] clk: highbank: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-4-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-4-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqJabV618xcAwoSOZT7D8TJ825N3SxS+qV_MGYcSUGidHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 6:15 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers in this driver, allowing us to
> move closer to a clear split of consumer and provider clk APIs.
>
> Cc: Rob Herring <robh@kernel.org>

Acked-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>
> See commit 58657d189a2f and it's children for details on this
> new registration API.
>
>  drivers/clk/clk-highbank.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
> index be3a21abb185..727ed8e1bb72 100644
> --- a/drivers/clk/clk-highbank.c
> +++ b/drivers/clk/clk-highbank.c
> @@ -275,7 +275,6 @@ static const struct clk_ops periclk_ops = {
>  static __init struct clk *hb_clk_init(struct device_node *node, const struct clk_ops *ops)
>  {
>         u32 reg;
> -       struct clk *clk;
>         struct hb_clk *hb_clk;
>         const char *clk_name = node->name;
>         const char *parent_name;
> @@ -308,13 +307,13 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
>
>         hb_clk->hw.init = &init;
>
> -       clk = clk_register(NULL, &hb_clk->hw);
> -       if (WARN_ON(IS_ERR(clk))) {
> +       rc = clk_hw_register(NULL, &hb_clk->hw);
> +       if (WARN_ON(rc)) {
>                 kfree(hb_clk);
>                 return NULL;
>         }
> -       rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> -       return clk;
> +       rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &hb_clk->hw);
> +       return hb_clk->hw.clk;
>  }
>
>  static void __init hb_pll_init(struct device_node *node)
> --
> 2.7.4
>
