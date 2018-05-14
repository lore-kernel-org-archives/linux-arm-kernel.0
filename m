From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 14 May 2018 16:55:35 +0800
Subject: [RFC PATCH 09/10] x86: tsc: Register the persistent clock
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <3b626f6d7dd5ca047e6835b10c3a4e662db2539f.1526285602.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the tsc as one persistent clock to compensate the suspend time
if the tsc clocksource is always available.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/x86/Kconfig      |    1 +
 arch/x86/kernel/tsc.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492..667e3a7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -195,6 +195,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PERSISTENT_CLOCK
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..dd8d7c3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/percpu.h>
+#include <linux/persistent_clock.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
 
@@ -1032,6 +1033,11 @@ static u64 read_tsc(struct clocksource *cs)
 	return (u64)rdtsc_ordered();
 }
 
+static u64 notrace tsc_read_persistent_clock(void)
+{
+	return (u64)rdtsc_ordered();
+}
+
 static void tsc_cs_mark_unstable(struct clocksource *cs)
 {
 	if (tsc_unstable)
@@ -1300,6 +1306,11 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+	if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP)
+		persistent_clock_init_and_register(tsc_read_persistent_clock,
+						   CLOCKSOURCE_MASK(64),
+						   tsc_khz, 0);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
@@ -1327,6 +1338,11 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+		if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP)
+			persistent_clock_init_and_register(tsc_read_persistent_clock,
+							   CLOCKSOURCE_MASK(64),
+							   tsc_khz, 0);
 unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
-- 
1.7.9.5
