From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 07 May 2012 13:26:29 -0700
Subject: [PATCH 5/5] clk: add a fixed factor clock
In-Reply-To: <CAJOA=zOYFdDfXqFQBD8C-eLUt=6SjmEN63akRo+E9eNHE+P1YA@mail.gmail.com>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
 <1336367310-5140-6-git-send-email-mturquette@linaro.org>
 <4FA82875.604@codeaurora.org>
 <CAJOA=zOYFdDfXqFQBD8C-eLUt=6SjmEN63akRo+E9eNHE+P1YA@mail.gmail.com>
Message-ID: <4FA82FF5.4000805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2012 01:14 PM, Turquette, Mike wrote:
> On Mon, May 7, 2012 at 12:54 PM, Saravana Kannan<skannan@codeaurora.org>  wrote:
>> On 05/06/2012 10:08 PM, Mike Turquette wrote:
>>> From: Sascha Hauer<s.hauer@pengutronix.de>
>>> +struct clk *clk_register_fixed_factor(struct device *dev, const char
>>> *name,
>>> +               const char *parent_name, unsigned long flags,
>>> +               unsigned int mult, unsigned int div)
>>> +{
>>> +       struct clk_fixed_factor *fix;
>>> +       struct clk_init_data init;
>>> +       struct clk *clk;
>>> +
>>> +       fix = kmalloc(sizeof(*fix), GFP_KERNEL);
>>> +       if (!fix) {
>>> +               pr_err("%s: could not allocate fixed factor clk\n",
>>> __func__);
>>> +               return ERR_PTR(-ENOMEM);
>>> +       }
>>
>>
>> Can we add a check for mult<= div? It doesn't look like this clock is meant
>> to capture clock multipliers (if there is even anything like that other than
>> PLLs).
>>
>
> I don't think we should enforce a rule like that.  Some folks with
> static PLLs that never change their rates (and maybe are set up by the
> bootloader) might find this clock type to be perfect for them as a
> multiplier.

I would think those clocks would have some type of register control. At 
least for enable/disable. This clock just seems to implement a simple 
integer divider/fractional multiplier. I think we should add this check.

> <snip>
>>> +#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name,           \
>>> +                               _parent_ptr, _flags,            \
>>> +                               _mult, _div)                    \
>>> +       static struct clk _name;                                \
>>> +       static const char *_name##_parent_names[] = {           \
>>> +               _parent_name,                                   \
>>> +       };                                                      \
>>> +       static struct clk *_name##_parents[] = {                \
>>> +               _parent_ptr,                                    \
>>> +       };                                                      \
>>> +       static struct clk_fixed_factor _name##_hw = {           \
>>> +               .hw = {                                         \
>>> +                       .clk =&_name,                           \
>>> +               },                                              \
>>> +               .mult = _mult,                                  \
>>> +               .div = _div,                                    \
>>> +       };                                                      \
>>> +       DEFINE_CLK(_name, clk_fixed_factor_ops, _flags,         \
>>> +                       _name##_parent_names, _name##_parents);
>>> +
>>
>>
>> I would prefer not defining a macro for this. But if we are going to do it,
>> can we please at least stop doing nested macros here? It would be much
>> easier for a new comer to read if we don't nest these clock macros.
>
> This macro follows the others in every way.  Why should we make it
> look less uniform?

May be the other macros should be refactored to not be nested too?

>> Also, should we stop adding support for fully static allocation for new
>> clock types? Since it's supposed to be going away soon. Since Mike didn't
>> add this clock type, I'm guessing he doesn't need the clock type now and
>> hence doesn't need static allocation support for it.
>>
>
> I'm afraid I don't follow.  I do need this clock in fact (see
> https://github.com/mturquette/linux/commits/clk-next-may06-omap), and
> my platform's data is still static.

Never mind. If you are using this clock type, then it's okay to support 
static init.

>> Should we have one header file for each common clock type? We seem to be
>> adding a lot of those (which is good), but it almost feels like
>> clock-provider get out of hand soon.
>>
>
> I think clk-provider.h is fine for now.  It's a good one-stop-shop for
> people that are just now figuring out what basic clock types exist and
> applying them to their platform.  The file itself is only 336 lines
> which is hardly out of control...

I still prefer them to be split out since one doesn't need to include 
(and be recompiled when it changes) stuff they don't care about. But 
it's not yet a significant point to argue about. So, let's wait and see 
how it goes.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
