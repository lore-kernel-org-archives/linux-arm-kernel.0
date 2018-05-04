From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Fri,  4 May 2018 13:16:27 +0900
Subject: [BUGFIX PATCH v3 4/4] arm: kprobes: Prohibit kprobes on get_user
 functions
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
Message-ID: <152540738682.29650.10638462666953783065.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since do_undefinstr() uses get_user to get the undefined
instruction, it can be called before kprobes processes
recursive check. This can cause an infinit recursive
exception.
Prohibit probing on get_user functions.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable at vger.kernel.org
---
 Changes in v2:
  - Fix to add _ASM_NOKPROBE() definition for
    !CONFIG_KPROBES.
---
 arch/arm/include/asm/assembler.h |   10 ++++++++++
 arch/arm/lib/getuser.S           |   10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index bc8d4bbd82e2..9342904cccca 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -536,4 +536,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(entry)				\
+	.pushsection "_kprobe_blacklist", "aw" ;	\
+	.balign 4 ;					\
+	.long entry;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(entry)
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index df73914e81c8..746e7801dcdf 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -38,6 +38,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
+_ASM_NOKPROBE(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +59,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
+_ASM_NOKPROBE(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,6 +67,7 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
+_ASM_NOKPROBE(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad8
@@ -78,6 +81,7 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
+_ASM_NOKPROBE(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -91,6 +95,7 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
+_ASM_NOKPROBE(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -98,6 +103,7 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
+_ASM_NOKPROBE(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -114,6 +120,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
+_ASM_NOKPROBE(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -121,6 +128,7 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
+_ASM_NOKPROBE(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -131,6 +139,8 @@ __get_user_bad:
 	ret	lr
 ENDPROC(__get_user_bad)
 ENDPROC(__get_user_bad8)
+_ASM_NOKPROBE(__get_user_bad)
+_ASM_NOKPROBE(__get_user_bad8)
 
 .pushsection __ex_table, "a"
 	.long	1b, __get_user_bad
