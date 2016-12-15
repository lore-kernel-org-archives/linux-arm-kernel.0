From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Dec 2016 12:00:45 +0000
Subject: Linux crashes when trying to online secondary core
In-Reply-To: <1147ef90-7877-e4d2-bb2b-5c4fa8d3144b@free.fr>
References: <ef972981-3fb6-74a4-cd83-a6629d2dab2a@free.fr>
 <alpine.DEB.2.20.1612141807410.3556@nanos>
 <8a021a90-e69e-f38b-c8df-ea8963f3973f@free.fr>
 <1147ef90-7877-e4d2-bb2b-5c4fa8d3144b@free.fr>
Message-ID: <20161215120045.GD21758@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 11:35:12AM +0100, Mason wrote:
> On 14/12/2016 18:47, Mason wrote:
> > On 14/12/2016 18:08, Thomas Gleixner wrote:
> >> Does the patch below fix the issue?

> >> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> >> index 22acee76cf4c..2594c287b078 100644
> >> --- a/include/linux/cpuhotplug.h
> >> +++ b/include/linux/cpuhotplug.h
> >> @@ -101,7 +101,6 @@ enum cpuhp_state {
> >>  	CPUHP_AP_ARM_L2X0_STARTING,
> >>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
> >>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
> >> -	CPUHP_AP_DUMMY_TIMER_STARTING,
> >>  	CPUHP_AP_JCORE_TIMER_STARTING,
> >>  	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
> >>  	CPUHP_AP_ARM_TWD_STARTING,
> >> @@ -111,6 +110,7 @@ enum cpuhp_state {
> >>  	CPUHP_AP_MARCO_TIMER_STARTING,
> >>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
> >>  	CPUHP_AP_ARC_TIMER_STARTING,
> >> +	CPUHP_AP_DUMMY_TIMER_STARTING,
> >>  	CPUHP_AP_KVM_STARTING,
> >>  	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
> >>  	CPUHP_AP_KVM_ARM_VGIC_STARTING,

> > It does seem to fix the problem:

> > I reverted your patch, and the kernel blows up again.
> > 
> > So what's the problem, and how does your patch solve it?
> 
> Link to the original report:
> https://marc.info/?l=linux-arm-kernel&m=148173152524746&w=2
> 
> Forgot to CC Robin Murphy, who had provided valuable input
> in similar circumstances a few months back.
> 
> Also add LKML, since this doesn't appear to be ARM-specific.
> 
> Do I need to specify which device tree I was using?

This is already fixed in the linux-tip tree, with commit messages
describing the fix.

It's specific to a few clocksources, due to their hotplug callbacks
occuring later than the dummy timer. That triggers the bug fixed in:

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/urgent&id=c1a9eeb938b5433947e5ea22f89baff3182e7075

The relevant timers were fixed in:

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/urgent&id=9bf11ecce5a2758e5a097c2f3a13d08552d0d6f9

Thanks,
Mark.
