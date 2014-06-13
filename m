From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:03 +0200
Subject: [PATCH 01/14] ARM: mvebu: fix randconfig builds for pmsu driver
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

local_flush_tlb_all() is not available for NOMMU NOSMP builds.
The isb() assembly instruction is not available when building
a combined ARMv6/v7 kernel, unlike the isb() inline that falls
back to the ARMv6 opcode.
If CPUIDLE support is disabled globally, we must not call
arm_cpu_suspend. If it is enabled, we should ensure that it
is available.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 arch/arm/mach-mvebu/pmsu.c  | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 6090b9e..bcfe094 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -18,6 +18,7 @@ menu "Marvell EBU SoC variants"
 config MACH_MVEBU_V7
 	bool
 	select ARMADA_370_XP_TIMER
+	select ARM_CPU_SUSPEND if CPU_IDLE
 	select CACHE_L2X0
 
 config MACH_ARMADA_370
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..14351bf 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/smp.h>
 #include <linux/resource.h>
+#include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
@@ -200,7 +201,9 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 	/* If we are here, wfi failed. As processors run out of
 	 * coherency for some time, tlbs might be stale, so flush them
 	 */
+#ifdef CONFIG_MMU
 	local_flush_tlb_all();
+#endif
 
 	ll_enable_coherency();
 
@@ -210,9 +213,10 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 	"tst	%0, #(1 << 2) \n\t"
 	"orreq	%0, %0, #(1 << 2) \n\t"
 	"mcreq	p15, 0, %0, c1, c0, 0 \n\t"
-	"isb	"
 	: : "r" (0));
 
+	isb();
+
 	pr_warn("Failed to suspend the system\n");
 
 	return 0;
@@ -220,6 +224,9 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 
 static int armada_370_xp_cpu_suspend(unsigned long deepidle)
 {
+	if (!IS_ENABLED(CONFIG_CPU_IDLE))
+		return -ENODEV;
+
 	return cpu_suspend(deepidle, do_armada_370_xp_cpu_suspend);
 }
 
-- 
1.8.3.2
