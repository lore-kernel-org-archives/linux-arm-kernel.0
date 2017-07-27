From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Jul 2017 20:08:03 +0800
Subject: [PATCH] ARM: Use WFI when possible when halting a core
Message-ID: <20170727120803.27848-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, the kernel busy loops after cleaning up when a core is to be
halted. This may have the undesired effect of increasing the core
temperature, at a time when no power or thermal management is
available, such as a kernel panic or shutdown to halt.

x86 uses the more efficient HLT (halt) instruction. The equivalent
instruction on ARM is WFI (wait for interrupt).

This patch makes the busy loops in the ARM halt/reboot/panic paths
use WFI when available (as defined in arch/arm/include/asm/barrier.h).

A touch test indicates that this lowers the surface temperature of the
Allwinner H3 SoC, with all 4 cores brought up with SMP, from painfully
hot to just warm to the touch after shutdown to halt.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I asked about this some time ago, and the answer was no one had done
it. So here it is. It is somewhat similar to the patch "arm64:
Improve parking of stopped CPUs", for arm64 obviously.

---
 arch/arm/kernel/reboot.c | 13 +++++++++++--
 arch/arm/kernel/smp.c    |  7 ++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3b2aa9a9fe26..068aef796de4 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 
+#include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
 #include <asm/virt.h>
@@ -107,7 +108,11 @@ void machine_halt(void)
 {
 	local_irq_disable();
 	smp_send_stop();
-	while (1);
+	while (1) {
+#ifdef wfi
+		wfi();
+#endif
+	}
 }
 
 /*
@@ -151,5 +156,9 @@ void machine_restart(char *cmd)
 
 	/* Whoops - the platform was unable to reboot. Tell the user! */
 	printk("Reboot failed -- System halted\n");
-	while (1);
+	while (1) {
+#ifdef wfi
+		wfi();
+#endif
+	}
 }
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index c9a0a5299827..7666fb2ed481 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -32,6 +32,7 @@
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
+#include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -567,8 +568,12 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+#ifdef wfi
+		wfi();
+#endif
+	}
 }
 
 static DEFINE_PER_CPU(struct completion *, cpu_completion);
-- 
2.13.3
