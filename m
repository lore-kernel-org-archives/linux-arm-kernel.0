From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 10 Feb 2016 14:56:55 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: Remove shmobile_boot_arg
In-Reply-To: <1455112615-6970-1-git-send-email-geert+renesas@glider.be>
References: <1455112615-6970-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455112615-6970-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU boot configuration writes to shmobile_boot_arg, which is located in
the .text section, and thus should not be written to.

As of commit 1d33a354bbb618ba ("ARM: shmobile: Per-CPU SMP boot / sleep
code for SCU SoCs"), and ignoring accidental remainings,
shmobile_boot_arg is always set to MPIDR_HWID_BITMASK by C code.
Hence we can just hardcode this in the assembler code, and remove the
variable, and thus also remove the need to write to this variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/mach-shmobile/common.h       | 1 -
 arch/arm/mach-shmobile/headsmp.S      | 8 ++------
 arch/arm/mach-shmobile/platsmp-apmu.c | 1 -
 arch/arm/mach-shmobile/platsmp-scu.c  | 1 -
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 225c12bb3de91e76..5464b7a75e3028a7 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -4,7 +4,6 @@
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
-extern unsigned long shmobile_boot_arg;
 extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 4cf7f0b016b0b0fe..ede974b4fd67d8cd 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -24,7 +24,6 @@
 	.arm
 	.align  12
 ENTRY(shmobile_boot_vector)
-	ldr     r0, 2f
 	ldr     r1, 1f
 	bx	r1
 
@@ -34,9 +33,6 @@ ENDPROC(shmobile_boot_vector)
 	.globl	shmobile_boot_fn
 shmobile_boot_fn:
 1:	.space	4
-	.globl	shmobile_boot_arg
-shmobile_boot_arg:
-2:	.space	4
 	.globl	shmobile_boot_size
 shmobile_boot_size:
 	.long	. - shmobile_boot_vector
@@ -46,9 +42,9 @@ shmobile_boot_size:
  */
 
 ENTRY(shmobile_smp_boot)
-						@ r0 = MPIDR_HWID_BITMASK
 	mrc	p15, 0, r1, c0, c0, 5		@ r1 = MPIDR
-	and	r0, r1, r0			@ r0 = cpu_logical_map() value
+	and	r0, r1, #0xffffff		@ MPIDR_HWID_BITMASK
+						@ r0 = cpu_logical_map() value
 	mov	r1, #0				@ r1 = CPU index
 	adr	r2, 1f
 	ldmia	r2, {r5, r6, r7}
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 911884f7e28b174c..aba75c89f9c1c5eb 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -123,7 +123,6 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
-	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* perform per-cpu setup */
 	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 4c7d2caf3730f644..8d478f1da265d55e 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -46,7 +46,6 @@ void __init shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
-	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* enable SCU and cache coherency on booting CPU */
 	shmobile_scu_base_phys = scu_base_phys;
-- 
1.9.1
