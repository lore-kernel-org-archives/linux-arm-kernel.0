From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 27 Apr 2016 16:55:21 +0200
Subject: [PATCH V2] clk: bcm2835: mark enabled pll_dividers as critical
In-Reply-To: <7BC21876-C9EF-489D-9F5A-06C7DD52F05C@martin.sperl.org>
References: <1461660989-11846-1-git-send-email-kernel@martin.sperl.org>
 <8737q8dv5f.fsf@eliezer.anholt.net>
 <BC74AA10-C36C-4643-B979-0617D222D605@martin.sperl.org>
 <87bn4v6dou.fsf@eliezer.anholt.net>
 <7BC21876-C9EF-489D-9F5A-06C7DD52F05C@martin.sperl.org>
Message-ID: <CE870B17-69B8-49B5-9BB8-005F6B27D5AE@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 27.04.2016, at 07:31, Martin Sperl <kernel@martin.sperl.org> wrote:
> 
> 
> 
>> On 27.04.2016, at 03:30, Eric Anholt <eric@anholt.net> wrote:
>> 
>> Martin Sperl <kernel@martin.sperl.org> writes:
>> 
>>> Sent from my iPad
>>>> On 26.04.2016, at 21:31, Eric Anholt <eric@anholt.net> wrote:
>>>> 
>>>> kernel at martin.sperl.org writes:
>>>> 
>>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>>> 
>>>>> The bcm2835 firmware enables several clocks and plls before
>>>>> booting the linux kernel.
>>>>> 
>>>>> These plls should never get disabled as it may result in a
>>>>> stopped system clock and more.
>>>>> 
>>>>> So during probing we check if the pll_divider is enabled
>>>>> and if it is then mark that pll_divider as critical.
>>>>> As a consequence this will also enable the corresponding parent pll.
>>>>> 
>>>>> Here the list of pll_div that are marked as critical:
>>>>> [    2.022437] bcm2835-clk 20101000.cprman: found enabled pll_div plla_core - marking it as critical
>>>>> [    2.031640] bcm2835-clk 20101000.cprman: found enabled pll_div pllb_arm - marking it as critical
>>>>> [    2.040966] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_core0 - marking it as critical
>>>>> [    2.050351] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_per - marking it as critical
>>>>> [    2.059427] bcm2835-clk 20101000.cprman: found enabled pll_div plld_core - marking it as critical
>>>>> [    2.068590] bcm2835-clk 20101000.cprman: found enabled pll_div plld_per - marking it as critical
>>>>> [    2.077724] bcm2835-clk 20101000.cprman: found enabled pll_div pllh_pix - marking it as critical
>>>> 
>>>> Yeah, pllh_pix isn't critical, though.  We want it to get turned off
>>>> when the driver asks to disable its clock, or we're going to just waste
>>>> a pile of power.
>>>> 
>>>> I'm sending out a patch that marks the VPU clock as critical (it's the
>>>> also AXI bus, so it certainly is critical), which should solve your
>>>> aux_uart clock disabling problem, I think.
>>> 
>>> The problem is that it also fails on the pcm clock alone when pllc or 
>>> plld_per are used as parent, but it is fine when osc is used...
>> 
>> For that you're going to want the HAND_OFF patches that mturquette is
>> working on: Don't let the clock and its parents get turned off until a
>> driver has shown up that has referenced the clock and done at least a
>> prepare on it once.
> That one was the one I thought of as well, but it does not solve the
> issue at all, because:
> 
> Speaker-test opens the audio device for 32bit 41200 samples
> Which in turn uses the i2s driver
> Which enable_prepares the clock (uses pllc_per or plld_per)
> Plays sound until the end
> Then speaker test closes the audio device
> Which disables/unprepared the PCM clock
> Which disables/unprepares plld_per
> Which disables/unprepares plld
> Machine crashes
> 
> For those last few steps the handsoff still would release the
> Pll-div and pll as it has been claimed correctly first.
> 
> Maybe handsoff would work if applied to the individual
> Clocks (not the pll or pllc), but I am not sure if this is a correct
> assumption, as I do not know if handsoff would propagate 
> up the clock tree.
> 
> So the critical flag seems the "best" approach for now,
> But as you have said: it is not ideal as it never disables
> Any clocks when they are not really needed.
> 
> But so that we can continue we need something 
> that works now (even if it is not perfect)
> 
> Another approach would be knowing the list of clocks 
> that the firmware claims/owns and mark only those as "critical?.
I did a test with HAND_OFF and that works very well indeed!

Here the corresponding patch:
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 35f8de7..31417fd 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1251,6 +1251,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
                init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
        }

+       /* if the clock is running, then mark is as critical */
+       if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
+               dev_info(cprman->dev,
+                        "found enabled clock %s - enabling hand off\n",
+                        data->name);
+               init.flags |= CLK_ENABLE_HAND_OFF;
+       }
+
        clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
        if (!clock)
                return NULL;

Note that I am not sure if that is also needed for the pll
and pll-div - there may be some explicit consumers of the pll_div

At least that latest issue we have seen with the pcm clock has gone away.

Registered clocks with hand-off:
bcm2835-clk 20101000.cprman: found enabled clock timer - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock otp - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock uart - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock v3d - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock isp - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock h264 - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock vec - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock tsens - enabling hand off
bcm2835-clk 20101000.cprman: found enabled clock emmc - enabling hand off

Enabled clock count:
root at raspcm:~# grep -vE ^0 /sys/kernel/debug/clk/*/clk_enable_count
/sys/kernel/debug/clk/apb_pclk/clk_enable_count:1
/sys/kernel/debug/clk/clock/clk_enable_count:1
/sys/kernel/debug/clk/core/clk_enable_count:3
/sys/kernel/debug/clk/emmc/clk_enable_count:1
/sys/kernel/debug/clk/h264/clk_enable_count:1
/sys/kernel/debug/clk/isp/clk_enable_count:1
/sys/kernel/debug/clk/osc/clk_enable_count:7
/sys/kernel/debug/clk/otp/clk_enable_count:1
/sys/kernel/debug/clk/plla/clk_enable_count:1
/sys/kernel/debug/clk/plla_core/clk_enable_count:3
/sys/kernel/debug/clk/pllc/clk_enable_count:1
/sys/kernel/debug/clk/pllc_per/clk_enable_count:1
/sys/kernel/debug/clk/plld/clk_enable_count:1
/sys/kernel/debug/clk/plld_per/clk_enable_count:1
/sys/kernel/debug/clk/pllh_aux/clk_enable_count:1
/sys/kernel/debug/clk/pllh_aux_prediv/clk_enable_count:1
/sys/kernel/debug/clk/pllh/clk_enable_count:1
/sys/kernel/debug/clk/timer/clk_enable_count:1
/sys/kernel/debug/clk/tsens/clk_enable_count:1
/sys/kernel/debug/clk/uart0_pclk/clk_enable_count:1
/sys/kernel/debug/clk/uart/clk_enable_count:1
/sys/kernel/debug/clk/v3d/clk_enable_count:1
/sys/kernel/debug/clk/vec/clk_enable_count:1

That is a setup where the clock bcm2835 is only referenced in the device 
tree for pcm.

Using pcm-audio would trigger a machine halt before this patch.
Now this does not happen.

Hope that this is the best solution and an incentive to get those
CLK_ENABLE_HAND_OFF patches in as there is now the first user.

I will post this as a patch.

Martin
