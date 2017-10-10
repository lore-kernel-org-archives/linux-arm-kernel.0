From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 10 Oct 2017 11:33:00 +0100
Subject: [PATCH v8 5/8] arm64: Use of_cpu_node_to_id helper for CPU topology
 parsing
In-Reply-To: <20171010103303.32436-1-suzuki.poulose@arm.com>
References: <20171010103303.32436-1-suzuki.poulose@arm.com>
Message-ID: <20171010103303.32436-6-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the new generic helper to convert an of_node of a CPU
to the logical CPU id in parsing the topology.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/topology.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 8d48b233e6ce..21868530018e 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -37,18 +37,14 @@ static int __init get_cpu_for_node(struct device_node *node)
 	if (!cpu_node)
 		return -1;
 
-	for_each_possible_cpu(cpu) {
-		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
-			topology_parse_cpu_capacity(cpu_node, cpu);
-			of_node_put(cpu_node);
-			return cpu;
-		}
-	}
-
-	pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+	cpu = of_cpu_node_to_id(cpu_node);
+	if (cpu >= 0)
+		topology_parse_cpu_capacity(cpu_node, cpu);
+	else
+		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
 
 	of_node_put(cpu_node);
-	return -1;
+	return cpu;
 }
 
 static int __init parse_core(struct device_node *core, int cluster_id,
-- 
2.13.6
