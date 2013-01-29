From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Tue, 29 Jan 2013 15:46:19 +0530
Subject: [PATCH v2 4/5] ARM: Handle l2x0 quirks in cpu_idle path
Message-ID: <20130129101616.GA21952@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a result of to-be deprecated "CONFIG_PL310_ERRATA_*" config
option, handle the quirks at run time. As of now, PL310 errata
769419 is managed this way.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |   13 +++++++++++++
 arch/arm/kernel/process.c                  |    7 ++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index ab76131..7cca69c 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -136,6 +136,19 @@ struct l2x0_regs {
 extern struct l2x0_regs l2x0_saved_regs;
 extern u32 l2x0_revision;
 
+#ifdef CONFIG_CACHE_PL310
+static inline void handle_l2x0_quirks(void)
+{
+	/* handle ERRATA_769419 */
+	if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0)
+		wmb();
+}
+#else
+static inline void handle_l2x0_quirks(void)
+{
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index c6dec5f..12e3b5f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -201,9 +202,9 @@ void cpu_idle(void)
 			 * to ensure we don't miss a wakeup call.
 			 */
 			local_irq_disable();
-#ifdef CONFIG_PL310_ERRATA_769419
-			wmb();
-#endif
+
+			handle_l2x0_quirks();
+
 			if (hlt_counter) {
 				local_irq_enable();
 				cpu_relax();
-- 
1.7.2.dirty
