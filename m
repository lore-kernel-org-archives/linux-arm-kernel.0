From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:17:57 +0900
Subject: [PATCH 03/08] ARM: Make alignment_trap macro self-contained
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071757.28048.71028.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the .LCcralign dependency from the aligment_trap
macro. Needed to create multiple __irq_usr instances.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/entry-header.S |    6 +++++-
 arch/arm/kernel/entry-armv.S        |    2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

--- 0003/arch/arm/include/asm/entry-header.S
+++ work/arch/arm/include/asm/entry-header.S	2010-10-06 15:06:16.000000000 +0900
@@ -38,9 +38,13 @@
 
 	.macro	alignment_trap, rtemp
 #ifdef CONFIG_ALIGNMENT_TRAP
-	ldr	\rtemp, .LCcralign
+	ldr	\rtemp, 1f
 	ldr	\rtemp, [\rtemp]
 	mcr	p15, 0, \rtemp, c1, c0
+	b	2f
+1:
+	.word	cr_alignment
+2:
 #endif
 	.endm
 
--- 0003/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-06 14:28:47.000000000 +0900
@@ -255,8 +255,6 @@ __pabt_svc:
 ENDPROC(__pabt_svc)
 
 	.align	5
-.LCcralign:
-	.word	cr_alignment
 #ifdef MULTI_DABORT
 .LCprocfns:
 	.word	processor
