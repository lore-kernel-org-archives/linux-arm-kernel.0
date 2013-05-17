From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:45 +0100
Subject: [RFC PATCH v4 02/18] ARM: kernel: fix __cpu_logical_map default
 initialization
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __cpu_logical_map array is statically initialized to 0, which is a valid
MPIDR value. To prevent issues with the current implementation, this patch
defines an MPIDR_INVALID value, and statically initializes the
__cpu_logical_map[] array to it. Entries in the arm_dt_init_cpu_maps()
tmp_map array used to stash DT reg properties while parsing DT are initialized
with the MPIDR_INVALID value as well for consistency.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cputype.h  | 2 ++
 arch/arm/include/asm/smp_plat.h | 2 +-
 arch/arm/kernel/devtree.c       | 2 +-
 arch/arm/kernel/setup.c         | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 7652712..dba62cb 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -32,6 +32,8 @@
 
 #define MPIDR_HWID_BITMASK 0xFFFFFF
 
+#define MPIDR_INVALID (~MPIDR_HWID_BITMASK)
+
 #define MPIDR_LEVEL_BITS 8
 #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
 
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index aaa61b6..e789832 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -49,7 +49,7 @@ static inline int cache_ops_need_broadcast(void)
 /*
  * Logical CPU mapping.
  */
-extern int __cpu_logical_map[];
+extern u32 __cpu_logical_map[];
 #define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
 /*
  * Retrieve logical cpu index corresponding to a given MPIDR[23:0]
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 904cad5..0905502 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -82,7 +82,7 @@ void __init arm_dt_init_cpu_maps(void)
 	u32 i, j, cpuidx = 1;
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 
-	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = UINT_MAX };
+	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 	bool bootcpu_valid = false;
 	cpus = of_find_node_by_path("/cpus");
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6ae71b7..eeac924 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -457,7 +457,7 @@ void notrace cpu_init(void)
 	    : "r14");
 }
 
-int __cpu_logical_map[NR_CPUS];
+u32 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 
 void __init smp_setup_processor_id(void)
 {
-- 
1.8.2.2
