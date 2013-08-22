From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu, 22 Aug 2013 13:23:25 +0530
Subject: [RFC PATCH 1/3] clk: add support for temporary parent clock
 migration
In-Reply-To: <20130822061649.8231.86212@quantum>
References: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
 <1375778065-21808-2-git-send-email-chander.kashyap@linaro.org>
 <20130822061649.8231.86212@quantum>
Message-ID: <CANuQgHEHrrgwh0yvj3QtO8pAujo5342JyGg=p3_EPaqL3PchiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 August 2013 11:46, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Chander Kashyap (2013-08-06 01:34:23)
>> Some platforms use to migrate temporarily to another parent during cpu frequency
>> scaling, e.g. Exynos and Tegra. Once the frequency is changed the latch on to
>> original parent.
>>
>> The generic cpufreq-cpu0 driver use CCF to scale cpu frequency. This patch is an
>> attempt to address the above mentioned requirement.
>
> The generic cpufreq-cpu0 driver does not use CCF per se. It uses the
> long-standing clock api written by Russell. Coincidentally I think that
> all the platforms using cpufreq-cpu0 have converted to the common struct
> clk.
>
>>
>> This is achieved as follows:
>>
>> Add a clk flag "CLK_SET_RATE_ALTERNATE" for clocks which need to migrate to
>> another parent during set_rate operation on them.
>
> We discussed the naming a bit already. I think I like
> CLK_SET_RATE_TEMP_PARENT more. It's really long but it gets the idea
> across easily.

ok, TEMP, seems more crisp and clear.

>
>>
>> Add "alternate_parent_name" and "alternate_parent" fields to clk structure
>> i.e the name of alternate_parent_clock and reference to alternate_parent_clock.
>
> Similarly temp_parent_name and temp_parent here.

ok

>
>>
>> Hence in clk_set_rate API check for the "CLK_SET_RATE_ALTERNATE" flag, then
>> latch on to alternate parent clock temporarily. Once the requested rate is set
>> on the clk, re-parent back to original parent clock.
>>
>> This property is applicable only for mux-clocks, where it is guaranteed that
>> set_rate will actually execute on parent clock.
>
> Can you clarify what you mean by this?

sure,
means to say only mux-out clk can have multiple parents.

>
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> ---
>>  drivers/clk/clk-mux.c        |   13 ++++++------
>>  drivers/clk/clk.c            |   45 +++++++++++++++++++++++++++++++++++++++---
>>  include/linux/clk-private.h  |   17 +++++++++-------
>>  include/linux/clk-provider.h |   10 ++++++----
>>  4 files changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
>> index 614444c..47cb77f 100644
>> --- a/drivers/clk/clk-mux.c
>> +++ b/drivers/clk/clk-mux.c
>> @@ -109,8 +109,8 @@ EXPORT_SYMBOL_GPL(clk_mux_ops);
>>
>>  struct clk *clk_register_mux_table(struct device *dev, const char *name,
>>                 const char **parent_names, u8 num_parents, unsigned long flags,
>> -               void __iomem *reg, u8 shift, u32 mask,
>> -               u8 clk_mux_flags, u32 *table, spinlock_t *lock)
>> +               const char *alternate_parent_name, void __iomem *reg, u8 shift,
>> +               u32 mask, u8 clk_mux_flags, u32 *table, spinlock_t *lock)
>>  {
>>         struct clk_mux *mux;
>>         struct clk *clk;
>> @@ -137,6 +137,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
>>         init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names = parent_names;
>>         init.num_parents = num_parents;
>> +       init.alternate_parent_name = alternate_parent_name;
>>
>>         /* struct clk_mux assignments */
>>         mux->reg = reg;
>> @@ -157,12 +158,12 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
>>
>>  struct clk *clk_register_mux(struct device *dev, const char *name,
>>                 const char **parent_names, u8 num_parents, unsigned long flags,
>> -               void __iomem *reg, u8 shift, u8 width,
>> -               u8 clk_mux_flags, spinlock_t *lock)
>> +               const char *alternate_parent_name, void __iomem *reg, u8 shift,
>> +               u8 width, u8 clk_mux_flags, spinlock_t *lock)
>>  {
>>         u32 mask = BIT(width) - 1;
>>
>>         return clk_register_mux_table(dev, name, parent_names, num_parents,
>> -                                     flags, reg, shift, mask, clk_mux_flags,
>> -                                     NULL, lock);
>> +                                     flags, alternate_parent_name, reg, shift,
>> +                                     mask, clk_mux_flags, NULL, lock);
>>  }
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 54a191c..0f18a45 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1209,8 +1209,8 @@ static void clk_change_rate(struct clk *clk)
>>   */
>>  int clk_set_rate(struct clk *clk, unsigned long rate)
>>  {
>> -       struct clk *top, *fail_clk;
>> -       int ret = 0;
>> +       struct clk *top, *fail_clk, *parent = NULL;
>> +       int ret = 0, index;
>>
>>         /* prevent racing with updates to the clock topology */
>>         clk_prepare_lock();
>> @@ -1231,6 +1231,36 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>>                 goto out;
>>         }
>>
>> +       /* Latch on to alternate parent temporarily if needed */
>> +       if ((clk->flags & CLK_SET_RATE_ALTERNATE)
>> +                               && clk->alternate_parent_name) {
>> +               /* Save current parent before latching on to alternate parent */
>> +               parent = clk->parent;
>> +
>> +               if (!clk->alternate_parent) {
>> +                       for (index = 0; index < clk->num_parents; index++) {
>> +                               if (!strcmp(clk->parent_names[index],
>> +                                               clk->alternate_parent_name))
>> +                                       clk->alternate_parent =
>> +                                       __clk_lookup(clk->alternate_parent_name);
>> +                       }
>> +
>> +                       if (!clk->alternate_parent) {
>> +                               pr_warn("%s: wrong alternate_parent_name %s",
>> +                                       __func__, clk->alternate_parent_name);
>> +                               ret = -EINVAL;
>> +                               goto out;
>> +                       }
>> +               }
>> +
>> +               ret = clk_set_parent(clk, clk->alternate_parent);
>> +               if (ret) {
>> +                       pr_warn("%s: failed to set %s parent\n",
>> +                               __func__, clk->alternate_parent->name);
>> +                       goto out;
>> +               }
>> +       }
>
> I have two concerns here. First is making the core code more complex for
> handling this case. I think that the .set_rate callback for a clock type
> could just as easily call clk_set_parent() twice instead of introducing
> a new flag and doing it here inside clk_set_rate().

Well there will be one problem then. if CLK_SET_RATE_PARENT flag is
set, then set parent operation will happen on "current clk" and actual
rate change will happen on (top) "parent clk". If if this is handled
in .set_rate call back, the .set_rate will have no idea whose parent
need to be set temporarily.

or the suggestion is to implement specific call back for this clk.

>
> My second concern is the case where there could be more than one
> temporary parent. If a clock has 3 possible inputs, one being the
> reference input and the other two being alternate/temporary inputs then
> there might be a time to use one of the other of the alternates. This is
> purely hypothetical but it shows how the CLK_SET_RATE_ALTERNATE flag is
> less flexible than just leaving these details up to the .set_rate
> callback implementation.

Well if there are more than one temporary parents, and can be used in
different conditions, then that has to be decided at runtime. In that
case again you have to provide a .set_rate call back specific to that
clk.
But in common scenario this can not be the case as the purpose of temp
clk parent is well defined.

I still agree that CLK_SET_RATE_ALTERNATE can be done away, and
"set_parent" can be called if "clk->alter_parent" is set.

>
> Regards,
> Mike



-- 
with warm regards,
Chander Kashyap
