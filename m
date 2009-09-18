From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri, 18 Sep 2009 18:55:45 +0400
Subject: [PATCH] arm: fix compilation of entry-common.S for older CPUs
Message-ID: <1253285745-4198-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 181f817eaaca4c1f introduced some new code to entry-common.S
Sadly, this new code uses 'bx' instruction which is available only on
ARMv5 and higher CPUs. This causes following compilation errors when
building kernel for StrongARM (ARMv4):

arch/arm/kernel/entry-common.S: Assembler messages:
arch/arm/kernel/entry-common.S:129: Error: selected processor does not
 support `bx ip'
arch/arm/kernel/entry-common.S:138: Error: selected processor does not
 support `bx ip'

Fix these errors by using 'mov pc' instead of 'bx'.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/kernel/entry-common.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Please note that I haven't tested this change on hardware as I don't
have needed toolchain (GCC 4.4+).

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 807cfeb..825db52 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -126,7 +126,7 @@ ENTRY(__gnu_mcount_nc)
 	cmp r0, r2
 	bne gnu_trace
 	ldmia sp!, {r0-r3, ip, lr}
-	bx ip
+	mov pc, ip
 
 gnu_trace:
 	ldr r1, [sp, #20]			@ lr of instrumented routine
@@ -135,7 +135,7 @@ gnu_trace:
 	mov lr, pc
 	mov pc, r2
 	ldmia sp!, {r0-r3, ip, lr}
-	bx ip
+	mov pc, ip
 
 ENTRY(mcount)
 	stmdb sp!, {r0-r3, lr}
-- 
1.6.3.4
