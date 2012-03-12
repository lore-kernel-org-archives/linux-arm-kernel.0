From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Mar 2012 17:00:57 -0500
Subject: [PATCH v6 3/3] clk: basic clock hardware types
In-Reply-To: <CAJOA=zOS44YRfg3A7D8G+jWoQ_gzRQ937A7tYDU+DxWce_khzQ@mail.gmail.com>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-4-git-send-email-mturquette@linaro.org>
 <4F5E5A0C.6080604@gmail.com>
 <CAJOA=zOS44YRfg3A7D8G+jWoQ_gzRQ937A7tYDU+DxWce_khzQ@mail.gmail.com>
Message-ID: <4F5E7219.7020301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2012 03:58 PM, Turquette, Mike wrote:
> On Mon, Mar 12, 2012 at 1:18 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On 03/10/2012 01:54 AM, Mike Turquette wrote:
>>> Many platforms support simple gateable clocks, fixed-rate clocks,
>>> adjustable divider clocks and multi-parent multiplexer clocks.
>>>
>>> This patch introduces basic clock types for the above-mentioned hardware
>>> which share some common characteristics.
>>>
>>> Based on original work by Jeremy Kerr and contribution by Jamie Iles.
>>> Dividers and multiplexor clocks originally contributed by Richard Zhao &
>>> Sascha Hauer.
>>>

snip

>>> +static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>>> +             unsigned long parent_rate)
>>> +{
>>> +     struct clk_divider *divider = to_clk_divider(hw);
>>> +     unsigned int div;
>>> +     unsigned long flags = 0;
>>> +
>>> +     if (divider->lock)
>>> +             spin_lock_irqsave(divider->lock, flags);
>>> +
>>> +     div = readl(divider->reg) >> divider->shift;
>>> +     div &= (1 << divider->width) - 1;
>>> +
>>> +     if (divider->lock)
>>> +             spin_unlock_irqrestore(divider->lock, flags);
>>
>> What are you locking against? You are only reading the register.
> 
> Hi Rob,
> 
> These register-level locks originally came in from the divider &
> multiplexer patches from Richard and Sascha and I'm sure they can give
> you more details than I.
> 
> Basically on their platform they have some 32-bits regs that have a
> lot of overlapping clock functions in them, such as enable/disable and
> adjusting a divider all in one reg.  Those operations are protected by
> different locks (enable spinlock and prepare mutex, respectively) so
> some synchronization mechanism is necessary.  On OMAP we don't use
> this since we have a billion registers that typically only map to one
> clock each.  I also wonder if having device type memory for the
> affected regions makes a this irrelevant on ARM... but that wouldn't
> matter for non-ARM architectures.  Just a thought.
> 

In fact, I pointed out that locking for a register access was needed in
an early version of this series as well. However, locking is only needed
if you are doing a read-mod-write on a field in a shared register or
reading from multiple registers. It makes no sense if you are *only*
reading a single shared register as is the case here. That's already an
atomic operation.

Rob
