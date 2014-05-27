From: zlim@broadcom.com (Zi Shen Lim)
Date: Tue, 27 May 2014 16:49:24 -0700
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519171511.GA5240@e102568-lin.cambridge.arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
 <20140519123314.GU12304@sirena.org.uk>
 <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
 <20140519161217.GX12304@sirena.org.uk>
 <20140519171511.GA5240@e102568-lin.cambridge.arm.com>
Message-ID: <20140527234924.GA2691@lc-sj1-5012.sj.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 06:15:11PM +0100, Lorenzo Pieralisi wrote:
[...]
> 
> Hashing compresses the cluster index, but that index is not representative
> of HW anyway. If you go for simple shifting we might end up with huge cluster
> ids, which is fine but a bit weird.
> 
> So either (1) you use three affinity levels or (2) the simplest way to combine
> the affinity levels.
> 

Sorry for jumping in late. The original patch packs the cluster_id, in hope of
providing linear mapping when the affinity tree is balanced. I'm fine with
the simplest way of shifting/oring, if that's the preferred method :)

The patch below applies on top of the series Mark sent out.
1. Dropped mpidr_hash-related bits, in favor of simpler shift/or using MPIDR.
2. Also addressed Lorenzo's comment about redundant cluster_id==-1 check.

Mark, can you please apply/squash this patch?

Thanks,
z

---
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index b3b3287..7639e8b 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -32,9 +32,6 @@
 #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
 	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
 
-#define MPIDR_AFF_MASK(level) \
-	((u64)MPIDR_LEVEL_MASK << MPIDR_LEVEL_SHIFT(level))
-
 #define read_cpuid(reg) ({						\
 	u64 __val;							\
 	asm("mrs	%0, " #reg : "=r" (__val));			\
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f7f3478..26fc5b0 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 
 #include <asm/cputype.h>
-#include <asm/smp_plat.h>
 #include <asm/topology.h>
 
 /*
@@ -364,12 +363,6 @@ static void update_siblings_masks(unsigned int cpuid)
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
 	int cpu;
 
-	if (cpuid_topo->cluster_id == -1) {
-		/* No topology information for this cpu ?! */
-		pr_err("CPU%u: No topology information configured\n", cpuid);
-		return;
-	}
-
 	/* update core and thread sibling masks */
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
@@ -410,19 +403,15 @@ void store_cpu_topology(unsigned int cpuid)
 		/* Multiprocessor system : Multi-threads per core */
 		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-		cpuid_topo->cluster_id =
-			((mpidr & MPIDR_AFF_MASK(2)) >> mpidr_hash.shift_aff[2] |
-			 (mpidr & MPIDR_AFF_MASK(3)) >> mpidr_hash.shift_aff[3])
-			>> mpidr_hash.shift_aff[1] >> mpidr_hash.shift_aff[0];
+		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
 	} else {
 		/* Multiprocessor system : Single-thread per core */
 		cpuid_topo->thread_id  = -1;
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->cluster_id =
-			((mpidr & MPIDR_AFF_MASK(1)) >> mpidr_hash.shift_aff[1] |
-			 (mpidr & MPIDR_AFF_MASK(2)) >> mpidr_hash.shift_aff[2] |
-			 (mpidr & MPIDR_AFF_MASK(3)) >> mpidr_hash.shift_aff[3])
-			>> mpidr_hash.shift_aff[0];
+		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
+					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
 	}
 
 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %llx\n",
-- 
1.8.4.3
