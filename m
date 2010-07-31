From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 31 Jul 2010 19:38:53 +0530
Subject: [PATCH] ARM: update show_interrupts for online cpu's only
Message-ID: <1280585333-4870-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even after CPUx is logically offline, it's interrupt are displayed
in proc entry

This patch fixes the same by use of 'for_each_online_cpu' instead
of 'for_each_present_cpu' in 'show_interrupts' function

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3b3d2c8..cfab369 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -60,7 +60,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		char cpuname[12];
 
 		seq_printf(p, "    ");
-		for_each_present_cpu(cpu) {
+		for_each_online_cpu(cpu) {
 			sprintf(cpuname, "CPU%d", cpu);
 			seq_printf(p, " %10s", cpuname);
 		}
@@ -74,7 +74,7 @@ int show_interrupts(struct seq_file *p, void *v)
 			goto unlock;
 
 		seq_printf(p, "%3d: ", i);
-		for_each_present_cpu(cpu)
+		for_each_online_cpu(cpu)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, cpu));
 		seq_printf(p, " %10s", irq_desc[i].chip->name ? : "-");
 		seq_printf(p, "  %s", action->name);
-- 
1.6.0.4
