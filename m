From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 11:23:39 -0700
Subject: [PATCH 3/6] clk: bcm2835: enable clocks that have been enabled by
 firmware
In-Reply-To: <19B78DCB-23E2-4600-ABF6-177AFACF159D@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-4-git-send-email-kernel@martin.sperl.org>
 <87vb575ld9.fsf@eliezer.anholt.net> <87poutf1gv.fsf@eliezer.anholt.net>
 <19B78DCB-23E2-4600-ABF6-177AFACF159D@martin.sperl.org>
Message-ID: <87bn6dt13o.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 17.03.2016, at 18:39, Eric Anholt <eric@anholt.net> wrote:
>> 
>> Eric Anholt <eric@anholt.net> writes:
>> 
>>> kernel at martin.sperl.org writes:
>>> 
>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>> 
>>>> If a clock that has been enabled by the firmware gets disabled
>>>> by a driver this may right now result in a crash of the system
>>>> as then also the corresponding PLL_dividers as well as PLLs
>>>> get disabled (if not used) - some of which are used by the
>>>> VideoCore GPU (which also runs the firmware)
>>>> 
>>>> This patch prepares/enables those clocks that have been
>>>> configured by the firmware.
>>>> 
>>>> Whenever the clock framework implements either
>>>> CLK_IS_CRITICAL or HAND_OFF this can get changed to use this
>>>> new mechanism.
>>>> 
>>>> For this to be completely successful (i.e not missing a clock
>>>> and subsequently a pll) it is recommended to add all the known
>>>> clocks of the soc so that this can get applied to all clocks.
>>> 
>>> I think this makes sense to have, for now at least.
>>> 
>>> Reviewed-by: Eric Anholt <eric@anholt.net>
>> 
>> Scratch that, this breaks display.  Since the clkgen clocks are flagged
>> as needing to be gated in order to change dividers, it means you can't
>> set clock rates for anything that was turned on at boot.
>
> See that separate thread that triggered this:
>   serial: clk: bcm2835: Strange effects when using aux-uart in console
> and this patch fixes this issue.
>
> To summarize the situation figured in the thread:
> * you load the module
>
> * you start using the tty (say by using "stty -F /dev/ttyAMA0")
> * this opens the device
> * this prepare the relevant clock (usage = 1)
> * this prepares the parent pll-divider (usage = 1)
> * this prepares the parent pll (usage = 1)
>
> * you stop using the tty (stty closes the device)
> * this release the clock
> *   usage count drops to 0, so disable the clock
> * this releases the parent pll-divider
> *   usage count drops to 0, so disable the pll-div
> * this releases the parent pll (and disables it as usage = 0)
> *   usage count drops to 0, so disable the pll-div
>
> * system crashes (with a bit of delay)
>
> The prepare should just increase the usage so it never gets to a count of 0.
>
> Maybe we need to use those "CLK_IS_CRITICAL? ?HANDS_OFF? flags instead?
> (when/if they become available)
>
> How do you want to solve that - I have not got a DSI display, 
> but HDMI continues to work...

We should just prepare the necessary divider, not the leaf clocks that
we actually want to control at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/7fb1570f/attachment.sig>
