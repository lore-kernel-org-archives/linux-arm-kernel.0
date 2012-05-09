From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 May 2012 21:37:28 +0900
Subject: [PATCH] ARM: EXYNOS: fix the hotplug for Cortex-A15
Message-ID: <01a301cd2de0$7ebaada0$7c3008e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

The sequence of cpu_enter_lowpower() for Cortex-A15
is different from the sequence for Cortex-A9.
This patch implements cpu_enter_lowpower() for EXYNOS5
SoC which has Cortex-A15 cores.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Note, I didn't see common code for fix of hotplug for Cortex-A15.
If any regarding patch, please kindly let me know, thanks.

 arch/arm/mach-exynos/hotplug.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 9c17a0a..2a444b1 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -21,9 +21,11 @@
 
 #include <mach/regs-pmu.h>
 
+#include <plat/cpu.h>
+
 extern volatile int pen_release;
 
-static inline void cpu_enter_lowpower(void)
+static inline void cpu_enter_lowpower_a9(void)
 {
 	unsigned int v;
 
@@ -45,6 +47,35 @@ static inline void cpu_enter_lowpower(void)
 	  : "cc");
 }
 
+static inline void cpu_enter_lowpower_a15(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+
+	flush_cache_all();
+
+	asm volatile(
+	/*
+	* Turn off coherency
+	*/
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (0x40)
+	: "cc");
+
+	isb();
+	dsb();
+}
+
 static inline void cpu_leave_lowpower(void)
 {
 	unsigned int v;
@@ -112,7 +143,11 @@ void platform_cpu_die(unsigned int cpu)
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
-	cpu_enter_lowpower();
+	if (soc_is_exynos5250())
+		cpu_enter_lowpower_a15();
+	else
+		cpu_enter_lowpower_a9();
+
 	platform_do_lowpower(cpu, &spurious);
 
 	/*
-- 
1.7.1
