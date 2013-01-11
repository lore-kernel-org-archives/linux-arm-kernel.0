From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:15 +0000
Subject: [PATCH 4/6] ARM: virt: avoid clobbering lr when forcing svc mode
In-Reply-To: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1357918457-20469-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The safe_svcmode_maskall macro is used to ensure that we are running in
svc mode, causing an exception return from hvc mode if required.

This patch removes the unneeded lr clobber from the macro and operates
entirely on the temporary parameter register instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[will: updated comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/assembler.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index eb87200..05ee9ee 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -246,18 +246,14 @@
  *
  * This macro is intended for forcing the CPU into SVC mode at boot time.
  * you cannot return to the original mode.
- *
- * Beware, it also clobers LR.
  */
 .macro safe_svcmode_maskall reg:req
 #if __LINUX_ARM_ARCH__ >= 6
 	mrs	\reg , cpsr
-	mov	lr , \reg
-	and	lr , lr , #MODE_MASK
-	cmp	lr , #HYP_MODE
-	orr	\reg , \reg , #PSR_I_BIT | PSR_F_BIT
+	eor	\reg, \reg, #HYP_MODE
+	tst	\reg, #MODE_MASK
 	bic	\reg , \reg , #MODE_MASK
-	orr	\reg , \reg , #SVC_MODE
+	orr	\reg , \reg , #PSR_I_BIT | PSR_F_BIT | SVC_MODE
 THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	bne	1f
 	orr	\reg, \reg, #PSR_A_BIT
-- 
1.8.0
