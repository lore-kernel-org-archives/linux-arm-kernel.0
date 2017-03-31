From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat,  1 Apr 2017 01:51:04 +0800
Subject: [PATCH v23 10/11] clocksource: arm_arch_timer: add GTDT support for
 memory-mapped timer
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Message-ID: <20170331175105.8370-11-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the
information provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 415e30a..c722bb5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1150,10 +1150,35 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static int __init arch_timer_mem_acpi_init(int platform_timer_count)
+{
+	struct arch_timer_mem *timer_mem;
+	int timer_count, i, ret;
+
+	timer_mem = kcalloc(platform_timer_count, sizeof(*timer_mem),
+			    GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	ret = acpi_arch_timer_mem_init(timer_mem, &timer_count);
+	if (ret || !timer_count)
+		goto error;
+
+	for (i = 0; i < timer_count; i++) {
+		ret = arch_timer_mem_init(timer_mem + i);
+		if (!ret)
+			break;
+	}
+
+error:
+	kfree(timer_mem);
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
@@ -1162,7 +1187,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	ret = acpi_gtdt_init(table, NULL);
+	ret = acpi_gtdt_init(table, &platform_timer_count);
 	if (ret) {
 		pr_err("Failed to init GTDT table.\n");
 		return ret;
@@ -1199,6 +1224,10 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
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
