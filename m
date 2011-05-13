From: vbendeb@google.com (Vadim Bendebury)
Date: Fri, 13 May 2011 12:58:58 -0700 (PDT)
Subject: [PATCH 1/1] ARM: thumb: Fix thumb mode compilation problems.
Message-ID: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: thumb: Fix thumb mode compilation problems.

This change has not been tested in this tree (other than
verifying compilation/linking success in both Thumb2 and regular
modes).

It was however tested in a Chromium OS tree
(http://www.chromium.org/chromium-os). The latest fiq.c version
of the Chromium OS is the same as arm.linux.org.uk, so the patch
applies as is, headsmp.S is different, but the patch applies the
same.

Signed-off-by: Vadim Bendebury <vbendeb@chromium.org>
---
 arch/arm/kernel/fiq.c         |   34 ++++++++++++++++++++++++++--------
 arch/arm/mach-tegra/headsmp.S |    3 ++-
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index e72dc34..b0f3e0c 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -99,15 +99,24 @@ void __naked set_fiq_regs(struct pt_regs *regs)
 	register unsigned long tmp;
 	asm volatile (
 	"mov	ip, sp\n\
-	stmfd	sp!, {fp, ip, lr, pc}\n\
+	sub	sp, sp, #8\n\
+	stmfd	sp!, {fp, ip}\n\
+	str	lr, [sp, #8]\n\
+	str	pc, [sp, #12]\n\
 	sub	fp, ip, #4\n\
 	mrs	%0, cpsr\n\
-	msr	cpsr_c, %2	@ select FIQ mode\n\
+	mov	ip, %2		@ select FIQ mode\n\
+	msr	cpsr_c, ip\n\
 	mov	r0, r0\n\
-	ldmia	%1, {r8 - r14}\n\
+	ldmia	%1, {r8 - ip}\n\
+	ldr	r13, [%1, #20]\n\
+	ldr	r14, [%1, #24]\n\
 	msr	cpsr_c, %0	@ return to SVC mode\n\
 	mov	r0, r0\n\
-	ldmfd	sp, {fp, sp, pc}"
+	ldr	ip, [sp, #8]\n\
+	ldr	fp, [sp]\n\
+	ldr	sp, [sp, #4]\n\
+	mov	pc, ip"
 	: "=&r" (tmp)
 	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
 }
@@ -117,15 +126,24 @@ void __naked get_fiq_regs(struct pt_regs *regs)
 	register unsigned long tmp;
 	asm volatile (
 	"mov	ip, sp\n\
-	stmfd	sp!, {fp, ip, lr, pc}\n\
+	sub	sp, sp, #8\n\
+	stmfd	sp!, {fp, ip}\n\
+	str	lr, [sp, #8]\n\
+	str	pc, [sp, #12]\n\
 	sub	fp, ip, #4\n\
 	mrs	%0, cpsr\n\
-	msr	cpsr_c, %2	@ select FIQ mode\n\
+	mov	ip, %2		@ select FIQ mode\n\
+	msr	cpsr_c, ip\n\
 	mov	r0, r0\n\
-	stmia	%1, {r8 - r14}\n\
+	stmia	%1, {r8 - ip}\n\
+	str	r13, [%1, #20]\n\
+	str	r14, [%1, #24]\n\
 	msr	cpsr_c, %0	@ return to SVC mode\n\
 	mov	r0, r0\n\
-	ldmfd	sp, {fp, sp, pc}"
+	ldr	ip, [sp, #8]\n\
+	ldr	fp, [sp]\n\
+	ldr	sp, [sp, #4]\n\
+	mov	pc, ip"
 	: "=&r" (tmp)
 	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | FIQ_MODE));
 }
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index b5349b2..bcbfbab 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -48,7 +48,8 @@ ENTRY(v7_invalidate_l1)
 ENDPROC(v7_invalidate_l1)
 
 ENTRY(tegra_secondary_startup)
-	msr	cpsr_fsxc, #0xd3
+	mov     r0, #0xd3
+	msr     cpsr_fsxc, r0
         bl      v7_invalidate_l1
 	mrc	p15, 0, r0, c0, c0, 5
         and	r0, r0, #15
-- 
1.7.3.1
