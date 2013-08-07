From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:39:34 +0900
Subject: [GIT PULL 8/9] ARM: shmobile: Introduce per-CPU SMP boot / sleep code
In-Reply-To: <cover.1375841380.git.horms+renesas@verge.net.au>
References: <cover.1375841380.git.horms+renesas@verge.net.au>
Message-ID: <cc61591e45c0457139ddd4cd7e57f75928acaaf2.1375841380.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add per-CPU SMP boot / sleep code that can be used by all
SoCs included in mach-shmobile.

The boot code reads out the per-CPU MPIDR id value and
matches it with the value stored for any CPU number, and
if there is a match and the boot function is set as well
then the boot function will be executed.

The sleep code simply uses WFI and then jumps back to the
boot code to see if anyone has asked to wake up that CPU,
if not it will sleep again.

Signed-off-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: Remove trailing whitespace]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp.S             | 49 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  4 +++
 arch/arm/mach-shmobile/platsmp.c             | 18 ++++++++++
 3 files changed, 71 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 559d1ce..2940fc9 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -38,3 +38,52 @@ shmobile_boot_fn:
 	.globl	shmobile_boot_arg
 shmobile_boot_arg:
 2:	.space	4
+
+/*
+ * Per-CPU SMP boot function/argument selection code based on MPIDR
+ */
+
+ENTRY(shmobile_smp_boot)
+						@ r0 = MPIDR_HWID_BITMASK
+	mrc	p15, 0, r1, c0, c0, 5		@ r1 = MPIDR
+	and	r0, r1, r0			@ r0 = cpu_logical_map() value
+	mov	r1, #0				@ r1 = CPU index
+	adr	r5, 1f				@ array of per-cpu mpidr values
+	adr	r6, 2f				@ array of per-cpu functions
+	adr	r7, 3f				@ array of per-cpu arguments
+
+shmobile_smp_boot_find_mpidr:
+	ldr	r8, [r5, r1, lsl #2]
+	cmp	r8, r0
+	bne	shmobile_smp_boot_next
+
+	ldr	r9, [r6, r1, lsl #2]
+	cmp	r9, #0
+	bne	shmobile_smp_boot_found
+
+shmobile_smp_boot_next:
+	add	r1, r1, #1
+	cmp	r1, #CONFIG_NR_CPUS
+	blo	shmobile_smp_boot_find_mpidr
+
+	b	shmobile_smp_sleep
+
+shmobile_smp_boot_found:
+	ldr	r0, [r7, r1, lsl #2]
+	mov	pc, r9
+ENDPROC(shmobile_smp_boot)
+
+ENTRY(shmobile_smp_sleep)
+	wfi
+	b	shmobile_smp_boot
+ENDPROC(shmobile_smp_sleep)
+
+	.globl	shmobile_smp_mpidr
+shmobile_smp_mpidr:
+1:	.space	CONFIG_NR_CPUS * 4
+	.globl	shmobile_smp_fn
+shmobile_smp_fn:
+2:	.space	CONFIG_NR_CPUS * 4
+	.globl	shmobile_smp_arg
+shmobile_smp_arg:
+3:	.space	CONFIG_NR_CPUS * 4
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 04209d5..3880cf5 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -10,6 +10,10 @@ extern void shmobile_setup_console(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
+extern void shmobile_smp_boot(void);
+extern void shmobile_smp_sleep(void);
+extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
+			      unsigned long arg);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 1f958d7..d4ae616 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -12,6 +12,9 @@
  */
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include <mach/common.h>
 
 void __init shmobile_smp_init_cpus(unsigned int ncores)
 {
@@ -26,3 +29,18 @@ void __init shmobile_smp_init_cpus(unsigned int ncores)
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
 }
+
+extern unsigned long shmobile_smp_fn[];
+extern unsigned long shmobile_smp_arg[];
+extern unsigned long shmobile_smp_mpidr[];
+
+void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
+{
+	shmobile_smp_fn[cpu] = 0;
+	flush_cache_all();
+
+	shmobile_smp_mpidr[cpu] = cpu_logical_map(cpu);
+	shmobile_smp_fn[cpu] = fn;
+	shmobile_smp_arg[cpu] = arg;
+	flush_cache_all();
+}
-- 
1.8.3.2
