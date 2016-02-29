From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 29 Feb 2016 22:59:43 +0100
Subject: [PATCH 5/6] clk: bcm2835: correctly enable fractional clock
 support
In-Reply-To: <87mvqj5k9r.fsf@eliezer.anholt.net>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-6-git-send-email-kernel@martin.sperl.org>
 <87mvqj5k9r.fsf@eliezer.anholt.net>
Message-ID: <0ED2FB7F-B112-487B-B222-08E5FAEE27F9@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 29.02.2016, at 21:33, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> The current driver calculates the clock divider with
>> fractional support enabled.
>> 
>> But it does not enable fractional support in the
>> control register itself resulting in an integer only divider,
>> but in clk_set_rate responds back the fractionally divided
>> clock frequency.
>> 
>> This patch enables fractional support in the control register
>> whenever there is a fractional bit set in the requested clock divider.
>> 
>> Mash clock limits are are also handled for the PWM clock
>> applying the correct divider limits (2 and max_int) applicable to
>> basic fractional divider support (mash order of 1).
>> 
>> It also adds locking to protect the read/modify/write cycle of
>> the register modification.
>> 
>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
>> audio domain clocks")
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> Rewrite of the commit message:
> 
> The driver has been using fractional dividers for all clocks with
> fractional bits.  However, MASH clocks (those used to drive audio) only
> do fractional division when in MASH mode, which is used to push clock
> jitter out of the audio band.  The PWM clock (used to drive i2s audio)
> is the only MASH clock currently enabled in the driver.
> 
> Additional MASH modes are available that widen the frequency range, but
> only 1-level MASH is used for now, until we characterize some better
> policy.
> 
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
> audio domain clocks?)

That is not 100% true - non mash modes have CM_FRAC and CM_FRAC = CM_MASH0
so these map each other

And for a non-mash clock if CM_FRAC is not set then the factual divider
support is not used and only the integer portion is used.
This results in a frequency that is to high (as the frac bits are missing).

Just to giv an example of firmware set clock for the timer:
root at raspcm:~# head /sys/kernel/debug/clk/timer/current_*
==> /sys/kernel/debug/clk/timer/current_divf <==
819

==> /sys/kernel/debug/clk/timer/current_divi <==
19

==> /sys/kernel/debug/clk/timer/current_frac <==
1

==> /sys/kernel/debug/clk/timer/current_parent <==
xosc

root@raspcm:~# head /sys/kernel/debug/clk/timer/regdump
ctl = 0x00000291
div = 0x00013333

So this - non mash - clock has frac set by default
and this clock is set up by the firmware!

Similar things for: hsm and uart - all of them are ?normal?
clocks and they have the CM_FRAC bit set and divf > 0.

So the code essentially sets:
* CM_FRAC for ?normal? clocks
* CM_MASH0 for mash clocks
when the divider has a fract component.

So I believe my description is correct.

But anyway: except for the pcm clocks clk_set_rate
is not really being used right now, as we still consume
the clocks set up by the firmware.

The comment portion about mash-order=1 could probably get added.

As for enabling higher order mash modes - at least in the audio
domain using I2S I have done some interresting measurements
making use of all the variations (and clock selections).

The result there was that - at least with the DAC that I 
am using - the noise level varies widely between
different mash modes and clock dividers.

So the ?lowest? noise showed the following combinations:
osc-mash3
pllc-mash2
osc-mash1
osc-non-frac (optimized so that we may use integer divider)
osc-mash2
pllc-mash1
pllc-mash3

So the "selection? of clocks/divider/mash is really requiring
fine tuning and measurement - because there is no real pattern
visible.

Here a graph showing the audio spectrum for the different
modes with a 400Hz signal:
https://cloud.githubusercontent.com/assets/2638784/13278003/20e09002-dacd-11e5-8d62-17eb7118a4fa.jpg

> 
> This is just the low bit of the 2-bit CM_MASH field at 9:10.  So you're
> enabling MASH mode 1 in this patch.  Similarly, the subject of the patch
> should be something like "Fix MASH-based fractional clock support for
> PWM" since all the other clocks work with fractional already.
> 

As explained above: no they do not work without setting the FRAC bit!

Take again the example of timer:
when not using FRAC you get a timer clock of:
1010526Hz while with FRAC you get 1000002 Hz

So you NEED to set FRAC for all.
>> 
>> 
>> +	ctl = cprman_read(cprman, data->ctl_reg) & ~CM_FRAC;
>> +	ctl |= (div & CM_DIV_FRAC_MASK) ? CM_FRAC : 0;
>> +	cprman_write(cprman, data->ctl_reg, ctl);
> 
> This should all be under "if (data->is_mash_clock) {}" since it doesn't
> do anything on non-mash clocks.
Again: without CM_FRAC you get a frequency that is too high, so it
needs to be implemented for all - independent of if it is a mash clock
or a FRAC clock.
The only cases where it does not apply is for clocks that have no fract
bits at all.
