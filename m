From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:35 +0100
Subject: [PATCH 13/14] ARM: shmobile: Add watchdog support
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <58adf1ba0d227754d9bc763c667f10efe0053ce5.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
boot CPUs run a routine designed to bring up SMP and deal with hot plug.
The value contained in the SBAR registers is not initialized by a WDT
triggered reset, which means that after a WDT triggered reset we jump
to the SMP bring up routine, preventing the system from executing the
bootrom code.

The purpose of this patch is to jump to the bootrom code in case of a
WDT triggered reset, and keep the SMP functionality untouched.
In order to tell if the code had been called due to the WDT overflowing
we are testing WOVF from register RWTCSRA.

The new function shmobile_boot_vector_gen2 isn't replacing
shmobile_boot_vector for backward compatibility reasons. The kernel
will install the best option (either shmobile_boot_vector or
shmobile_boot_vector_gen2) to ICRAM1 after parsing the device tree,
according to the amount of memory available.

Since shmobile_boot_vector has become bigger, "reg" property of nodes
compatible with "renesas,smp-sram" now need to be set to a value
greater or equal to "<0 0x60>".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: dropped #ifdef from common.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h  |  4 +++
 arch/arm/mach-shmobile/headsmp.S | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index a8fa4f7e1f60..43c1ac696274 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -7,6 +7,10 @@ extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_size;
+extern void shmobile_boot_vector_gen2(void);
+extern unsigned long shmobile_boot_fn_gen2;
+extern unsigned long shmobile_boot_cpu_gen2;
+extern unsigned long shmobile_boot_size_gen2;
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 32e0bf6e3ccb..cef8e8c555f8 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -16,6 +16,11 @@
 #include <asm/assembler.h>
 #include <asm/memory.h>
 
+#define SCTLR_MMU	0x01
+#define BOOTROM_ADDRESS	0xE6340000
+#define RWTCSRA_ADDRESS 0xE6020004
+#define RWTCSRA_WOVF	0x10
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
@@ -37,6 +42,56 @@ shmobile_boot_fn:
 shmobile_boot_size:
 	.long	. - shmobile_boot_vector
 
+#ifdef CONFIG_ARCH_RCAR_GEN2
+/*
+ * Reset vector for R-Car Gen2 and RZ/G1 secondary CPUs.
+ * This will be mapped at address 0 by SBAR register.
+ */
+ENTRY(shmobile_boot_vector_gen2)
+	mrc	p15, 0, r0, c0, c0, 5		@ r0 = MPIDR
+	ldr	r1, shmobile_boot_cpu_gen2
+	cmp	r0, r1
+	bne	shmobile_smp_continue_gen2
+
+	mrc	p15, 0, r1, c1, c0, 0		@ r1 = SCTLR
+	and	r0, r1, #SCTLR_MMU
+	cmp	r0, #SCTLR_MMU
+	beq	shmobile_smp_continue_gen2
+
+	ldr	r0, rwtcsra
+	mov	r1, #0
+	ldrb	r1, [r0]
+	and	r0, r1, #RWTCSRA_WOVF
+	cmp	r0, #RWTCSRA_WOVF
+	bne	shmobile_smp_continue_gen2
+
+	ldr	r0, bootrom
+	bx	r0
+
+shmobile_smp_continue_gen2:
+	ldr     r1, shmobile_boot_fn_gen2
+	bx	r1
+
+ENDPROC(shmobile_boot_vector_gen2)
+
+	.align	4
+rwtcsra:
+	.word	RWTCSRA_ADDRESS
+bootrom:
+	.word	BOOTROM_ADDRESS
+	.globl	shmobile_boot_cpu_gen2
+shmobile_boot_cpu_gen2:
+	.word	0x00000000
+
+	.align	2
+	.globl	shmobile_boot_fn_gen2
+shmobile_boot_fn_gen2:
+	.space	4
+	.globl	shmobile_boot_size_gen2
+shmobile_boot_size_gen2:
+	.long	. - shmobile_boot_vector_gen2
+#endif /* CONFIG_ARCH_RCAR_GEN2 */
+
 /*
  * Per-CPU SMP boot function/argument selection code based on MPIDR
  */
-- 
2.11.0
