From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 7 May 2012 13:14:17 -0700
Subject: [PATCH 5/5] clk: add a fixed factor clock
In-Reply-To: <4FA82875.604@codeaurora.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
 <1336367310-5140-6-git-send-email-mturquette@linaro.org>
 <4FA82875.604@codeaurora.org>
Message-ID: <CAJOA=zOYFdDfXqFQBD8C-eLUt=6SjmEN63akRo+E9eNHE+P1YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 12:54 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 05/06/2012 10:08 PM, Mike Turquette wrote:
>> From: Sascha Hauer<s.hauer@pengutronix.de>
>> +struct clk *clk_register_fixed_factor(struct device *dev, const char
>> *name,
>> + ? ? ? ? ? ? ? const char *parent_name, unsigned long flags,
>> + ? ? ? ? ? ? ? unsigned int mult, unsigned int div)
>> +{
>> + ? ? ? struct clk_fixed_factor *fix;
>> + ? ? ? struct clk_init_data init;
>> + ? ? ? struct clk *clk;
>> +
>> + ? ? ? fix = kmalloc(sizeof(*fix), GFP_KERNEL);
>> + ? ? ? if (!fix) {
>> + ? ? ? ? ? ? ? pr_err("%s: could not allocate fixed factor clk\n",
>> __func__);
>> + ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
>> + ? ? ? }
>
>
> Can we add a check for mult <= div? It doesn't look like this clock is meant
> to capture clock multipliers (if there is even anything like that other than
> PLLs).
>

I don't think we should enforce a rule like that.  Some folks with
static PLLs that never change their rates (and maybe are set up by the
bootloader) might find this clock type to be perfect for them as a
multiplier.

<snip>
>> +#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name, ? ? ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? _parent_ptr, _flags, ? ? ? ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? _mult, _div) ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? static struct clk _name; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? static const char *_name##_parent_names[] = { ? ? ? ? ? \
>> + ? ? ? ? ? ? ? _parent_name, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? }; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? static struct clk *_name##_parents[] = { ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? ? _parent_ptr, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? }; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? static struct clk_fixed_factor _name##_hw = { ? ? ? ? ? \
>> + ? ? ? ? ? ? ? .hw = { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? .clk =&_name, ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? ? ? ? ? }, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? ? .mult = _mult, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? ? .div = _div, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? }; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? DEFINE_CLK(_name, clk_fixed_factor_ops, _flags, ? ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? _name##_parent_names, _name##_parents);
>> +
>
>
> I would prefer not defining a macro for this. But if we are going to do it,
> can we please at least stop doing nested macros here? It would be much
> easier for a new comer to read if we don't nest these clock macros.

This macro follows the others in every way.  Why should we make it
look less uniform?

> Also, should we stop adding support for fully static allocation for new
> clock types? Since it's supposed to be going away soon. Since Mike didn't
> add this clock type, I'm guessing he doesn't need the clock type now and
> hence doesn't need static allocation support for it.
>

I'm afraid I don't follow.  I do need this clock in fact (see
https://github.com/mturquette/linux/commits/clk-next-may06-omap), and
my platform's data is still static.

>
>> ?/**
>> ? * __clk_init - initialize the data structures in a struct clk
>> ? * @dev: ? ? ?device initializing this clk, placeholder for now
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 5db3412..c1c23b9 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -277,6 +277,29 @@ struct clk *clk_register_mux(struct device *dev,
>> const char *name,
>> ? ? ? ? ? ? ? ?u8 clk_mux_flags, spinlock_t *lock);
>>
>> ?/**
>> + * struct clk_fixed_factor - fixed multiplier and divider clock
>> + *
>> + * @hw: ? ? ? ? ? ? ? ?handle between common and hardware-specific
>> interfaces
>> + * @mult: ? ? ?multiplier
>> + * @div: ? ? ? divider
>> + *
>> + * Clock with a fixed multiplier and divider. The output frequency is the
>> + * parent clock rate divided by div and multiplied by mult.
>> + * Implements .recalc_rate, .set_rate and .round_rate
>> + */
>> +
>> +struct clk_fixed_factor {
>> + ? ? ? struct clk_hw ? hw;
>> + ? ? ? unsigned int ? ?mult;
>> + ? ? ? unsigned int ? ?div;
>> +};
>> +
>> +extern struct clk_ops clk_fixed_factor_ops;
>> +struct clk *clk_register_fixed_factor(struct device *dev, const char
>> *name,
>> + ? ? ? ? ? ? ? const char *parent_name, unsigned long flags,
>> + ? ? ? ? ? ? ? unsigned int mult, unsigned int div);
>
>
> Should we have one header file for each common clock type? We seem to be
> adding a lot of those (which is good), but it almost feels like
> clock-provider get out of hand soon.
>

I think clk-provider.h is fine for now.  It's a good one-stop-shop for
people that are just now figuring out what basic clock types exist and
applying them to their platform.  The file itself is only 336 lines
which is hardly out of control...

Regards,
Mike

> Thanks,
> Saravana
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
