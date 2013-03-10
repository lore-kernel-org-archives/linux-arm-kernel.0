From: hotforest@gmail.com (Tao Hou)
Date: Sun, 10 Mar 2013 10:46:37 +0800
Subject: [PATCH] ARM: fix the magic numbers used for checking the existence of
 saved caller registers
Message-ID: <1362883597-19635-1-git-send-email-hotforest@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When any backtraced function has saved the caller register r10
(e.g., show_mem), without the fix in c_backtrace all saved caller
registers of the function will not been dumped.

Signed-off-by: Tao Hou <hotforest@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/lib/backtrace.S |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index cd07b58..b4ecdd5 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -69,7 +69,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 1003:		ldr	r2, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
 		ldr	r3, .Ldsi+4		@ adjust saved 'pc' back one
-		teq	r3, r2, lsr #10		@ instruction
+		teq	r3, r2, lsr #11		@ instruction
 		subne	r0, sv_pc, #4		@ allow for mov
 		subeq	r0, sv_pc, #8		@ allow for mov + stmia
 
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
 
@@ -146,7 +146,7 @@ ENDPROC(c_backtrace)
 .Lcr:		.asciz	"\n"
 .Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
 		.align
-.Ldsi:		.word	0xe92dd800 >> 10	@ stmfd sp!, {... fp, ip, lr, pc}
-		.word	0xe92d0000 >> 10	@ stmfd sp!, {}
+.Ldsi:		.word	0xe92dd800 >> 11	@ stmfd sp!, {... fp, ip, lr, pc}
+		.word	0xe92d0000 >> 11	@ stmfd sp!, {}
 
 #endif
-- 
1.7.9.5
