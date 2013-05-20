From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 20 May 2013 12:03:27 +0530
Subject: [RFC PATCH 5/6] ARM: vexpress: use the core cpu hotplug functions
In-Reply-To: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
References: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <1369031608-27347-6-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic arm cpu hotplug related functions are moved to core hotplug code,
remove the functions from the platform code.

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 arch/arm/mach-vexpress/hotplug.c |   38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
index f0ce6b8..cca1361 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/mach-vexpress/hotplug.c
@@ -14,43 +14,7 @@
 
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
-
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-		"mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, %3\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
-	  : "cc");
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-		"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	  : "=&r" (v)
-	  : "Ir" (CR_C), "Ir" (0x40)
-	  : "cc");
-}
+#include <asm/hotplug.h>
 
 static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 {
-- 
1.7.9.5
