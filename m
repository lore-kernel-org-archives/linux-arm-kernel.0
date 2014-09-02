From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 14:19:10 -0700
Subject: [PATCH v2 5/9] ARM: zynq: Remove invalidate cache for cpu die
In-Reply-To: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1409692754-13437-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

As there is no Power management unit on this board, it is not possible to power
down a core, just WFI is allowed. There is no point to invalidate the cache and
exit coherency.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-and-tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/hotplug.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
index 5052c70326e4..366f46c91365 100644
--- a/arch/arm/mach-zynq/hotplug.c
+++ b/arch/arm/mach-zynq/hotplug.c
@@ -10,35 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-
-#include <asm/cacheflush.h>
-#include <asm/cp15.h>
-#include "common.h"
-
-static inline void zynq_cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	flush_cache_all();
-	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	dsb\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x40\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C)
-	  : "cc");
-}
+#include <asm/proc-fns.h>
 
 /*
  * platform-specific code to shutdown a CPU
@@ -47,8 +19,6 @@ static inline void zynq_cpu_enter_lowpower(void)
  */
 void zynq_platform_cpu_die(unsigned int cpu)
 {
-	zynq_cpu_enter_lowpower();
-
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
-- 
2.1.0.1.g27b9230
