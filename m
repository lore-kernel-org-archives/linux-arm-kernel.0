From: eric@anholt.net (Eric Anholt)
Date: Tue, 10 May 2016 10:45:43 -0700
Subject: [PATCH 0/5] clk: bcm2835: add flags for mash and parent clocks
In-Reply-To: <57319C89.7040705@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
 <87h9e6yb6i.fsf@eliezer.anholt.net> <57319C89.7040705@martin.sperl.org>
Message-ID: <877ff1yfg8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

> On 10.05.2016 03:05, Eric Anholt wrote:
>> kernel at martin.sperl.org writes:
>>
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>
>>> Allow flags to be set on a per clock index basis, which control:
>>> * the parent clocks selected when not setting clocks explicitly
>>
>> I don't think we need this other than avoiding PLLC.  What else do you
>> want to filter, and why?
> What about potentially disabling PLLA_per or PLLH_aux?
> Under some circumstances it may make sense to avoid those clocks.
> (or testdebug for that matter).

PLLH and its descendents are only used by vc4, and the parent choice
done by this driver for pllh is correct.

I don't know what you mean by "potentially disabling PLLA_PER".

We don't expose the testdebug parents, because they're of no use to us.

>>> * the clock mode with regards to integer only or higher order mash
>>
>> Please provide justification in the commit message explaining why there
>> is no obvious mash setting to just implement in clk-bcm2835.c, but that
>> that a better policy can be encoded in the DT.
>
> The normal fractional divider will vary the effective period length
> between int(div)/Fparent and (int(div)+1)/Fparent.
>
> So the device (say DAC or other) connected needs to support in
> principle Fparent/int(div) as a clock.
>
> But for higher order mash the HW will spread the period length between:
> (int(div)-3)/Fparent and (int(div)+4)/Fparent.
>
> This value may be outside of the frequencies supported by the attached
> HW. That is why mash is not enabled by default for mash clocks - only
> div.
>
> That is also why we need to have this configurable.
>
> Also obviously higher parent clock frequencies result in higher dividers
> for the same target-frequency. So the above effect is less dramatic
> when using plld_per (or pllc for that matter) compared to the main
> 19.2MHz oscillator, as for 32bit stereo audio at 96kHz (equivalent to
> 6144000Hz) in the first case we have a divider of 81.38 while for the
> second (osc) case we have a divider of 3.125.
>
> The use of mash3 is impossible for osc but the use of mash 2 would
> spread the frequencies between 9.6MHz (div=2) and 3.84MHz (div=5).
>
> For plld_per as parent using mash3 instead we get the range:
> 6410256.4Hz (div=78) and 5882352.9Hz (div=85), which is a much more
> acceptable range and should not impact the device that much.
>
> So enabling mash 3 by default is not in the best interest hence it is
> not done.

It sounds like you're optimizing for reducing frequency spread.  That
sounds fairly easy to do in the parent-choice function.

> As a side note: selection of parent oscillator and corresponding mash
> may have distinct noise behavior on the same device, where for
> 32bit*2 at 48k it is the main oscillator with mash3 while the second best
> match would be pllc with mash2 - not mash3, which has the worsted SN
> from all tested!

But PLLC continues to be unusable, since it's changed at runtime, and
evaluating its noise characteristics based on a snapshot of its
frequency doesn't make any sense.

> This behavior obviously changes with different "target frequencies"
> so it may even be necessary to account for the different target
> frequencies.

This is why encoding mash in the DT doesn't make any sense to me.  You
need a runtime policy for choosing the mash setting based on the
frequency requested, so let's figure out what policy we actually want.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/a3970398/attachment.sig>
