From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 00:36:49 +0000
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
Message-ID: <1416530209-16016-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The only requirement the scheduler has on cluster IDs is that they must
be unique.  When enumerating the topology based on MPIDR information the
kernel currently generates cluster IDs by using the first level of
affinity above the core ID (either level one or two depending on if the
core has multiple threads) however the ARMv8 architecture allows for up
to three levels of affinity.  This means that an ARMv8 system may
contain cores which have MPIDRs identical other than affinity level
three which with current code will cause us to report multiple cores
with the same identification to the scheduler in violation of its
uniqueness requirement.

Ensure that we do not violate the scheduler requirements on systems that
uses all the affinity levels by incorporating both affinity levels two
and three into the cluser ID when the cores are not threaded.

While no currently known hardware uses multi-level clusters it is better
to program defensively, this will help ease bringup of systems that have
them and will ensure that things like distribution install media do not
need to be respun to replace kernels in order to deploy such systems.
In the worst case the system will work but perform suboptimally until a
kernel modified to handle the new topology better is installed, in the
best case this will be an adequate description of such topologies for
the scheduler to perform well.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/topology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b6ee26b..fcb8f7b 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -255,12 +255,15 @@ void store_cpu_topology(unsigned int cpuid)
 		/* Multiprocessor system : Multi-threads per core */
 		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
 	} else {
 		/* Multiprocessor system : Single-thread per core */
 		cpuid_topo->thread_id  = -1;
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
 	}
 
 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
-- 
2.1.1
