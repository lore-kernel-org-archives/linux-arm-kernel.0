From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:17 +0000
Subject: [PATCH RFC v3 10/12] arm64: kernel: add CPU idle call
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-11-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CPU idle is enabled, the architectural idle call should go through
the idle subsystem to allow CPUs to enter idle states defined
by the platform CPU idle back-end operations.

This patch, mirroring other archs behaviour, adds the CPU idle call to the
architectural arch_cpu_idle implementation for arm64.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..50491ec 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -33,6 +33,7 @@
 #include <linux/kallsyms.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/elfcore.h>
 #include <linux/pm.h>
 #include <linux/tick.h>
@@ -98,8 +99,10 @@ void arch_cpu_idle(void)
 	 * This should do all the clock switching and wait for interrupt
 	 * tricks
 	 */
-	cpu_do_idle();
-	local_irq_enable();
+	if (cpuidle_idle_call()) {
+		cpu_do_idle();
+		local_irq_enable();
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.8.4
