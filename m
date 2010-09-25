From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 25 Sep 2010 15:46:16 -0400 (EDT)
Subject: [PATCH] ARM: SECCOMP support
In-Reply-To: <20100925185805.GB3044@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1009231709230.13233@xanadu.home>
	<20100925113413.GA3044@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1009251220420.13233@xanadu.home>
	<20100925185805.GB3044@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1009251533240.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Sep 2010, Russell King - ARM Linux wrote:

> On Sat, Sep 25, 2010 at 12:31:07PM -0400, Nicolas Pitre wrote:
> > Well, for one thing, the syscall tracing has the ability to change the 
> > actual syscall number.  So this looked like a possible hole that could 
> > somehow be exploited to escape the seccomp control.  So I went with the 
> > safest way.
> 
> That is also true for x86 - the seccomp test on x86 is done first,
> before the syscall entry trap.

OK, what about this then:

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f05a35a..5f3c4bf 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -293,7 +293,6 @@ ENTRY(vector_swi)
 
 	get_thread_info tsk
 	adr	tbl, sys_call_table		@ load syscall table pointer
-	ldr	ip, [tsk, #TI_FLAGS]		@ check for syscall tracing
 
 #if defined(CONFIG_OABI_COMPAT)
 	/*
@@ -310,8 +309,20 @@ ENTRY(vector_swi)
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
 #endif
 
+	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
-	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
+
+#ifdef CONFIG_SECCOMP
+	tst	r10, #_TIF_SECCOMP
+	beq	1f
+	mov	r0, scno
+	bl	__secure_computing	
+	add	r0, sp, #S_R0 + S_OFF		@ pointer to regs
+	ldmia	r0, {r0 - r3}			@ have to reload r0 - r3
+1:
+#endif
+
+	tst	r10, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
 	bne	__sys_trace
 
 	cmp	scno, #NR_syscalls		@ check upper syscall limit

Nicolas
