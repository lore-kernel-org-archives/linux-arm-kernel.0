From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Sep 2011 09:40:01 +0100
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110913175312.GB6267@n2100.arm.linux.org.uk>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
Message-ID: <20110923084001.GP17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 06:53:12PM +0100, Russell King - ARM Linux wrote:
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

And to make things worse... 4bd0fe1c78623062263cf5ae875fd484c5b8256d
has appeared in mainline today.

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 7c2282c..df6ef1b 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -106,6 +106,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
         */
        spin_lock(&boot_lock);
        spin_unlock(&boot_lock);
+
+       set_cpu_online(cpu, true);
 }

 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)

I think some work needs to be done to eliminate some of the dependencies
in this code so that we can have a *sane* order for bringup of secondary
CPUs.

I'm just going to sit on the fence and watch what platform people do
during the next merge window when the support for the topological
scheduler goes in.
