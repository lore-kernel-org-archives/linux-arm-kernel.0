From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 6 Oct 2011 09:11:59 -0700
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E8D01BE.3020202@codeaurora.org>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E8D01BE.3020202@codeaurora.org>
Message-ID: <CAJOA=zO=Hou85bJnUr5yp7fdzWpiAtZj+MWrMgWuqbD3j33tSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2011 at 6:17 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 09/22/2011 03:26 PM, Mike Turquette wrote:
>> + ? ? ? unsigned long ? (*recalc_rate)(struct clk_hw *);
>> + ? ? ? long ? ? ? ? ? ?(*round_rate)(struct clk_hw *, unsigned long);
>> + ? ? ? struct clk * ? ?(*get_parent)(struct clk_hw *);
>> +};
>
> I would like to understand the need for recalc rate if that's something that
> we want to go into the common framework (even if it's optional). I have
> mostly heard only second hand explanations of the need for recalc_rate(), so
> I might not have the full picture. But for all the cases that I can think
> of, recalc_rate seems like a paradox.

Recalc rate has four main uses that I can think of off the top of my head:
1) clk_set_rate is called on clock0, which is a non-leaf clock.  All
clocks "below" clock0 have had their rates changed, yet no one called
clk_set_rate on those child clocks.  We use recalc to walk the
sub-tree of children and recalculate their rates based on the new rate
of their parent, clock0.

2) exact same as #1, but using clk_set_parent instead of clk_set_rate.
 Again, changing the rate of a clock "high up" in the tree will affect
the rates of many child clocks below it.

3) at boot-time/init-time when we don't trust the bootloader and need
to determine the clock rates by parsing registers

4) modeling rates for clocks that we don't really control.  This is
not as common as the above three, but there are times when we're
interested in knowing a clock rate (perhaps for debug purposes), but
it's scaling logic is in firmware or somehow independent of the Linux
clock framework.

> If recalc_rate() is used to make sure the "current rate" of a "clock A" is
> always known even if it's parent "clock B"'s rate is changed, then it also
> means that the rate of "clock A" can change without clk_set_rate(clock A,
> new rate). That in turn means that the clk_get_rate() just gives the
> instantaneous snapshot of the rate. So, any use of clk_get_rate(clock A) for
> anything other than printing/logging the return value is broken code. In

For most clocks, the first three examples I give above will cover all
of the times that a clock's rate will change.  As long as a
recalc/tree-walk is present then clk->rate is not out of sync and thus
printing/reading that value is not broken.

> which case, do we really care for recalc_rate()? We could just return the
> rate that it was set to when clk_set_rate() was called and call it a day or
> return 0 for such clocks to indicate that the clock rate is "unknown".

What's the point of tracking a rate if it can't be trusted?  Also, it
is important to recalc rates whenever changes are made "high up" in
the clock tree once we start to work on rate-change-arbitration
issues, etc.

Regards,
Mike

> The whole concept of trying to recalculate the rate for a clock makes me
> feel uneasy since it promotes misunderstanding the behavior of the clock and
> writing bad code based on that misunderstanding.
>
> I would like to hear to real usecases before I propose some alternatives
> that I have in mind.
>
> Thanks,
> Saravana
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
