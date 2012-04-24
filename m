From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 24 Apr 2012 11:39:21 +0530
Subject: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer
 after hwmod reset
In-Reply-To: <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
Message-ID: <CAMQu2gwTtGLFaQnRs5CXdkqAf+SaOfBbSe2BxcaJNPJWhcEBOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 2:29 AM, Paul Walmsley <paul@pwsan.com> wrote:
> cc Santosh
>
> Hi Kevin,
>
> Nice changelog!
>
> On Fri, 13 Apr 2012, Kevin Hilman wrote:
>
>> Without runtime PM enabled, hwmod needs to leave all IP blocks in an
>> enabled state by default so any driver access to the HW will succeed.
>> This is accomplished by seting the postsetup_state to enabled for all
>> hwmods during init when runtime PM is disabled.
>>
>> Currently, we have a special case for WDT in that its postsetup_state
>> is always set to disabled. ?This is done so that the WDT is disabled
>> and the timer is disarmed at boot in case there is no WDT driver.
>> This also means that when runtime PM is disabled, if a WDT driver *is*
>> built in the kernel, the kernel will crash on the first access to the
>> WDT hardware.
>>
>> We can't simply leave the WDT module enabled, because the timer is
>> armed by default after reset. That means that if there is no WDT
>> driver initialzed or loaded before the timer expires, the kernel will
>> reboot.
>>
>> To fix this, a custom reset method is added to the watchdog class of
>> omap_hwmod. ?This method will *always* disarm the timer after hwmod
>> reset. ?The WDT timer then will only be rearmed when/if the driver is
>> loaded for the WDT. ?With the timer disarmed by default, we no longer
>> need a special-case for the postsetup_state of WDT during init, so it
>> is removed.
>>
>> Any platforms wishing to ensure the watchdog remains armed across the
>> entire boot boot can simply disable the reset-on-init feature of the
>> watchdog hwmod using omap_hwmod_no_setup_reset().
>>
>> Tested on 3530/Overo, 4430/Panda.
>>
>> NOTE: on 4430, the hwmod OCP reset does not seem to rearm the timer as
>> documented in the TRM (and what happens on OMAP3.) ?I noticed this
>> because testing the HWMOD_INIT_NO_RESET feature with no driver loaded,
>> I expected a reboot part way through the boot, but did not see a
>> reboot. ?Adding some debug to read the counter, I verified that right
>> after OCP softreset, the counter is not firing. ?After writing the
>> magic start sequence, the timer starts counting. ?This means that the
>> timer disarm sequence added here does not seem to be needed for 4430,
>> but is technically the correct way to ensure the timer is disarmed, so
>> it is left in for OMAP4.
>>
>> Special thanks to Paul Walmsley for helping brainstorm ideas to fix
>> this problem.
>>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> This looks great, looks like it will finally fix this longstanding bug. ?I
> think Santosh hit it too a long time ago, so I suspect he will be happy
> too.
>
Indeed !!
Thanks a lot Kevin/Paul for getting this sorted out.

FWIW,
Acked-by: Santosh Shilimkar ,santosh.shilimkar at ti.com>
