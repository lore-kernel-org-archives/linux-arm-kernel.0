From: fkan@apm.com (Feng Kan)
Date: Wed, 23 Sep 2015 11:55:39 -0700
Subject: [PATCH V5 2/2] arm64: copy_to-from-in_user optimization using copy
 template
In-Reply-To: <1443034539-1848-1-git-send-email-fkan@apm.com>
References: <1443034539-1848-1-git-send-email-fkan@apm.com>
Message-ID: <1443034539-1848-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch optimize copy_to-from-in_user for arm 64bit architecture. The
copy template is used as template file for all the copy*.S files. Minor
change was made to it to accommodate the copy to/from/in user files.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Balamurugan Shanmugam <bshanmugam@apm.com>
---
 arch/arm64/lib/copy_from_user.S | 78 +++++++++++++++++++++++------------------
 arch/arm64/lib/copy_in_user.S   | 67 ++++++++++++++++++++---------------
 arch/arm64/lib/copy_to_user.S   | 67 ++++++++++++++++++++---------------
 3 files changed, 120 insertions(+), 92 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 1be9ef2..4699cd7 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -18,6 +18,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -31,49 +32,58 @@
  * Returns:
  *	x0 - bytes not copied
  */
+
+	.macro ldrb1 ptr, regB, val
+	USER(9998f, ldrb  \ptr, [\regB], \val)
+	.endm
+
+	.macro strb1 ptr, regB, val
+	strb \ptr, [\regB], \val
+	.endm
+
+	.macro ldrh1 ptr, regB, val
+	USER(9998f, ldrh  \ptr, [\regB], \val)
+	.endm
+
+	.macro strh1 ptr, regB, val
+	strh \ptr, [\regB], \val
+	.endm
+
+	.macro ldr1 ptr, regB, val
+	USER(9998f, ldr \ptr, [\regB], \val)
+	.endm
+
+	.macro str1 ptr, regB, val
+	str \ptr, [\regB], \val
+	.endm
+
+	.macro ldp1 ptr, regB, regC, val
+	USER(9998f, ldp \ptr, \regB, [\regC], \val)
+	.endm
+
+	.macro stp1 ptr, regB, regC, val
+	stp \ptr, \regB, [\regC], \val
+	.endm
+
+end	.req	x5
 ENTRY(__copy_from_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x1, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-USER(9f, ldp	x3, x4, [x1], #16)
-	subs	x2, x2, #16
-	stp	x3, x4, [x0], #16
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-USER(9f, ldr	x3, [x1], #8	)
-	sub	x2, x2, #8
-	str	x3, [x0], #8
-2:	adds	x2, x2, #4
-	b.mi	3f
-USER(9f, ldr	w3, [x1], #4	)
-	sub	x2, x2, #4
-	str	w3, [x0], #4
-3:	adds	x2, x2, #2
-	b.mi	4f
-USER(9f, ldrh	w3, [x1], #2	)
-	sub	x2, x2, #2
-	strh	w3, [x0], #2
-4:	adds	x2, x2, #1
-	b.mi	5f
-USER(9f, ldrb	w3, [x1]	)
-	strb	w3, [x0]
-5:	mov	x0, #0
+	add	end, x0, x2
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__copy_from_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x2, x5, x1
-	mov	x3, x2
-10:	strb	wzr, [x0], #1			// zero remaining buffer space
-	subs	x3, x3, #1
-	b.ne	10b
-	mov	x0, x2				// bytes not copied
+9998:
+	sub	x0, end, dst
+9999:
+	strb	wzr, [dst], #1			// zero remaining buffer space
+	cmp	dst, end
+	b.lo	9999b
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 1b94661e..81c8fc9 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -20,6 +20,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -33,44 +34,52 @@
  * Returns:
  *	x0 - bytes not copied
  */
+	.macro ldrb1 ptr, regB, val
+	USER(9998f, ldrb  \ptr, [\regB], \val)
+	.endm
+
+	.macro strb1 ptr, regB, val
+	USER(9998f, strb \ptr, [\regB], \val)
+	.endm
+
+	.macro ldrh1 ptr, regB, val
+	USER(9998f, ldrh  \ptr, [\regB], \val)
+	.endm
+
+	.macro strh1 ptr, regB, val
+	USER(9998f, strh \ptr, [\regB], \val)
+	.endm
+
+	.macro ldr1 ptr, regB, val
+	USER(9998f, ldr \ptr, [\regB], \val)
+	.endm
+
+	.macro str1 ptr, regB, val
+	USER(9998f, str \ptr, [\regB], \val)
+	.endm
+
+	.macro ldp1 ptr, regB, regC, val
+	USER(9998f, ldp \ptr, \regB, [\regC], \val)
+	.endm
+
+	.macro stp1 ptr, regB, regC, val
+	USER(9998f, stp \ptr, \regB, [\regC], \val)
+	.endm
+
+end	.req	x5
 ENTRY(__copy_in_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-USER(9f, ldp	x3, x4, [x1], #16)
-	subs	x2, x2, #16
-USER(9f, stp	x3, x4, [x0], #16)
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-USER(9f, ldr	x3, [x1], #8	)
-	sub	x2, x2, #8
-USER(9f, str	x3, [x0], #8	)
-2:	adds	x2, x2, #4
-	b.mi	3f
-USER(9f, ldr	w3, [x1], #4	)
-	sub	x2, x2, #4
-USER(9f, str	w3, [x0], #4	)
-3:	adds	x2, x2, #2
-	b.mi	4f
-USER(9f, ldrh	w3, [x1], #2	)
-	sub	x2, x2, #2
-USER(9f, strh	w3, [x0], #2	)
-4:	adds	x2, x2, #1
-	b.mi	5f
-USER(9f, ldrb	w3, [x1]	)
-USER(9f, strb	w3, [x0]	)
-5:	mov	x0, #0
+	add	end, x0, x2
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0
 	ret
 ENDPROC(__copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x5, x0			// bytes not copied
+9998:	sub	x0, end, dst			// bytes not copied
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index a257b47..7512bbb 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -18,6 +18,7 @@
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cache.h>
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
@@ -31,44 +32,52 @@
  * Returns:
  *	x0 - bytes not copied
  */
+	.macro ldrb1 ptr, regB, val
+	ldrb  \ptr, [\regB], \val
+	.endm
+
+	.macro strb1 ptr, regB, val
+	USER(9998f, strb \ptr, [\regB], \val)
+	.endm
+
+	.macro ldrh1 ptr, regB, val
+	ldrh  \ptr, [\regB], \val
+	.endm
+
+	.macro strh1 ptr, regB, val
+	USER(9998f, strh \ptr, [\regB], \val)
+	.endm
+
+	.macro ldr1 ptr, regB, val
+	ldr \ptr, [\regB], \val
+	.endm
+
+	.macro str1 ptr, regB, val
+	USER(9998f, str \ptr, [\regB], \val)
+	.endm
+
+	.macro ldp1 ptr, regB, regC, val
+	ldp \ptr, \regB, [\regC], \val
+	.endm
+
+	.macro stp1 ptr, regB, regC, val
+	USER(9998f, stp \ptr, \regB, [\regC], \val)
+	.endm
+
+end	.req	x5
 ENTRY(__copy_to_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
-	add	x5, x0, x2			// upper user buffer boundary
-	subs	x2, x2, #16
-	b.mi	1f
-0:
-	ldp	x3, x4, [x1], #16
-	subs	x2, x2, #16
-USER(9f, stp	x3, x4, [x0], #16)
-	b.pl	0b
-1:	adds	x2, x2, #8
-	b.mi	2f
-	ldr	x3, [x1], #8
-	sub	x2, x2, #8
-USER(9f, str	x3, [x0], #8	)
-2:	adds	x2, x2, #4
-	b.mi	3f
-	ldr	w3, [x1], #4
-	sub	x2, x2, #4
-USER(9f, str	w3, [x0], #4	)
-3:	adds	x2, x2, #2
-	b.mi	4f
-	ldrh	w3, [x1], #2
-	sub	x2, x2, #2
-USER(9f, strh	w3, [x0], #2	)
-4:	adds	x2, x2, #1
-	b.mi	5f
-	ldrb	w3, [x1]
-USER(9f, strb	w3, [x0]	)
-5:	mov	x0, #0
+	add	end, x0, x2
+#include "copy_template.S"
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
 	    CONFIG_ARM64_PAN)
+	mov	x0, #0
 	ret
 ENDPROC(__copy_to_user)
 
 	.section .fixup,"ax"
 	.align	2
-9:	sub	x0, x5, x0			// bytes not copied
+9998:	sub	x0, end, dst			// bytes not copied
 	ret
 	.previous
-- 
1.9.1
