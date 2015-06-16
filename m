From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 16 Jun 2015 12:23:28 +0200
Subject: [PATCH v3 1/3] clk: Add regmap support
In-Reply-To: <1433864283-25490-2-git-send-email-matthias.bgg@gmail.com>
References: <1433864283-25490-1-git-send-email-matthias.bgg@gmail.com>
 <1433864283-25490-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAGhQ9VwDQZ77OCOKKd4nFipqRhfa3GVWVMeWC3eiEoh2x9E_CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 June 2015 at 17:38, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> Some devices like SoCs from Mediatek need to use the clock
> through a regmap interface.
> This patch adds regmap support for the simple multiplexer clock,
> the divider clock and the clock gate code.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/clk/Makefile         |   1 +
>  drivers/clk/clk-divider.c    |  71 ++++++++++++++++++++------
>  drivers/clk/clk-gate.c       |  60 +++++++++++++++++-----
>  drivers/clk/clk-io.c         |  62 +++++++++++++++++++++++
>  drivers/clk/clk-io.h         |  13 +++++
>  drivers/clk/clk-mux.c        |  94 +++++++++++++++++++++++++++++------
>  include/linux/clk-provider.h | 115 +++++++++++++++++++++++++++++++++++++++++--
>  7 files changed, 373 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/clk/clk-io.c
>  create mode 100644 drivers/clk/clk-io.h
[...]
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2e5df06..22acfd5 100644
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
> @@ -31,6 +32,7 @@
>  #define CLK_GET_RATE_NOCACHE   BIT(6) /* do not use the cached clk rate */
>  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
>  #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
> +#define CLK_USE_REGMAP BIT(9) /* clock uses regmap to access its registers */
>
>  struct clk_hw;
>  struct clk_core;
> @@ -271,6 +273,8 @@ void of_fixed_clk_setup(struct device_node *np);
>   *
>   * @hw:                handle between common and hardware-specific interfaces
>   * @reg:       register controlling gate
> + * @regmap:    regmap used to control the gate
> + * @offset:    offset inside the regmap
>   * @bit_idx:   single bit controlling gate
>   * @flags:     hardware-specific flags
>   * @lock:      register lock
> @@ -288,7 +292,11 @@ void of_fixed_clk_setup(struct device_node *np);
>   */
>  struct clk_gate {
>         struct clk_hw hw;
> -       void __iomem    *reg;
> +       union {
> +               void __iomem    *reg;
> +               struct regmap   *regmap;
> +       };
> +       u32             offset;

Maybe using a named union here would be nice here. Something like:
union clk_io {
               void __iomem    *reg;
               struct regmap   *regmap;
};

And you could use this in the clk_gate, clk_mux, and clk_div
structures as well as your clk_io_* functions.
Having both void __iomem *reg and struct regmap *regmap as function
parameters seems a bit awkward to me.

Or maybe even as a structure:
struct clk_io {
               union {
                              void __iomem    *reg;
                              struct regmap   *regmap;
               };
               u32 offset;
}

What do you think?


I would also like to see this land so thanks for doing this work Matthias.
Hope some clk maintainer will have the time to look at it soon also.

regards,
Joachim Eastwood
