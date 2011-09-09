From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri,  9 Sep 2011 11:26:49 -0400
Subject: [PATCH 2/5] ARM: exynos4: Use wfi macro in platform_do_lowpower.
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <1315582012-23507-3-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current Exynos4 CPU hotplug code includes a hardcoded WFI instruction,
in ARM encoding.  The hardcoded instruction is both hard to understand
and doomed to failure when building the kernel in Thumb-2 mode.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
Compile tested in both ARM and Thumb-2 mode.
---
 arch/arm/mach-exynos4/hotplug.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
index 7490789..8724227 100644
--- a/arch/arm/mach-exynos4/hotplug.c
+++ b/arch/arm/mach-exynos4/hotplug.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 
 #include <mach/regs-pmu.h>
 
@@ -67,13 +68,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		if (cpu == 1)
 			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
 
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		wfi();
 
 		if (pen_release == cpu) {
 			/*
-- 
1.7.3.4
