From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 12 May 2016 11:19:43 +0200
Subject: [PATCH 0/5] clk: bcm2835: add flags for mash and parent clocks
In-Reply-To: <877ff1yfg8.fsf@eliezer.anholt.net>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
 <87h9e6yb6i.fsf@eliezer.anholt.net> <57319C89.7040705@martin.sperl.org>
 <877ff1yfg8.fsf@eliezer.anholt.net>
Message-ID: <57344AAF.8000205@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10.05.2016 19:45, Eric Anholt wrote:
> Martin Sperl <kernel@martin.sperl.org> writes:
>
>> On 10.05.2016 03:05, Eric Anholt wrote:
>>> kernel at martin.sperl.org writes:
>>>
>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>>
>>>> Allow flags to be set on a per clock index basis, which control:
>>>> * the parent clocks selected when not setting clocks explicitly
>>>
>>> I don't think we need this other than avoiding PLLC.  What else do you
>>> want to filter, and why?
>> What about potentially disabling PLLA_per or PLLH_aux?
>> Under some circumstances it may make sense to avoid those clocks.
>> (or testdebug for that matter).
>
> PLLH and its descendents are only used by vc4, and the parent choice
> done by this driver for pllh is correct.
>
> I don't know what you mean by "potentially disabling PLLA_PER".
>
> We don't expose the testdebug parents, because they're of no use to us.
For all practical purposes we still have all the clocks as potential
parents during automatic clock selection - and that includes:
PLLA_PER, PLLH_AUX and TESTDEBUGX.

Not all of them are enabled, but some are - so If I select an i2s 
frequency of "3903125" then plla_per will get used with a divider of 2.

>>>> * the clock mode with regards to integer only or higher order mash
>>>
>>> Please provide justification in the commit message explaining why there
>>> is no obvious mash setting to just implement in clk-bcm2835.c, but that
>>> that a better policy can be encoded in the DT.
>>
>> The normal fractional divider will vary the effective period length
>> between int(div)/Fparent and (int(div)+1)/Fparent.
>>
>> So the device (say DAC or other) connected needs to support in
>> principle Fparent/int(div) as a clock.
>>
>> But for higher order mash the HW will spread the period length between:
>> (int(div)-3)/Fparent and (int(div)+4)/Fparent.
>>
>> This value may be outside of the frequencies supported by the attached
>> HW. That is why mash is not enabled by default for mash clocks - only
>> div.
>>
>> That is also why we need to have this configurable.
>>
>> Also obviously higher parent clock frequencies result in higher dividers
>> for the same target-frequency. So the above effect is less dramatic
>> when using plld_per (or pllc for that matter) compared to the main
>> 19.2MHz oscillator, as for 32bit stereo audio at 96kHz (equivalent to
>> 6144000Hz) in the first case we have a divider of 81.38 while for the
>> second (osc) case we have a divider of 3.125.
>>
>> The use of mash3 is impossible for osc but the use of mash 2 would
>> spread the frequencies between 9.6MHz (div=2) and 3.84MHz (div=5).
>>
>> For plld_per as parent using mash3 instead we get the range:
>> 6410256.4Hz (div=78) and 5882352.9Hz (div=85), which is a much more
>> acceptable range and should not impact the device that much.
>>
>> So enabling mash 3 by default is not in the best interest hence it is
>> not done.
>
> It sounds like you're optimizing for reducing frequency spread.  That
> sounds fairly easy to do in the parent-choice function.

You misunderstand my argument here!

I know that it may be automated, but you may have different devices
connected to: i2s/pcm, pwm, gp and slim.

Some of them need the audio spreading, while others need a stable
waveform - as mentioned mash3 varies the period between:
(divi-2)/fparent and (divi+4)/fparent in discrete steps
For this the worsted case is a requested frequency that results
in a divider between 4 and 5.

Also some DAC require a STABLE clock waveform on i2s with
specific requirements for ton/(ton+toff) between 40% and 60%,
as they have their own internal PLL, while others do not need
this kind of behavior and can handle variable period-length.
But then these DAC still have a minimum period length, which we
may not exceed.

So making an automatic selection is not possible hence
we need a means to configure the supported mash level
to get the best results in all cases.

>
>> As a side note: selection of parent oscillator and corresponding mash
>> may have distinct noise behavior on the same device, where for
>> 32bit*2 at 48k it is the main oscillator with mash3 while the second best
>> match would be pllc with mash2 - not mash3, which has the worsted SN
>> from all tested!
>
> But PLLC continues to be unusable, since it's changed at runtime, and
> evaluating its noise characteristics based on a snapshot of its
> frequency doesn't make any sense.
That was a general side note not necessarily related to PLLC.
But this may be better handled by a generic clock driver
similar to clk-fixed-factor.

>
>> This behavior obviously changes with different "target frequencies"
>> so it may even be necessary to account for the different target
>> frequencies.
>
> This is why encoding mash in the DT doesn't make any sense to me.  You
> need a runtime policy for choosing the mash setting based on the
> frequency requested, so let's figure out what policy we actually want.
See the argument of different devices/DAC with different requirements.
There is no way for any of this to work automatically and make every
client happy.
