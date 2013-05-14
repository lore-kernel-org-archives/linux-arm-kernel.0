From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:42 +0100
Subject: [PATCH 6/8] ARM: mpu: add MPU initialisation for secondary cores
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-7-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MPU initialisation on the primary core is performed in two stages, one
minimal stage to ensure the CPU can boot and a second one after
sanity_check_meminfo. As the memory configuration is known by the time we
boot secondary cores only a single step is necessary, provided the values
for DRSR are passed to secondaries.

This patch implements this arrangement. The configuration generated for the
MPU regions is made available to the secondary core, which can then use the
asm MPU intialisation code to program a complete region configuration.

This is necessary for SMP configurations without an MMU, as the MPU
initialisation is the only way to ensure that memory is specified as
'shared'.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/smp.h   |    5 ++++-
 arch/arm/kernel/head-nommu.S |    7 +++++++
 arch/arm/kernel/smp.c        |    8 ++++++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index d3a22be..a8cae71c 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -65,7 +65,10 @@ asmlinkage void secondary_start_kernel(void);
  * Initial data for bringing up a secondary CPU.
  */
 struct secondary_data {
-	unsigned long pgdir;
+	union {
+		unsigned long mpu_rgn_szr;
+		unsigned long pgdir;
+	};
 	unsigned long swapper_pg_dir;
 	void *stack;
 };
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 0b0751f..3d3071b 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -103,6 +103,13 @@ ENTRY(secondary_startup)
 
 	adr	r4, __secondary_data
 	ldmia	r4, {r7, r12}
+
+#ifdef CONFIG_ARM_MPU
+	/* Use MPU region info supplied by __cpu_up */
+	ldr	r6, [r7]			@ get secondary_data.mpu_szr
+	bl      __setup_mpu			@ Initialize the MPU
+#endif
+
 	adr	lr, BSYM(__after_proc_init)	@ return address
 	mov	r13, r12			@ __secondary_switched address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b476002..c53d5e9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -45,6 +45,7 @@
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
 #include <asm/mach/arch.h>
+#include <asm/mpu.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -87,6 +88,10 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
 	 * its stack and the page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
+#ifdef CONFIG_ARM_MPU
+	secondary_data.mpu_rgn_szr = mpu_rgn_info.rgns[MPU_RAM_REGION].drsr;
+#endif
+
 #ifdef CONFIG_MMU
 	secondary_data.pgdir = virt_to_phys(idmap_pgd);
 	secondary_data.swapper_pg_dir = virt_to_phys(swapper_pg_dir);
@@ -114,9 +119,8 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
-	secondary_data.stack = NULL;
-	secondary_data.pgdir = 0;
 
+	memset(&secondary_data, 0, sizeof(secondary_data));
 	return ret;
 }
 
-- 
1.7.9.5
