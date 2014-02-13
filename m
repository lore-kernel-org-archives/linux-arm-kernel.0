From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Feb 2014 15:31:39 +0100
Subject: [PATCH v3 2/7] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <CAJuA9aiqTPRKha4rBVxsqfWE1q2W3nP75vsY-0H+7A5YVq4vsg@mail.gmail.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-3-git-send-email-thomas.ab@samsung.com>
 <52FBBC99.8060406@samsung.com>
 <CAJuA9aiqTPRKha4rBVxsqfWE1q2W3nP75vsY-0H+7A5YVq4vsg@mail.gmail.com>
Message-ID: <52FCD74B.3050005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.02.2014 08:58, Thomas Abraham wrote:
> On Wed, Feb 12, 2014 at 11:55 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> On 07.02.2014 16:55, Thomas Abraham wrote:
>>> +/* common round rate callback useable for all types of cpu clocks */
>>> +static long samsung_cpuclk_round_rate(struct clk_hw *hw,
>>> +                       unsigned long drate, unsigned long *prate)
>>> +{
>>> +       struct clk *parent = __clk_get_parent(hw->clk);
>>> +       unsigned long max_prate = __clk_round_rate(parent, UINT_MAX);
>>> +       unsigned long t_prate, best_div = 1;
>>> +       unsigned long delta, min_delta = UINT_MAX;
>>> +
>>> +       do {
>>> +               t_prate = __clk_round_rate(parent, drate * best_div);
>>> +               delta = drate - (t_prate / best_div);
>>> +               if (delta < min_delta) {
>>> +                       *prate = t_prate;
>>> +                       min_delta = delta;
>>> +               }
>>> +               if (!delta)
>>> +                       break;
>>> +               best_div++;
>>> +       } while ((drate * best_div) < max_prate && best_div <= MAX_DIV);
>>> +
>>> +       return t_prate / best_div;
>>> +}
>>
>>
>> I think there is something wrong with the code above. You increment best_div
>> in every iteration of the loop and use it to calculate the final best
>> frequency. Shouldn't best_div be the divisor which was found to give the
>> least delta and so the loop should rather iterate on a different variable
>> and store best_div only if (delta < min_delta) condition is true?
>
> This function finds out the best parent frequency (APLL in this case)
> which when divided with some divider value provides the the closest
> possible drate. Probably, the name best_div is misleading since there
> is no need to know the value of best_div outside this function.
>

What I mean is that the .round_rate() method is defined with two output 
values - best parent rate (*prate) and resulting rate of the clock 
itself (the value returned). Now, your function uses different divisor 
value to calculate the return value than the one found to give best 
delta, which is wrong.

>>
>> Anyway, I wonder if you couldn't somehow reuse the code from
>> drivers/clk/clk-divider.c...
>
> Yes, there are some similarities between these but they are not
> entirely the same.

They are implemented using slightly different ways (the one in 
clk-divider is more generic), but I believe they calculate exactly the same.

>>
>>
>>> +
>>> +static unsigned long _calc_div(unsigned long prate, unsigned long drate)
>>> +{
>>> +       unsigned long div = prate / drate;
>>> +
>>> +       WARN_ON(div >= MAX_DIV);
>>> +       return (!(prate % drate)) ? div-- : div;
>>> +}
>>> +
>>> +/* helper function to register a cpu clock */
>>> +static int __init samsung_cpuclk_register(unsigned int lookup_id,
>>
>>
>> Isn't the name a bit too generic? I'd say it should be
>> exynos_cpuclk_register(), since the implementation is rather Exynos specific
>> anyway.
>
> The implementation of the cpu clock type is supposed to be usable on
> all Samsung SoCs starting from s3c24xx onwards. I should have probably
> stated that explicitly.

I'm not sure how much of the code added by this patch could be reused by 
pre-Exynos platforms. AFAIK, except s5v210, their ARM frequency change 
semantics are completely different, so maybe we shouldn't bloat Exynos 
code by trying to make it too generic.

I believe we should keep this Exynos-specific right now to make the code 
simpler and, if needed and found to be appropriate after analyzing how 
cpufreq works on them, it might be extended to support older SoCs as 
well in future.

>>
>>
>>> +       init.parent_names = parents;
>>> +       init.num_parents = 1;
>>
>>
>> I believe this clock should take two clocks as its parents, because it can
>> dynamically switch between mout_apll and mout_mpll using mout_core mux.
>
> Since the mout_core mux is encapsulated into the cpu clock type, the
> dynamic switching is not allowed from CCF API. The switching is fully
> controlled by the cpu clock type when required and hence the CCF need
> not be told about 2 parents.
>

Semantically, the ARM clock can use two different parents, which are not 
encapsulated inside, but instead are fed into the ARM clock block from 
outside, so CCF should know about it.

However, looking at the clock core code again, it seems to support only 
num_parents > 1 when .get_parent() op is implemented, so for now it 
should be safe to keep it as is.

>>
>>
>>> +       init.ops = ops;
>>> +
>>> +       cpuclk->hw.init = &init;
>>> +       cpuclk->ctrl_base = base;
>>> +
>>> +       if (soc_data && soc_data->parser) {
>>
>>
>> Is it even possible to instantiate this clock without soc_data and parser
>> function? Shouldn't it simply bail out instead?
>
> Yes, the intent was to allow Samsung cpu clock type to usable on
> non-DT platforms as well. If a platform has soc_data, then the parser
> can be called.

If we keep this Exynos-specific, which I believe is better than making 
the code overly generic, this could be simplified.

>
>>
>>
>>> +               ret = soc_data->parser(np, &cpuclk->data);
>>> +               if (ret) {
>>> +                       pr_err("%s: error %d in parsing %s clock data",
>>> +                                       __func__, ret, name);
>>> +                       ret = -EINVAL;
>>> +                       goto free_cpuclk;
>>> +               }
>>> +               cpuclk->offset = soc_data->offset;
>>> +               init.ops = soc_data->ops;
>>> +       }
>>> +
>>> +       if (soc_data && soc_data->clk_cb) {
>>
>>
>> Same here. Does it make any sense to instantiate this clock without a
>> notifier callback?
>>
>>
>>> +               cpuclk->clk_nb.notifier_call = soc_data->clk_cb;
>>> +               if (clk_notifier_register(__clk_lookup(parents[0]),
>>> +                               &cpuclk->clk_nb)) {
>>> +                       pr_err("%s: failed to register clock notifier for
>>> %s\n",
>>> +                                       __func__, name);
>>> +                       goto free_cpuclk_data;
>>> +               }
>>> +       }
>>> +
>>> +       if (num_parents == 2) {
>>
>>
>> When num_parents could be other than 2?
>
> If any Samsung SoC needs no alternate parent clock when changing armclk rate.
>

I don't see any real need for this for now. It can be added later if 
such need shows up. For now, I don't think much of this code will be 
reusable on pre-s5pv210 SoCs anyway and s5pv210 needs alternate parent 
too, so it's safe to support only such setup.

>>> +       if (readl(base + SRC_CPU) & EXYNOS4210_MUX_HPM_MASK) {
>>> +               div1 = readl(base + DIV_CPU1) & EXYNOS4210_DIV1_HPM_MASK;
>>> +               div1 |= ((armclk_data->div1) & ~EXYNOS4210_DIV1_HPM_MASK);
>>> +       }
>>> +
>>> +       /*
>>> +        * if the new and old parent clock speed is less than the clock
>>> speed
>>> +        * of the alternate parent, then it should be ensured that at no
>>> point
>>> +        * the armclk speed is more than the old_prate until the dividers
>>> are
>>> +        * set.
>>> +        */
>>> +       need_safe_freq = ndata->old_rate < alt_prate &&
>>> +                               ndata->new_rate < alt_prate;
>>
>>
>> Are you sure this condition is correct? The parent clock (PLL) alone doesn't
>> fully determine the rate of ARM clock, because you are also changing
>> div_core. So you can end up with PLL going down, while ARM clock going up,
>> because the divisors are significantly lowered.
>
> Interesting! I did not think about this. Will fix it.
>
>>
>> I think you should compare ARM clock rates here OR just remove div_core
>> configuration, keeping it as 0 (divide by 1) all the time, except when safe
>> frequency is active.
>
> I would like to keep have div_core configuration, since it gives more
> options for armclk, not just limited to PLL speeds.

Could this be added later as an extension? The original Exynos cpufreq 
doesn't seem to change these divisors and I'm not sure if we should be 
touching them. I'd rather keep the semantics of the old driver, at least 
for now.

>>
>> You seem to always perform the configuration in pre rate change notifier,
>> but original cpufreq code used to do it depending on whether the new
>> frequency is less than old or not, e.g.
>
> Yes, but with the clock notifier callback, we need not do it like below.

I don't think so. Your code always seem to do the transition in exactly 
the same order, regardless of transition direction. I assume that 
original driver contained such distinction, because of some hardware 
requirements and so such semantics should be preserved in new code.

This series is a refactor and should not introduce functional changes. 
Any semantic changes should be done as separate patches to make sure 
that no regressions are introduced.

>>
>> The property should be prefixed with "#" as other properties defining number
>> of cells.
>
> Isn't # a unnecessary requirement here. The old dt bindings used to
> have it and I am not sure in what way it helps. And this is a samsung
> specific property. Anyways, I do not have any particular preference on
> this.

Well, all such properties used to follow this convention, so I'm not 
sure why we should be changing this.

>>
>>> +       prop = of_find_property(np, "samsung,armclk-divider-table", NULL);
>>> +       if (!prop)
>>> +               return -EINVAL;
>>> +       if (!prop->value)
>>> +               return -EINVAL;
>>> +       if ((prop->length / sizeof(u32)) % cells)
>>> +               return -EINVAL;
>>> +       row = ((prop->length / sizeof(u32)) / cells) + 1;
>>
>>
>> Why + 1? Also the variable could be named in a bit more meaningful way, e.g.
>> num_rows.
>
> +1 since this is a zero terminated table. Will change the variable name.
>

To make this more clear, I'd say you should simply add 1 when calling 
kzalloc() and not include sentinel row in nr_rows...

>>
>>
>>> +
>>> +       *data = kzalloc(sizeof(*tdata) * row, GFP_KERNEL);
>>> +       if (!*data)
>>> +               ret = -ENOMEM;
>>> +       tdata = *data;
>>> +
>>> +       val = prop->value;
>>> +       for (; row > 1; row--, tdata++) {

...then you could iterate here to 0. However to make the code more 
readable I would simply rewrite this to:

	for (row = 0; row < nr_rows; ++row, ++tdata) {

>>> +/**
>>> + * samsung_register_arm_clock: register arm clock with ccf.
>>> + * @lookup_id: armclk clock output id for the clock controller.
>>> + * @parent: name of the parent clock for armclk.
>>> + * @base: base address of the clock controller from which armclk is
>>> generated.
>>> + * @np: device tree node pointer of the clock controller (optional).
>>> + * @ops: clock ops for this clock (optional)
>>> + */
>>> +int __init samsung_register_arm_clock(unsigned int lookup_id,
>>> +               const char **parent_names, unsigned int num_parents,
>>> +               void __iomem *base, struct device_node *np, struct clk_ops
>>> *ops)
>>> +{
>>> +       const struct of_device_id *match;
>>> +       const struct samsung_cpuclk_soc_data *data = NULL;
>>> +
>>> +       if (np) {
>>> +               match = of_match_node(samsung_clock_ids_armclk, np);
>>> +               data = match ? match->data : NULL;
>>> +       }
>>
>>
>> Since this is rather Exynos-specific and Exynos is DT-only, np being NULL
>> would be simply an error.
>
> The cpu clock type is usable for not-dt samsung platform also.

As I said, I would recommend keeping this simple to cover just Exynos 
SoCs for now. The design might also consider s5pv210, but it's going to 
be fully converted to DT as well, so it should be safe to make this code 
DT-only.

Best regards,
Tomasz
