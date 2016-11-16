From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 16 Nov 2016 21:49:07 +0800
Subject: [PATCH v16 14/15] clocksource/drivers/arm_arch_timer: Add GTDT
 support for memory-mapped timer
In-Reply-To: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1479304148-2965-15-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the
information provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c494ca8..0aad60a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1067,7 +1067,28 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_of_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static int __init arch_timer_mem_acpi_init(void)
+{
+	struct arch_timer_mem *timer_mem;
+	int ret = 0;
+	int i = 0;
+
+	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
+	if (!timer_mem)
+		return -ENOMEM;
+
+	while (!gtdt_arch_timer_mem_init(timer_mem, i)) {
+		ret = arch_timer_mem_init(timer_mem);
+		if (ret)
+			break;
+		i++;
+	}
+
+	kfree(timer_mem);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int ret;
@@ -1104,6 +1125,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL);
 
+	if (arch_timer_mem_acpi_init())
+		pr_err("Failed to initialize memory-mapped timer.\n");
+
 	ret = arch_timer_init();
 
 error:
-- 
2.7.4
