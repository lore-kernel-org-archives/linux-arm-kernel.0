From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 20 May 2013 12:03:26 +0530
Subject: [RFC PATCH 4/6] ARM: spear: use the core cpu hotplug functions
In-Reply-To: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
References: <1369031608-27347-1-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <1369031608-27347-5-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic arm cpu hotplug related functions are moved to core hotplug code,
remove the functions from the platform code.

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 arch/arm/mach-spear/hotplug.c |   37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
index d97749c..988a9a6 100644
--- a/arch/arm/mach-spear/hotplug.c
+++ b/arch/arm/mach-spear/hotplug.c
@@ -15,42 +15,7 @@
 #include <linux/smp.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	dsb\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	: "=&r" (v)
-	: "r" (0), "Ir" (CR_C)
-	: "cc", "memory");
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile("mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	: "=&r" (v)
-	: "Ir" (CR_C)
-	: "cc");
-}
+#include <asm/hotplug.h>
 
 static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
 {
-- 
1.7.9.5
