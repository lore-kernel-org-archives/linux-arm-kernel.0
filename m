From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  7 Aug 2013 12:43:32 +0100
Subject: [PATCH v3 2/3] ARM: vexpress: tc2: disable GIC CPU IF in
 tc2_pm_suspend
In-Reply-To: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1375875813-13358-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prevent cores from exiting wfi when they are about to be shut down
the GIC CPU IF must be disabled so that the GIC CPU IF IRQ output line
is not asserted to the cores. wfi completion must be prevented since,
in absence of coordinating HW logic, if the power controller receives
a standbywfi signal but in the meantime the processor restarts executing
owing to a pending IRQ, the core might be reset when running in a
non-quiescent state (eg with pending load/store transactions)

Raw GIC distributor IRQ signals are routed to the power controller, that
is capable of taking core out of reset on pending IRQs even if their GIC
CPU IF is disabled, thus keeping the normal wfi behaviour.

GIC CPU IF is restored upon CPU wake-up by the respective MCPM API
consumers (ie CPU idle driver and suspend to RAM thread).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mach-vexpress/tc2_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index dfb55d4..3303ac6 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/mcpm.h>
 #include <asm/proc-fns.h>
@@ -211,6 +212,7 @@ static void tc2_pm_suspend(u64 residency)
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
+	gic_cpu_if_down();
 	tc2_pm_down(residency);
 }
 
-- 
1.8.2.2
