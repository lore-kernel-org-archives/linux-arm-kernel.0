From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 24 Apr 2014 17:40:16 +0100
Subject: [PATCH 2/4] arm/mach-vexpress: array accessed out of bounds
In-Reply-To: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
References: <1398357618-11050-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1398357618-11050-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

dcscb_allcpus_mask is an array of size 2.

The index variable cluster has to be checked against this limit
before accessing the array.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/dcscb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 788495d..30b9933 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -51,12 +51,14 @@ static int dcscb_allcpus_mask[2];
 static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int rst_hold, cpumask = (1 << cpu);
-	unsigned int all_mask = dcscb_allcpus_mask[cluster];
+	unsigned int all_mask;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= 4 || cluster >= 2)
 		return -EINVAL;
 
+	all_mask = dcscb_allcpus_mask[cluster];
+
 	/*
 	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
 	 * variant exists, we need to disable IRQs manually here.
@@ -101,11 +103,12 @@ static void dcscb_power_down(void)
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	cpumask = (1 << cpu);
-	all_mask = dcscb_allcpus_mask[cluster];
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= 4 || cluster >= 2);
 
+	all_mask = dcscb_allcpus_mask[cluster];
+
 	__mcpm_cpu_going_down(cpu, cluster);
 
 	arch_spin_lock(&dcscb_lock);
-- 
1.8.3.2
