From: amit.kachhap@linaro.org (Amit Kachhap)
Date: Mon, 26 Sep 2011 12:56:07 +0530
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110923084001.GP17169@n2100.arm.linux.org.uk>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
	<20110923084001.GP17169@n2100.arm.linux.org.uk>
Message-ID: <CAK44p23rtqv3jPs-7oFbcs=xJPd6zsGyJNHOTSMUkh+Weh5zjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 23 September 2011 14:10, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 13, 2011 at 06:53:12PM +0100, Russell King - ARM Linux wrote:
>> So, we must have the setting of CPU online _after_ we've setup the
>> scheduler domain information etc - so the following is a strict
>> ordering:
>>
>> 1. calibrate_delay()
>> 2. smp_store_cpu_info()
>> 3. set_cpu_online()
>>
>> Now, the question is do we need interrupts enabled to setup timers
>> via percpu_timer_setup() and calibrate delay. ?Can we move enabling
>> interrupts after smp_store_cpu_info(). ?IOW, instead of moving the
>> setting of cpu online before all this, can we move notify_cpu_starting()
>> and the enabling of _both_ interrupts after smp_store_cpu_info()...
>> No idea at the moment.
>
> And to make things worse... 4bd0fe1c78623062263cf5ae875fd484c5b8256d
> has appeared in mainline today.
>
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index 7c2282c..df6ef1b 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -106,6 +106,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
> ? ? ? ? */
> ? ? ? ?spin_lock(&boot_lock);
> ? ? ? ?spin_unlock(&boot_lock);
> +
> + ? ? ? set_cpu_online(cpu, true);
> ?}
>
> ?int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>

The above patch was added as a workaround fix for
5dfc54e087c15f823ee9b6541d2f0f314e69cbed (ARM: GIC: avoid routing
interrupts to offline CPUs).

Actually the main cause is that exynos4 uses external cpu timer and
hence irq_set_affinity is called inside percpu_timer_setup and this
will fail if secondary cpu is offline. I tried deferring
irq_set_affinity using cpu_online notifiers but this approach effects
bogomips calculation and looks complex also. So any suggestion on how
to handle this situation in exynos4?

diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index ddd8686..30a7226 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/cpu.h>

 #include <mach/map.h>
 #include <mach/regs-mct.h>
@@ -354,6 +355,18 @@ static struct irqaction mct_tick1_event_irq = {
        .handler        = exynos4_mct_tick_isr,
 };

+static int __cpuinit exynos4_set_affinity(struct notifier_block *self,
+                                     unsigned long action, void *cpu)
+{
+       if (action == CPU_ONLINE || action == CPU_ONLINE_FROZEN)
+               irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
+       return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata exynos4_set_affinity_nb = {
+       .notifier_call = exynos4_set_affinity,
+};
+
 static void exynos4_mct_tick_init(struct clock_event_device *evt)
 {
        unsigned int cpu = smp_processor_id();
@@ -390,7 +403,6 @@ static void exynos4_mct_tick_init(struct
clock_event_device *evt)
        } else {
                mct_tick1_event_irq.dev_id = &mct_tick[cpu];
                setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
-               irq_set_affinity(IRQ_MCT_L1, cpumask_of(1));
        }
 }

@@ -422,6 +434,7 @@ static void __init exynos4_timer_init(void)
        exynos4_timer_resources();
        exynos4_clocksource_init();
        exynos4_clockevent_init();
+       register_cpu_notifier(&exynos4_set_affinity_nb);
 }

 struct sys_timer exynos4_timer = {
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index ca01370..8c0d74f 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -108,8 +108,6 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
         */
        spin_lock(&boot_lock);
        spin_unlock(&boot_lock);
-
-       set_cpu_online(cpu, true);
 }

 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
1.7.1

Thanks,
Amit D

> I think some work needs to be done to eliminate some of the dependencies
> in this code so that we can have a *sane* order for bringup of secondary
> CPUs.
>
> I'm just going to sit on the fence and watch what platform people do
> during the next merge window when the support for the topological
> scheduler goes in.
>
