From: chao.xie@marvell.com (Chao Xie)
Date: Mon,  7 May 2012 11:23:58 +0800
Subject: [PATCH V2 1/4] ARM: mm: proc-mohawk: add suspend resume for mohawk
Message-ID: <1336361041-18145-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enable ARCH_SUSPEND_POSSIBLE, it need defintion of
cpu_mohawk_do_suspend and cpu_mohawk_do_resume

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/Kconfig          |    2 +-
 arch/arm/mm/proc-mohawk.S |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4cf9d42..aaa22f8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2275,7 +2275,7 @@ source "kernel/power/Kconfig"
 config ARCH_SUSPEND_POSSIBLE
 	depends on !ARCH_S5PC100
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
-		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
+		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
 
 config ARM_CPU_SUSPEND
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index cdfedc5..6a050b1 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -344,6 +344,41 @@ ENTRY(cpu_mohawk_set_pte_ext)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
+.globl	cpu_mohawk_suspend_size
+.equ	cpu_mohawk_suspend_size, 4 * 6
+#ifdef CONFIG_PM_SLEEP
+ENTRY(cpu_mohawk_do_suspend)
+	stmfd	sp!, {r4 - r9, lr}
+	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
+	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mrc	p15, 0, r6, c13, c0, 0	@ PID
+	mrc 	p15, 0, r7, c3, c0, 0	@ domain ID
+	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
+	mrc 	p15, 0, r9, c1, c0, 0	@ control reg
+	bic	r4, r4, #2		@ clear frequency change bit
+	stmia	r0, {r4 - r9}		@ store cp regs
+	ldmia	sp!, {r4 - r9, pc}
+ENDPROC(cpu_mohawk_do_suspend)
+
+ENTRY(cpu_mohawk_do_resume)
+	ldmia	r0, {r4 - r9}		@ load cp regs
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
+	mcr	p15, 0, ip, c7, c10, 4	@ drain write (&fill) buffer
+	mcr	p15, 0, ip, c7, c5, 4	@ flush prefetch buffer
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
+	mcr	p14, 0, r4, c6, c0, 0	@ clock configuration, turbo mode.
+	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mcr	p15, 0, r6, c13, c0, 0	@ PID
+	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
+	orr	r1, r1, #0x18		@ cache the page table in L2
+	mcr	p15, 0, r1, c2, c0, 0	@ translation table base addr
+	mcr	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
+	mov	r0, r9			@ control register
+	b	cpu_resume_mmu
+ENDPROC(cpu_mohawk_do_resume)
+#endif
+
 	__CPUINIT
 
 	.type	__mohawk_setup, #function
-- 
1.7.0.4
