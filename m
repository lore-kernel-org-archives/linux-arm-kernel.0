From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:13 +0900
Subject: [PATCH 03/43] ARM: shmobile: Move EMEV2 CPU boot vector setup code
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the boot vector setup code for the EMEV2 SoC to match
the sh73a0 and r8a7779 implementations. With this in place
all SoC specific SMP implementations for mach-shmobile uses
the ->smp_prepare_cpus() callback to setup the boot vector.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 72620b1..6427821 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -74,9 +74,6 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 	/* enable cache coherency */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
-	/* Tell ROM loader about our vector (in headsmp.S) */
-	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
-
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 	return 0;
 }
@@ -87,6 +84,9 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 
 	scu_enable(scu_base);
 
+	/* Tell ROM loader about our vector (in headsmp.S) */
+	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
+
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
-- 
1.7.10.4
