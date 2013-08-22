From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 22 Aug 2013 15:50:52 +0800
Subject: [PATCH v7 10/11] ARM: hi3xxx: add clk-hi3716
In-Reply-To: <20130822055931.8231.48936@quantum>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
 <1376965873-14431-11-git-send-email-haojian.zhuang@linaro.org>
 <20130821214300.8231.81515@quantum>
 <CAMj5BkhCVALJO=OHJ6WSr_Jsi+9DPQ_1_PGs3PgWfQxx-W-neg@mail.gmail.com>
 <20130822055931.8231.48936@quantum>
Message-ID: <CAD6h2NSCh7m5O3Tc2-D-Znf5teXA=kqorU-+af2eK261yTtO=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 August 2013 13:59, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting zhangfei gao (2013-08-21 18:19:33)
>> On Thu, Aug 22, 2013 at 5:43 AM, Mike Turquette <mturquette@linaro.org> wrote:
>> > Quoting Haojian Zhuang (2013-08-19 19:31:12)
>> >> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>> >>
>> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> >> Signed-off-by: Zhang Mingjun <zhang.mingjun@linaro.org>
>> >> ---
>>
>> >> +static int hi3716_clkgate_prepare(struct clk_hw *hw)
>> >> +{
>> >> +       struct hi3716_clk *clk = to_clk_hi3716(hw);
>> >> +       unsigned long flags = 0;
>> >> +       u32 reg;
>> >> +
>> >> +       spin_lock_irqsave(&_lock, flags);
>> >> +
>> >> +       reg = readl_relaxed(clk->reg);
>> >> +       reg &= ~BIT(clk->reset_bit);
>> >> +       writel_relaxed(reg, clk->reg);
>> >> +
>> >> +       spin_unlock_irqrestore(&_lock, flags);
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +static void hi3716_clkgate_unprepare(struct clk_hw *hw)
>> >> +{
>> >> +       struct hi3716_clk *clk = to_clk_hi3716(hw);
>> >> +       unsigned long flags = 0;
>> >> +       u32 reg;
>> >> +
>> >> +       spin_lock_irqsave(&_lock, flags);
>> >> +
>> >> +       reg = readl_relaxed(clk->reg);
>> >> +       reg |= BIT(clk->reset_bit);
>> >> +       writel_relaxed(reg, clk->reg);
>> >> +
>> >> +       spin_unlock_irqrestore(&_lock, flags);
>> >> +}
>> >> +
>> >> +static struct clk_ops hi3716_clkgate_ops = {
>> >> +       .prepare        = hi3716_clkgate_prepare,
>> >> +       .unprepare      = hi3716_clkgate_unprepare,
>> >> +};
>> >
>> > Why .prepare & .unprepare instead of .enable & .disable?
>> >
>> > Regards,
>> > Mike
>>
>> Thanks  Mike for the review
>>
>> the .enable & .disable is directly use clk_gate_ops.
>>
>> +       hi3716_clkgate_ops.enable = clk_gate_ops.enable;
>> +       hi3716_clkgate_ops.disable = clk_gate_ops.disable;
>> +       hi3716_clkgate_ops.is_enabled = clk_gate_ops.is_enabled;
>> +       p_clk->gate.bit_idx = array[1];
>>
>> prepare & unprepare is handle reset bit, while enable & disable is
>> handle enable bit.
>> We have to extend since clk_gate_ops does not consider prepare &
>> unprepare, otherwise it would be simpler.
>
> I understand why you made this choice from the perspective of re-using
> the existing gate-clock implementation. What I meant in my question is
> whether or not handling the reset bit in the .prepare/.unprepare is the
> right thing.
>
> For instance if you called clk_enable or clk_disable from within an
> interrupt handler would you want to toggle the reset bit in that
> instance?
>

No. We don't want to access reset bit for clk_enable() & clk_disable().

We don't know what issue will occur if we always control reset & unreset with
enabling/disabling.

Regards
Haojian
