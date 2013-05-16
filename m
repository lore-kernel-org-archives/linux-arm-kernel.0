From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 May 2013 16:34:05 +0100
Subject: [PATCH 1/3] ARM: DT: kernel: move temporary cpu map stack array to
 static data
In-Reply-To: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368718447-19209-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the number of CPUs increase, the temporary array allocated on the
stack in arm_dt_init_cpu_maps() can become too big and trigger stack
issues.
This patch moves the allocated memory to static __initdata so that stack
data is not used anymore to allocate the temporary array.
Memory is marked as __initdata since it need not be persistent after boot.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/devtree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5af04f6..3d652e4f 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -78,11 +78,12 @@ void __init arm_dt_init_cpu_maps(void)
 	 * contain a list of MPIDR[23:0] values where MPIDR[31:24] must
 	 * read as 0.
 	 */
+	static u32 tmp_map[NR_CPUS] __initdata = {
+				[0 ... NR_CPUS-1] = UINT_MAX };
 	struct device_node *cpu, *cpus;
 	u32 i, j, cpuidx = 1;
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 
-	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = UINT_MAX };
 	bool bootcpu_valid = false;
 	cpus = of_find_node_by_path("/cpus");
 
-- 
1.8.2.2
