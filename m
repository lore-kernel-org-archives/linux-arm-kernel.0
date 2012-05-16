From: zhoujiewu@gmail.com (zhoujie wu)
Date: Wed, 16 May 2012 19:55:27 +0800
Subject: [PATCH V2] clk: give clock chance to change parent at setrate
 stage
In-Reply-To: <CAJOA=zNnKM6ymn=FW2260cVr6hat-ucBkSG8iiRcPt38Sve89w@mail.gmail.com>
References: <CAG9bXvmAf-0fmVb8nzWkuAKaMoOJVzR=hThwXpN_izQzM26q-g@mail.gmail.com>
 <1336146319-6803-1-git-send-email-leiwen@marvell.com>
 <CALZhoSQcjrOk3s6NFRs34H5uiYWK+TYeqJpoiwC6XSF+xPXrzg@mail.gmail.com>
 <20120509183455.GB19219@gmail.com>
 <CAAXpJNvafi5oZJDQsE9oxLyKZVVLyLLBP9DUt1+jBw9_reY_8Q@mail.gmail.com>
 <CAJOA=zNnKM6ymn=FW2260cVr6hat-ucBkSG8iiRcPt38Sve89w@mail.gmail.com>
Message-ID: <CAAXpJNvdaZxSiCr3Usd0B4iGHLkxshwzfN4LQZ2xZCcwBe8fVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/5/16 Turquette, Mike <mturquette@ti.com>:
> On Thu, May 10, 2012 at 2:03 AM, zhoujie wu <zhoujiewu@gmail.com> wrote:
>> Please help to see below code, we add this as our clock have some
>> special requirements.
>> 1) this clock has four sources, and one divider field, and it requests
>> a trigger bits to trigger HW to issue frequency change.
>> 2) every set rate operation we want to set mux, divider and trigger
>> bits at the same time, we don't want to set mux&trigger to change the
>> parent at the first time, and then set divider&trigger to trigger the
>> clock rate change the second time, this may bring some interim clock
>> frequency, which may harmful to HW.
>
> Are you able to program these bits in separate writes? ?Specifically,
> can you perform the following sequence:
>
> writel(divider_value, register_address);
> writel(mux_value, register_address);
> writel(trigger_bit_value, register_address);
>
> Also can you read from this register or is write-only? ?Specifically,
> can you perform a read-modify-write sequence to it? ?Looks like you
> can read since I see alot of "val = readl(cc_reg->base);" in some of
> your functions below.

Yes, the register is R/W and we could perform a read-modify-write sequence.

>
> Ideally I'd like to break your clock up into two clocks. ?First a mux,
> and then the child of that mux is a divider. ?To do so requires that
> you can make multiple separate writes to your trigger register.
>
>> 3) This clock has registered clk notifier to trigger voltage change
>> when its rate changes.
>>
>> In our current implement, we set flag CLK_SET_RATE_PARENT for this clock.
>
> At the bottom of this mail you say that you do not wish to use
> CLK_SET_RATE_PARENT on this clock and that you do no wish to
> dynamically change the rate of this clock's parent. ?Can you clarify
> whether or not you want to change the rate of the parent of this
> "trigger" clock?

Sorry for the confuse, we will not CLK_SET_RATE_PARENT flag for this clock.

>
> ...
>> +static int clk_periph_set_rate(struct clk_hw *hw, unsigned long rate)
>> +{
> ...
>> + ? ? ? fsel = asel = clk_periph->clk_tbl[clk_periph->clk_tbl_index].psel_val;
>> + ? ? ? prate = __clk_get_rate(__clk_get_parent(hw->clk));
>> + ? ? ? fdiv = prate / rate - 1;
>> + ? ? ? adiv = prate / clk_periph->clk_tbl[clk_periph->clk_tbl_index].aclk - 1;
>> +
>> + ? ? ? fdiv = (fdiv > div_mask(cc_reg, fsel_width)) ? \
>> + ? ? ? ? ? ? ? div_mask(cc_reg, fsel_width) : fdiv;
>> + ? ? ? adiv = (adiv > div_mask(cc_reg, asel_width)) ? \
>> + ? ? ? ? ? ? ? div_mask(cc_reg, asel_width) : adiv;
>> +
>> + ? ? ? fsel = fsel << (cc_reg->fsel_shift);
>> + ? ? ? asel = asel << (cc_reg->asel_shift);
>> + ? ? ? fdiv = fdiv << (cc_reg->fdiv_shift);
>> + ? ? ? adiv = adiv << (cc_reg->adiv_shift);
> ...
>> + ? ? ? /* trigger fclk change */
>> + ? ? ? val = readl(cc_reg->base);
>> + ? ? ? mask = (div_mask(cc_reg, fsel_width) << cc_reg->fsel_shift) |
>> + ? ? ? ? ? ? ? (div_mask(cc_reg, fdiv_width) << cc_reg->fdiv_width);
>> + ? ? ? val &= ~mask;
>> + ? ? ? val |= (fsel | fdiv | (1 << cc_reg->fclk_fc_req));
>> + ? ? ? printk(KERN_DEBUG "gc_set_rate fclk val = %x\n", val);
>> + ? ? ? writel(val, cc_reg->base);
>
> Can this write above be done in multiple, incremental writes? ?If so
> then I think breaking this clock up into separate mux and dividers is
> the way to go. ?Below is an example where I write fdiv separately,
> then I write fsel and the trigger bit:
>
> /* select fclk divider */
> val = readl(cc_reg->base);
> mask = (div_mask(cc_reg, fdiv_width) << cc_reg->fdiv_width);
> val &= ~mask;
> val |= fdiv;
> printk(KERN_DEBUG "gc_set_rate fclk val = %x\n", val);
> writel(val, cc_reg->base);
>
> /* select parent and trigger fclk change */
> val = readl(cc_reg->base);
> mask = (div_mask(cc_reg, fdiv_width) << cc_reg->fdiv_width);
> val &= ~mask;
> val |= (fsel | fdiv | (1 << cc_reg->fclk_fc_req));
> printk(KERN_DEBUG "gc_set_rate fclk val = %x\n", val);
> writel(val, cc_reg->base);
>
> Will this work for you?
>
> Thanks,
> Mike

If I separate this clock to mux->divider model,
mux node will NOT set CLK_SET_RATE_PARENT flag
divider node will set CLK_SET_RATE_PARENT flag

When I want to change this clock's rate, it will at first find proper
divider with current parent rate,
if best_parent_rate != cur_parent_rate, this means we should re-parent
the mux. The mux node rate
will be change at first, and then divider. Per your suggestion, in mux
.set_rate ops we disable new parent
and set mux field, then disable old parent.
But there is a limitation here,  write to the mux filed doesn't really
change the source of the parent. It requires
the trigger bits to be set.
If we don't set trigger bits here, the source is still not change, we
could not disable old parent. Where is the proper place to disable it?
If we set mux and trigger here, we may use some tmp dangerous clock
rate since divider has not update yet.
For example, rate 400M = mux_400M/ div_1 at first. When we want to set
to 533M, we have change mux to 1066M here, we may get tmp rate 1066M =
1066M/1, but this clock may not run up to 1066M.
That is why we think it is more safe to set mux&div&trigger the same time.


Thanks!





-- 
Zhoujie Wu
