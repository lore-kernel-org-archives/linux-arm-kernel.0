From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:19:46 +0900
Subject: [PATCH 02/06] ARM: shmobile: Add SCU boot function using argument
In-Reply-To: <20130610091925.18944.68117.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
Message-ID: <20130610091946.18944.39252.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a shmoible_boot_scu function that assumes that the base address
of the SCU is passed in r0. This code is free from inline virtual
to physical address conversion.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp-scu.S         |   13 +++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 2 files changed, 14 insertions(+)

--- 0001/arch/arm/mach-shmobile/headsmp-scu.S
+++ work/arch/arm/mach-shmobile/headsmp-scu.S	2013-06-10 17:44:41.000000000 +0900
@@ -51,6 +51,19 @@ ENTRY(shmobile_secondary_vector_scu)
 2:	.long shmobile_scu_base - PAGE_OFFSET + PLAT_PHYS_OFFSET
 ENDPROC(shmobile_secondary_vector_scu)
 
+ENTRY(shmobile_boot_scu)
+					@ r0 = SCU base address
+	mrc     p15, 0, r1, c0, c0, 5	@ read MIPDR
+	and	r1, r1, #3		@ mask out cpu ID
+	lsl	r1, r1, #3		@ we will shift by cpu_id * 8 bits
+	ldr	r2, [r0, #8]		@ SCU Power Status Register
+	mov	r3, #3
+	bic	r2, r2, r3, lsl r1	@ Clear bits of our CPU (Run Mode)
+	str	r2, [r0, #8]		@ write back
+
+	b	shmobile_invalidate_start
+ENDPROC(shmobile_boot_scu)
+
 	.text
 	.globl	shmobile_scu_base
 shmobile_scu_base:
--- 0004/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-06-10 16:32:25.000000000 +0900
@@ -11,6 +11,7 @@ extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
 extern void shmobile_secondary_vector_scu(void);
+extern void shmobile_boot_scu(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
