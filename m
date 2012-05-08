From: hwoo.yang@gmail.com (Hyungwoo Yang)
Date: Tue, 8 May 2012 10:24:27 -0700
Subject: [PATCH] Prevent process migration during vfp_init()
In-Reply-To: <20120508111332.GG2263@mudshark.cambridge.arm.com>
References: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
 <20120508111332.GG2263@mudshark.cambridge.arm.com>
Message-ID: <CAOsG7tqr__yWp1zmMfy3myRGFmY690f8i8emuXq5d7E=o3E7Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

Thank you for your comments. I didn't check the implementation of
preempt_disable() on non-preemptible kernel case.

I think we don't need preempt_disable()/preempt_enable() call in your proposal.
I mean, since we have enabled on every VFPs in cores online(
on_each_cpu() ), we don't need to worry about accessing a VFP which is
disabled. So we don't need to worry about migration after
"on_each_cpu()", right?

- Hyungwoo Yang

On Tue, May 8, 2012 at 4:13 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, May 04, 2012 at 09:28:15PM +0100, Hyungwoo Yang wrote:
>> Hello,
>
> Hi,
>
> Some comments inline and a proposed v2.
>
>> From f96fc79d508235706462336239eb30d66e2e6c0b Mon Sep 17 00:00:00 2001
>> From: Hyungwoo Yang <hyungwooy@nvidia.com>
>> Date: Fri, 4 May 2012 11:22:59 -0700
>> Subject: [PATCH] System crashes if there is process migration during
>> vfp_init() call.
>>
>> During vfp_init(), if a process which called vfp_enable() is migrated just
>> after the call, then the process executing the rest of code will access
>> a VFP unit which is not ENABLED and also smp_call_function() will not work
>> as it is expected.
>>
>> This patch prevents accessing VFP unit disabled by preventing migration
>> and also replaces smp_call_function() with on_each_cpu() to make sure that
>> no VFP remains disabled.
>>
>> Signed-off-by: Hyungwoo Yang <hyungwooy@nvidia.com>
>>
>> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>> index bc683b8..6f33e4d 100644
>> --- a/arch/arm/vfp/vfpmodule.c
>> +++ b/arch/arm/vfp/vfpmodule.c
>> @@ -655,7 +655,9 @@ static int __init vfp_init(void)
>> ?{
>> ? ? ? unsigned int vfpsid;
>> ? ? ? unsigned int cpu_arch = cpu_architecture();
>> -
>> +#ifdef CONFIG_SMP
>> + ? ? preempt_disable();
>> +#endif
>
> I don't think it's worth having the SMP guards for this.
>
>> ? ? ? if (cpu_arch >= CPU_ARCH_ARMv6)
>> ? ? ? ? ? ? ? vfp_enable(NULL);
>
> I think we can avoid this redundant enable if we move some code around (see
> below).
>
>> @@ -667,7 +669,9 @@ static int __init vfp_init(void)
>> ? ? ? vfp_vector = vfp_testing_entry;
>> ? ? ? barrier();
>> ? ? ? vfpsid = fmrx(FPSID);
>> - ? ? barrier();
>> +#ifdef CONFIG_SMP
>> + ? ? preempt_enable();
>> +#endif
>
> If we're not running a PREEMPT kernel, you just removed a compiler barrier.
>
> How about something like the following instead? I've also added a BUG_ON to
> vfp_enable to stop this catching us out in future:
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index bc683b8..8e08983 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -11,6 +11,7 @@
> ?#include <linux/types.h>
> ?#include <linux/cpu.h>
> ?#include <linux/cpu_pm.h>
> +#include <linux/hardirq.h>
> ?#include <linux/kernel.h>
> ?#include <linux/notifier.h>
> ?#include <linux/signal.h>
> @@ -432,7 +433,10 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
>
> ?static void vfp_enable(void *unused)
> ?{
> - ? ? ? u32 access = get_copro_access();
> + ? ? ? u32 access;
> +
> + ? ? ? BUG_ON(preemptible());
> + ? ? ? access = get_copro_access();
>
> ? ? ? ?/*
> ? ? ? ? * Enable full access to VFP (cp10 and cp11)
> @@ -657,18 +661,20 @@ static int __init vfp_init(void)
> ? ? ? ?unsigned int cpu_arch = cpu_architecture();
>
> ? ? ? ?if (cpu_arch >= CPU_ARCH_ARMv6)
> - ? ? ? ? ? ? ? vfp_enable(NULL);
> + ? ? ? ? ? ? ? on_each_cpu(vfp_enable, NULL, 1);
>
> ? ? ? ?/*
> ? ? ? ? * First check that there is a VFP that we can use.
> ? ? ? ? * The handler is already setup to just log calls, so
> ? ? ? ? * we just need to read the VFPSID register.
> ? ? ? ? */
> + ? ? ? preempt_disable();
> ? ? ? ?vfp_vector = vfp_testing_entry;
> ? ? ? ?barrier();
> ? ? ? ?vfpsid = fmrx(FPSID);
> ? ? ? ?barrier();
> ? ? ? ?vfp_vector = vfp_null_entry;
> + ? ? ? preempt_enable();
>
> ? ? ? ?printk(KERN_INFO "VFP support v0.3: ");
> ? ? ? ?if (VFP_arch)
> @@ -678,8 +684,6 @@ static int __init vfp_init(void)
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?hotcpu_notifier(vfp_hotplug, 0);
>
> - ? ? ? ? ? ? ? smp_call_function(vfp_enable, NULL, 1);
> -
> ? ? ? ? ? ? ? ?VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT; ?/* Extract the architecture version */
> ? ? ? ? ? ? ? ?printk("implementor %02x architecture %d part %02x variant %x rev %x\n",
> ? ? ? ? ? ? ? ? ? ? ? ?(vfpsid & FPSID_IMPLEMENTER_MASK) >> FPSID_IMPLEMENTER_BIT,
>
> Will
