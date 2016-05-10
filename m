From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 10 May 2016 10:32:09 +0200
Subject: [PATCH 0/5] clk: bcm2835: add flags for mash and parent clocks
In-Reply-To: <87h9e6yb6i.fsf@eliezer.anholt.net>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
 <87h9e6yb6i.fsf@eliezer.anholt.net>
Message-ID: <57319C89.7040705@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10.05.2016 03:05, Eric Anholt wrote:
> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Allow flags to be set on a per clock index basis, which control:
>> * the parent clocks selected when not setting clocks explicitly
>
> I don't think we need this other than avoiding PLLC.  What else do you
> want to filter, and why?
What about potentially disabling PLLA_per or PLLH_aux?
Under some circumstances it may make sense to avoid those clocks.
(or testdebug for that matter).

One of the reasons can be to avoid low dividers - see also mash below

>
>> * the clock mode with regards to integer only or higher order mash
>
> Please provide justification in the commit message explaining why there
> is no obvious mash setting to just implement in clk-bcm2835.c, but that
> that a better policy can be encoded in the DT.

The normal fractional divider will vary the effective period length
between int(div)/Fparent and (int(div)+1)/Fparent.

So the device (say DAC or other) connected needs to support in
principle Fparent/int(div) as a clock.

But for higher order mash the HW will spread the period length between:
(int(div)-3)/Fparent and (int(div)+4)/Fparent.

This value may be outside of the frequencies supported by the attached
HW. That is why mash is not enabled by default for mash clocks - only
div.

That is also why we need to have this configurable.

Also obviously higher parent clock frequencies result in higher dividers
for the same target-frequency. So the above effect is less dramatic
when using plld_per (or pllc for that matter) compared to the main
19.2MHz oscillator, as for 32bit stereo audio at 96kHz (equivalent to
6144000Hz) in the first case we have a divider of 81.38 while for the
second (osc) case we have a divider of 3.125.

The use of mash3 is impossible for osc but the use of mash 2 would
spread the frequencies between 9.6MHz (div=2) and 3.84MHz (div=5).

For plld_per as parent using mash3 instead we get the range:
6410256.4Hz (div=78) and 5882352.9Hz (div=85), which is a much more
acceptable range and should not impact the device that much.

So enabling mash 3 by default is not in the best interest hence it is
not done.

This also shows why with some devices it may be preferable to configure
that only pllc is used and then with mash 3.

So this patchset tries to accomodate that - even if not in a
perfect way - I would have preferred to have this in the dt-node that
is claiming that clock, but I did not want to go that far (yet) adding
another method to clock_op.

To answer your comments on the patches themselves:
I had also been investigating the use of "assigned-clock-parents".
Something like this will not work:
i2s at ... {
   clock = <&preman PCM>;
   assigned-clocks = <&cprman PCM>, <&pcrman PCM>
   assigned-clock-parents = <&osc>, <&cprman PLLD_PER>;
}
because what it does it:
* call clk_set_parent(pcm, osc);
* call clk_set_parent(pcm, plld_per);

(if you add "assigned-clock-rates" into the mix then
clk_set_rate(pcm, rate) is also called separately).

So there is no way to "keep" track of the parent clocks we wanted
assigned.

As far as I can see the only thing that would work is to implement
an extension to the dt that would define "assigned-clock-flags"
and have a set_flags(struct clk_hw *, u32 flags) method in
clk_ops.

So maybe someone has some better ideas of how to solve this.

Martin

As a side note: selection of parent oscillator and corresponding mash
may have distinct noise behavior on the same device, where for
32bit*2 at 48k it is the main oscillator with mash3 while the second best
match would be pllc with mash2 - not mash3, which has the worsted SN
from all tested!

This behavior obviously changes with different "target frequencies"
so it may even be necessary to account for the different target
frequencies.

But that is for a different discussion.
