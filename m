From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu, 13 Feb 2014 13:28:19 +0530
Subject: [PATCH v3 2/7] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <52FBBC99.8060406@samsung.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-3-git-send-email-thomas.ab@samsung.com>
 <52FBBC99.8060406@samsung.com>
Message-ID: <CAJuA9aiqTPRKha4rBVxsqfWE1q2W3nP75vsY-0H+7A5YVq4vsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Thanks for your detailed review.

On Wed, Feb 12, 2014 at 11:55 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Thomas,
>
>
> On 07.02.2014 16:55, Thomas Abraham wrote:
>>
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> The CPU clock provider supplies the clock to the CPU clock domain. The
>> composition and organization of the CPU clock provider could vary among
>> Exynos SoCs. A CPU clock provider can be composed of clock mux, dividers
>> and gates. This patch defines a new clock type for CPU clock provider and
>> adds infrastructure to register the CPU clock providers for Samsung
>> platforms.
>>
>> In addition to this, the arm cpu clock provider for Exynos4210 and
>> compatible SoCs is instantiated using the new cpu clock type. The clock
>> configuration data for this clock is obtained from device tree. This
>> implementation is reusable for Exynos4x12 and Exynos5250 SoCs as well.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>   drivers/clk/samsung/Makefile  |    2 +-
>>   drivers/clk/samsung/clk-cpu.c |  409
>> +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/samsung/clk.h     |    5 +
>>   3 files changed, 415 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clk/samsung/clk-cpu.c
>
>
> [snip]
>
>
>> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
>> new file mode 100644
>> index 0000000..673f620
>> --- /dev/null
>> +++ b/drivers/clk/samsung/clk-cpu.c
>> @@ -0,0 +1,409 @@
>
>
> [snip]
>
>
>> +#define SRC_CPU                        0x0
>> +#define STAT_CPU               0x200
>> +#define DIV_CPU0               0x300
>> +#define DIV_CPU1               0x304
>> +#define DIV_STAT_CPU0          0x400
>> +#define DIV_STAT_CPU1          0x404
>> +
>> +#define MAX_DIV                        8
>> +
>> +#define EXYNOS4210_ARM_DIV1(base) ((readl(base + DIV_CPU0) & 0xf) + 1)
>> +#define EXYNOS4210_ARM_DIV2(base) (((readl(base + DIV_CPU0) >> 28) & 0xf)
>> + 1)
>
>
> Those are 3-bit dividers, so the mask should be rather 0x7, shouldn't it?

Yes, that is correct. I will fix this.

>
> Btw. Somehow I feel like this kind of macros is simply obfuscating code
> without any real benefits. Could you rewrite them to simply take the value
> of DIV_CPU0 register, without hiding readl behind the scenes?

Okay. I will change this.

>
>
>> +
>> +#define EXYNOS4210_DIV_CPU0(d5, d4, d3, d2, d1, d0)                    \
>> +               ((d5 << 24) | (d4 << 20) | (d3 << 16) | (d2 << 12) |    \
>> +                (d1 << 8) | (d0 <<  4))
>> +#define EXYNOS4210_DIV_CPU1(d2, d1, d0)
>> \
>> +               ((d2 << 8) | (d1 << 4) | (d0 << 0))
>> +
>> +#define EXYNOS4210_DIV1_HPM_MASK       ((0x7 << 0) | (0x7 << 4))
>> +#define EXYNOS4210_MUX_HPM_MASK                (1 << 20)
>
>
> [snip]
>
>
>> +/* common round rate callback useable for all types of cpu clocks */
>> +static long samsung_cpuclk_round_rate(struct clk_hw *hw,
>> +                       unsigned long drate, unsigned long *prate)
>> +{
>> +       struct clk *parent = __clk_get_parent(hw->clk);
>> +       unsigned long max_prate = __clk_round_rate(parent, UINT_MAX);
>> +       unsigned long t_prate, best_div = 1;
>> +       unsigned long delta, min_delta = UINT_MAX;
>> +
>> +       do {
>> +               t_prate = __clk_round_rate(parent, drate * best_div);
>> +               delta = drate - (t_prate / best_div);
>> +               if (delta < min_delta) {
>> +                       *prate = t_prate;
>> +                       min_delta = delta;
>> +               }
>> +               if (!delta)
>> +                       break;
>> +               best_div++;
>> +       } while ((drate * best_div) < max_prate && best_div <= MAX_DIV);
>> +
>> +       return t_prate / best_div;
>> +}
>
>
> I think there is something wrong with the code above. You increment best_div
> in every iteration of the loop and use it to calculate the final best
> frequency. Shouldn't best_div be the divisor which was found to give the
> least delta and so the loop should rather iterate on a different variable
> and store best_div only if (delta < min_delta) condition is true?

This function finds out the best parent frequency (APLL in this case)
which when divided with some divider value provides the the closest
possible drate. Probably, the name best_div is misleading since there
is no need to know the value of best_div outside this function.

>
> Anyway, I wonder if you couldn't somehow reuse the code from
> drivers/clk/clk-divider.c...

Yes, there are some similarities between these but they are not
entirely the same.

>
>
>> +
>> +static unsigned long _calc_div(unsigned long prate, unsigned long drate)
>> +{
>> +       unsigned long div = prate / drate;
>> +
>> +       WARN_ON(div >= MAX_DIV);
>> +       return (!(prate % drate)) ? div-- : div;
>> +}
>> +
>> +/* helper function to register a cpu clock */
>> +static int __init samsung_cpuclk_register(unsigned int lookup_id,
>
>
> Isn't the name a bit too generic? I'd say it should be
> exynos_cpuclk_register(), since the implementation is rather Exynos specific
> anyway.

The implementation of the cpu clock type is supposed to be usable on
all Samsung SoCs starting from s3c24xx onwards. I should have probably
stated that explicitly.

>
>
>> +               const char *name, const char **parents,
>> +               unsigned int num_parents, void __iomem *base,
>> +               const struct samsung_cpuclk_soc_data *soc_data,
>> +               struct device_node *np, const struct clk_ops *ops)
>> +{
>> +       struct samsung_cpuclk *cpuclk;
>> +       struct clk_init_data init;
>> +       struct clk *clk;
>> +       int ret;
>> +
>> +       cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
>> +       if (!cpuclk) {
>> +               pr_err("%s: could not allocate memory for %s clock\n",
>> +                                       __func__, name);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       init.name = name;
>> +       init.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT;
>
>
> Why CLK_GET_RATE_NOCACHE? There is only one entity that can change rate of
> this clock and it is this clock driver, so it can update the cache on any
> change.

Right, will remove this flag.

>
>
>> +       init.parent_names = parents;
>> +       init.num_parents = 1;
>
>
> I believe this clock should take two clocks as its parents, because it can
> dynamically switch between mout_apll and mout_mpll using mout_core mux.

Since the mout_core mux is encapsulated into the cpu clock type, the
dynamic switching is not allowed from CCF API. The switching is fully
controlled by the cpu clock type when required and hence the CCF need
not be told about 2 parents.

>
>
>> +       init.ops = ops;
>> +
>> +       cpuclk->hw.init = &init;
>> +       cpuclk->ctrl_base = base;
>> +
>> +       if (soc_data && soc_data->parser) {
>
>
> Is it even possible to instantiate this clock without soc_data and parser
> function? Shouldn't it simply bail out instead?

Yes, the intent was to allow Samsung cpu clock type to usable on
non-DT platforms as well. If a platform has soc_data, then the parser
can be called.

>
>
>> +               ret = soc_data->parser(np, &cpuclk->data);
>> +               if (ret) {
>> +                       pr_err("%s: error %d in parsing %s clock data",
>> +                                       __func__, ret, name);
>> +                       ret = -EINVAL;
>> +                       goto free_cpuclk;
>> +               }
>> +               cpuclk->offset = soc_data->offset;
>> +               init.ops = soc_data->ops;
>> +       }
>> +
>> +       if (soc_data && soc_data->clk_cb) {
>
>
> Same here. Does it make any sense to instantiate this clock without a
> notifier callback?
>
>
>> +               cpuclk->clk_nb.notifier_call = soc_data->clk_cb;
>> +               if (clk_notifier_register(__clk_lookup(parents[0]),
>> +                               &cpuclk->clk_nb)) {
>> +                       pr_err("%s: failed to register clock notifier for
>> %s\n",
>> +                                       __func__, name);
>> +                       goto free_cpuclk_data;
>> +               }
>> +       }
>> +
>> +       if (num_parents == 2) {
>
>
> When num_parents could be other than 2?

If any Samsung SoC needs no alternate parent clock when changing armclk rate.

>
>
>> +               cpuclk->alt_parent = __clk_lookup(parents[1]);
>> +               if (!cpuclk->alt_parent) {
>> +                       pr_err("%s: could not lookup alternate parent
>> %s\n",
>> +                                       __func__, parents[1]);
>> +                       ret = -EINVAL;
>> +                       goto free_cpuclk_data;
>> +               }
>> +       }
>> +
>> +       clk = clk_register(NULL, &cpuclk->hw);
>> +       if (IS_ERR(clk)) {
>> +               pr_err("%s: could not register cpuclk %s\n", __func__,
>> name);
>> +               ret = PTR_ERR(clk);
>> +               goto free_cpuclk_data;
>> +       }
>> +
>> +       samsung_clk_add_lookup(clk, lookup_id);
>> +       return 0;
>> +
>> +free_cpuclk_data:
>> +       kfree(cpuclk->data);
>> +free_cpuclk:
>> +       kfree(cpuclk);
>> +       return ret;
>> +}
>> +
>> +static inline void _exynos4210_set_armclk_div(void __iomem *base,
>> +                       unsigned long div)
>
>
> I'd say it would be better to leave the decision about inlining to the
> compiler.

Okay.

>
>
>> +{
>> +       writel((readl(base + DIV_CPU0) & ~0xf) | div, base + DIV_CPU0);
>
>
> CORE_RATIO bitfield is 3-bit wide.

Right, will fix.

>
>
>> +       while (readl(base + DIV_STAT_CPU0) != 0)
>> +               ;
>
>
> Wouldn't it be better to add some timeout and print an error to make sure
> that even if something wrong happens the user will know that it happened?

Okay, will add timeout.

>
>
>> +}
>> +
>> +static unsigned long exynos4210_armclk_recalc_rate(struct clk_hw *hw,
>> +                               unsigned long parent_rate)
>> +{
>> +       struct samsung_cpuclk *armclk = to_samsung_cpuclk_hw(hw);
>> +       void __iomem *base = armclk->ctrl_base + armclk->offset;
>> +
>> +       return parent_rate / EXYNOS4210_ARM_DIV1(base) /
>> +                               EXYNOS4210_ARM_DIV2(base);
>
>
> The code would be more readable if you read the register to a temporary
> variable using readl() directly and then accessing its contents.

Okay.

>
>
>> +}
>> +
>> +/*
>> + * This clock notifier is called when the frequency of the parent clock
>> + * of armclk is to be changed. This notifier handles the setting up all
>> + * the divider clocks, remux to temporary parent and handling the safe
>> + * frequency levels when using temporary parent.
>> + */
>> +static int exynos4210_armclk_notifier_cb(struct notifier_block *nb,
>> +                               unsigned long event, void *data)
>> +{
>> +       struct clk_notifier_data *ndata = data;
>> +       struct samsung_cpuclk *armclk = to_samsung_cpuclk_nb(nb);
>> +       struct exynos4210_armclk_data *armclk_data;
>> +       unsigned long alt_prate, alt_div, div0, div1, mux_reg;
>> +       void __iomem *base;
>> +       bool need_safe_freq;
>> +
>> +       armclk_data = armclk->data;
>> +       base = armclk->ctrl_base + armclk->offset;
>> +       alt_prate = clk_get_rate(armclk->alt_parent);
>> +
>> +       if (event == POST_RATE_CHANGE)
>> +               goto e4210_armclk_post_rate_change;
>
>
> This would look better if you separated the main configuration code from the
> notifier callback, like this:
>
>         int ret = 0;
>
>         switch (event) {
>         case POST_RATE_CHANGE:
>                 ret = exynos4210_armclk_post_rate_change(...);
>                 break;
>         case PRE_RATE_CHANGE:
>                 ret = exynos4210_armclk_pre_rate_change(...);
>                 break;
>         }
>
>         return notifier_from_errno(ret);

Okay.

>
> By the way, I wonder if some of this couldn't simply happen in .set_rate()
> op of this clock, since
>
>
>> +
>> +       /* pre-rate change. find out the divider values to use for clock
>> data */
>> +       while (armclk_data->prate != ndata->new_rate) {
>> +               if (armclk_data->prate == 0)
>> +                       return NOTIFY_BAD;
>> +               armclk_data++;
>> +       }
>> +
>> +       div0 = armclk_data->div0;
>> +       div1 = armclk_data->div1;
>
>
> You should always use read-modify-write for such registers to preserve
> reserved bits. This will also clean a bit safe frequency activation, see
> below.
>
>
>> +       if (readl(base + SRC_CPU) & EXYNOS4210_MUX_HPM_MASK) {
>> +               div1 = readl(base + DIV_CPU1) & EXYNOS4210_DIV1_HPM_MASK;
>> +               div1 |= ((armclk_data->div1) & ~EXYNOS4210_DIV1_HPM_MASK);
>> +       }
>> +
>> +       /*
>> +        * if the new and old parent clock speed is less than the clock
>> speed
>> +        * of the alternate parent, then it should be ensured that at no
>> point
>> +        * the armclk speed is more than the old_prate until the dividers
>> are
>> +        * set.
>> +        */
>> +       need_safe_freq = ndata->old_rate < alt_prate &&
>> +                               ndata->new_rate < alt_prate;
>
>
> Are you sure this condition is correct? The parent clock (PLL) alone doesn't
> fully determine the rate of ARM clock, because you are also changing
> div_core. So you can end up with PLL going down, while ARM clock going up,
> because the divisors are significantly lowered.

Interesting! I did not think about this. Will fix it.

>
> I think you should compare ARM clock rates here OR just remove div_core
> configuration, keeping it as 0 (divide by 1) all the time, except when safe
> frequency is active.

I would like to keep have div_core configuration, since it gives more
options for armclk, not just limited to PLL speeds.

>
>
>> +       if (need_safe_freq) {
>> +               alt_div = _calc_div(alt_prate, ndata->old_rate);
>> +               _exynos4210_set_armclk_div(base, alt_div);
>> +               div0 |= alt_div;
>> +       }
>
>
>
> You could move div0 and div1 calculation (including reading original values
> of registers) here to remove "div0 |= alt_div;" line from the if above and
> fully isolate ARM divisor setup code from changing other divisors.
>
>
>> +
>> +       mux_reg = readl(base + SRC_CPU);
>> +       writel(mux_reg | (1 << 16), base + SRC_CPU);
>
>
> Don't you need to hold the samsung clock spinlock when writing to this
> register? It seems to control more muxes than just this one.

Right, will fix it.

>
>
>> +       while (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
>> +               ;
>> +
>> +       writel(div0, base + DIV_CPU0);
>> +       while (readl(base + DIV_STAT_CPU0) != 0)
>> +               ;
>> +       writel(div1, base + DIV_CPU1);
>> +       while (readl(base + DIV_STAT_CPU1) != 0)
>> +               ;
>
>
> You seem to always perform the configuration in pre rate change notifier,
> but original cpufreq code used to do it depending on whether the new
> frequency is less than old or not, e.g.

Yes, but with the clock notifier callback, we need not do it like below.

>
> static void exynos5250_set_frequency(unsigned int old_index,
>                                   unsigned int new_index)
> {
>         if (old_index > new_index) {
>                 set_clkdiv(new_index);
>                 set_apll(new_index);
>         } else if (old_index < new_index) {
>                 set_apll(new_index);
>                 set_clkdiv(new_index);
>         }
> }
>
> set_clkdiv does the following:
>   1) set DIV_CPU0
>   2) wait for DIV_STAT_CPU0
>   3) set DIV_CPU1
>   4) wait for DIV_STAT_CPU1
>
> and set_apll:
>   1) set parent to MPLL
>   2) wait for MUX_STAT_CPU
>   3) set APLL rate
>   4) set parent to APLL
>   5) wait for MUX_STAT_CPU
>
> Note that higher index means lower frequency.
>
> Btw. It would be nice to handle timeouts here as well, to prevent system
> lockups.

Okay.

>
>
>> +       return NOTIFY_OK;
>> +
>> +e4210_armclk_post_rate_change:
>> +       /* post-rate change event, re-mux back to primary parent */
>> +       mux_reg = readl(base + SRC_CPU);
>> +       writel(mux_reg & ~(1 << 16), base + SRC_CPU);
>> +       while (((readl(base + STAT_CPU) >> 16) & 0x7) != 1)
>> +                       ;
>
>
> nit: Too many tabs.
>
> Timeout would be nice too.
>
>
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>> +static int exynos4210_armclk_set_rate(struct clk_hw *hw, unsigned long
>> drate,
>> +                                       unsigned long prate)
>> +{
>> +       struct samsung_cpuclk *armclk = to_samsung_cpuclk_hw(hw);
>> +       void __iomem *base = armclk->ctrl_base + armclk->offset;
>> +       unsigned long div;
>> +
>> +       div = drate < prate ? _calc_div(prate, drate) : 0;
>> +       _exynos4210_set_armclk_div(base, div);
>> +       return 0;
>
>
> Hmm, here you are supposed to set exactly the rate given to you in drate
> argument. Core clock code calls your .round_rate() first and the rate
> returned by it is what .set_rate() gets as drate. You can safely assume that
>
>
>> +}
>> +
>> +static const struct clk_ops exynos4210_armclk_clk_ops = {
>> +       .recalc_rate = exynos4210_armclk_recalc_rate,
>> +       .round_rate = samsung_cpuclk_round_rate,
>> +       .set_rate = exynos4210_armclk_set_rate,
>> +};
>> +
>> +/*
>> + * parse divider configuration data from dt for all the cpu clock domain
>> + * clocks in exynos4210 and compatible SoC's.
>> + */
>> +static int __init exynos4210_armclk_parser(struct device_node *np, void
>> **data)
>> +{
>> +       struct exynos4210_armclk_data *tdata;
>> +       unsigned long cfg[10], row, col;
>> +       const struct property *prop;
>> +       const __be32 *val;
>> +       u32 cells;
>> +       int ret;
>> +
>> +       if (of_property_read_u32(np, "samsung,armclk-cells", &cells))
>> +               return -EINVAL;
>
>
> The property should be prefixed with "#" as other properties defining number
> of cells.

Isn't # a unnecessary requirement here. The old dt bindings used to
have it and I am not sure in what way it helps. And this is a samsung
specific property. Anyways, I do not have any particular preference on
this.

>
> Also you should check if cells value is correct, e.g. a number of cells
> supported

Okay.

>
>
>> +       prop = of_find_property(np, "samsung,armclk-divider-table", NULL);
>> +       if (!prop)
>> +               return -EINVAL;
>> +       if (!prop->value)
>> +               return -EINVAL;
>> +       if ((prop->length / sizeof(u32)) % cells)
>> +               return -EINVAL;
>> +       row = ((prop->length / sizeof(u32)) / cells) + 1;
>
>
> Why + 1? Also the variable could be named in a bit more meaningful way, e.g.
> num_rows.

+1 since this is a zero terminated table. Will change the variable name.

>
>
>> +
>> +       *data = kzalloc(sizeof(*tdata) * row, GFP_KERNEL);
>> +       if (!*data)
>> +               ret = -ENOMEM;
>> +       tdata = *data;
>> +
>> +       val = prop->value;
>> +       for (; row > 1; row--, tdata++) {
>> +               for (col = 0; col < cells; col++)
>> +                       cfg[col] = be32_to_cpup(val++);
>
>
> You could use of_prop_next_u32() here.

Okay.

>
>
>> +
>> +               tdata->prate = cfg[0] * 1000;
>> +               tdata->div0 = EXYNOS4210_DIV_CPU0(cfg[6], cfg[5], cfg[4],
>> +                                               cfg[3], cfg[2], cfg[1]);
>> +               tdata->div1 = cells == 10 ?
>> +                               EXYNOS4210_DIV_CPU1(cfg[9], cfg[8],
>> cfg[7]) :
>> +                               EXYNOS4210_DIV_CPU1(0, cfg[8], cfg[7]);
>> +       }
>> +       tdata->prate = 0;
>> +       return 0;
>> +}
>> +
>> +static const struct samsung_cpuclk_soc_data exynos4210_cpuclk_soc_data =
>> {
>> +       .parser = exynos4210_armclk_parser,
>> +       .ops = &exynos4210_armclk_clk_ops,
>> +       .offset = 0x14200,
>> +       .clk_cb = exynos4210_armclk_notifier_cb,
>> +};
>> +
>> +static const struct samsung_cpuclk_soc_data exynos5250_cpuclk_soc_data =
>> {
>> +       .parser = exynos4210_armclk_parser,
>> +       .ops = &exynos4210_armclk_clk_ops,
>> +       .offset = 0x200,
>> +       .clk_cb = exynos4210_armclk_notifier_cb,
>> +};
>> +
>> +static const struct of_device_id samsung_clock_ids_armclk[] = {
>> +       { .compatible = "samsung,exynos4210-clock",
>> +                       .data = &exynos4210_cpuclk_soc_data, },
>> +       { .compatible = "samsung,exynos4412-clock",
>> +                       .data = &exynos4210_cpuclk_soc_data, },
>> +       { .compatible = "samsung,exynos5250-clock",
>> +                       .data = &exynos5250_cpuclk_soc_data, },
>> +       { },
>> +};
>> +
>> +/**
>> + * samsung_register_arm_clock: register arm clock with ccf.
>> + * @lookup_id: armclk clock output id for the clock controller.
>> + * @parent: name of the parent clock for armclk.
>> + * @base: base address of the clock controller from which armclk is
>> generated.
>> + * @np: device tree node pointer of the clock controller (optional).
>> + * @ops: clock ops for this clock (optional)
>> + */
>> +int __init samsung_register_arm_clock(unsigned int lookup_id,
>> +               const char **parent_names, unsigned int num_parents,
>> +               void __iomem *base, struct device_node *np, struct clk_ops
>> *ops)
>> +{
>> +       const struct of_device_id *match;
>> +       const struct samsung_cpuclk_soc_data *data = NULL;
>> +
>> +       if (np) {
>> +               match = of_match_node(samsung_clock_ids_armclk, np);
>> +               data = match ? match->data : NULL;
>> +       }
>
>
> Since this is rather Exynos-specific and Exynos is DT-only, np being NULL
> would be simply an error.

The cpu clock type is usable for not-dt samsung platform also.

>
> Best regards,
> Tomasz

Thanks for your review.

Regards,
Thomas.
