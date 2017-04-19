From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 17:44:19 +0100
Subject: [PATCH 02/16] clocksource: arm_arch_timer: rename type macros
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1492620273-30037-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

In preparation for moving the type macros out into a header, rename
these so they are namespaced w.r.t. the arch timer. We'll apply the same
prefix to other definitions in subsequent patches. This will aid
consistency and avoid potential name clahses when this move occurs.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 43 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 467ee61..38bddb9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -55,8 +55,8 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_CP15_TIMER	BIT(0)
-#define ARCH_MEM_TIMER	BIT(1)
+#define ARCH_TIMER_TYPE_CP15		BIT(0)
+#define ARCH_TIMER_TYPE_MEM		BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -686,7 +686,7 @@ static void __arch_timer_setup(unsigned type,
 {
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
-	if (type == ARCH_CP15_TIMER) {
+	if (type == ARCH_TIMER_TYPE_CP15) {
 		if (arch_timer_c3stop)
 			clk->features |= CLOCK_EVT_FEAT_C3STOP;
 		clk->name = "arch_sys_timer";
@@ -811,7 +811,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 	u32 flags;
 
-	__arch_timer_setup(ARCH_CP15_TIMER, clk);
+	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
 
 	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -855,16 +855,17 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 static void arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		type & ARCH_CP15_TIMER ? "cp15" : "",
-		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " : "",
-		type & ARCH_MEM_TIMER ? "mmio" : "",
+		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
+		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
+			" and " : "",
+		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		type & ARCH_CP15_TIMER ?
+		type & ARCH_TIMER_TYPE_CP15 ?
 			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
 			"",
-		type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
-		type & ARCH_MEM_TIMER ?
+		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
+		type & ARCH_TIMER_TYPE_MEM ?
 			arch_timer_mem_use_virtual ? "virt" : "phys" :
 			"");
 }
@@ -899,7 +900,7 @@ static void __init arch_counter_register(unsigned type)
 	u64 start_count;
 
 	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_CP15_TIMER) {
+	if (type & ARCH_TIMER_TYPE_CP15) {
 		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
@@ -1062,7 +1063,7 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 	t->base = base;
 	t->evt.irq = irq;
-	__arch_timer_setup(ARCH_MEM_TIMER, &t->evt);
+	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &t->evt);
 
 	if (arch_timer_mem_use_virtual)
 		func = arch_timer_handler_virt_mem;
@@ -1105,13 +1106,15 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned mask = ARCH_CP15_TIMER | ARCH_MEM_TIMER;
+	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
 
 	/* Wait until both nodes are probed if we have two timers */
 	if ((arch_timers_present & mask) != mask) {
-		if (arch_timer_needs_probing(ARCH_MEM_TIMER, arch_timer_mem_of_match))
+		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
+					     arch_timer_mem_of_match))
 			return 0;
-		if (arch_timer_needs_probing(ARCH_CP15_TIMER, arch_timer_of_match))
+		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
+					     arch_timer_of_match))
 			return 0;
 	}
 
@@ -1171,12 +1174,12 @@ static int __init arch_timer_of_init(struct device_node *np)
 {
 	int i;
 
-	if (arch_timers_present & ARCH_CP15_TIMER) {
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
-	arch_timers_present |= ARCH_CP15_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
@@ -1211,7 +1214,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	unsigned int irq, ret = -EINVAL;
 	u32 cnttidr;
 
-	arch_timers_present |= ARCH_MEM_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
 	cntctlbase = of_iomap(np, 0);
 	if (!cntctlbase) {
 		pr_err("Can't find CNTCTLBase\n");
@@ -1311,14 +1314,14 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	struct acpi_table_gtdt *gtdt;
 
-	if (arch_timers_present & ARCH_CP15_TIMER) {
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
 	gtdt = container_of(table, struct acpi_table_gtdt, header);
 
-	arch_timers_present |= ARCH_CP15_TIMER;
+	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
 	arch_timer_ppi[PHYS_SECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-- 
1.9.1
