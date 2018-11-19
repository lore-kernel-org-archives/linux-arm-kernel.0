From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Mon, 19 Nov 2018 16:44:43 -0500
Subject: [PATCH v1 1/1] arm64: Early boot time stamps
In-Reply-To: <20181119214443.25175-1-pasha.tatashin@soleen.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
Message-ID: <20181119214443.25175-2-pasha.tatashin@soleen.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow printk time stamps/sched_clock() to be available from the early
boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4df41a66b403 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
@@ -279,8 +280,26 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+/*
+ * Get time stamps available early in boot, useful to identify boot time issues
+ * from the early boot.
+ */
+static __init void sched_clock_early_init(void)
+{
+	u64 freq = arch_timer_get_cntfrq();
+	u64 (*read_time)(void) = arch_counter_get_cntvct;
+
+	/* Early clock is available only on platforms with known freqs */
+	if (!freq)
+		return;
+
+	sched_clock_register(read_time, BITS_PER_LONG, freq);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	sched_clock_early_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.19.1
