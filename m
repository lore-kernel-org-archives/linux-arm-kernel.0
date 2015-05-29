From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 29 May 2015 18:54:20 +0200
Subject: [PATCH v2 1/3] clk: mux: Add regmap support for simple mux
In-Reply-To: <1432915288-14034-2-git-send-email-matthias.bgg@gmail.com>
References: <1432915288-14034-1-git-send-email-matthias.bgg@gmail.com>
 <1432915288-14034-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAGhQ9Vzny3VLbs8ZFE1--nbGguqk=JH4hYpdOHcd=+Vu8tqibQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2015 at 18:01, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> Some devices like SoCs from Mediatek need to use the clock muxes
> through a regmap interface.
> This patch adds regmap support for the simple multiplexer
> clock code.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/clk/clk-mux.c        | 134 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/clk-provider.h |  44 +++++++++++++-
>  2 files changed, 162 insertions(+), 16 deletions(-)

What is this patch generated against?

I can't seem to apply it to either clk-next, next or Linus master.


> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 1fa2a8d..6f75116 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -29,6 +29,43 @@
>
>  #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
>
> +static void clk_mux_writel(struct clk_mux *mux, u32 val)
> +{
> +       if (mux->flags & CLK_MUX_USE_REGMAP)
> +               regmap_write(mux->regmap, mux->offset, val);
> +       else
> +               clk_writel(val, mux->reg);
> +}
> +
> +static u32 clk_mux_readl(struct clk_mux *mux)
> +{
> +       u32 val;
> +
> +       if (mux->flags & CLK_MUX_USE_REGMAP)
> +               regmap_read(mux->regmap, mux->offset, &val);
> +       else
> +               val = clk_readl(mux->reg);
> +
> +       return val;
> +}
> +
> +static int clk_mux_update_bits(struct clk_mux *mux, u32 mask, u32 val)
> +{
> +       unsigned int ret;
> +
> +       if (mux->flags & CLK_MUX_USE_REGMAP) {
> +               ret = regmap_update_bits(mux->regmap, mux->offset, mask, val);

If you just do a "return regmap_update_bits(...)" here you can drop
the else below and also remove the ret variable.

> +       } else {
> +               ret = clk_readl(mux->reg);
> +               ret &= ~mask;
> +               ret |= val;
> +               clk_writel(ret, mux->reg);
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}

The three functions above seems pretty generic and should be usable in
both gate and divider as well. Maybe we could figure out a way to
share them across the mux, gate and divider clk drivers.


> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index ec609e5..c7487ad 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/regmap.h>
>
>  #ifdef CONFIG_COMMON_CLK
>
> @@ -408,8 +409,12 @@ void clk_unregister_divider(struct clk *clk);
>   */
>  struct clk_mux {
>         struct clk_hw   hw;
> -       void __iomem    *reg;
> +       union {
> +               void __iomem    *reg;
> +               struct regmap   *regmap;
> +       };
>         u32             *table;
> +       u32             offset;
>         u32             mask;
>         u8              shift;
>         u8              flags;
> @@ -421,6 +426,7 @@ struct clk_mux {
>  #define CLK_MUX_HIWORD_MASK            BIT(2)
>  #define CLK_MUX_READ_ONLY              BIT(3) /* mux can't be changed */
>  #define CLK_MUX_ROUND_CLOSEST          BIT(4)
> +#define CLK_MUX_USE_REGMAP             BIT(5)

Since you are adding both fields and a flag to struct clk_mux it would
be nice if you could update the documentation above the struct
definition in clk-provider.h also.

regards,
Joachim Eastwood
