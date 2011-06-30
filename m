From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 10:52:30 +0900
Subject: [PATCH 2/2] ARM: EXYNOS4: Enable Internal RTC's Wakeup from
	Suspend-to-Ram
In-Reply-To: <1309398750-25859-1-git-send-email-myungjoo.ham@samsung.com>
References: <1309398750-25859-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1309398750-25859-2-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow Exynos4 to setup WAKEUP-MASK bits based on IRQ numbers. Currently,
Exynos4's cpu.c supports RTC ALARM/TICK based IRQs only.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 9babe44..fbb6f30 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -10,6 +10,7 @@
 
 #include <linux/sched.h>
 #include <linux/sysdev.h>
+#include <linux/irq.h>
 
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -23,6 +24,7 @@
 #include <plat/sdhci.h>
 #include <plat/devs.h>
 #include <plat/fimc-core.h>
+#include <plat/pm.h>
 
 #include <mach/regs-irq.h>
 
@@ -170,6 +172,8 @@ void __init exynos4_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
+
+	irq_get_chip(IRQ_RTC_ALARM)->irq_set_wake = s3c_irq_wake;
 }
 
 struct sysdev_class exynos4_sysclass = {
-- 
1.7.4.1
