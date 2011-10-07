From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 7 Oct 2011 14:17:02 +0200 (CEST)
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <01d501cc84d6$62720890$275619b0$%kim@samsung.com>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
	<20110923084001.GP17169@n2100.arm.linux.org.uk>
	<01d501cc84d6$62720890$275619b0$%kim@samsung.com>
Message-ID: <alpine.LFD.2.02.1110071354310.3240@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Oct 2011, Kukjin Kim wrote:
> I think, basically, if SPIs in GIC are used in local timer, the routing
> interrupt like calling irq_set_affinity() to offline CPUs should be
> available when boot time before calling set_cpu_online() because as you know
> the local_timer_setup() which includes setup interrupt is called in
> percpu_timer_setup() now...
> 
> Is there any way to get the flags of struct irqaction from struct irq_data
> in gic_set_affinity()? Or?

No, and you should not even think about it at all.

The problem I can see from all this discussion is related to the early
enabling of interrupts and the per cpu timer setup before the cpu is
marked online. I really do not understand at all why this needs to be
done in order to call calibrate_delay().

calibrate_delay() monitors jiffies, which are updated from the CPU
which is waiting for the new CPU to set the online bit.

So you simply can call calibrate_delay() on the new CPU just from the
interrupt disabled region and move the local timer setup after you
stored the cpu data and before enabling interrupts.

This solves both the cpu_online vs. cpu_active problem and the
affinity setting of the per cpu timers.

Thanks,

	tglx
----
Index: linux-2.6/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/smp.c
+++ linux-2.6/arch/arm/kernel/smp.c
@@ -301,17 +301,7 @@ asmlinkage void __cpuinit secondary_star
 	 */
 	platform_secondary_init(cpu);
 
-	/*
-	 * Enable local interrupts.
-	 */
 	notify_cpu_starting(cpu);
-	local_irq_enable();
-	local_fiq_enable();
-
-	/*
-	 * Setup the percpu timer for this CPU.
-	 */
-	percpu_timer_setup();
 
 	calibrate_delay();
 
@@ -323,10 +313,23 @@ asmlinkage void __cpuinit secondary_star
 	 * before we continue.
 	 */
 	set_cpu_online(cpu, true);
+
+	/*
+	 * Setup the percpu timer for this CPU.
+	 */
+	percpu_timer_setup();
+
 	while (!cpu_active(cpu))
 		cpu_relax();
 
 	/*
+	 * cpu_active bit is set, so it's safe to enable interrupts
+	 * now.
+	 */
+	local_irq_enable();
+	local_fiq_enable();
+
+	/*
 	 * OK, it's off to the idle thread for us
 	 */
 	cpu_idle();
