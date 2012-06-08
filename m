From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:19:29 +0100
Subject: [PATCH] ARM: extable: ensure fixup entries are 4-byte aligned
Message-ID: <1339168769-30172-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixup entries in the kernel exception tables should be 4-byte aligned
since we return directly to them when handling a faulting instruction in
the kernel.

This patch adds the missing align directives to the fixup entries.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/futex.h |    1 +
 arch/arm/kernel/entry-armv.S |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 7be5469..e42cf59 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -19,6 +19,7 @@
 	"	.long	1b, 4f, 2b, 4f\n"			\
 	"	.popsection\n"					\
 	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.align	2\n"					\
 	"4:	mov	%0, " err_reg "\n"			\
 	"	b	3b\n"					\
 	"	.popsection"
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 437f0c4..0d1851c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -495,6 +495,7 @@ ENDPROC(__und_usr)
  * The out of line fixup for the ldrt above.
  */
 	.pushsection .fixup, "ax"
+	.align	2
 4:	mov	pc, r9
 	.popsection
 	.pushsection __ex_table,"a"
-- 
1.7.4.1
