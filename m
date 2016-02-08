From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 8 Feb 2016 12:12:44 +0100
Subject: [PATCH V4 5/7] clk: bcm2835: add missing 22 HW-clocks.
In-Reply-To: <87h9hr517u.fsf@eliezer.anholt.net>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-6-git-send-email-kernel@martin.sperl.org>
 <87h9hr517u.fsf@eliezer.anholt.net>
Message-ID: <56B8782C.4060107@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02.02.2016 02:51, Eric Anholt wrote:
> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> There were 22 HW clocks missing from the clock driver.
>>
>> These have been included and int_bits and frac_bits
>> have been set correctly based on information extracted
>> from the broadcom videocore headers
>> (http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz)
>>
>> For an extracted view of the registers please see:
>> https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md
>>
>> bcm2835_clock_per_parents has been assigned as the parent
>> clock for all new clocks, but this may not be correct
>> in all cases - documentation on this is not publicly
>> available, so some modifications may be needed in the
>> future.
>
> We need the parents to be correct if we're going to land the patch.
> I'll try to update them.
>
> I'm not a fan of this "let's just shove everything we can find in some
> header file into the .c and hope for the best."  Most of these clocks
> were left out intentionally.

Well - I wanted to get them in just in case we need them later.

If you have got access to documentation which states the correct
parent mux, then please share them so that we can implement them
correctly.

Also listing all allows us then to expose the values of the registers
via debugfs in case we need it - see separate RFC-patch 9 -  where
we expose the raw register values as well.

>> +static const struct bcm2835_clock_data bcm2835_clock_aveo_data = {
>> +	.name = "aveo",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_AVEOCTL,
>> +	.div_reg = CM_AVEODIV,
>> +	.int_bits = 4,
>> +	.frac_bits = 12,
>> +};
>
> AVEO has 0 fractional bits

Correct - my issue (copy paste - I assume).

>
>> +static const struct bcm2835_clock_data bcm2835_clock_ccp2_data = {
>> +	/* this is possibly a gate */
>> +	.name = "ccp2",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_CCP2CTL,
>> +	.div_reg = CM_CCP2DIV,
>> +	.int_bits = 1,
>> +	.frac_bits = 0,
>> +};
>
> CCP2 is a gate from a different clock source, so this won't work.
See comment above: please provide parent clock mux.
See also my comment about 3 clock that may be gates - this applies.

>
>> +static const struct bcm2835_clock_data bcm2835_clock_dsi0p_data = {
>> +	/* this is possibly a gate */
>> +	.name = "dsi0p",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_DSI0PCTL,
>> +	.div_reg = CM_DSI0PDIV,
>> +	.int_bits = 1,
>> +	.frac_bits = 0,
>> +};
>> +
>> +static const struct bcm2835_clock_data bcm2835_clock_dsi1p_data = {
>> +	/* this is possibly a gate */
>> +	.name = "dsi1p",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_DSI1PCTL,
>> +	.div_reg = CM_DSI1PDIV,
>> +	.int_bits = 1,
>> +	.frac_bits = 0,
>> +};
>
> DSI0/1 pixel clocks take different clock sources and are gates off of
> them, so these definitions don't work.
See comment above: please provide parent clock.
See also my comment about 3 clock that may be gates.

>
>> +
>> +static const struct bcm2835_clock_data bcm2835_clock_gnric_data = {
>> +	.name = "gnric",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_GNRICCTL,
>> +	.div_reg = CM_GNRICDIV,
>> +	.int_bits = 12,
>> +	.frac_bits = 12,
>> +};
>
> GNRIC isn't an actual clock, it's just what's used for describing the
> overall structure of clocks.

Well - there is the corresponding register at 0x7e101000 which reads as:
ctl = 0x0000636d
div = 0x0000636d

So we could remove this one if this is really the case of a dummy -
even though I wonder why there would be space in io-space reserved for
this "description" only.

>
>> +static const struct bcm2835_clock_data bcm2835_clock_peria_data = {
>> +	.name = "peria",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_PERIACTL,
>> +	.div_reg = CM_PERIADIV,
>> +	.int_bits = 12,
>> +	.frac_bits = 12,
>> +};
>
> This register doesn't do anything, because the debug bit in the power
> manager is not set.  We don't think we should expose a clock gate if it
> doesn't work, I think.
maybe we allow setting debug in the PM at a later point in time?

>
>> +static const struct bcm2835_clock_data bcm2835_clock_pulse_data = {
>> +	.name = "pulse",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_PULSECTL,
>> +	.div_reg = CM_PULSEDIV,
>> +	.int_bits = 12,
>> +	.frac_bits = 0,
>> +};
>
> There's some other divider involved in this clock, won't give correct results.
See comment above: please provide parent clock.

>
>> +static const struct bcm2835_clock_data bcm2835_clock_td0_data = {
>> +	.name = "td0",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_TD0CTL,
>> +	.div_reg = CM_TD0DIV,
>> +	.int_bits = 12,
>> +	.frac_bits = 12,
>> +};
>> +
>> +static const struct bcm2835_clock_data bcm2835_clock_td1_data = {
>> +	.name = "td1",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_TD1CTL,
>> +	.div_reg = CM_TD1DIV,
>> +	.int_bits = 12,
>> +	.frac_bits = 12,
>> +};
>
> These are some other clock generator, not the generic or mash ones used
> elsewhere.  I wouldn't enable them without testing.

As long as they are not referenced in the DT these only are read only
and can get read via debugfs - these are disabled anyway:

root at raspcm:/build/linux# head /sys/kernel/debug/clk/td*/clk_rate
==> /sys/kernel/debug/clk/td0/clk_rate <==
0

==> /sys/kernel/debug/clk/td1/clk_rate <==
0

>
>> +static const struct bcm2835_clock_data bcm2835_clock_tec_data = {
>> +	.name = "tec",
>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>> +	.parents = bcm2835_clock_per_parents,
>> +	.ctl_reg = CM_TECCTL,
>> +	.div_reg = CM_TECDIV,
>> +	.int_bits = 6,
>> +	.frac_bits = 0,
>> +};
>
> TEC should be osc parents.
I will change that.

>
>> -/*
>> - * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
>> - * you have the debug bit set in the power manager, which we
>> - * don't bother exposing) are individual gates off of the
>> - * non-stop vpu clock.
>> - */
>>   static const struct bcm2835_gate_data bcm2835_clock_peri_image_data = {
>>   	.name = "peri_image",
>>   	.parent = "vpu",
>>   	.ctl_reg = CM_PERIICTL,
>>   };
>>
>> +static const struct bcm2835_gate_data bcm2835_clock_sys_data = {
>> +	.name = "sys",
>> +	.parent = "vpu",
>> +	.ctl_reg = CM_SYSCTL,
>> +};
>
> same concern as peria.
maybe we allow setting debug in the PM at a later point in time?

Please propose how to continue to get the clocks in.

If you want some clocks left out, then that is fine and we
can accommodate that and just leave the defines in the bindings
header for later use...

Just list them.

Martin
