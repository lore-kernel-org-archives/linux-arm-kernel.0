From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 May 2016 11:49:02 +0100
Subject: [PATCH 2/3] ARM: introduce svc_pt_regs structure
In-Reply-To: <20160513104802.GU19428@n2100.arm.linux.org.uk>
References: <20160513104802.GU19428@n2100.arm.linux.org.uk>
Message-ID: <E1b1AeU-0005DK-6E@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the privileged mode pt_regs are an extended version of the saved
userland pt_regs, introduce a new svc_pt_regs structure to describe this
layout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/assembler.h | 4 ++--
 arch/arm/include/asm/ptrace.h    | 8 ++++++++
 arch/arm/kernel/asm-offsets.c    | 2 ++
 arch/arm/kernel/entry-armv.S     | 4 ++--
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 60d9c5471eb6..4eaea2173bf8 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -480,13 +480,13 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	uaccess_save, tmp
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	mrc	p15, 0, \tmp, c3, c0, 0
-	str	\tmp, [sp, #PT_REGS_SIZE]
+	str	\tmp, [sp, #SVC_DACR]
 #endif
 	.endm
 
 	.macro	uaccess_restore
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
-	ldr	r0, [sp, #PT_REGS_SIZE]
+	ldr	r0, [sp, #SVC_DACR]
 	mcr	p15, 0, r0, c3, c0, 0
 #endif
 	.endm
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 51622ba7c4a6..5194cf79c90f 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -13,10 +13,18 @@
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 struct pt_regs {
 	unsigned long uregs[18];
 };
 
+struct svc_pt_regs {
+	struct pt_regs regs;
+	u32 dacr;
+	u32 unused;
+};
+
 #define user_mode(regs)	\
 	(((regs)->ARM_cpsr & 0xf) == 0)
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 2841c9980bcd..9a8ce342cd82 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -108,6 +108,8 @@ int main(void)
   DEFINE(S_PSR,			offsetof(struct pt_regs, ARM_cpsr));
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
+  DEFINE(SVC_DACR,		offsetof(struct svc_pt_regs, dacr));
+  DEFINE(SVC_REGS_SIZE,		sizeof(struct svc_pt_regs));
   BLANK();
 #ifdef CONFIG_CACHE_L2X0
   DEFINE(L2X0_R_PHY_BASE,	offsetof(struct l2x0_regs, phy_base));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index a6cb019d9920..0d6f5413be18 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -152,7 +152,7 @@ ENDPROC(__und_invalid)
 	.macro	svc_entry, stack_hole=0, trace=1, uaccess=1
  UNWIND(.fnstart		)
  UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(PT_REGS_SIZE + 8 + \stack_hole - 4)
+	sub	sp, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
 #ifdef CONFIG_THUMB2_KERNEL
  SPFIX(	str	r0, [sp]	)	@ temporarily saved
  SPFIX(	mov	r0, sp		)
@@ -167,7 +167,7 @@ ENDPROC(__und_invalid)
 	ldmia	r0, {r3 - r5}
 	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
 	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(PT_REGS_SIZE + 8 + \stack_hole - 4)
+	add	r2, sp, #(SVC_REGS_SIZE + \stack_hole - 4)
  SPFIX(	addeq	r2, r2, #4	)
 	str	r3, [sp, #-4]!		@ save the "real" r0 copied
 					@ from the exception stack
-- 
2.1.0
