From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 May 2012 10:15:41 -0700
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <4FA45580.8070802@ti.com> (Jon Hunter's message of "Fri, 4 May
 2012 17:17:36 -0500")
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
 <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
 <20120426180719.GC20186@mudshark.cambridge.arm.com>
 <4FA45580.8070802@ti.com>
Message-ID: <87ipg76hfm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Will,
>
> On 04/26/2012 01:07 PM, Will Deacon wrote:
>> On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
>>> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
>>>>
>>>> Part of the problem is that the clockdomain data for the emu_sys 
>>>> clockdomain is wrong.  Here's something to try to fix it.  It might just 
>>>> be enough to get it to work.
>>>
>>> Hmm, doesn't seem to work but I do see the following in dmesg when I try to
>>> use perf:
>>>
>>>  powerdomain: waited too long for powerdomain emu_pwrdm to complete transition
>>>
>>> which is new with your patch.
>> 
>> Sorry to nag, but does anybody have a clue where to go from here? I can
>> start digging in the OMAP PM code, but it's all new territory for me.
>
> I did a little playing around with this today and I think that I have figured out why this was not working (see below). Please can you try the following patch? I tried this on top of your series for perf/omap4. 
>
> Paul, FYI. If this works for Will then I can re-base on top of the latest linux-omap and submit to the mailing list.
>
> Also, the above error about the emu_pwrdm is odd too. I noticed that the emu_pwrdm is always in the transitioning state. And when I say always, I mean that even if I check the power domain state while u-boot is running it is in the transitioning state. So even before the kernel starts. 
>
> Cheers
> Jon 
>
> From 9137ff9c1b382232de7443db0b51b7555846fb62 Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 4 May 2012 16:48:45 -0500
> Subject: [PATCH] ARM: OMAP4: Disable auto enable for EMU CLKDM
>
> The flag CLKDM_CAN_HWSUP allows the clock-domain to automatically transition
> to the enabled and disabled state. This means that as soon as we force a
> software wake-up on the clock domain, the clock domain will be allowed to idle
> and put back into the hardware auto state. For the EMU clock domain this is not
> what we want. We want to keep the clock domain in the software wakeup state
> while the clock domain is being used and put it back in to the hardware auto
> state when we have finished using the clock domain.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

With this patch, how is the clkdm ever idled?

IIUC, your patch will get PMU interrupts working, but similarily to
previous patches in this thread, it works because it *never* allows the
EMU clkdm to idle.  This is not a mergeable solution because it will not
allow CORE retention (and thus full-chip retention.)

What we need is a solution that allows the clkdm to idle, and then to be
reinitialzed when it wakes up.  Due to the way (I understand) resets in
the debugss, allowing the clkdm to idle will cause a reset, so the
PMU/CTI interrupts need to be reinitialzied after wakeup.

Kevin

P.S. Please note there is also already a different fix in mainline for
the EMU clkdm data from Paul which adds the force wakeup flag and
removes the DISABLE_AUTO flag[1] (but leaves the ENABLE_AUTO flag,
because the hardware is capable.)


[1]
Author: Paul Walmsley <paul@pwsan.com>  2012-04-04 07:25:25
Committer: Paul Walmsley <paul@pwsan.com>  2012-04-04 07:25:25
Parent: c16fa4f2ad19908a47c63d8fa436a1178438c7e7 (Linux 3.3)
Branches: many (164)
Follows: v3.4-rc1
Precedes: omap-fixes-a-for-3.4rc, omap-fixes-a2-for-3.4rc

    ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTRL data
    
    According to the 4430 ES2.0 TRM vX Table 3-744 "CM_EMU_CLKSTCTRL",
    the emu_sys clockdomain data in mainline is incorrect.
    
    The emu_sys clockdomain does not support the DISABLE_AUTO state, and
    instead it supports the FORCE_WAKEUP state.
    
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Beno?t Cousson <b-cousson@ti.com>
    Cc: Kevin Hilman <khilman@ti.com>
    Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Cc: Ming Lei <ming.lei@canonical.com>
    Cc: Will Deacon <will.deacon@arm.com>
