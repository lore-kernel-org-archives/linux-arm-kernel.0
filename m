From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 17:02:39 +0000
Subject: [PATCH] ARM: make kernel oops easier to read
Message-ID: <20131030170239.GH16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking at a number of oopses recently, I've decided we can do a
little better with our output, without sacrificing any information -
and actually providing a bit more information than we did before using
slightly less characters. :)

This shouldn't break any scripts... "shouldn't"... :)

8<====
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: make kernel oops easier to read

We don't need the offset for the first function name in each backtrace
entry; this needlessly consumes screen space.  This is virtually always
the first or second instruction in the called function.

Also, recognise stmfd instructions which include r10 as a valid stack
saving instruction, and when dumping the registers, dump six registers
per line rather than five, and fix the wrapping.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/traps.c  |    2 +-
 arch/arm/lib/backtrace.S |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 8fcda140358d..cbf14efbd913 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -55,7 +55,7 @@ static void dump_mem(const char *, const char *, unsigned long, unsigned long);
 void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
 {
 #ifdef CONFIG_KALLSYMS
-	printk("[<%08lx>] (%pS) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
+	printk("[<%08lx>] (%ps) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
 #else
 	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
 #endif
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index cd07b5814c23..4102be617fce 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -80,14 +80,14 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 		ldr	r1, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
 		ldr	r3, .Ldsi+4
-		teq	r3, r1, lsr #10
+		teq	r3, r1, lsr #11
 		ldreq	r0, [frame, #-8]	@ get sp
 		subeq	r0, r0, #4		@ point at the last arg
 		bleq	.Ldumpstm		@ dump saved registers
 
 1004:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, ip, lr, pc}
 		ldr	r3, .Ldsi		@ instruction exists,
-		teq	r3, r1, lsr #10
+		teq	r3, r1, lsr #11
 		subeq	r0, frame, #16
 		bleq	.Ldumpstm		@ dump saved registers
 
@@ -128,11 +128,11 @@ ENDPROC(c_backtrace)
 		beq	2f
 		add	r7, r7, #1
 		teq	r7, #6
-		moveq	r7, #1
-		moveq	r1, #'\n'
-		movne	r1, #' '
-		ldr	r3, [stack], #-4
-		mov	r2, reg
+		moveq	r7, #0
+		adr	r3, .Lcr
+		addne	r3, r3, #1		@ skip newline
+		ldr	r2, [stack], #-4
+		mov	r1, reg
 		adr	r0, .Lfp
 		bl	printk
 2:		subs	reg, reg, #1
@@ -142,11 +142,11 @@ ENDPROC(c_backtrace)
 		blne	printk
 		ldmfd	sp!, {instr, reg, stack, r7, pc}
 
-.Lfp:		.asciz	"%cr%d:%08x"
+.Lfp:		.asciz	" r%d:%08x%s"
 .Lcr:		.asciz	"\n"
 .Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
 		.align
-.Ldsi:		.word	0xe92dd800 >> 10	@ stmfd sp!, {... fp, ip, lr, pc}
-		.word	0xe92d0000 >> 10	@ stmfd sp!, {}
+.Ldsi:		.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
+		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
 
 #endif
-- 
1.7.4.4
