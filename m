From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 11:26:16 +0000
Subject: [PATCH 11/17] arm64: arch_timer: Move clocksource_counter and co
 around
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <20170306112622.13853-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to access clocksource_counter from the errata handling code,
move it (together with the related structures and functions) towards
the top of the file.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2bbe0b9c3c24..a5a88db2ac90 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -158,6 +158,37 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
+/*
+ * Default to cp15 based access because arm64 uses this function for
+ * sched_clock() before DT is probed and the cp15 method is guaranteed
+ * to exist on arm64. arm doesn't use this before DT is probed so even
+ * if we don't have the cp15 accessors we won't have a problem.
+ */
+u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
+
+static u64 arch_counter_read(struct clocksource *cs)
+{
+	return arch_timer_read_counter();
+}
+
+static u64 arch_counter_read_cc(const struct cyclecounter *cc)
+{
+	return arch_timer_read_counter();
+}
+
+static struct clocksource clocksource_counter = {
+	.name	= "arch_sys_counter",
+	.rating	= 400,
+	.read	= arch_counter_read,
+	.mask	= CLOCKSOURCE_MASK(56),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static struct cyclecounter cyclecounter __ro_after_init = {
+	.read	= arch_counter_read_cc,
+	.mask	= CLOCKSOURCE_MASK(56),
+};
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -747,37 +778,6 @@ static u64 arch_counter_get_cntvct_mem(void)
 	return ((u64) vct_hi << 32) | vct_lo;
 }
 
-/*
- * Default to cp15 based access because arm64 uses this function for
- * sched_clock() before DT is probed and the cp15 method is guaranteed
- * to exist on arm64. arm doesn't use this before DT is probed so even
- * if we don't have the cp15 accessors we won't have a problem.
- */
-u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
-
-static u64 arch_counter_read(struct clocksource *cs)
-{
-	return arch_timer_read_counter();
-}
-
-static u64 arch_counter_read_cc(const struct cyclecounter *cc)
-{
-	return arch_timer_read_counter();
-}
-
-static struct clocksource clocksource_counter = {
-	.name	= "arch_sys_counter",
-	.rating	= 400,
-	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static struct cyclecounter cyclecounter __ro_after_init = {
-	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
-};
-
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
 struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
-- 
2.11.0
