From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Thu, 16 Feb 2012 17:02:05 +0100
Subject: [PATCH] ARM: prevent misaligning of stack by c_backtrace()
Message-ID: <1329408125-4414-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

c_backtrace() calls printk() with a misaligned stack which can cause

 |  WARNING: at arch/arm/mach-mmp/trizeps6/trizeps6.c:193 trizeps6_init+0x88/0x2c0()
 |  Modules linked in:
 |  Backtrace:
 |  [<c000c588>] (dump_backtrace+0x0/0x118) from [<c02fff30>] (dump_stack+0x20/0x24)
 |  BUG: recent printk recursion!
 |  ...
 |  Backtrace:
 |  [<c01ea28c>] (number.isra.6+0x0/0x314) from [<c01eaec0>] (vsnprintf+0x350/0x398)
 |  [<c01eab70>] (vsnprintf+0x0/0x398) from [<c01eaf9c>] (vscnprintf+0x14/0x2c)
 |  [<c01eaf88>] (vscnprintf+0x0/0x2c) from [<c00188a0>] (vprintk+0x150/0x3d0)
 |  Unhandled fault: alignment exception (0x803) at 0xc7839a14

on < ARMv6 machines (above has been seen on a pxa168).

The '.Ldumpstm' location is entered with a correctly, 8 byte aligned
stack but pushed 5 * 4 bytes on it before calling printk().  The

 |       strd    r2, [fp, #-124] ; 0xffffff84

which is executed there assumes an 8 byte stack and throws an exception
on < ARMv6 architectures.

Patch pushes a dummy word on the stack to ensure correct alignment.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/lib/backtrace.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index cd07b58..c9e1470 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -115,8 +115,9 @@ ENDPROC(c_backtrace)
 #define instr r4
 #define reg   r5
 #define stack r6
+#define dummy r8			/* prevent misaligned stack */
 
-.Ldumpstm:	stmfd	sp!, {instr, reg, stack, r7, lr}
+.Ldumpstm:	stmfd	sp!, {instr, reg, stack, r7, dummy, lr}
 		mov	stack, r0
 		mov	instr, r1
 		mov	reg, #10
@@ -140,7 +141,7 @@ ENDPROC(c_backtrace)
 		teq	r7, #0
 		adrne	r0, .Lcr
 		blne	printk
-		ldmfd	sp!, {instr, reg, stack, r7, pc}
+		ldmfd	sp!, {instr, reg, stack, r7, dummy, pc}
 
 .Lfp:		.asciz	"%cr%d:%08x"
 .Lcr:		.asciz	"\n"
-- 
1.7.7.6
