From: james.morse@arm.com (James Morse)
Date: Tue,  2 Feb 2016 17:03:31 +0000
Subject: [PATCH v1 5/5] arm64: kernel: Don't toggle PAN on systems with UAO
In-Reply-To: <1454432611-21333-1-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
Message-ID: <1454432611-21333-6-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a CPU supports both Privileged Access Never (PAN) and User Access
Override (UAO), we don't need to disable/re-enable PAN round all
copy_to_user() like calls.

UAO alternatives cause these calls to use the 'unprivileged' load/store
instructions, which are overridden to be the privileged kind when
fs==KERNEL_DS.

This patch changes the copy_to_user() calls to have their PAN toggling
depend on a new composite 'feature' ARM64_ALT_PAN_NOT_UAO.

If both features are detected, PAN will be enabled, but the copy_to_user()
alternatives will not be applied. This means PAN will be enabled all the
time for these functions. If only PAN is detected, the toggling will be
enabled as normal.

This will save the time taken to disable/re-enable PAN, and allow us to
catch copy_to_user() accesses that occur with fs==KERNEL_DS.

Futex and swp-emulation code continue to hang their PAN toggling code on
ARM64_HAS_PAN.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/include/asm/uaccess.h    |  8 ++++----
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 arch/arm64/lib/clear_user.S         |  4 ++--
 arch/arm64/lib/copy_from_user.S     |  4 ++--
 arch/arm64/lib/copy_in_user.S       |  4 ++--
 arch/arm64/lib/copy_to_user.S       |  4 ++--
 arch/arm64/mm/fault.c               |  3 +++
 8 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 349e8203d16e..7ae0d90a21ed 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -31,8 +31,9 @@
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
 #define ARM64_HAS_UAO				8
+#define ARM64_ALT_PAN_NOT_UAO			9
 
-#define ARM64_NCAPS				9
+#define ARM64_NCAPS				10
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index f973bdce8410..16ba0d5c9740 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -145,7 +145,7 @@ static inline void set_fs(mm_segment_t fs)
 do {									\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(ptr);						\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_ALT_PAN_NOT_UAO,\
 			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
@@ -168,7 +168,7 @@ do {									\
 		BUILD_BUG();						\
 	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_ALT_PAN_NOT_UAO,\
 			CONFIG_ARM64_PAN));				\
 } while (0)
 
@@ -217,7 +217,7 @@ do {									\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_ALT_PAN_NOT_UAO,\
 			CONFIG_ARM64_PAN));				\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
@@ -239,7 +239,7 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_ALT_PAN_NOT_UAO,\
 			CONFIG_ARM64_PAN));				\
 } while (0)
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index caecc9a81b82..3456f0847a3c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -67,6 +67,10 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 		.width = 0,				\
 	}
 
+/* meta feature for alternatives */
+static bool __maybe_unused
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
+
 static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
@@ -671,6 +675,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.enable = cpu_enable_uao,
 	},
 #endif /* CONFIG_ARM64_UAO */
+#ifdef CONFIG_ARM64_PAN
+	{
+		.capability = ARM64_ALT_PAN_NOT_UAO,
+		.matches = cpufeature_pan_not_uao,
+	},
+#endif /* CONFIG_ARM64_PAN */
 	{},
 };
 
@@ -962,3 +972,9 @@ void cpu_enable_uao(void *__unused)
 	asm(SET_PSTATE_UAO(1));
 }
 #endif /* CONFIG_ARM64_UAO */
+
+static bool __maybe_unused
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry)
+{
+	return (cpus_have_cap(ARM64_HAS_PAN) && !cpus_have_cap(ARM64_HAS_UAO));
+}
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 3f950b677c07..5d1cad3ce6d6 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -33,7 +33,7 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__clear_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
@@ -54,7 +54,7 @@ uao_user_alternative 9f, strh, sttrh, wzr, x0, 2
 	b.mi	5f
 uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 5:	mov	x0, #0
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__clear_user)
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 1d982d64f1a7..17e8306dca29 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -67,11 +67,11 @@
 
 end	.req	x5
 ENTRY(__copy_from_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	mov	x0, #0				// Nothing to copy
 	ret
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index feaad1520dc1..f7292dd08c84 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -68,11 +68,11 @@
 
 end	.req	x5
 ENTRY(__copy_in_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	mov	x0, #0
 	ret
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 2dae2cd2c481..21faae60f988 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -66,11 +66,11 @@
 
 end	.req	x5
 ENTRY(__copy_to_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	mov	x0, #0
 	ret
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5ce2656b04df..5dd40909cbce 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -234,6 +234,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	if (permission_fault(esr) && (addr < USER_DS)) {
+		if (get_thread_info(regs->sp)->addr_limit == KERNEL_DS)
+			panic("Accessing user space memory with fs=KERNEL_DS");
+
 		if (!search_exception_tables(regs->pc))
 			panic("Accessing user space memory outside uaccess.h routines");
 	}
-- 
2.6.2
