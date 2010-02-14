From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 22:08:11 +0530
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <4B773560.2060800@arm.com>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-7-git-send-email-rabin@rab.in>
	<4B773560.2060800@arm.com>
Message-ID: <20100214163811.GA4467@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 13, 2010 at 11:27:28PM +0000, Catalin Marinas wrote:
> >diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> >index 42eb166..cd2a574 100644
> >--- a/arch/arm/kernel/entry-common.S
> >+++ b/arch/arm/kernel/entry-common.S
> >@@ -156,7 +156,8 @@ ENTRY(__gnu_mcount_nc)
> > 	stmdb	sp!, {r0-r3, lr}
> > 	ldr	r0, =ftrace_trace_function
> > 	ldr	r2, [r0]
> >-	adr	r0, ftrace_stub
> >+ THUMB(	orr	r2, r2, #1		)
> >+	adr	r0, BSYM(ftrace_stub)
> > 	cmp	r0, r2
> 
> Does this code not give the correct result if not modified?

Without the BSYM, I get assembler errors:

entry-common.S: Assembler messages:
entry-common.S:179: Error: invalid immediate for address calculation (value = 0x00000004)

Without the orr, the lsb is not set on the pointer loaded from
ftrace_trace_function, but is set on BSYM(ftrace_stub), leading to the
comparison failing even when the pointer is pointing to ftrace_stub.

> 
> > 	bne	gnu_trace
> > 	ldmia	sp!, {r0-r3, ip, lr}
> >@@ -166,8 +167,9 @@ gnu_trace:
> > 	ldr	r1, [sp, #20]			@ lr of instrumented routine
> > 	mov	r0, lr
> > 	sub	r0, r0, #MCOUNT_INSN_SIZE
> >-	mov	lr, pc
> >-	mov	pc, r2
> >+ ARM(	mov	lr, pc			)
> >+ ARM(	mov	pc, r2			)
> >+ THUMB(	blx	r2			)
> > 	ldmia	sp!, {r0-r3, ip, lr}
> > 	mov	pc, ip
> > ENDPROC(__gnu_mcount_nc)
> 
> As above, what does this need modifying? "mov pc, r2" wouldn't
> change the mode to ARM even if the value in r2 is even. It may need
> THUMB(nop) after this instruction.

The "mov pc, r2" is not the problem.  The problem is the "mov lr, pc",
which does not set the lsb when storing the pc in lr.  The called
function returns with "bx lr", and the mode changes to ARM.  The blx is
to avoid this.

Rabin
