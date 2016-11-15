From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 15 Nov 2016 15:01:33 +0000
Subject: [PATCH] ARM: fix backtrace
Message-ID: <E1c6fEr-0006WQ-Ly@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent kernels have changed their behaviour to be more inconsistent
when handling printk continuations.  With todays kernels, the output
looks sane on the console, but dmesg splits individual printk()s which
do not have the KERN_CONT prefix into separate lines.

Since the assembly code is not trivial to add the KERN_CONT, and we
ideally want to avoid using KERN_CONT (as multiple printk()s can race
between different threads), convert the assembly dumping the register
values to C code, and have the C code build the output a line at a
time before dumping to the console.

This avoids the KERN_CONT issue, and also avoids situations where the
output is intermixed with other console activity.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Noticed due to a NFS bug in 4.9-rc.

 arch/arm/kernel/traps.c  | 20 ++++++++++++++++++++
 arch/arm/lib/backtrace.S | 37 +++----------------------------------
 2 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 2771ba243f36..ff2ae872d555 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -75,6 +75,26 @@ void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long
 		dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
 }
 
+void dump_backtrace_stm(u32 *stack, u32 instruction)
+{
+	char str[80], *p;
+	unsigned int x;
+	int reg;
+
+	for (reg = 10, x = 0, p = str; reg >= 0; reg--) {
+		if (instruction & BIT(reg)) {
+			p += sprintf(p, " r%d:%08x", reg, *stack--);
+			if (++x == 6) {
+				x = 0;
+				p = str;
+				printk("%s\n", str);
+			}
+		}
+	}
+	if (p != str)
+		printk("%s\n", str);
+}
+
 #ifndef CONFIG_ARM_UNWIND
 /*
  * Stack pointers should always be within the kernels view of
diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index fab5a50503ae..7d7952e5a3b1 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -10,6 +10,7 @@
  * 27/03/03 Ian Molton Clean up CONFIG_CPU
  *
  */
+#include <linux/kern_levels.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 		.text
@@ -83,13 +84,13 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 		teq	r3, r1, lsr #11
 		ldreq	r0, [frame, #-8]	@ get sp
 		subeq	r0, r0, #4		@ point at the last arg
-		bleq	.Ldumpstm		@ dump saved registers
+		bleq	dump_backtrace_stm	@ dump saved registers
 
 1004:		ldr	r1, [sv_pc, #0]		@ if stmfd sp!, {..., fp, ip, lr, pc}
 		ldr	r3, .Ldsi		@ instruction exists,
 		teq	r3, r1, lsr #11
 		subeq	r0, frame, #16
-		bleq	.Ldumpstm		@ dump saved registers
+		bleq	dump_backtrace_stm	@ dump saved registers
 
 		teq	sv_fp, #0		@ zero saved fp means
 		beq	no_frame		@ no further frames
@@ -112,38 +113,6 @@ ENDPROC(c_backtrace)
 		.long	1004b, 1006b
 		.popsection
 
-#define instr r4
-#define reg   r5
-#define stack r6
-
-.Ldumpstm:	stmfd	sp!, {instr, reg, stack, r7, lr}
-		mov	stack, r0
-		mov	instr, r1
-		mov	reg, #10
-		mov	r7, #0
-1:		mov	r3, #1
- ARM(		tst	instr, r3, lsl reg	)
- THUMB(		lsl	r3, reg			)
- THUMB(		tst	instr, r3		)
-		beq	2f
-		add	r7, r7, #1
-		teq	r7, #6
-		moveq	r7, #0
-		adr	r3, .Lcr
-		addne	r3, r3, #1		@ skip newline
-		ldr	r2, [stack], #-4
-		mov	r1, reg
-		adr	r0, .Lfp
-		bl	printk
-2:		subs	reg, reg, #1
-		bpl	1b
-		teq	r7, #0
-		adrne	r0, .Lcr
-		blne	printk
-		ldmfd	sp!, {instr, reg, stack, r7, pc}
-
-.Lfp:		.asciz	" r%d:%08x%s"
-.Lcr:		.asciz	"\n"
 .Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
 		.align
 .Ldsi:		.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
-- 
2.7.4
