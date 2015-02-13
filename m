From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 13 Feb 2015 12:59:50 -0800
Subject: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <CANqRtoSOBf3ZCKdKYta-P2q==ZMHk=VZgfEztPJ+uaKQtkBWjg@mail.gmail.com>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>	<20150213202002.GB29727@verge.net.au>	<54DE5D3A.5070104@codeaurora.org>
 <CANqRtoSOBf3ZCKdKYta-P2q==ZMHk=VZgfEztPJ+uaKQtkBWjg@mail.gmail.com>
Message-ID: <54DE65C6.8000304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/15 12:54, Magnus Damm wrote:
> Hi Stephen,
>
> On Fri, Feb 13, 2015 at 8:23 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 02/13/15 12:20, Simon Horman wrote:
>>> Hi Stephen,
>>>
>>> On Fri, Feb 13, 2015 at 10:06:39AM -0800, Stephen Boyd wrote:
>>>> diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
>>>> index 3f761f839043..b45206f93ddf 100644
>>>> --- a/arch/arm/mach-shmobile/smp-r8a7779.c
>>>> +++ b/arch/arm/mach-shmobile/smp-r8a7779.c
>>>> @@ -124,19 +124,12 @@ static int r8a7779_cpu_kill(unsigned int cpu)
>>>>
>>>>      return 0;
>>>>  }
>>>> -
>>>> -static int r8a7779_cpu_disable(unsigned int cpu)
>>>> -{
>>>> -    /* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
>>>> -    return cpu == 0 ? -EPERM : 0;
>>>> -}
>>>>  #endif /* CONFIG_HOTPLUG_CPU */
>>>>
>>>>  struct smp_operations r8a7779_smp_ops  __initdata = {
>>>>      .smp_prepare_cpus       = r8a7779_smp_prepare_cpus,
>>>>      .smp_boot_secondary     = r8a7779_boot_secondary,
>>>>  #ifdef CONFIG_HOTPLUG_CPU
>>>> -    .cpu_disable            = r8a7779_cpu_disable,
>>>>      .cpu_die                = shmobile_smp_scu_cpu_die,
>>>>      .cpu_kill               = r8a7779_cpu_kill,
>>>>  #endif
>>> Its not clear to me why r8a7779_cpu_disable() has been
>>> removed rather than replaced by r8a7779_cpu_can_disable()
>> By default ARM's smp.c assumes that CPU0 can't be hotplugged. The
>> function is redundant. I guess I should have mentioned that in the
>> commit text.
> Thanks for your efforts. Can you please tell me where that limitation
> is located? I'm quite sure I've brought CPU cores up and down
> including CPU0, but maybe something is missing?
>
>

The assumption is made if there isn't a cpu_disable (now
cpu_can_disable) op. See platform_cpu_disable() in
arch/arm/kernel/smp.c. If there isn't such a limitation on a particular
platform, the platform needs to set the cpu_disable/cpu_can_disable op
and indicate that there isn't a limitation (by returning 1 for example).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
