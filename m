From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:50 -0400
Subject: [PATCH RFC/RFT 3/6] ARM: vexpress: DCSCB: tighten CPU validity
 assertion
In-Reply-To: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1426701893-25589-4-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the cpu argument validity check uses a hardcoded limit of 4.
The DCSCB configuration data provides the actual number of CPUs and
we already use it elsewhere.  Let's improve the cpu argument validity
check by using that information instead.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 30b993399e..12c74734cd 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -54,7 +54,7 @@ static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 	unsigned int all_mask;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	if (cpu >= 4 || cluster >= 2)
+	if (cluster >= 2 || !(cpumask & dcscb_allcpus_mask[cluster]))
 		return -EINVAL;
 
 	all_mask = dcscb_allcpus_mask[cluster];
@@ -105,7 +105,7 @@ static void dcscb_power_down(void)
 	cpumask = (1 << cpu);
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cpu >= 4 || cluster >= 2);
+	BUG_ON(cluster >= 2 || !(cpumask & dcscb_allcpus_mask[cluster]));
 
 	all_mask = dcscb_allcpus_mask[cluster];
 
@@ -189,7 +189,7 @@ static void __init dcscb_usage_count_init(void)
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
-	BUG_ON(cpu >= 4 || cluster >= 2);
+	BUG_ON(cluster >= 2 || !((1 << cpu) & dcscb_allcpus_mask[cluster]));
 	dcscb_use_count[cpu][cluster] = 1;
 }
 
-- 
2.1.0
