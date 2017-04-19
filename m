From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 17:44:20 +0100
Subject: [PATCH 03/16] clocksource: arm_arch_timer: rename the PPI enum
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1492620273-30037-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

In preparation for moving the PPI enum out into a header, rename the
enum and its constituent values these so they are namespaced w.r.t. the
arch timer. This will aid consistency and avoid potential name clashes
when this move occurs.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 82 ++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 38bddb9..94e355b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -70,19 +70,19 @@ struct arch_timer {
 
 static u32 arch_timer_rate;
 
-enum ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
+enum arch_timer_ppi_nr {
+	ARCH_TIMER_PHYS_SECURE_PPI,
+	ARCH_TIMER_PHYS_NONSECURE_PPI,
+	ARCH_TIMER_VIRT_PPI,
+	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_MAX_TIMER_PPI
 };
 
-static int arch_timer_ppi[MAX_TIMER_PPI];
+static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
-static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
@@ -694,14 +694,14 @@ static void __arch_timer_setup(unsigned type,
 		clk->cpumask = cpumask_of(smp_processor_id());
 		clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
 		switch (arch_timer_uses_ppi) {
-		case VIRT_PPI:
+		case ARCH_TIMER_VIRT_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_virt;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
 			clk->set_next_event = arch_timer_set_next_event_virt;
 			break;
-		case PHYS_SECURE_PPI:
-		case PHYS_NONSECURE_PPI:
-		case HYP_PPI:
+		case ARCH_TIMER_PHYS_SECURE_PPI:
+		case ARCH_TIMER_PHYS_NONSECURE_PPI:
+		case ARCH_TIMER_HYP_PPI:
 			clk->set_state_shutdown = arch_timer_shutdown_phys;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
 			clk->set_next_event = arch_timer_set_next_event_phys;
@@ -789,8 +789,8 @@ static void arch_counter_set_user_access(void)
 
 static bool arch_timer_has_nonsecure_ppi(void)
 {
-	return (arch_timer_uses_ppi == PHYS_SECURE_PPI &&
-		arch_timer_ppi[PHYS_NONSECURE_PPI]);
+	return (arch_timer_uses_ppi == ARCH_TIMER_PHYS_SECURE_PPI &&
+		arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 }
 
 static u32 check_ppi_trigger(int irq)
@@ -817,8 +817,9 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
 
 	if (arch_timer_has_nonsecure_ppi()) {
-		flags = check_ppi_trigger(arch_timer_ppi[PHYS_NONSECURE_PPI]);
-		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], flags);
+		flags = check_ppi_trigger(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
+		enable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
+				  flags);
 	}
 
 	arch_counter_set_user_access();
@@ -862,7 +863,7 @@ static void arch_timer_banner(unsigned type)
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
 		type & ARCH_TIMER_TYPE_CP15 ?
-			(arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
+			(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
 			"",
 		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
 		type & ARCH_TIMER_TYPE_MEM ?
@@ -901,7 +902,8 @@ static void __init arch_counter_register(unsigned type)
 
 	/* Register the CP15 based counter if we have one */
 	if (type & ARCH_TIMER_TYPE_CP15) {
-		if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
+		if (IS_ENABLED(CONFIG_ARM64) ||
+		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
 			arch_timer_read_counter = arch_counter_get_cntvct;
 		else
 			arch_timer_read_counter = arch_counter_get_cntpct;
@@ -930,7 +932,7 @@ static void arch_timer_stop(struct clock_event_device *clk)
 
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
-		disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
+		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 
 	clk->set_state_shutdown(clk);
 }
@@ -993,24 +995,24 @@ static int __init arch_timer_register(void)
 
 	ppi = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
-	case VIRT_PPI:
+	case ARCH_TIMER_VIRT_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_virt,
 					 "arch_timer", arch_timer_evt);
 		break;
-	case PHYS_SECURE_PPI:
-	case PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[PHYS_NONSECURE_PPI]) {
-			ppi = arch_timer_ppi[PHYS_NONSECURE_PPI];
+		if (!err && arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]) {
+			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
 			err = request_percpu_irq(ppi, arch_timer_handler_phys,
 						 "arch_timer", arch_timer_evt);
 			if (err)
-				free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
+				free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI],
 						arch_timer_evt);
 		}
 		break;
-	case HYP_PPI:
+	case ARCH_TIMER_HYP_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_phys,
 					 "arch_timer", arch_timer_evt);
 		break;
@@ -1042,7 +1044,7 @@ static int __init arch_timer_register(void)
 out_unreg_notify:
 	free_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], arch_timer_evt);
 	if (arch_timer_has_nonsecure_ppi())
-		free_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI],
+		free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI],
 				arch_timer_evt);
 
 out_free:
@@ -1139,16 +1141,16 @@ static int __init arch_timer_init(void)
 	 * their CNTHP_*_EL2 counterparts, and use a different PPI
 	 * number.
 	 */
-	if (is_hyp_mode_available() || !arch_timer_ppi[VIRT_PPI]) {
+	if (is_hyp_mode_available() || !arch_timer_ppi[ARCH_TIMER_VIRT_PPI]) {
 		bool has_ppi;
 
 		if (is_kernel_in_hyp_mode()) {
-			arch_timer_uses_ppi = HYP_PPI;
-			has_ppi = !!arch_timer_ppi[HYP_PPI];
+			arch_timer_uses_ppi = ARCH_TIMER_HYP_PPI;
+			has_ppi = !!arch_timer_ppi[ARCH_TIMER_HYP_PPI];
 		} else {
-			arch_timer_uses_ppi = PHYS_SECURE_PPI;
-			has_ppi = (!!arch_timer_ppi[PHYS_SECURE_PPI] ||
-				   !!arch_timer_ppi[PHYS_NONSECURE_PPI]);
+			arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
+			has_ppi = (!!arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] ||
+				   !!arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
 		}
 
 		if (!has_ppi) {
@@ -1165,7 +1167,7 @@ static int __init arch_timer_init(void)
 	if (ret)
 		return ret;
 
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
 
 	return 0;
 }
@@ -1180,7 +1182,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	}
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
 	arch_timer_detect_rate(NULL, np);
@@ -1196,7 +1198,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 */
 	if (IS_ENABLED(CONFIG_ARM) &&
 	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		arch_timer_uses_ppi = PHYS_SECURE_PPI;
+		arch_timer_uses_ppi = ARCH_TIMER_PHYS_SECURE_PPI;
 
 	/* On some systems, the counter stops ticking when in suspend. */
 	arch_counter_suspend_stop = of_property_read_bool(np,
@@ -1323,19 +1325,19 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	arch_timer_ppi[PHYS_SECURE_PPI] =
+	arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
 		gtdt->secure_el1_flags);
 
-	arch_timer_ppi[PHYS_NONSECURE_PPI] =
+	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
 		gtdt->non_secure_el1_flags);
 
-	arch_timer_ppi[VIRT_PPI] =
+	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
 		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
 		gtdt->virtual_timer_flags);
 
-	arch_timer_ppi[HYP_PPI] =
+	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-- 
1.9.1
