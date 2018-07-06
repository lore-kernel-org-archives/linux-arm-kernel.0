From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jul 2018 12:02:48 +0100
Subject: [PATCH v3 7/7] arm64: topology: re-introduce numa mask check for
 scheduler MC selection
In-Reply-To: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1530874968-5960-8-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain from
core_siblings") selected the smallest of LLC, socket siblings, and NUMA
node siblings to ensure that the sched domain we build for the MC layer
isn't larger than the DIE above it or it's shrunk to the socket or NUMA
node if LLC exist acrosis NUMA node/chiplets.

Commit acd32e52e4e0 ("arm64: topology: Avoid checking numa mask for
scheduler MC selection") reverted the NUMA siblings checks since the
CPU topology masks weren't updated on hotplug at that time.

This patch re-introduces numa mask check as the CPU and NUMA topology
is now updated in hotplug paths. Effectively, this patch does the
partial revert of commit acd32e52e4e0.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 03b0ed2480aa..0825c4a856e3 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -215,8 +215,13 @@ EXPORT_SYMBOL_GPL(cpu_topology);
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
+	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
 
+	/* Find the smaller of NUMA, core or LLC siblings */
+	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
+		/* not numa in package, lets use the package siblings */
+		core_mask = &cpu_topology[cpu].core_sibling;
+	}
 	if (cpu_topology[cpu].llc_id != -1) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
 			core_mask = &cpu_topology[cpu].llc_sibling;
-- 
2.7.4
