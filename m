From: hwoo.yang@gmail.com (Hyungwoo Yang)
Date: Tue, 8 May 2012 11:28:08 -0700
Subject: [PATCH] Prevent process migration during vfp_init()
In-Reply-To: <20120508180430.GL2263@mudshark.cambridge.arm.com>
References: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
 <20120508111332.GG2263@mudshark.cambridge.arm.com>
 <CAOsG7tqr__yWp1zmMfy3myRGFmY690f8i8emuXq5d7E=o3E7Vw@mail.gmail.com>
 <20120508180430.GL2263@mudshark.cambridge.arm.com>
Message-ID: <CAOsG7try1-E1JOq2w_A2767rbi+iyyahh=H1z9TzY+KLoc8N0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, I've already tested without preemption, it seems it is working fine.

for the failure, it is simple. on my A9 quad, due to heavy loads
during "late initcall", sometimes process migration happens just after
vfp_enable() but before smp_call_function(). it means there can be a
VFP disabled but accessed since smp_call_function() is for the rest of
cores not the core running it.

For example, if enable_vfp() is executed on core0 but
smp_call_function() is excuted on core1 due to migration, then VFP on
core1 is not enabled. it will be enabled next time when the core1
online again.

- Hyungwoo Yang

On Tue, May 8, 2012 at 11:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 08, 2012 at 06:24:27PM +0100, Hyungwoo Yang wrote:
>> I think we don't need preempt_disable()/preempt_enable() call in your proposal.
>> I mean, since we have enabled on every VFPs in cores online(
>> on_each_cpu() ), we don't need to worry about accessing a VFP which is
>> disabled. So we don't need to worry about migration after
>> "on_each_cpu()", right?
>
> Yes, that sounds reasonable to me since any thread migration will imply the
> barriers we need for the VFP exception vector to be correct. In which case the
> patch can be further reduced to what I've got below.
>
> It seems happy enough on my quad A9 running a bunch of paranoia FP tests --
> do you have a particular testcase which was exhibiting this failure when you
> reported the issue?
>
> Cheers,
>
> Will
>
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index bc683b8..c5767b5 100644
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
> @@ -657,7 +661,7 @@ static int __init vfp_init(void)
> ? ? ? ?unsigned int cpu_arch = cpu_architecture();
>
> ? ? ? ?if (cpu_arch >= CPU_ARCH_ARMv6)
> - ? ? ? ? ? ? ? vfp_enable(NULL);
> + ? ? ? ? ? ? ? on_each_cpu(vfp_enable, NULL, 1);
>
> ? ? ? ?/*
> ? ? ? ? * First check that there is a VFP that we can use.
> @@ -678,8 +682,6 @@ static int __init vfp_init(void)
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?hotcpu_notifier(vfp_hotplug, 0);
>
> - ? ? ? ? ? ? ? smp_call_function(vfp_enable, NULL, 1);
> -
> ? ? ? ? ? ? ? ?VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT; ?/* Extract the architecture version */
> ? ? ? ? ? ? ? ?printk("implementor %02x architecture %d part %02x variant %x rev %x\n",
> ? ? ? ? ? ? ? ? ? ? ? ?(vfpsid & FPSID_IMPLEMENTER_MASK) >> FPSID_IMPLEMENTER_BIT,
