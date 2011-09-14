From: frank.rowand@am.sony.com (Frank Rowand)
Date: Tue, 13 Sep 2011 18:10:38 -0700
Subject: [patch] ARM: smpboot: Enable interrupts after marking
	CPU	online/active
In-Reply-To: <20110913175312.GB6267@n2100.arm.linux.org.uk>
References: <20110908215314.829452535@linutronix.de>	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>	<20110913133258.GA6267@n2100.arm.linux.org.uk>	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
Message-ID: <4E6FFF0E.4070302@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/11 10:53, Russell King - ARM Linux wrote:
> On Tue, Sep 13, 2011 at 07:22:16PM +0200, Vincent Guittot wrote:
>> The assumption done in the 1st patch that smp_store_cpu_info can be
>> delayed is no more true. The smp_store_cpu_info is now also used to
>> store the cpu topology information
>> (https://lkml.org/lkml/2011/7/5/209). This must be done before calling
>> sched_init_smp, which will use this information for building
>> sched_domain.
>> If we move set_cpu_online before smp_store_cpu_info, sched_init_smp
>> can be called before having called smp_store_cpu_info on all cpus.
> 
> Right.  We hold off returning from cpu_up() by watching for the upcoming
> CPU setting its online bit.
> 
> The bug which Thomas' patch introduces is to move the setting of that
> before we've finished bringing the CPU up - specifically, allowing the
> requesting CPU to continue while the brought-up CPU is still calibrating
> loops_per_jiffy, and before it's stored that information and setup the
> scheduler domain information.
> 
> The other issue is that moving the marking of the CPU online in the
> way Thomas has means that we then invite the delivery of IPIs to the
> CPU which is still in the process of coming up.  Whether that's an
> issue depends on what the IPIs are.
> 
> So, we must have the setting of CPU online _after_ we've setup the
> scheduler domain information etc - so the following is a strict
> ordering:
> 
> 1. calibrate_delay()
> 2. smp_store_cpu_info()
> 3. set_cpu_online()
> 
> Now, the question is do we need interrupts enabled to setup timers
> via percpu_timer_setup() and calibrate delay.  Can we move enabling
> interrupts after smp_store_cpu_info().  IOW, instead of moving the
> setting of cpu online before all this, can we move notify_cpu_starting()
> and the enabling of _both_ interrupts after smp_store_cpu_info()...
> No idea at the moment.

Modified the patch from Thomas to move enabling interrupts after
smp_store_cpu_info(), as suggested by Russell.

Tested on RealView (3.0.1, 3.0.1-rt11), Panda (3.0.0, 3.0.3-rt12).

The calibrate_delay() is platform specific, so be aware that there are
more platforms that I did not test.

Note that these kernel versions do not have the store_cpu_topology()
that Vincent pointed out.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 arch/arm/kernel/smp.c |   14 	7 +	7 -	0 !
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/arch/arm/kernel/smp.c
===================================================================
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -303,13 +303,6 @@ asmlinkage void __cpuinit secondary_star
 	platform_secondary_init(cpu);
 
 	/*
-	 * Enable local interrupts.
-	 */
-	notify_cpu_starting(cpu);
-	local_irq_enable();
-	local_fiq_enable();
-
-	/*
 	 * Setup the percpu timer for this CPU.
 	 */
 	percpu_timer_setup();
@@ -328,6 +321,13 @@ asmlinkage void __cpuinit secondary_star
 		cpu_relax();
 
 	/*
+	 * Enable local interrupts.
+	 */
+	notify_cpu_starting(cpu);
+	local_irq_enable();
+	local_fiq_enable();
+
+	/*
 	 * OK, it's off to the idle thread for us
 	 */
 	cpu_idle();
