From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Jul 2012 10:20:19 +0100
Subject: [RFC PATCH 1/4] ARM: arch_timers: enable the use of the virtual timer
In-Reply-To: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
References: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1341566422-20368-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment, the arch_timer driver only uses the physical timer,
which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
which is likely in a virtualized environment. Instead, the virtual
timer is always available.

This patch enables the use of both the virtual timer, unless no
interrupt is provided in the DT for it, in which case is falls
back to the physical timer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c |  248 ++++++++++++++++++++++++++++++++----------
 1 file changed, 188 insertions(+), 60 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index dd58035..54599e9 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -27,11 +27,29 @@
 #include <asm/sched_clock.h>
 
 static unsigned long arch_timer_rate;
-static int arch_timer_ppi;
-static int arch_timer_ppi2;
+
+enum ppi_nr {
+	PHYS_SECURE_PPI,
+	PHYS_NONSECURE_PPI,
+	VIRT_PPI,
+	HYP_PPI,
+	MAX_TIMER_PPI
+};
+
+static int arch_timer_ppi[MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu **arch_timer_evt;
 
+static bool arch_timer_use_virtual = true;
+
+struct arch_timer_reg_ops {
+	void	(*reg_write)(int reg, u32 val);
+	u32	(*reg_read)(int reg);
+	cycle_t	(*counter_read)(void);
+};
+
+static struct arch_timer_reg_ops __percpu **arch_timer_reg_ops;
+
 /*
  * Architected system timer support.
  */
@@ -44,7 +62,37 @@ static struct clock_event_device __percpu **arch_timer_evt;
 #define ARCH_TIMER_REG_FREQ		1
 #define ARCH_TIMER_REG_TVAL		2
 
-static void arch_timer_reg_write(int reg, u32 val)
+static inline void arch_timer_reg_write(int reg, u32 val)
+{
+	(*__this_cpu_ptr(arch_timer_reg_ops))->reg_write(reg, val);
+}
+
+static inline u32 arch_timer_reg_read(int reg)
+{
+	return (*__this_cpu_ptr(arch_timer_reg_ops))->reg_read(reg);
+}
+
+static inline cycle_t arch_timer_counter_read(void)
+{
+	return (*__this_cpu_ptr(arch_timer_reg_ops))->counter_read();
+}
+
+static u32 arch_timer_common_reg_read(int reg)
+{
+	u32 val;
+
+	switch (reg) {
+	case ARCH_TIMER_REG_FREQ:
+		asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
+		break;
+	default:
+		BUG();
+	}
+
+	return val;
+}
+
+static void arch_timer_phys_reg_write(int reg, u32 val)
 {
 	switch (reg) {
 	case ARCH_TIMER_REG_CTRL:
@@ -58,7 +106,7 @@ static void arch_timer_reg_write(int reg, u32 val)
 	isb();
 }
 
-static u32 arch_timer_reg_read(int reg)
+static u32 arch_timer_phys_reg_read(int reg)
 {
 	u32 val;
 
@@ -66,19 +114,78 @@ static u32 arch_timer_reg_read(int reg)
 	case ARCH_TIMER_REG_CTRL:
 		asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
 		break;
-	case ARCH_TIMER_REG_FREQ:
-		asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
-		break;
 	case ARCH_TIMER_REG_TVAL:
 		asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
 		break;
 	default:
-		BUG();
+		val = arch_timer_common_reg_read(reg);
+	}
+
+	return val;
+}
+
+static inline cycle_t arch_counter_get_cntpct(void)
+{
+	u32 cvall, cvalh;
+
+	asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
+
+	return ((cycle_t) cvalh << 32) | cvall;
+}
+
+static struct arch_timer_reg_ops arch_timer_phys_ops = {
+	.reg_write	= arch_timer_phys_reg_write,
+	.reg_read	= arch_timer_phys_reg_read,
+	.counter_read	= arch_counter_get_cntpct,
+};
+
+static void arch_timer_virt_reg_write(int reg, u32 val)
+{
+	switch (reg) {
+	case ARCH_TIMER_REG_CTRL:
+		asm volatile("mcr p15, 0, %0, c14, c3, 1" : : "r" (val));
+		break;
+	case ARCH_TIMER_REG_TVAL:
+		asm volatile("mcr p15, 0, %0, c14, c3, 0" : : "r" (val));
+		break;
+	}
+
+	isb();
+}
+
+static u32 arch_timer_virt_reg_read(int reg)
+{
+	u32 val;
+
+	switch (reg) {
+	case ARCH_TIMER_REG_CTRL:
+		asm volatile("mrc p15, 0, %0, c14, c3, 1" : "=r" (val));
+		break;
+	case ARCH_TIMER_REG_TVAL:
+		asm volatile("mrc p15, 0, %0, c14, c3, 0" : "=r" (val));
+		break;
+	default:
+		val = arch_timer_common_reg_read(reg);
 	}
 
 	return val;
 }
 
+static inline cycle_t arch_counter_get_cntvct(void)
+{
+	u32 cvall, cvalh;
+
+	asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
+
+	return ((cycle_t) cvalh << 32) | cvall;
+}
+
+static struct arch_timer_reg_ops arch_timer_virt_ops = {
+	.reg_write	= arch_timer_virt_reg_write,
+	.reg_read	= arch_timer_virt_reg_read,
+	.counter_read	= arch_counter_get_cntvct,
+};
+
 static irqreturn_t arch_timer_handler(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
@@ -134,6 +241,8 @@ static int arch_timer_set_next_event(unsigned long evt,
 
 static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 {
+	int i;
+
 	/* Be safe... */
 	arch_timer_disable();
 
@@ -142,16 +251,16 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 	clk->rating = 450;
 	clk->set_mode = arch_timer_set_mode;
 	clk->set_next_event = arch_timer_set_next_event;
-	clk->irq = arch_timer_ppi;
+	clk->irq = arch_timer_ppi[PHYS_SECURE_PPI];
 
 	clockevents_config_and_register(clk, arch_timer_rate,
 					0xf, 0x7fffffff);
 
 	*__this_cpu_ptr(arch_timer_evt) = clk;
 
-	enable_percpu_irq(clk->irq, 0);
-	if (arch_timer_ppi2)
-		enable_percpu_irq(arch_timer_ppi2, 0);
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+		if (arch_timer_ppi[i])
+			enable_percpu_irq(arch_timer_ppi[i], 0);
 
 	return 0;
 }
@@ -188,38 +297,24 @@ static int arch_timer_available(void)
 	return 0;
 }
 
-static inline cycle_t arch_counter_get_cntpct(void)
+static u32 notrace arch_counter_get_cnt32(void)
 {
-	u32 cvall, cvalh;
-
-	asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
-
-	return ((cycle_t) cvalh << 32) | cvall;
-}
-
-static inline cycle_t arch_counter_get_cntvct(void)
-{
-	u32 cvall, cvalh;
-
-	asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
-
-	return ((cycle_t) cvalh << 32) | cvall;
-}
-
-static u32 notrace arch_counter_get_cntvct32(void)
-{
-	cycle_t cntvct = arch_counter_get_cntvct();
+	cycle_t cnt = arch_timer_counter_read();
 
 	/*
 	 * The sched_clock infrastructure only knows about counters
 	 * with@most 32bits. Forget about the upper 24 bits for the
 	 * time being...
 	 */
-	return (u32)(cntvct & (u32)~0);
+	return (u32)(cnt & (u32)~0);
 }
 
 static cycle_t arch_counter_read(struct clocksource *cs)
 {
+	/*
+	 * Always use the physical counter for the clocksource.
+	 * CNTHCTL.PL1PCTEN must be set to 1.
+	 */
 	return arch_counter_get_cntpct();
 }
 
@@ -233,11 +328,13 @@ static struct clocksource clocksource_counter = {
 
 static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
 {
+	int i;
+
 	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
 		 clk->irq, smp_processor_id());
-	disable_percpu_irq(clk->irq);
-	if (arch_timer_ppi2)
-		disable_percpu_irq(arch_timer_ppi2);
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+		if (arch_timer_ppi[i])
+			disable_percpu_irq(arch_timer_ppi[i]);
 	arch_timer_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 }
 
@@ -251,33 +348,48 @@ static struct clock_event_device arch_timer_global_evt;
 static int __init arch_timer_register(void)
 {
 	int err;
+	int i;
+	int cpu;
+
+	arch_timer_reg_ops = alloc_percpu(struct arch_timer_reg_ops *);
+	if (!arch_timer_reg_ops)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct arch_timer_reg_ops **p;
+
+		p = per_cpu_ptr(arch_timer_reg_ops, cpu);
+		if (arch_timer_use_virtual)
+			*p = &arch_timer_virt_ops;
+		else
+			*p = &arch_timer_phys_ops;
+	}
 
 	err = arch_timer_available();
 	if (err)
-		return err;
+		goto out;
 
 	arch_timer_evt = alloc_percpu(struct clock_event_device *);
-	if (!arch_timer_evt)
-		return -ENOMEM;
+	if (!arch_timer_evt) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 
-	err = request_percpu_irq(arch_timer_ppi, arch_timer_handler,
-				 "arch_timer", arch_timer_evt);
-	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       arch_timer_ppi, err);
-		goto out_free;
-	}
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++) {
+		irq_handler_t handler = arch_timer_handler;
 
-	if (arch_timer_ppi2) {
-		err = request_percpu_irq(arch_timer_ppi2, arch_timer_handler,
+		if (!arch_timer_ppi[i])
+			continue;
+
+		err = request_percpu_irq(arch_timer_ppi[i], handler,
 					 "arch_timer", arch_timer_evt);
 		if (err) {
 			pr_err("arch_timer: can't register interrupt %d (%d)\n",
-			       arch_timer_ppi2, err);
-			arch_timer_ppi2 = 0;
-			goto out_free_irq;
+			       arch_timer_ppi[i], err);
+			arch_timer_ppi[i] = 0;
+			goto out_free;
 		}
 	}
 
@@ -299,13 +411,14 @@ static int __init arch_timer_register(void)
 	return 0;
 
 out_free_irq:
-	free_percpu_irq(arch_timer_ppi, arch_timer_evt);
-	if (arch_timer_ppi2)
-		free_percpu_irq(arch_timer_ppi2, arch_timer_evt);
+	for ( ; i > PHYS_SECURE_PPI; i--)
+		if (arch_timer_ppi[i])
+			free_percpu_irq(arch_timer_ppi[i], arch_timer_evt);
 
 out_free:
 	free_percpu(arch_timer_evt);
-
+out:
+	free_percpu(arch_timer_reg_ops);
 	return err;
 }
 
@@ -318,6 +431,7 @@ int __init arch_timer_of_register(void)
 {
 	struct device_node *np;
 	u32 freq;
+	int i;
 
 	np = of_find_matching_node(NULL, arch_timer_of_match);
 	if (!np) {
@@ -329,10 +443,24 @@ int __init arch_timer_of_register(void)
 	if (!of_property_read_u32(np, "clock-frequency", &freq))
 		arch_timer_rate = freq;
 
-	arch_timer_ppi = irq_of_parse_and_map(np, 0);
-	arch_timer_ppi2 = irq_of_parse_and_map(np, 1);
-	pr_info("arch_timer: found %s irqs %d %d\n",
-		np->name, arch_timer_ppi, arch_timer_ppi2);
+	pr_info("arch_timer: found %s irqs ", np->name);
+
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++) {
+		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
+		if (!arch_timer_ppi[i]) {
+			/*
+			 * No interrupt provided for virtual timer,
+			 * we'll have to stick to the physical timer.
+			 */
+			if (i == VIRT_PPI)
+				arch_timer_use_virtual = false;
+			
+			continue;
+		}
+		pr_cont("%d ", arch_timer_ppi[i]);
+	}
+
+	pr_cont("\n");
 
 	return arch_timer_register();
 }
@@ -345,6 +473,6 @@ int __init arch_timer_sched_clock_init(void)
 	if (err)
 		return err;
 
-	setup_sched_clock(arch_counter_get_cntvct32, 32, arch_timer_rate);
+	setup_sched_clock(arch_counter_get_cnt32, 32, arch_timer_rate);
 	return 0;
 }
-- 
1.7.10.3
