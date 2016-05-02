From: martin@sperl.org (Martin Sperl)
Date: Mon, 2 May 2016 10:54:29 +0200
Subject: [PATCH 2/2] clk: bcm2835: Skip PLLC clocks when deciding on a new
 clock parent
In-Reply-To: <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
References: <1461699585-6649-1-git-send-email-eric@anholt.net>
 <1461699585-6649-2-git-send-email-eric@anholt.net>
 <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
Message-ID: <572715C5.6070700@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 30.04.2016 11:28, Martin Sperl wrote:
>> On 26.04.2016, at 21:39, Eric Anholt <eric@anholt.net> wrote:
>>
>> If the firmware had set up a clock to source from PLLC, go along with
>> it.  But if we're looking for a new parent, we don't want to switch it
>> to PLLC because the firmware will force PLLC (and thus the AXI bus
>> clock) to different frequencies during over-temp/under-voltage,
>> without notification to Linux.
>>
>> On my system, this moves the Linux-enabled HDMI state machine and DSI1
>> escape clock over to plld_per from pllc_per.  EMMC still ends up on
>> pllc_per, because the firmware had set it up to use that.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
>> ?
> I guess this patch looks to me as if it is a policy inside the kernel,
> which is AFAIK frowned upon.
>
> I am looking into making "assigned-clock-parents? inside the dt
> work with the driver.
>
> Could look something like this:
> i2s: i2s at 7e203000 {
> 	assigned-clock-parents = <&cprman BCM2835_PLLD_PER>, <&clk_osc>;
> 	assigned-clocks = <&cprman BCM2835_CLOCK_PCM>, <&cprman BCM2835_CLOCK_PCM>;
> };
> (not sure if that works really - the same clock in assigned-clocks looks suspicious)
>
> This would move the policy out of the kernel into the device-tree,
> which - i guess is a better solution.

So after some more investigation it seems that we can not really use those
assigned-clock-parents properties for our purpose of filtering the parent
clocks, as it:
a) requires also assigned-clocks to be set (this may be OK)
b) it does not allow to define a list of clocks to get used - it will 
just set the
     parent of the assigned-clock - if we take the example shown above, 
it would
     call clk_set_parent 2 times for the PCM clock - once with PLLD_PER
     and once with clk_osc.

So I start to wonder if it would not be better to use an approach like this:
cprman: cprman at 7e101000 {
     ...
     brcm,clock-flags = <flags for PCM>, <flags for PWM>;
     brcm,clock-index = <BCM2835_CLOCK_PCM>, <BCM2835_CLOCK_PWM>;
}

the flags would be a bitfield that select the parent clocks.

So it could look like this:
cprman: cprman at 7e101000 {
     ...
     brcm,clock-flags = (BIT(BCM2835_PER_PARENT_OSC) |
BIT(BCM2835_PER_PARENT_PLLD_PER)), ...;
     brcm,clock-index = <BCM2835_CLOCK_PCM>, <BCM2835_CLOCK_PWM>;
}

BCM2835_PER_PARENT_PLLD_PER and BCM2835_PER_PARENT_OSC
would then be defined in include/dt-bindings/clock/bcm2835.h

In addition this would also allow us to add other flags to enable
higher order MASH clock dividers - we currently only allow simple
fractional dividers - we could even force the use of integer dividers
if there comes a need.

This would really allow us to define the parents freely and if the
firmware ever changes its behavior with regards to PLLC, then we can
easily change the device-tree.

Is this approach acceptable - maybe in a variation?

Thanks,
                     Martin
