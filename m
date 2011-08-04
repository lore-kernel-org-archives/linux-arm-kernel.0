From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:49:34 -0700
Subject: [PATCH 05/12] ARM: h720x:  Remove LATCH and CLOCK_TICK_RATE dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804134934.GC1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
h720x code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-h720x/common.c    |    4 +++-
 arch/arm/mach-h720x/common.h    |    3 +++
 arch/arm/mach-h720x/cpu-h7201.c |    2 +-
 arch/arm/mach-h720x/cpu-h7202.c |    2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index 51d4e44..383c121 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -30,6 +30,8 @@
 
 #include <asm/mach/dma.h>
 
+#include "common.h"
+
 #if 0
 #define IRQDBG(args...) printk(args)
 #else
@@ -46,7 +48,7 @@ void __init arch_dma_init(dma_t *dma)
  */
 unsigned long h720x_gettimeoffset(void)
 {
-	return (CPU_REG (TIMER_VIRT, TM0_COUNT) * tick_usec) / LATCH;
+	return (CPU_REG (TIMER_VIRT, TM0_COUNT) * tick_usec) / H720X_LATCH;
 }
 
 /*
diff --git a/arch/arm/mach-h720x/common.h b/arch/arm/mach-h720x/common.h
index 7dd5fa6..ac32f3c 100644
--- a/arch/arm/mach-h720x/common.h
+++ b/arch/arm/mach-h720x/common.h
@@ -27,3 +27,6 @@ extern void __init h7202_init_time(void);
 #ifdef CONFIG_ARCH_H7201
 extern struct sys_timer h7201_timer;
 #endif
+
+#define H720X_TICK_RATE		3686400
+#define H720X_LATCH		((H720X_TICK_RATE + HZ/2) / HZ)	/* For divider */
diff --git a/arch/arm/mach-h720x/cpu-h7201.c b/arch/arm/mach-h720x/cpu-h7201.c
index 24df2a3..8c2b36d 100644
--- a/arch/arm/mach-h720x/cpu-h7201.c
+++ b/arch/arm/mach-h720x/cpu-h7201.c
@@ -46,7 +46,7 @@ static struct irqaction h7201_timer_irq = {
  */
 void __init h7201_init_time(void)
 {
-	CPU_REG (TIMER_VIRT, TM0_PERIOD) = LATCH;
+	CPU_REG (TIMER_VIRT, TM0_PERIOD) = H720X_LATCH;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_RESET;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_REPEAT | TM_START;
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) = ENABLE_TM0_INTR | TIMER_ENABLE_BIT;
diff --git a/arch/arm/mach-h720x/cpu-h7202.c b/arch/arm/mach-h720x/cpu-h7202.c
index c37d570..c2879af 100644
--- a/arch/arm/mach-h720x/cpu-h7202.c
+++ b/arch/arm/mach-h720x/cpu-h7202.c
@@ -180,7 +180,7 @@ static struct irqaction h7202_timer_irq = {
  */
 void __init h7202_init_time(void)
 {
-	CPU_REG (TIMER_VIRT, TM0_PERIOD) = LATCH;
+	CPU_REG (TIMER_VIRT, TM0_PERIOD) = H720X_LATCH;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_RESET;
 	CPU_REG (TIMER_VIRT, TM0_CTRL) = TM_REPEAT | TM_START;
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) = ENABLE_TM0_INTR | TIMER_ENABLE_BIT;
-- 
1.7.4.1
