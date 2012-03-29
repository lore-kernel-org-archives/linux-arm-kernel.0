From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Mar 2012 00:00:24 -0400
Subject: [PATCH 4/4] ARM: option to select LDRD/STRD optimized memory copy
In-Reply-To: <1332993624-16552-1-git-send-email-nico@fluxnic.net>
References: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
 <1332993624-16552-1-git-send-email-nico@fluxnic.net>
Message-ID: <1332993624-16552-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Because STRD requires a 64-bit aligned destination pointer, we
unconditionally enable the cache alignment code.

Same concern with LDRD, but we conditionally execute them or the LDM
fallback depending on the source pointer alignment.

Obviously, this could be optimized further by duplicating each loop and
increasing the code.  Convincing benchmarks would be in order before
doing so.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/Kconfig              |    9 +++++++++
 arch/arm/lib/copy_from_user.S |   15 ++++++++++++++-
 arch/arm/lib/copy_template.S  |    3 +++
 arch/arm/lib/copy_to_user.S   |   11 ++++++++++-
 arch/arm/lib/memcpy.S         |   26 ++++++++++++++++++++++++--
 5 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5098564d58..b87069730a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1826,6 +1826,15 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config USE_LDRDSTRD_OVER_LDMSTM
+	bool "Use 64-bit access instructions to optimize memory copy"
+	depends on CPU_V7
+	help
+	  Some processors, notably the Cortex-A15, are known to perform
+	  better when accessing memory using LDRD/STRD instructions instead
+	  of LDM/STM.  Select this to optimize memory copy routines
+	  accordingly.
+
 config SECCOMP
 	bool
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index d1df0ec62b..375cbbf0e5 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -40,6 +40,12 @@
 #endif
 #define STR1W_SHIFT	0
 
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+/* Enforce destination cache line alignment */
+#undef CALGN
+#define CALGN(x...) x
+#endif
+
 	.macro ldr1w ptr reg abort
 	ldrusr	\reg, \ptr, 4, abort=\abort
 	.endm
@@ -64,7 +70,14 @@
 	.endm
 
 	.macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
-	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+	strd	\reg1, \reg2, [\ptr], #8
+	strd	\reg3, \reg4, [\ptr], #8
+	strd	\reg5, \reg6, [\ptr], #8
+	strd	\reg7, \reg8, [\ptr], #8
+#else
+	stmia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#endif
 	.endm
 
 	.macro str1b ptr reg cond=al abort
diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
index f6f42c3330..6a9823d51f 100644
--- a/arch/arm/lib/copy_template.S
+++ b/arch/arm/lib/copy_template.S
@@ -63,6 +63,9 @@
  *	Correction to be applied to the "ip" register when branching into
  *	the ldr1w or str1w instructions (some of these macros may expand to
  *	more than one 32bit instruction in Thumb-2)
+ *
+ * Note: ldr8w is the only accessor that is allowed to change the
+ * condition code. 
  */
 
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index a83bc04365..11534edea1 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -45,7 +45,16 @@
 	.endm
 
 	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
-	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+	tst	\ptr, #7
+	ldreqd	\reg1, \reg2, [\ptr], #8
+	ldreqd	\reg3, \reg4, [\ptr], #8
+	ldreqd	\reg5, \reg6, [\ptr], #8
+	ldreqd	\reg7, \reg8, [\ptr], #8
+	ldmneia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#else
+	ldmia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#endif
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index adbccc6e2d..db49a300c8 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -16,12 +16,27 @@
 #define LDR1W_SHIFT	0
 #define STR1W_SHIFT	0
 
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+/* Enforce destination cache line alignment */
+#undef CALGN
+#define CALGN(x...) x
+#endif
+
 	.macro ldr1w ptr reg abort
 	W(ldr) \reg, [\ptr], #4
 	.endm
 
 	.macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
-	ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+	tst	\ptr, #7
+	ldreqd	\reg1, \reg2, [\ptr], #8
+	ldreqd	\reg3, \reg4, [\ptr], #8
+	ldreqd	\reg5, \reg6, [\ptr], #8
+	ldreqd	\reg7, \reg8, [\ptr], #8
+	ldmneia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#else
+	ldmia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#endif
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
@@ -33,7 +48,14 @@
 	.endm
 
 	.macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
-	stmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#ifdef CONFIG_USE_LDRDSTRD_OVER_LDMSTM
+	strd	\reg1, \reg2, [\ptr], #8
+	strd	\reg3, \reg4, [\ptr], #8
+	strd	\reg5, \reg6, [\ptr], #8
+	strd	\reg7, \reg8, [\ptr], #8
+#else
+	stmia	\ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \reg7, \reg8}
+#endif
 	.endm
 
 	.macro str1b ptr reg cond=al abort
-- 
1.7.9.rc2
