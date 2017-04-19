From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 17:44:21 +0100
Subject: [PATCH 04/16] clocksource: arm_arch_timer: move enums and defines to
 header file
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1492620273-30037-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

To support the arm_arch_timer via ACPI we need to share defines and enums
between the driver and the ACPI parser code.
So we split out the relevant defines and enums into arm_arch_timer.h.

No functional change.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 11 -----------
 include/clocksource/arm_arch_timer.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 94e355b..04218c1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -55,8 +55,6 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
-#define ARCH_TIMER_TYPE_CP15		BIT(0)
-#define ARCH_TIMER_TYPE_MEM		BIT(1)
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
@@ -69,15 +67,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate;
-
-enum arch_timer_ppi_nr {
-	ARCH_TIMER_PHYS_SECURE_PPI,
-	ARCH_TIMER_PHYS_NONSECURE_PPI,
-	ARCH_TIMER_VIRT_PPI,
-	ARCH_TIMER_HYP_PPI,
-	ARCH_TIMER_MAX_TIMER_PPI
-};
-
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index caedb74..b898637 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -16,9 +16,13 @@
 #ifndef __CLKSOURCE_ARM_ARCH_TIMER_H
 #define __CLKSOURCE_ARM_ARCH_TIMER_H
 
+#include <linux/bitops.h>
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
+#define ARCH_TIMER_TYPE_CP15		BIT(0)
+#define ARCH_TIMER_TYPE_MEM		BIT(1)
+
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -34,6 +38,14 @@ enum arch_timer_reg {
 	ARCH_TIMER_REG_TVAL,
 };
 
+enum arch_timer_ppi_nr {
+	ARCH_TIMER_PHYS_SECURE_PPI,
+	ARCH_TIMER_PHYS_NONSECURE_PPI,
+	ARCH_TIMER_VIRT_PPI,
+	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_MAX_TIMER_PPI
+};
+
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
-- 
1.9.1
