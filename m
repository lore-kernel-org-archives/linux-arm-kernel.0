From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 12:33:22 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110208112323.GA22592@n2100.arm.linux.org.uk>
References: <AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTi=JCQBH4sjJzWajYJx6VuUTgdB76nxXbvKTrcwc@mail.gmail.com>
	<20110207143351.GH31929@n2100.arm.linux.org.uk>
	<AANLkTikVQG1ngkT7VwvjiSJjSfNsSMw=msfhc44emx6B@mail.gmail.com>
	<20110207150233.GI31929@n2100.arm.linux.org.uk>
	<1297160512.31587.17.camel@e102568-lin.cambridge.arm.com>
	<20110208112323.GA22592@n2100.arm.linux.org.uk>
Message-ID: <20110208123322.GB22592@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 11:23:23AM +0000, Russell King - ARM Linux wrote:
> > The same goes for the stack pointer global variable which should be
> > per cpu.
> 
> Yes, but this is what is currently done, so at the present time I'm
> just sorting out what's already in the kernel.  If we need further
> changes, then that needs to be built on top of this.

Like this:

 arch/arm/kernel/sleep.S |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 9f106fa..e10618f 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -25,7 +25,14 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
+#ifdef CONFIG_SMP
+	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
+	ALT_UP(mov lr, #0)
+	and	lr, lr, #15
+	str	r2, [r3, lr, lsl #2]	@ save phys SP
+#else
 	str	r2, [r3]		@ save phys SP
+#endif
 	mov	lr, pc
 	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
 #else
@@ -36,7 +43,14 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
+#ifdef CONFIG_SMP
+	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
+	ALT_UP(mov lr, #0)
+	and	lr, lr, #15
+	str	r2, [r3, lr, lsl #2]	@ save phys SP
+#else
 	str	r2, [r3]		@ save phys SP
+#endif
 	bl	cpu_do_suspend
 #endif
 
@@ -96,7 +110,15 @@ cpu_resume_after_mmu:
 	.data
 	.align
 ENTRY(cpu_resume)
+#ifdef CONFIG_SMP
+	adr	r0, sleep_save_sp
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	ldr	r0, [r0, r1, lsl #2]	@ stack phys addr
+#else
 	ldr	r0, sleep_save_sp	@ stack phys addr
+#endif
 	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
 #ifdef MULTI_CPU
 	ldmia	r0!, {r1, sp, lr, pc}	@ load v:p, stack, return fn, resume fn
@@ -107,4 +129,6 @@ ENTRY(cpu_resume)
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
-	.word	0				@ preserve stack phys ptr here
+	.rept	CONFIG_NR_CPUS
+	.long	0				@ preserve stack phys ptr here
+	.endr
