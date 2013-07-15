From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 15 Jul 2013 15:21:41 +0100
Subject: [PATCH] xen/arm: disable cpuidle when linux is running as dom0
Message-ID: <1373898101-15633-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When linux is running as dom0, Xen doesn't show the physical cpu but a
virtual CPU.
On some ARM SOC (for instance the exynos 5250), linux registers callbacks
for cpuidle. When these callbacks are called, they will modify
directly the physical cpu not the virtual one. It can impact the whole board
instead of dom0.

Signed-off-by: Julien Grall <julien.grall@linaro.org>
---
 arch/arm/xen/enlighten.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 49839d8..a98999f 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -24,6 +24,8 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/cpuidle.h>
+#include <linux/cpufreq.h>
 
 #include <linux/mm.h>
 
@@ -292,6 +294,11 @@ static int __init xen_pm_init(void)
 {
 	pm_power_off = xen_power_off;
 	arm_pm_restart = xen_restart;
+	/*
+	 * Making sure board specific code will not set up ops for
+	 * cpu idle.
+	 */
+	disable_cpuidle();
 
 	return 0;
 }
-- 
1.7.10.4
