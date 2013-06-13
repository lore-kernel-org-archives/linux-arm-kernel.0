From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 15:59:44 +0900
Subject: [PATCH 06/15] ARM: shmobile: Add SCU boot function using argument
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106793-25071-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a shmoible_boot_scu function that assumes that the base address
of the SCU is passed in r0. This code is free from inline virtual
to physical address conversion.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-scu.S         | 13 +++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 7d113f8..c5c9106 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
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
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 54472ef..8ef1c3c 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -11,6 +11,7 @@ extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
 extern void shmobile_secondary_vector_scu(void);
+extern void shmobile_boot_scu(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
-- 
1.8.2.1
