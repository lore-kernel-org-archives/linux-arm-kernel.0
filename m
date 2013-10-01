From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:35:40 +0900
Subject: [PATCH 08/14] ARM: shmobile: Add CPU notifier based SCU boot vector
 code
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
Message-ID: <916d6121b5947f162979595cc1c0396192a9aa86.1380532277.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CPU notifiers for the shared mach-shmobile SCU code
to allow removal of the shared SCU boot_secondary code.

Regarding notifiers, at CPU_UP_PREPARE time the SMP boot
vector is initialized so secondary CPU cores can boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-scu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index c96f501..49ae8df 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -16,6 +17,26 @@
 #include <asm/smp_scu.h>
 #include <mach/common.h>
 
+static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
+					  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		/* For this particular CPU register SCU SMP boot vector */
+		shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
+				  (unsigned long)shmobile_scu_base);
+		break;
+	};
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block shmobile_smp_scu_notifier = {
+	.notifier_call = shmobile_smp_scu_notifier_call,
+};
+
 void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
@@ -25,6 +46,9 @@ void __init shmobile_smp_scu_prepare_cpus(unsigned int max_cpus)
 	/* enable SCU and cache coherency on booting CPU */
 	scu_enable(shmobile_scu_base);
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+
+	/* Use CPU notifier for reset vector control */
+	register_cpu_notifier(&shmobile_smp_scu_notifier);
 }
 
 int shmobile_smp_scu_boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
1.8.4
