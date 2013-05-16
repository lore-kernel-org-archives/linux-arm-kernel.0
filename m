From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 May 2013 16:34:06 +0100
Subject: [PATCH 2/3] ARM: kernel: fix arm_dt_init_cpu_maps() to skip non-cpu
 nodes
In-Reply-To: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368718447-19209-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of the cpu-map topology node in the cpus node implies
that cpus node might have children that are not cpu nodes. The DT
parsing code needs updating otherwise it would check for cpu nodes
properties in nodes that are not required to contain them, resulting
in warnings that have no bearing on bindings defined in the dts source file.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/devtree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 3d652e4f..d2293c0 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -93,6 +93,9 @@ void __init arm_dt_init_cpu_maps(void)
 	for_each_child_of_node(cpus, cpu) {
 		u32 hwid;
 
+		if (of_node_cmp(cpu->type, "cpu"))
+			continue;
+
 		pr_debug(" * %s...\n", cpu->full_name);
 		/*
 		 * A device tree containing CPU nodes with missing "reg"
-- 
1.8.2.2
