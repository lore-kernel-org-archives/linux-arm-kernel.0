From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Oct 2013 10:55:00 +0100
Subject: [PATCH v2 1/3] ARM: mcpm: Factor out logical-to-physical CPU
 translation
In-Reply-To: <1380621302-5655-1-git-send-email-Dave.Martin@arm.com>
References: <1380621302-5655-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1380621302-5655-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch factors the logical-to-physical CPU translation out of
mcpm_boot_secondary(), so that it can be reused elsewhere.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_platsmp.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
index 1bc34c7..c0c3cd7 100644
--- a/arch/arm/common/mcpm_platsmp.c
+++ b/arch/arm/common/mcpm_platsmp.c
@@ -19,14 +19,23 @@
 #include <asm/smp.h>
 #include <asm/smp_plat.h>
 
+static void cpu_to_pcpu(unsigned int cpu,
+			unsigned int *pcpu, unsigned int *pcluster)
+{
+	unsigned int mpidr;
+
+	mpidr = cpu_logical_map(cpu);
+	*pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	*pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+}
+
 static int mcpm_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned int mpidr, pcpu, pcluster, ret;
+	unsigned int pcpu, pcluster, ret;
 	extern void secondary_startup(void);
 
-	mpidr = cpu_logical_map(cpu);
-	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	cpu_to_pcpu(cpu, &pcpu, &pcluster);
+
 	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
 		 __func__, cpu, pcpu, pcluster);
 
-- 
1.7.9.5
