From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 Feb 2016 21:03:40 +0800
Subject: [PATCH RFC 10/11] clk: sunxi: rewrite sun6i-ar100 using factors
 clk
In-Reply-To: <CAP=VYLosgmUbk3hmeTkodZoVhZX6e74aG28HSgLVKaD4mR3W+A@mail.gmail.com>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-11-git-send-email-wens@csie.org>
 <CAP=VYLosgmUbk3hmeTkodZoVhZX6e74aG28HSgLVKaD4mR3W+A@mail.gmail.com>
Message-ID: <CAGb2v65cTW+z5xnO0eikh=nF+4LnrZVJ6jCJ0K-65qQdTmSvCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 12:59 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Mon, Jan 25, 2016 at 8:15 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> sun6i's AR100 clock is a classic factors clk case:
>>
>> AR100 = ((parent mux) >> p) / (m + 1)
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> This patch adds a ".remove" function to a driver that is controlled by
> a bool Kconfig, and hence the remove code can't be called unless
> one explicitly goes into sysfs and muddles with the unbind as root
> (which normally has no sane use case for builtin, non-modular code).
>
> Since I'm trying to cut back on the amount of dead code we have
> in .remove functions for built in drivers, is there a valid use case
> for this one here, or can I just stage a delete commit for it too?

It's just there to balance the probe code. I thought it was missing.
But what you said makes sense. Go ahead.

> Normally I've set the set the disallow-unbind flag when deleting
> a .remove function to make it clear there is no sane use case
> for wandering into sysfs and unhooking the builtin driver.

Cool.

Thanks
ChenYu

>
> Thanks,
> Paul.
> --
>
>> ---
>>  drivers/clk/sunxi/clk-sun6i-ar100.c | 235 ++++++++++--------------------------
>>  1 file changed, 61 insertions(+), 174 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
>> index 20887686bdbe..a7f5777834eb 100644
>> --- a/drivers/clk/sunxi/clk-sun6i-ar100.c
>> +++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
>> @@ -8,211 +8,97 @@
>>   *
>>   */
>>
>> +#include <linux/bitops.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>>
>> -#define SUN6I_AR100_MAX_PARENTS                4
>> -#define SUN6I_AR100_SHIFT_MASK         0x3
>> -#define SUN6I_AR100_SHIFT_MAX          SUN6I_AR100_SHIFT_MASK
>> -#define SUN6I_AR100_SHIFT_SHIFT                4
>> -#define SUN6I_AR100_DIV_MASK           0x1f
>> -#define SUN6I_AR100_DIV_MAX            (SUN6I_AR100_DIV_MASK + 1)
>> -#define SUN6I_AR100_DIV_SHIFT          8
>> -#define SUN6I_AR100_MUX_MASK           0x3
>> -#define SUN6I_AR100_MUX_SHIFT          16
>> -
>> -struct ar100_clk {
>> -       struct clk_hw hw;
>> -       void __iomem *reg;
>> -};
>> -
>> -static inline struct ar100_clk *to_ar100_clk(struct clk_hw *hw)
>> -{
>> -       return container_of(hw, struct ar100_clk, hw);
>> -}
>> -
>> -static unsigned long ar100_recalc_rate(struct clk_hw *hw,
>> -                                      unsigned long parent_rate)
>> -{
>> -       struct ar100_clk *clk = to_ar100_clk(hw);
>> -       u32 val = readl(clk->reg);
>> -       int shift = (val >> SUN6I_AR100_SHIFT_SHIFT) & SUN6I_AR100_SHIFT_MASK;
>> -       int div = (val >> SUN6I_AR100_DIV_SHIFT) & SUN6I_AR100_DIV_MASK;
>> -
>> -       return (parent_rate >> shift) / (div + 1);
>> -}
>> -
>> -static int ar100_determine_rate(struct clk_hw *hw,
>> -                               struct clk_rate_request *req)
>> -{
>> -       int nparents = clk_hw_get_num_parents(hw);
>> -       long best_rate = -EINVAL;
>> -       int i;
>> -
>> -       req->best_parent_hw = NULL;
>> -
>> -       for (i = 0; i < nparents; i++) {
>> -               unsigned long parent_rate;
>> -               unsigned long tmp_rate;
>> -               struct clk_hw *parent;
>> -               unsigned long div;
>> -               int shift;
>> -
>> -               parent = clk_hw_get_parent_by_index(hw, i);
>> -               parent_rate = clk_hw_get_rate(parent);
>> -               div = DIV_ROUND_UP(parent_rate, req->rate);
>> -
>> -               /*
>> -                * The AR100 clk contains 2 divisors:
>> -                * - one power of 2 divisor
>> -                * - one regular divisor
>> -                *
>> -                * First check if we can safely shift (or divide by a power
>> -                * of 2) without losing precision on the requested rate.
>> -                */
>> -               shift = ffs(div) - 1;
>> -               if (shift > SUN6I_AR100_SHIFT_MAX)
>> -                       shift = SUN6I_AR100_SHIFT_MAX;
>> -
>> -               div >>= shift;
>> -
>> -               /*
>> -                * Then if the divisor is still bigger than what the HW
>> -                * actually supports, use a bigger shift (or power of 2
>> -                * divider) value and accept to lose some precision.
>> -                */
>> -               while (div > SUN6I_AR100_DIV_MAX) {
>> -                       shift++;
>> -                       div >>= 1;
>> -                       if (shift > SUN6I_AR100_SHIFT_MAX)
>> -                               break;
>> -               }
>> -
>> -               /*
>> -                * If the shift value (or power of 2 divider) is bigger
>> -                * than what the HW actually support, skip this parent.
>> -                */
>> -               if (shift > SUN6I_AR100_SHIFT_MAX)
>> -                       continue;
>> -
>> -               tmp_rate = (parent_rate >> shift) / div;
>> -               if (!req->best_parent_hw || tmp_rate > best_rate) {
>> -                       req->best_parent_hw = parent;
>> -                       req->best_parent_rate = parent_rate;
>> -                       best_rate = tmp_rate;
>> -               }
>> -       }
>> -
>> -       if (best_rate < 0)
>> -               return best_rate;
>> -
>> -       req->rate = best_rate;
>> -
>> -       return 0;
>> -}
>> -
>> -static int ar100_set_parent(struct clk_hw *hw, u8 index)
>> -{
>> -       struct ar100_clk *clk = to_ar100_clk(hw);
>> -       u32 val = readl(clk->reg);
>> -
>> -       if (index >= SUN6I_AR100_MAX_PARENTS)
>> -               return -EINVAL;
>> -
>> -       val &= ~(SUN6I_AR100_MUX_MASK << SUN6I_AR100_MUX_SHIFT);
>> -       val |= (index << SUN6I_AR100_MUX_SHIFT);
>> -       writel(val, clk->reg);
>> -
>> -       return 0;
>> -}
>> +#include "clk-factors.h"
>>
>> -static u8 ar100_get_parent(struct clk_hw *hw)
>> -{
>> -       struct ar100_clk *clk = to_ar100_clk(hw);
>> -       return (readl(clk->reg) >> SUN6I_AR100_MUX_SHIFT) &
>> -              SUN6I_AR100_MUX_MASK;
>> -}
>> -
>> -static int ar100_set_rate(struct clk_hw *hw, unsigned long rate,
>> -                         unsigned long parent_rate)
>> +/**
>> + * sun6i_get_ar100_factors - Calculates factors p, m for AR100
>> + *
>> + * AR100 rate is calculated as follows
>> + * rate = (parent_rate >> p) / (m + 1);
>> + */
>> +static void sun6i_get_ar100_factors(struct factors_request *req)
>>  {
>> -       unsigned long div = parent_rate / rate;
>> -       struct ar100_clk *clk = to_ar100_clk(hw);
>> -       u32 val = readl(clk->reg);
>> +       unsigned long div;
>>         int shift;
>>
>> -       if (parent_rate % rate)
>> -               return -EINVAL;
>> +       /* clock only divides */
>> +       if (req->rate > req->parent_rate)
>> +               req->rate = req->parent_rate;
>>
>> -       shift = ffs(div) - 1;
>> -       if (shift > SUN6I_AR100_SHIFT_MAX)
>> -               shift = SUN6I_AR100_SHIFT_MAX;
>> +       div = DIV_ROUND_UP(req->parent_rate, req->rate);
>>
>> -       div >>= shift;
>> +       if (div < 32)
>> +               shift = 0;
>> +       else if (div >> 1 < 32)
>> +               shift = 1;
>> +       else if (div >> 2 < 32)
>> +               shift = 2;
>> +       else
>> +               shift = 3;
>>
>> -       if (div > SUN6I_AR100_DIV_MAX)
>> -               return -EINVAL;
>> +       div >>= shift;
>>
>> -       val &= ~((SUN6I_AR100_SHIFT_MASK << SUN6I_AR100_SHIFT_SHIFT) |
>> -                (SUN6I_AR100_DIV_MASK << SUN6I_AR100_DIV_SHIFT));
>> -       val |= (shift << SUN6I_AR100_SHIFT_SHIFT) |
>> -              (div << SUN6I_AR100_DIV_SHIFT);
>> -       writel(val, clk->reg);
>> +       if (div > 32)
>> +               div = 32;
>>
>> -       return 0;
>> +       req->rate = (req->parent_rate >> shift) / div;
>> +       req->m = div - 1;
>> +       req->p = shift;
>>  }
>>
>> -static struct clk_ops ar100_ops = {
>> -       .recalc_rate = ar100_recalc_rate,
>> -       .determine_rate = ar100_determine_rate,
>> -       .set_parent = ar100_set_parent,
>> -       .get_parent = ar100_get_parent,
>> -       .set_rate = ar100_set_rate,
>> +static const struct clk_factors_config sun6i_ar100_config = {
>> +       .mwidth = 5,
>> +       .mshift = 8,
>> +       .pwidth = 2,
>> +       .pshift = 4,
>>  };
>>
>> +static const struct factors_data sun6i_ar100_data __initconst = {
>> +       .mux = 16,
>> +       .muxmask = GENMASK(1, 0),
>> +       .table = &sun6i_ar100_config,
>> +       .getter = sun6i_get_ar100_factors,
>> +};
>> +
>> +static DEFINE_SPINLOCK(sun6i_ar100_lock);
>> +
>>  static int sun6i_a31_ar100_clk_probe(struct platform_device *pdev)
>>  {
>> -       const char *parents[SUN6I_AR100_MAX_PARENTS];
>>         struct device_node *np = pdev->dev.of_node;
>> -       const char *clk_name = np->name;
>> -       struct clk_init_data init;
>> -       struct ar100_clk *ar100;
>>         struct resource *r;
>> +       void __iomem *reg;
>>         struct clk *clk;
>> -       int nparents;
>> -
>> -       ar100 = devm_kzalloc(&pdev->dev, sizeof(*ar100), GFP_KERNEL);
>> -       if (!ar100)
>> -               return -ENOMEM;
>>
>>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       ar100->reg = devm_ioremap_resource(&pdev->dev, r);
>> -       if (IS_ERR(ar100->reg))
>> -               return PTR_ERR(ar100->reg);
>> +       reg = devm_ioremap_resource(&pdev->dev, r);
>> +       if (IS_ERR(reg))
>> +               return PTR_ERR(reg);
>>
>> -       nparents = of_clk_get_parent_count(np);
>> -       if (nparents > SUN6I_AR100_MAX_PARENTS)
>> -               nparents = SUN6I_AR100_MAX_PARENTS;
>> -
>> -       of_clk_parent_fill(np, parents, nparents);
>> +       clk = sunxi_factors_register(np, &sun6i_ar100_data, &sun6i_ar100_lock,
>> +                                    reg);
>> +       if (!clk)
>> +               return -ENOMEM;
>>
>> -       of_property_read_string(np, "clock-output-names", &clk_name);
>> +       platform_set_drvdata(pdev, clk);
>>
>> -       init.name = clk_name;
>> -       init.ops = &ar100_ops;
>> -       init.parent_names = parents;
>> -       init.num_parents = nparents;
>> -       init.flags = 0;
>> +       return 0;
>> +}
>>
>> -       ar100->hw.init = &init;
>> +static int sun6i_a31_ar100_clk_remove(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct clk *clk = platform_get_drvdata(pdev);
>>
>> -       clk = clk_register(&pdev->dev, &ar100->hw);
>> -       if (IS_ERR(clk))
>> -               return PTR_ERR(clk);
>> +       sunxi_factors_unregister(np, clk);
>>
>> -       return of_clk_add_provider(np, of_clk_src_simple_get, clk);
>> +       return 0;
>>  }
>>
>>  static const struct of_device_id sun6i_a31_ar100_clk_dt_ids[] = {
>> @@ -227,6 +113,7 @@ static struct platform_driver sun6i_a31_ar100_clk_driver = {
>>                 .of_match_table = sun6i_a31_ar100_clk_dt_ids,
>>         },
>>         .probe = sun6i_a31_ar100_clk_probe,
>> +       .remove = sun6i_a31_ar100_clk_remove,
>>  };
>>  module_platform_driver(sun6i_a31_ar100_clk_driver);
>>
>> --
>> 2.7.0
>>
