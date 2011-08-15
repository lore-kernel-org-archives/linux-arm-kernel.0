From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:30:50 +0100
Subject: [PATCH v2 6/8] ARM: shmobile: convert logical CPU numbers to physical
	numbers
In-Reply-To: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
References: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
Message-ID: <1313429452-2820-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when dealing with the SCU in the SMP
boot path for sh73a0.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-shmobile/smp-sh73a0.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 3ffdbc9..be1ade7 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -74,6 +74,8 @@ void __cpuinit sh73a0_secondary_init(unsigned int cpu)
 
 int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
 {
+	cpu = cpu_logical_map(cpu);
+
 	/* enable cache coherency */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
@@ -87,6 +89,8 @@ int __cpuinit sh73a0_boot_secondary(unsigned int cpu)
 
 void __init sh73a0_smp_prepare_cpus(void)
 {
+	int cpu = cpu_logical_map(0);
+
 	scu_enable(scu_base_addr());
 
 	/* Map the reset vector (in headsmp.S) */
@@ -94,5 +98,5 @@ void __init sh73a0_smp_prepare_cpus(void)
 	__raw_writel(__pa(shmobile_secondary_vector), __io(SBAR));
 
 	/* enable cache coherency on CPU0 */
-	modify_scu_cpu_psr(0, 3 << (0 * 8));
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
-- 
1.7.0.4
