From: zhoujiewu@gmail.com (zhoujie wu)
Date: Thu, 10 May 2012 17:03:20 +0800
Subject: [PATCH V2] clk: give clock chance to change parent at setrate
 stage
In-Reply-To: <20120509183455.GB19219@gmail.com>
References: <CAG9bXvmAf-0fmVb8nzWkuAKaMoOJVzR=hThwXpN_izQzM26q-g@mail.gmail.com>
 <1336146319-6803-1-git-send-email-leiwen@marvell.com>
 <CALZhoSQcjrOk3s6NFRs34H5uiYWK+TYeqJpoiwC6XSF+xPXrzg@mail.gmail.com>
 <20120509183455.GB19219@gmail.com>
Message-ID: <CAAXpJNvafi5oZJDQsE9oxLyKZVVLyLLBP9DUt1+jBw9_reY_8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/5/10 Mike Turquette <mturquette@ti.com>:
> On 20120504-23:58, Lei Wen wrote:
>> There is one clock rate changing requirement like those:
>> 1. clock may need specify specific rate binded with specific parent
>> 2. driver care only set_rate, don't care for which parent it is linked
>> 3. It need registering notification to changing voltage
>> 4. It want keep parent and rate changing in an atomic operation, which
>> ? means for chaning parent, it only caching the mux chaning, and
>> ? maintent the relationship in this tree, while do the real parent
>> ? and rate chaning in the set_rate callback. And it requires
>> ? recalculated rate reflect the true rate changing state to make the
>> ? decision to whether sending notification.
>>
>> Base on those assumption, the logic in set_rate is changed a little, the
>> round_rate should return not only best parent_rate, but also best
>> parent. If best parent is changed, we would switch parent first, then do
>> the sub rate chaning.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Acked-by: Raul Xiong <raulxiong@gmail.com>
>
> Hi Lei,
>
> On the whole I am not convinced this change is necessary. ?It would help
> me to see the .set_rate implementation for your platform that makes use
> of this change. ?Can you share that code, even if it is in an unfinished
> state?

Of course, I will show you the draft code at the end of this mail.

>
> Also would you mind taking a look at OMAP's PLL .set_rate
> implementation? ?This code must also change parents based on rate but
> doesn't require your patch. ?It uses __clk_reparent to clean up the
> clock tree afterwards. ?Please view the relevant function here:
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=blob;f=arch/arm/mach-omap2/dpll3xxx.c;h=63e92e2d4bb80ea702572b919c17b0ac9f93cc0e;hb=clk-next-omap#l425

I have also considered about use __clk_reparent to change its parent
at first, but found it can not satisfy our clock.
I will describe the details below.

>
> There is a parallel thread also discussing some aspects of this topic:
> http://article.gmane.org/gmane.linux.ports.tegra/4696
>
> snip
>> @@ -767,6 +768,7 @@ static struct clk *clk_calc_new_rates(struct clk
>> *clk, unsigned long rate)
>> ? ? ? ?struct clk *top = clk;
>> ? ? ? ?unsigned long best_parent_rate = clk->parent->rate;
>> ? ? ? ?unsigned long new_rate;
>> + ? ? ? int ret;
>>
>> ? ? ? ?if (!clk->ops->round_rate && !(clk->flags & CLK_SET_RATE_PARENT)) {
>> ? ? ? ? ? ? ? ?clk->new_rate = clk->rate;
>> @@ -785,6 +787,21 @@ static struct clk *clk_calc_new_rates(struct clk
>> *clk, unsigned long rate)
>> ? ? ? ?else
>> ? ? ? ? ? ? ? ?new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
>>
>> + ? ? ? if (clk->hw->new_parent && (clk->hw->new_parent != clk->parent)) {
>> + ? ? ? ? ? ? ? if ((clk->flags & CLK_SET_PARENT_GATE) && clk->prepare_count)
>> + ? ? ? ? ? ? ? ? ? ? ? ret = -EBUSY;
>
> This check is redundant since __clk_set_parent will do the same. ?The
> caller (clk_calc_new_rates) should simply call __clk_set_parent and
> handle the returned error code.
>
>> + ? ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? ? ret = __clk_set_parent(clk, clk->hw->new_parent);
>> +
>> + ? ? ? ? ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? ? ? ? ? pr_debug("%s: %s set parent to %s failed\n", __func__,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk->name, clk->hw->new_parent->name);
>> + ? ? ? ? ? ? ? ? ? ? ? return NULL;
>> + ? ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? ? __clk_reparent(clk, clk->hw->new_parent);
>
> This call is also redundant since __clk_set_parent calls __clk_reparent.
>
>> + ? ? ? }
>> +
>> ? ? ? ?if (best_parent_rate != clk->parent->rate) {
>> ? ? ? ? ? ? ? ?top = clk_calc_new_rates(clk->parent, best_parent_rate);
>>
>> @@ -1050,7 +1067,10 @@ out:
>>
>> ? ? ? ?clk->parent = new_parent;
>>
>> - ? ? ? __clk_recalc_rates(clk, POST_RATE_CHANGE);
>> + ? ? ? if (!clk->hw->new_parent)
>> + ? ? ? ? ? ? ? __clk_recalc_rates(clk, POST_RATE_CHANGE);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? clk->hw->new_parent = NULL;
>
> I don't like this change at all.
>
>> ?}
>>
>> ?static int __clk_set_parent(struct clk *clk, struct clk *parent)
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 5508897..54dad8a 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -23,9 +23,11 @@
>> ?*
>> ?* clk: pointer to the struct clk instance that points back to this struct
>> ?* clk_hw instance
>> + * new_parent: pointer for caching new parent position
>> ?*/
>> ?struct clk_hw {
>> ? ? ? ?struct clk *clk;
>> + ? ? ? struct clk *new_parent;
>
> I would not put new_parent in struct clk_hw, but instead struct clk.
> This is analogous to the new_rate member of struct clk.
>
>> ?};
>>
>> ?/*
>> --
>> 1.7.5.4
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Please help to see below code, we add this as our clock have some
special requirements.
1) this clock has four sources, and one divider field, and it requests
a trigger bits to trigger HW to issue frequency change.
2) every set rate operation we want to set mux, divider and trigger
bits at the same time, we don't want to set mux&trigger to change the
parent at the first time, and then set divider&trigger to trigger the
clock rate change the second time, this may bring some interim clock
frequency, which may harmful to HW.
3) This clock has registered clk notifier to trigger voltage change
when its rate changes.

In our current implement, we set flag CLK_SET_RATE_PARENT for this clock.
.round_rate operation we only find the proper parent for the new rate
and record it in SW. (clk->hw->parent is used to record it). If
clk->hw->parent is set, we will call __clk_set_parent and
__clk_reparent API to let clock framework know our parent is changed.
But actually at this moment, this clock is still sourcing from old
parent and its rate also don't change here.
our .set_parent operation will do nothing, as I said above we don't
really change mux here due to temp frequency may occur here.

At the end of __clk_reparent API, __clk_recalc_rate(clk,
POST_RATE_CHANGE) will be called, as it assumes when a clk's parent is
changed, we should recalculate its clock rate and decide whether to
use notifier to trigger voltage change. Since from SW sides, its
parent is changed, and clk->rate = clk->ops->recalc_rate(clk->hw,
parent_rate) also changed(parent_rate changed here, but divider read
from register has not changed yet). Then it will send out a notifier
to request voltage change. But actually our rate has not changed yet,
we don't want adjust voltage here. So we only call __clk_recalc_rates
when clk->hw->new_parent is NULL.


 arch/arm/mach-mmp/clk_periph.c              |  208 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/clk-periph.h |   44 ++++++
 2 files changed, 252 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/clk_periph.c
 create mode 100644 arch/arm/mach-mmp/include/mach/clk-periph.h

diff --git a/arch/arm/mach-mmp/clk_periph.c b/arch/arm/mach-mmp/clk_periph.c
new file mode 100644
index 0000000..d5b5a9f
--- /dev/null
+++ b/arch/arm/mach-mmp/clk_periph.c
@@ -0,0 +1,208 @@
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <mach/clk.h>
+#include <mach/pxa988-clk.h>
+#include <mach/regs-apmu.h>
+
+
+struct clk_periph {
+       struct clk_hw   hw;
+       struct clk_ctrl_reg *cc_reg;
+       struct periph_clk_table *clk_tbl;
+       u32 clk_tbl_index;
+       spinlock_t      *lock;
+};
+
+#define to_clk_periph(_hw)     container_of(_hw, struct clk_periph, hw)
+#define div_mask(d, width)     ((1 << (d->width)) - 1)
+
+
+static int clk_periph_enable(struct clk_hw *hw)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk_ctrl_reg *cc_reg = clk_periph->cc_reg;
+       u32 val;
+
+       val = readl(cc_reg->base);
+       val |= cc_reg->enable_mask;
+       writel(val, cc_reg->base);
+
+       return 0;
+}
+
+static void clk_periph_disable(struct clk_hw *hw)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk_ctrl_reg *cc_reg = clk_periph->cc_reg;
+       u32 val;
+
+       val = readl(cc_reg->base);
+       val &= ~(cc_reg->enable_mask);
+       writel(val, cc_reg->base);
+       return;
+}
+
+static u8 clk_periph_get_parent(struct clk_hw *hw)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk_ctrl_reg *cc_reg = clk_periph->cc_reg;
+       u32 val;
+
+       val = readl(cc_reg->base) >> cc_reg->fsel_shift;
+       val &= div_mask(cc_reg, fsel_width);
+
+       if (val >= __clk_get_num_parents(hw->clk))
+               return -EINVAL;
+
+       return val;
+}
+
+static int clk_periph_set_parent(struct clk_hw *hw, u8 index)
+{
+       return 0;
+}
+
+static long clk_periph_round_rate(struct clk_hw *hw, unsigned long rate,
+                               unsigned long *prate)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk *clk = hw->clk;
+       struct clk *new_parent = NULL;
+       struct clk *cur_parent = __clk_get_parent(clk);
+       unsigned int i;
+
+       /* use cached parent, the clock is still from old parent */
+
+       /* Ugly adjust the parent here, since it doesn't care about
his parent */
+       for (i = 0; clk_periph->clk_tbl[i].fclk_parent != NULL; i++) {
+               if (rate >= clk_periph->clk_tbl[i].fclk) {
+                       new_parent = clk_periph->clk_tbl[i].fclk_parent;
+                       clk->hw->new_parent = new_parent;
+                       clk_periph->clk_tbl_index = i;
+                       *prate = __clk_get_rate(new_parent);
+                       return clk_periph->clk_tbl[i].fclk;
+               }
+       }
+
+       printk(KERN_WARNING "clk %s out of range! rate %u\n", \
+               __clk_get_name(clk), rate);
+       *prate = __clk_get_rate(cur_parent);
+       return clk->rate;
+}
+
+static int clk_periph_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk_ctrl_reg *cc_reg = clk_periph->cc_reg;
+       unsigned int fdiv, adiv, fsel, asel, prate;
+       unsigned long flags = 0;
+       u32 val, mask;
+
+       if (rate == hw->clk->rate)
+               return 0;
+
+       /*
+        * Always suppose fclk and aclk of GC are from
+        * the same clock source, and the fclk:aclk=1:1/1:2
+        * Think about the case aclk and fclk have different parent,
+        * but we don't want to expose aclk as a clk node, it is hard
+        * handle this case. Or use fixed aclk.
+        */
+       fsel = asel = clk_periph->clk_tbl[clk_periph->clk_tbl_index].psel_val;
+       prate = __clk_get_rate(__clk_get_parent(hw->clk));
+       fdiv = prate / rate - 1;
+       adiv = prate / clk_periph->clk_tbl[clk_periph->clk_tbl_index].aclk - 1;
+
+       fdiv = (fdiv > div_mask(cc_reg, fsel_width)) ? \
+               div_mask(cc_reg, fsel_width) : fdiv;
+       adiv = (adiv > div_mask(cc_reg, asel_width)) ? \
+               div_mask(cc_reg, asel_width) : adiv;
+
+       fsel = fsel << (cc_reg->fsel_shift);
+       asel = asel << (cc_reg->asel_shift);
+       fdiv = fdiv << (cc_reg->fdiv_shift);
+       adiv = adiv << (cc_reg->adiv_shift);
+
+       if (clk_periph->lock)
+               spin_lock_irqsave(clk_periph->lock, flags);
+
+       /* trigger aclk change first */
+       val = readl(cc_reg->base);
+       mask = (div_mask(cc_reg, asel_width) << cc_reg->asel_shift) |
+               (div_mask(cc_reg, adiv_width) << cc_reg->adiv_width);
+       val &= ~mask;
+       val |= (asel | adiv | (1 << cc_reg->aclk_fc_req));
+       printk(KERN_DEBUG "gc_set_rate aclk val = %x\n", val);
+       writel(val, cc_reg->base);
+
+       /* trigger fclk change */
+       val = readl(cc_reg->base);
+       mask = (div_mask(cc_reg, fsel_width) << cc_reg->fsel_shift) |
+               (div_mask(cc_reg, fdiv_width) << cc_reg->fdiv_width);
+       val &= ~mask;
+       val |= (fsel | fdiv | (1 << cc_reg->fclk_fc_req));
+       printk(KERN_DEBUG "gc_set_rate fclk val = %x\n", val);
+       writel(val, cc_reg->base);
+
+       if (clk_periph->lock)
+               spin_unlock_irqrestore(clk_periph->lock, flags);
+
+       return 0;
+}
+
+static unsigned long clk_periph_recalc_rate(struct clk_hw *hw,
+               unsigned long parent_rate)
+{
+       struct clk_periph *clk_periph = to_clk_periph(hw);
+       struct clk_ctrl_reg *cc_reg = clk_periph->cc_reg;
+       unsigned int div;
+
+       div = readl(cc_reg->base) >> cc_reg->fdiv_shift;
+       div &= div_mask(cc_reg, fdiv_width);
+       div += 1;
+
+       return parent_rate / div;
+}
+
+struct clk_ops clk_periph_ops = {
+       .enable = clk_periph_enable,
+       .disable = clk_periph_disable,
+       .set_rate = clk_periph_set_rate,
+       .round_rate = clk_periph_round_rate,
+       .recalc_rate = clk_periph_recalc_rate,
+       .get_parent = clk_periph_get_parent,
+       .set_parent = clk_periph_set_parent,
+};
+
+struct clk *clk_periph(const char *name, struct clk_ctrl_reg *cc_reg,
+                       struct periph_clk_table *clk_tbl,
+                       const char **parent_names, u8 num_parents,
+                       u8 clk_periph_flags, spinlock_t *lock)
+{
+       struct clk_periph *clk_periph;
+       struct clk *clk = NULL;
+
+       clk_periph = kzalloc(sizeof(*clk_periph), GFP_KERNEL);
+       if (!clk_periph) {
+               pr_err("%s: could not allocate mux clk\n", __func__);
+               return ERR_PTR(-ENOMEM);
+       }
+
+       clk_periph->clk_tbl = clk_tbl;
+       clk_periph->cc_reg = cc_reg;
+       clk_periph->lock = lock;
+
+       clk = clk_register(NULL, name, &clk_periph_ops, &clk_periph->hw,
+                       parent_names, num_parents, CLK_SET_RATE_PARENT);
+       if (IS_ERR(clk))
+               kfree(clk_periph);
+
+       return clk;
+}
+
diff --git a/arch/arm/mach-mmp/include/mach/clk-periph.h
b/arch/arm/mach-mmp/include/mach/clk-periph.h
new file mode 100644
index 0000000..979b807
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/clk-periph.h
@@ -0,0 +1,44 @@
+
+
+
+#ifndef __PXA988_CLK_H
+#define __PXA988_CLK_H
+
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+struct periph_clk_table {
+       unsigned long fclk;
+       unsigned long aclk;
+       const char *fclk_pname;
+       struct clk *fclk_parent;
+       unsigned long psel_val;
+};
+
+struct clk_ctrl_reg {
+       void __iomem    *base;
+       u32             enable_mask;
+       u8              fsel_shift;
+       u8              fsel_width;
+       u8              asel_shift;
+       u8              asel_width;
+       u8              fdiv_shift;
+       u8              fdiv_width;
+       u8              adiv_shift;
+       u8              adiv_width;
+       u8              fclk_fc_req;
+       u8              aclk_fc_req;
+};
+
+struct clk *clk_periph(const char *name, struct clk_ctrl_reg *cc_reg,
+                       struct periph_clk_table *clk_tbl,
+                       const char **parent_names, u8 num_parents,
+                       u8 clk_periph_flags, spinlock_t *lock);
+
+
+
+#endif
+
+
--
1.7.1

I also consider your suggestion and do NOT set flag
CLK_SET_RATE_PARENT for this clock, actually we don't want to change
its parents clock dynamic. Still have some issue. Please take a look
at below sequence.

Take rate changes from 533M->312M for example
clk_set_rate(clk, 312M)
   |
clk_calc_new_rate  -> .round_rate: find the right clock rate we can use
   |
clk_propagate_rate_change -> send PRE_RATE_CHANGE notify, do nothing
as we are decreasing rate from 533->312
  |
clk_change_rate ->  .set_rate    (old_rate = 533M)
                                     |
                        1)prepare and enable new parent
                                     |
                2)set mux, divider and trigger, clk rate really changed here.
                                     |
                3)__clk_reparent -> __clk_recalc_rates,  old_rate =
clk->rate = 533M(has not updated yet), the rate recalc_rate
                                                     from parent_rate
is 312M and NOT equal clk->rate, send POST_RATE_CHANGE notify, we
                                                     decrease voltage
                                     |
              4) unprepare and disable old parent, return
                                     |
                      call .recalc_rate
                                    |
                    update clk->rate here clk->rate = 312M, but
old_rate is 533M
                                    |
                    POST_RATE_CHANGE is called again.  This is not
what we want.

Mike,
Do you think it is possible that __clk_reparent do NOT call
__clk_recalc_rates, and it only do some SW thing?
We can move __clk_recalc_rates into function clk_set_parent, just
after __clk_reparent?
In my opinion, other platform also will meet the same issue,  Do you
think it can satisfy other platform has the same requirement? Or do
you have any other suggestion?

Another question from me, common clk framework assumes that if driver
wants to set to new rate which is sourcing from other parent, it has
to call clk_set_parent first and then call clk_set_rate. But these
drivers may be shared between platforms and they may don't want to
take care about the parent differences on different platform. Then
these things have to be handled by clock framework. Do you think it is
reasonable, or how about the original thought of common clk framework?

I have risen so many question to you. I really want to listen to your
suggestion to better understand and take use of the common clock
framework.
Thanks very much!

-- 
Zhoujie Wu
