From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat, 15 Apr 2017 02:40:13 +0800
Subject: [PATCH v24 10/11] clocksource: arm_arch_timer: add GTDT support for
 memory-mapped timer
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Message-ID: <20170414184014.8524-11-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the
information provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
[Mark: verify CNTFRQ, only register the first frame]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 78 ++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 05f2f7a..8981173 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1385,10 +1385,78 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static int __init
+arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
+{
+	struct arch_timer_mem_frame *frame;
+	u32 rate;
+	int i;
+
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		frame = &timer_mem->frame[i];
+
+		if (!frame->valid)
+			continue;
+
+		rate = arch_timer_mem_frame_get_cntfrq(frame);
+		if (rate == arch_timer_rate)
+			continue;
+
+		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
+		       &frame->cntbase,
+		       (unsigned long)rate, (unsigned long)arch_timer_rate);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init arch_timer_mem_acpi_init(int platform_timer_count)
+{
+	struct arch_timer_mem *timers, *timer;
+	struct arch_timer_mem_frame *frame;
+	int timer_count, i, ret = 0;
+
+	timers = kcalloc(platform_timer_count, sizeof(*timers), GFP_KERNEL);
+	if (!timers)
+		return -ENOMEM;
+
+	ret = acpi_arch_timer_mem_init(timers, &timer_count);
+	if (ret || !timer_count)
+		goto out;
+
+	for (i = 0; i < timer_count; i++) {
+		ret = arch_timer_mem_verify_cntfrq(&timers[i]);
+		if (ret) {
+			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
+			goto out;
+		}
+	}
+
+	/*
+	 * While unlikely, it's theoretically possible that none of the frames
+	 * in a timer expose the combination of feature we want.
+	 */
+	for (i = i; i < timer_count; i++) {
+		timer = &timers[i];
+
+		frame = arch_timer_mem_find_best_frame(timer);
+		if (frame)
+			break;
+	}
+
+	if (frame)
+		ret = arch_timer_mem_frame_register(frame);
+out:
+	kfree(timers);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	int ret;
+	int ret, platform_timer_count;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("already initialized, skipping\n");
@@ -1397,7 +1465,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	ret = acpi_gtdt_init(table, NULL);
+	ret = acpi_gtdt_init(table, &platform_timer_count);
 	if (ret) {
 		pr_err("Failed to init GTDT table.\n");
 		return ret;
@@ -1440,6 +1508,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	if (ret)
 		return ret;
 
+	if (platform_timer_count &&
+	    arch_timer_mem_acpi_init(platform_timer_count))
+		pr_err("Failed to initialize memory-mapped timer.\n");
+
 	return arch_timer_common_init();
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
-- 
2.9.3
