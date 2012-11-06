From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:32 +0530
Subject: [PATCH 1/5] ARM: EXYNOS: fix the hotplug for Cortex-A15
In-Reply-To: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352182356-28989-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sequence of cpu_enter_lowpower() for Cortex-A15
is different from the sequence for Cortex-A9.
This patch implements cpu_enter_lowpower() for EXYNOS5
SoC which has Cortex-A15 cores.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c |   45 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index f4d7dd2..8c06c4f 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -20,10 +20,11 @@
 #include <asm/smp_plat.h>
 
 #include <mach/regs-pmu.h>
+#include <plat/cpu.h>
 
 #include "common.h"
 
-static inline void cpu_enter_lowpower(void)
+static inline void cpu_enter_lowpower_a9(void)
 {
 	unsigned int v;
 
@@ -45,6 +46,35 @@ static inline void cpu_enter_lowpower(void)
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
@@ -103,11 +133,20 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 void __ref exynos_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
+	int primary_part = 0;
 
 	/*
-	 * we're ready for shutdown now, so do it
+	 * we're ready for shutdown now, so do it.
+	 * Exynos4 is A9 based while Exynos5 is A15; check the CPU part
+	 * number by reading the Main ID register and then perform the
+	 * appropriate sequence for entering low power.
 	 */
-	cpu_enter_lowpower();
+	asm("mrc p15, 0, %0, c0, c0, 0" : "=r"(primary_part) : : "cc");
+	if ((primary_part & 0xfff0) == 0xc0f0)
+		cpu_enter_lowpower_a15();
+	else
+		cpu_enter_lowpower_a9();
+
 	platform_do_lowpower(cpu, &spurious);
 
 	/*
-- 
1.6.6.1
