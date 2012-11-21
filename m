From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:26 -0600
Subject: [PATCH 2/9] ARM: mach-ux500: use SGI0 to wake up the other core
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <1353466713-18967-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>

The commit 7d28e3eaa1a8e951251b942e7220f97114bd73b9
("ARM: ux500: wake secondary cpu via resched") makes use
of schedule IPI to wake up the secondary core which seems
incorrect. Rather use SGI0.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 arch/arm/mach-ux500/platsmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 3db7782..79531f1 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -91,7 +91,7 @@ static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *
 	 */
 	write_pen_release(cpu_logical_map(cpu));
 
-	smp_send_reschedule(cpu);
+	gic_raise_softirq(cpumask_of(cpu), 0);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.10.4
