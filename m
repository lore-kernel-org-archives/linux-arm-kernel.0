From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 26 Feb 2015 20:26:46 +0100
Subject: [PATCH] ARM: kexec: Relax SMP validation to improve DT
 compatibility
In-Reply-To: <54EF6D4A.6000603@wwwdotorg.org>
References: <1424947028-7438-1-git-send-email-geert+renesas@glider.be>
 <20150226174206.GL8656@n2100.arm.linux.org.uk>
 <54EF6D4A.6000603@wwwdotorg.org>
Message-ID: <CAMuHMdW8R4yhYkw1GJeeA6gTRcZRJmPk84b6oQsiCUs-S1rVPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 8:00 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/26/2015 10:42 AM, Russell King - ARM Linux wrote:
>>
>> On Thu, Feb 26, 2015 at 11:37:08AM +0100, Geert Uytterhoeven wrote:
>>>
>>> When trying to kexec into a new kernel on a platform where multiple CPU
>>> cores are present, but no SMP bringup code is available yet, the
>>> kexec_load system call fails with:
>>>
>>>      kexec_load failed: Invalid argument
>>>
>>> The SMP test added to machine_kexec_prepare() in commit 2103f6cba61a8b8b
>>> ("ARM: 7807/1: kexec: validate CPU hotplug support") wants to prohibit
>>> kexec on SMP platforms where it cannot disable secondary CPUs.
>>> However, this test is too strict: if the secondary CPUs couldn't be
>>> enabled in the first place, there's no need to disable them later at
>>> kexec time.  Hence skip the test in the absence of SMP bringup code.
>>
>>
>> Hmm.  I don't think we should relax it in this manner - I think there's
>> an easier solution to this.
>>
>>> diff --git a/arch/arm/kernel/machine_kexec.c
>>> b/arch/arm/kernel/machine_kexec.c
>>> index de2b085ad7535da7..8bf3b7c098881b95 100644
>>> --- a/arch/arm/kernel/machine_kexec.c
>>> +++ b/arch/arm/kernel/machine_kexec.c
>>> @@ -46,7 +46,8 @@ int machine_kexec_prepare(struct kimage *image)
>>>          * and implements CPU hotplug for the current HW. If not, we
>>> won't be
>>>          * able to kexec reliably, so fail the prepare operation.
>>>          */
>>> -       if (num_possible_cpus() > 1 && !platform_can_cpu_hotplug())
>>> +       if (num_possible_cpus() > 1 && platform_can_secondary_boot() &&
>>> +           !platform_can_cpu_hotplug())
>>
>>
>>         if (num_online_cpus() > 1 && !platform_can_cpu_hotplug())
>
> I can't remember the call stack here. Is num_online_cpus() guaranteed not to
> change from this point through to when the kexec actually happens?

Yeah, I had similar thoughts when I added the new test.

include/linux/cpumask.h:
 *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
 *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
