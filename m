From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Feb 2018 16:41:55 +0000
Subject: [PATCHv2 1/8] ARM: ux500: remove PMU IRQ bouncer
In-Reply-To: <20180205164202.26502-1-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
Message-ID: <20180205164202.26502-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ux500 PMU IRQ bouncer is getting in the way of some fundametnal
changes to the ARM PMU driver, and it's the only special case that
exists today. Let's remove it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ux500/cpu-db8500.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 57058ac46f49..7e5d7a083707 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -23,7 +23,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/perf/arm_pmu.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/outercache.h>
@@ -112,37 +111,6 @@ static void ux500_restart(enum reboot_mode mode, const char *cmd)
 	prcmu_system_reset(0);
 }
 
-/*
- * The PMU IRQ lines of two cores are wired together into a single interrupt.
- * Bounce the interrupt to the other core if it's not ours.
- */
-static irqreturn_t db8500_pmu_handler(int irq, void *dev, irq_handler_t handler)
-{
-	irqreturn_t ret = handler(irq, dev);
-	int other = !smp_processor_id();
-
-	if (ret == IRQ_NONE && cpu_online(other))
-		irq_set_affinity(irq, cpumask_of(other));
-
-	/*
-	 * We should be able to get away with the amount of IRQ_NONEs we give,
-	 * while still having the spurious IRQ detection code kick in if the
-	 * interrupt really starts hitting spuriously.
-	 */
-	return ret;
-}
-
-static struct arm_pmu_platdata db8500_pmu_platdata = {
-	.handle_irq		= db8500_pmu_handler,
-	.irq_flags		= IRQF_NOBALANCING | IRQF_NO_THREAD,
-};
-
-static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
-	/* Requires call-back bindings. */
-	OF_DEV_AUXDATA("arm,cortex-a9-pmu", 0, "arm-pmu", &db8500_pmu_platdata),
-	{},
-};
-
 static struct of_dev_auxdata u8540_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu", NULL),
 	{},
@@ -165,9 +133,6 @@ static void __init u8500_init_machine(void)
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
 				     u8540_auxdata_lookup, NULL);
-	else
-		of_platform_populate(NULL, u8500_local_bus_nodes,
-				     u8500_auxdata_lookup, NULL);
 }
 
 static const char * stericsson_dt_platform_compat[] = {
-- 
2.11.0
