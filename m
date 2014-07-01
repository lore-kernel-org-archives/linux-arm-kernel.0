From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 1 Jul 2014 14:44:40 -0300
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <20140701115252.GM14471@dragon>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
Message-ID: <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 8:52 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

>> --- a/arch/arm/mach-imx/clk-gate2.c
>> +++ b/arch/arm/mach-imx/clk-gate2.c
>> @@ -67,7 +67,7 @@ static void clk_gate2_disable(struct clk_hw *hw)
>>
>>       spin_lock_irqsave(gate->lock, flags);
>>
>> -     if (gate->share_count && --(*gate->share_count) > 0)
>> +     if (gate->share_count && (*gate->share_count)-- > 0)
>
> The change makes no sense.  Let's say that clk_gate2_disable() gets
> called with share_count being 1.  In this case, we should access
> register to gate the clock, right?

If share_count is 1 it means that someone else is using the clock and
we can't disable it.

Please try running the series without this patch. When the extern
audio clock is enabled, share_count is 1. Later the the spdif clock
(the one that is shared with extern audio clock) is disabled by the
CCF as it is not used, which makes the extern audio clock to be also
disabled, which is not what we want.

What would you suggest?
