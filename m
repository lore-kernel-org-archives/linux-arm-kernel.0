From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 27 Jul 2013 18:42:08 +0800
Subject: [RFC][PATCH 2/2] ARM64: introduce cluster id and make a difference
 between socket id
In-Reply-To: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
References: <1374921728-9007-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1374921728-9007-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the cpu topology information, we define topology_physical_package_id()
as cpu socket id, which means that the socket id is the idenfication for
physical processor, not for a cluster in a cpu die.

On ARM64 platform, multi cluster in a cpu die will be normal, here is a
example with 2 cores in a cluster and 2 cluster in a socket:

|--------------------------------------|
|                socket                |
|                                      |
| |---------------|  |---------------| |
| |    cluster    |  |    cluster    | |
| |               |  |               | |
| | |----| |----| |  | |----| |----| | |
| | |core| |core| |  | |core| |core| | |
| | |----| |----| |  | |----| |----| | |
| |               |  |               | |
| |---------------|  |---------------| |
|                                      |
|--------------------------------------|

ARM64 extended the MPIDR into 64 bit and introduce another affinity level,
we can use this affinity level for socket id and use the third highest level
affinity for cluster id, which  make the socket id behavior in its original
way.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/topology.h |    1 +
 arch/arm64/kernel/topology.c      |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 8631808..ff68ecc 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -8,6 +8,7 @@
 struct cputopo_arm64 {
 	int thread_id;
 	int core_id;
+	int cluster_id;
 	int socket_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1eb0435..6d1e5a6 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -80,12 +80,14 @@ void store_cpu_topology(unsigned int cpuid)
 			/* core performance interdependency */
 			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL_0(mpidr);
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL_1(mpidr);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_2(mpidr);
+			cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL_2(mpidr);
+			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_3(mpidr);
 		} else {
 			/* largely independent cores */
 			cpuid_topo->thread_id = -1;
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL_0(mpidr);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_1(mpidr);
+			cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL_1(mpidr);
+			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL_2(mpidr);
 		}
 	} else {
 		/*
@@ -95,6 +97,7 @@ void store_cpu_topology(unsigned int cpuid)
 		 */
 		cpuid_topo->thread_id = -1;
 		cpuid_topo->core_id = 0;
+		cpuid_topo->cluster_id = -1;
 		cpuid_topo->socket_id = -1;
 	}
 
@@ -120,6 +123,7 @@ void __init init_cpu_topology(void)
 
 		topo->thread_id = -1;
 		topo->core_id =  -1;
+		topo->cluster_id = -1;
 		topo->socket_id = -1;
 		cpumask_clear(&topo->core_sibling);
 		cpumask_clear(&topo->thread_sibling);
-- 
1.7.9.5
