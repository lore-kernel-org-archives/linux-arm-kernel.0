From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Mar 2010 10:23:54 +0000
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <1268462987-8271-7-git-send-email-rabin@rab.in> (Rabin Vincent's
	message of "Sat, 13 Mar 2010 12:19:43 +0530")
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-7-git-send-email-rabin@rab.in>
Message-ID: <tnxsk80r2dh.fsf@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

Rabin Vincent <rabin@rab.in> wrote:
> Fix the mcount routines to build and run on a kernel built with the
> Thumb-2 instruction set:
>
>  - Without the BSYM, the following assembler errors appear:
>
>    entry-common.S: Assembler messages:
>    entry-common.S:179: Error: invalid immediate for address calculation (value = 0x00000004)

I'm still confused by this. I think that's a compiler problem but need
to get some feedback from toolchain people.

> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -167,7 +167,8 @@ ENTRY(__gnu_mcount_nc)
>  	stmdb	sp!, {r0-r3, lr}
>  	ldr	r0, =ftrace_trace_function
>  	ldr	r2, [r0]
> -	adr	r0, ftrace_stub
> + THUMB(	orr	r2, r2, #1		)
> +	adr	r0, BSYM(ftrace_stub)

If the ftrace_stub isn't .globl, the code compiles fine. My approach
would be something like this:

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d085033..5f5aef6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -122,7 +122,7 @@ ENTRY(__gnu_mcount_nc)
 	stmdb sp!, {r0-r3, lr}
 	ldr r0, =ftrace_trace_function
 	ldr r2, [r0]
-	adr r0, ftrace_stub
+	adr r0, 1f
 	cmp r0, r2
 	bne gnu_trace
 	ldmia sp!, {r0-r3, ip, lr}
@@ -132,8 +132,9 @@ gnu_trace:
 	ldr r1, [sp, #20]			@ lr of instrumented routine
 	mov r0, lr
 	sub r0, r0, #MCOUNT_INSN_SIZE
-	mov lr, pc
+	adr lr, BSYM(2f)
 	mov pc, r2
+2:
 	ldmia sp!, {r0-r3, ip, lr}
 	mov pc, ip
 
@@ -141,7 +142,7 @@ ENTRY(mcount)
 	stmdb sp!, {r0-r3, lr}
 	ldr r0, =ftrace_trace_function
 	ldr r2, [r0]
-	adr r0, ftrace_stub
+	adr r0, 1f
 	cmp r0, r2
 	bne trace
 	ldr lr, [fp, #-4]			@ restore lr
@@ -160,6 +161,7 @@ trace:
 
 	.globl ftrace_stub
 ftrace_stub:
+1:
 	mov pc, lr
 
 #endif /* CONFIG_FUNCTION_TRACER */

-- 
Catalin
