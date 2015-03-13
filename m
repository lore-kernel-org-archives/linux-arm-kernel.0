From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Mar 2015 13:07:31 +0100
Subject: [PATCH v2 7/8] ARM: keep .text and .fixup regions together
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426248452-4773-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves all fixup snippets to the .text.fixup section, which is
a special section that gets emitted along with the .text section
for each input object file, i.e., the snippets are kept much closer
to the code they refer to, which helps prevent linker failure on
large kernels.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/futex.h          |  2 +-
 arch/arm/include/asm/uaccess.h        | 10 +++++-----
 arch/arm/include/asm/word-at-a-time.h |  2 +-
 arch/arm/kernel/entry-armv.S          |  2 +-
 arch/arm/kernel/swp_emulate.c         |  2 +-
 arch/arm/kernel/vmlinux.lds.S         |  5 +----
 arch/arm/lib/clear_user.S             |  2 +-
 arch/arm/lib/copy_to_user.S           |  2 +-
 arch/arm/lib/csumpartialcopyuser.S    |  2 +-
 arch/arm/mm/alignment.c               |  6 +++---
 arch/arm/nwfpe/entry.S                |  2 +-
 11 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 53e69dae796f..4e78065a16aa 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -13,7 +13,7 @@
 	"	.align	3\n"					\
 	"	.long	1b, 4f, 2b, 4f\n"			\
 	"	.popsection\n"					\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"4:	mov	%0, " err_reg "\n"			\
 	"	b	3b\n"					\
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index ce0786efd26c..74b17d09ef7a 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -315,7 +315,7 @@ do {									\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(ldrb) "	%1,[%2],#0\n"			\
 	"2:\n"							\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"3:	mov	%0, %3\n"				\
 	"	mov	%1, #0\n"				\
@@ -351,7 +351,7 @@ do {									\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(ldr) "	%1,[%2],#0\n"			\
 	"2:\n"							\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"3:	mov	%0, %3\n"				\
 	"	mov	%1, #0\n"				\
@@ -397,7 +397,7 @@ do {									\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(strb) "	%1,[%2],#0\n"			\
 	"2:\n"							\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"3:	mov	%0, %3\n"				\
 	"	b	2b\n"					\
@@ -430,7 +430,7 @@ do {									\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(str) "	%1,[%2],#0\n"			\
 	"2:\n"							\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"3:	mov	%0, %3\n"				\
 	"	b	2b\n"					\
@@ -458,7 +458,7 @@ do {									\
  THUMB(	"1:	" TUSER(str) "	" __reg_oper1 ", [%1]\n"	) \
  THUMB(	"2:	" TUSER(str) "	" __reg_oper0 ", [%1, #4]\n"	) \
 	"3:\n"							\
-	"	.pushsection .fixup,\"ax\"\n"			\
+	"	.pushsection .text.fixup,\"ax\"\n"		\
 	"	.align	2\n"					\
 	"4:	mov	%0, %3\n"				\
 	"	b	3b\n"					\
diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index a6d0a29861e7..5831dce4b51c 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -71,7 +71,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	asm(
 	"1:	ldr	%0, [%2]\n"
 	"2:\n"
-	"	.pushsection .fixup,\"ax\"\n"
+	"	.pushsection .text.fixup,\"ax\"\n"
 	"	.align 2\n"
 	"3:	and	%1, %2, #0x3\n"
 	"	bic	%2, %2, #0x3\n"
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 672b21942fff..570306c49406 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -545,7 +545,7 @@ ENDPROC(__und_usr)
 /*
  * The out of line fixup for the ldrt instructions above.
  */
-	.pushsection .fixup, "ax"
+	.pushsection .text.fixup, "ax"
 	.align	2
 4:	str     r4, [sp, #S_PC]			@ retry current instruction
 	ret	r9
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index afdd51e30bec..1361756782c7 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -42,7 +42,7 @@
 	"	cmp		%0, #0\n"			\
 	"	movne		%0, %4\n"			\
 	"2:\n"							\
-	"	.section	 .fixup,\"ax\"\n"		\
+	"	.section	 .text.fixup,\"ax\"\n"		\
 	"	.align		2\n"				\
 	"3:	mov		%0, %5\n"			\
 	"	b		2b\n"				\
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 2e7b2220ef5f..82846f60e31e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -77,7 +77,7 @@ SECTIONS
 		ARM_EXIT_DISCARD(EXIT_DATA)
 		EXIT_CALL
 #ifndef CONFIG_MMU
-		*(.fixup)
+		*(.text.fixup)
 		*(__ex_table)
 #endif
 #ifndef CONFIG_SMP_ON_UP
@@ -112,9 +112,6 @@ SECTIONS
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
-#ifdef CONFIG_MMU
-			*(.fixup)
-#endif
 			*(.gnu.warning)
 			*(.glue_7)
 			*(.glue_7t)
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index 14a0d988c82c..1710fd7db2d5 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -47,7 +47,7 @@ USER(		strnebt	r2, [r0])
 ENDPROC(__clear_user)
 ENDPROC(__clear_user_std)
 
-		.pushsection .fixup,"ax"
+		.pushsection .text.fixup,"ax"
 		.align	0
 9001:		ldmfd	sp!, {r0, pc}
 		.popsection
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index a9d3db16ecb5..9648b0675a3e 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -100,7 +100,7 @@ WEAK(__copy_to_user)
 ENDPROC(__copy_to_user)
 ENDPROC(__copy_to_user_std)
 
-	.pushsection .fixup,"ax"
+	.pushsection .text.fixup,"ax"
 	.align 0
 	copy_abort_preamble
 	ldmfd	sp!, {r1, r2, r3}
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 7d08b43d2c0e..1d0957e61f89 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -68,7 +68,7 @@
  * so properly, we would have to add in whatever registers were loaded before
  * the fault, which, with the current asm above is not predictable.
  */
-		.pushsection .fixup,"ax"
+		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
 		ldr	r5, [sp, #8*4]		@ *err_ptr
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 2c0c541c60ca..9769f1eefe3b 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -201,7 +201,7 @@ union offset_union {
  THUMB(	"1:	"ins"	%1, [%2]\n"	)		\
  THUMB(	"	add	%2, %2, #1\n"	)		\
 	"2:\n"						\
-	"	.pushsection .fixup,\"ax\"\n"		\
+	"	.pushsection .text.fixup,\"ax\"\n"	\
 	"	.align	2\n"				\
 	"3:	mov	%0, #1\n"			\
 	"	b	2b\n"				\
@@ -261,7 +261,7 @@ union offset_union {
 		"	mov	%1, %1, "NEXT_BYTE"\n"		\
 		"2:	"ins"	%1, [%2]\n"			\
 		"3:\n"						\
-		"	.pushsection .fixup,\"ax\"\n"		\
+		"	.pushsection .text.fixup,\"ax\"\n"	\
 		"	.align	2\n"				\
 		"4:	mov	%0, #1\n"			\
 		"	b	3b\n"				\
@@ -301,7 +301,7 @@ union offset_union {
 		"	mov	%1, %1, "NEXT_BYTE"\n"		\
 		"4:	"ins"	%1, [%2]\n"			\
 		"5:\n"						\
-		"	.pushsection .fixup,\"ax\"\n"		\
+		"	.pushsection .text.fixup,\"ax\"\n"	\
 		"	.align	2\n"				\
 		"6:	mov	%0, #1\n"			\
 		"	b	5b\n"				\
diff --git a/arch/arm/nwfpe/entry.S b/arch/arm/nwfpe/entry.S
index 5d65be1f1e8a..71df43547659 100644
--- a/arch/arm/nwfpe/entry.S
+++ b/arch/arm/nwfpe/entry.S
@@ -113,7 +113,7 @@ next:
 	@ to fault.  Emit the appropriate exception gunk to fix things up.
 	@ ??? For some reason, faults can happen at .Lx2 even with a
 	@ plain LDR instruction.  Weird, but it seems harmless.
-	.pushsection .fixup,"ax"
+	.pushsection .text.fixup,"ax"
 	.align	2
 .Lfix:	ret	r9			@ let the user eat segfaults
 	.popsection
-- 
1.8.3.2
