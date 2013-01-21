From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 21 Jan 2013 18:47:12 +0530
Subject: [PATCH 4/4] ARM: apply the l2x0 Errata 769419 at run time
Message-ID: <20130121131709.GA29927@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/kernel/process.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index c6dec5f..c94d84f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -201,9 +202,11 @@ void cpu_idle(void)
 			 * to ensure we don't miss a wakeup call.
 			 */
 			local_irq_disable();
-#ifdef CONFIG_PL310_ERRATA_769419
-			wmb();
-#endif
+
+			/* Check for PL310 ERRATA 769419 */
+			if (l2x0_get_rtl_release() == L2X0_CACHE_ID_RTL_R3P0)
+				wmb();
+
 			if (hlt_counter) {
 				local_irq_enable();
 				cpu_relax();
-- 
1.7.2.dirty
