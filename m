From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Nov 2014 17:39:57 +0000
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <CAAfg0W7Y=gpU_LcmSB4LW7ULnWzKPoniaPJguZuNvDzYZ6NH+A@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>	<54746C74.8020400@arm.com>	<CAAfg0W4ntf+yRZnipO+w7beN+EsZcryXCuD1eUJo1RYQNkJ2hQ@mail.gmail.com>	<54749116.2050307@arm.com>
 <CAAfg0W7Y=gpU_LcmSB4LW7ULnWzKPoniaPJguZuNvDzYZ6NH+A@mail.gmail.com>
Message-ID: <5474BEED.9010202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/14 16:43, Andy Green wrote:
> On 25 November 2014 at 22:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 25/11/14 13:42, Andy Green wrote:
>>>
>>> On 25 November 2014 at 19:48, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>> On 20/11/14 12:35, Vincent Yang wrote:
>>>>>
>>>>>
>>>>> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
>>>>> CPU/CLUSTER power up/down done by SCB over mailbox.
>>>>>
>>>>
>>>>> diff --git a/arch/arm/mach-mb86s7x/smc.S b/arch/arm/mach-mb86s7x/smc.S
>>>>> new file mode 100644
>>>>> index 0000000..a14330b
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-mb86s7x/smc.S
>>>>> @@ -0,0 +1,27 @@
>>>>> +/*
>>>>> + * SMC command interface to set secondary entry point
>>>>> + * Copyright: (C) 2013-2014 Fujitsu Semiconductor Limited
>>>>> + * Copyright: (C) 2014 Linaro Ltd.
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>> + * published by the Free Software Foundation.
>>>>> + */
>>>>> +
>>>>> +#include <linux/linkage.h>
>>>>> +
>>>>> +.arch_extension sec
>>>>> +
>>>>> +/* void mb86s7x_cpu_entry(unsigned long secondary_entry); */
>>>>> +ENTRY(mb86s7x_cpu_entry)
>>>>> +       stmfd   sp!, {r1-r11, lr}
>>>>> +       mov r1, r0
>>>>> +       ldr r0, =1
>>>>> +       mrc p15, 0, r3, c1, c0, 0
>>>>> +       mov r4, r3
>>>>> +       and r3, #0xbfffffff
>>>>> +       mcr p15, 0, r3, c1, c0, 0
>>>>> +       smc #0
>>>>
>>>>
>>>>
>>>> Interesting, it looks like you have some secure entity running on your
>>>> platform.
>>>
>>>
>>> Yes, we have a stub "secure firmware" that implements a few critical
>>> functions to allow us to operate the kernel as nonsecure.  It's part
>>> of the bootloader for this platform which is also GPL'd.
>>>
>>
>> OK, thanks for clarifying.
>>
>>>> 1. While the CPU is powered down who is taking care of saving it's
>>>>      state as you are doing it in the Linux itself ?
>>>
>>>
>>> Nothing.  The secure firmware is in a bootloader that is copied to and
>>> runs from secure sram.  When the cpu is reset, he comes back up in
>>> secure mode and gets initialized in the secure firmware, before
>>> entering Non-secure mode and the kernel's secondary entry point.
>>>
>>
>> So you do have live secure firmware stub on secure sram at any time,
>> right ? When the CPUs are powered down especially for low power states,
>> how is the secure state of the CPUs preserved ?
>
> There isn't any 'secure state' like you are thinking.
>
> Our secure firmware is a rudimentary stub that provides a handful of
> stateless secure services to the kernel.
>
> There's nothing to save or restore.
>

Ok that clarifies, but I assume some customers would like to extend that
beyond the stub.

>>>> 2. Is Linux running in Secure or Non-secure mode ?
>>>
>>>
>>> Another firmware (unfortunately not GPL) running on an on-die M3
>>> informs the secure firmware on the AP whether he should set the AP cpu
>>> to nonsecure or not before jumping to the kernel... basically it's
>>> decided at runtime and the same kernel binary serves in both modes.
>>>
>>
>> OK that's fine as along as you assume that kernel *always* runs in
>> *non-secure* mode and never attempts any *secure access*.
>
> Yes that's how it's set up.
>
> When this M3 tells the bootloader to make us nonsecure before going to
> the kernel, he marks up all the IPs that have dynamic access control
> to allow access in nonsecure.  That's because we have complete BSP
> support out of tree and we want to prove that it can all work from
> nonsecure directly.
>
> When Fujitsu want to restrict an IP from nonsecure access for a
> particular customer they will add support to manage the IP either on
> the M3 or the AP secure firmware and disable the IP support in DT.
> But that does not exist yet.
>

Yes this was what I was trying to tell. From what I understand now, if
the customer implements secure firmware which might need to save and
restore the state, then he needs to manage.(He might end up with
duplication of this last man algorithm in the secure firmware too,
I was just trying to mention this)

>>>> 3. Why do you need this smc call for secondary boot only ?
>>>
>>>
>>> The call sets the secondary entry point stored in the secure sram.
>>>
>>
>> So IIUC, you run Linux in non-secure mode, PSCI would be more suitable
>> than MCPM when you start thinking/implementing CPUIdle otherwise I think
>> you will end up duplicating some logic(last man and race management)
>> both in Linux as well as your secure firmware.
>
> As I mentioned our secure firmware is not what you're imagining.
>

Understood, that?s about the current stub secure firmware and I was
talking about non-existent full blown secure firmware. If that's not the
case, then it's fine.

> MCPM works very well for us.  Are you saying we can't use MCPM and
> must reimplement with PSCI on both sides?
>

No I never said that, I wanted to understand what's the scope of your
or any secure firmware of your customer.

>>> The bootloader heuristic is if that's unset (0), and it's what the
>>
>>
>> This could be problem as when the CPU is hotplugged out, ideally it
>> should be set to 0 to avoid spurious wakeup and entry into Linux.
>
> ... I think you are talking about something else.
>
> This is a PA stored in secure SRAM that holds the kernel's secondary
> entry point.  It's 0 when the bootloader is copied to the secure SRAM
> by the M3 at cold reset.  If anybody set it, it means Linux booted.
>
> The M3 manages AP core state and either depowers the cluster or holds
> them in reset. So there can be no 'spurious wakeup and entry into
> Linux'.
>

Ok, good that you can guarantee that.

>> Yes MCPM does manage it, but IMO you are mixing up secure and non-secure
>> methods which might become issue later when implementing low power
>> CPU states.
>
> Can you explain where you see the problem?  All we are doing is
> storing the kernel secondary entry point.  The bootloader / secure
> firmware always receives any started core first and decides when and
> how to jump to it.
>
>>> bootloader decided should be regarded as the primary cpu, then we do
>>> the real onetime cold boot flow, load the kernel etc.  Non-primary
>>> cpus wait at WFI in the bootloader.  When the primary cpu runs the
>>> code above, he sets the secondary entry point, and later starts to
>>
>>
>> I assume it's not done when primary boots, but by primary cpu when
>> bringing up the secondaries.
>
> Yes the point is the primary sets the secondary entry at the secure
> firmware using the SMC and then the IPIs can start flying.
>

Only if GIC is properly configured for that though I don't see the point
in giving non-secure entity secure access. If any secure firmware wants
to change that in future that could be issue.

>>> bring up the other cores who jump to the secondary entry that was set.
>>>
>>
>> I assume primary sends IPI to wake up secondaries, but if the SGIs are
>> configured as secure, then it will _not_ be delivered. If not it *might*
>
> Well, it is coordinated between M3 and AP bootloader / secure firmware
> if we should run nonsecure or not, and it configures a bunch of stuff
> like GIC accordingly so it works.  And it does work.
>
>> work but I can't understand the need of running Linux non-secure with
>> all secure access given to it.
>
> Fujitsu's goal with this was confirm the SoC + kernel can work in
> nonsecure for the whole BSP stack.  Then as customers want particular
> IPs secure-only, implement the behaviour they need in the AP secure
> firmware or M3.  But as yet, no support for that is implemented.
>

I never said you *must implement* PSCI and *not use* MCPM. Since you 
mentioned that you will be providing option to run Linux in non-secure 
mode, which means there can be _secure_entity_ which does more than your
current stub, I just wanted to mention the possible issues you may need 
to resolve then.

Regards,
Sudeep
