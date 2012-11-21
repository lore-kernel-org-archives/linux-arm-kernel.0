From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 21 Nov 2012 16:42:56 +0000
Subject: [PATCH] ARM: kernel: fix nr_cpu_ids check in DT logical map init
Message-ID: <1353516176-12929-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a kernel is configured with a DT containing more /cpu nodes than
nr_cpu_ids, the number of cpus must be capped in the DT parsing
code. Current code carries out the check, but fails to cap the
value and the check is executed after the cpu logical index is used,
which can lead to memory corruption due to index overflow.

This patch refactors the check against nr_cpu_ids and move it before
any computed index is used in the parsing code.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
---
Russell,

while refactoring the DT loop over nodes, I unfortunately missed this niggle
in the parsing loop that Mark reported. Here is the fix, sorry for the
additional commit, if it is ok for you I will add it to your patch system.

Apologies and thanks,
Lorenzo

 arch/arm/kernel/devtree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index aaf9add..70f1bde 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -139,10 +139,14 @@ void __init arm_dt_init_cpu_maps(void)
 			i = cpuidx++;
 		}
 
-		tmp_map[i] = hwid;
-
-		if (cpuidx > nr_cpu_ids)
+		if (WARN(cpuidx > nr_cpu_ids, "DT /cpu %u nodes greater than "
+					       "max cores %u, capping them\n",
+					       cpuidx, nr_cpu_ids)) {
+			cpuidx = nr_cpu_ids;
 			break;
+		}
+
+		tmp_map[i] = hwid;
 	}
 
 	if (WARN(!bootcpu_valid, "DT missing boot CPU MPIDR[23:0], "
-- 
1.7.12
