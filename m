From: andy.gross@linaro.org (Andy Gross)
Date: Wed,  1 Feb 2017 11:28:27 -0600
Subject: [Patch v6 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <1485970108-14177-1-git-send-email-andy.gross@linaro.org>
References: <1485970108-14177-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1485970108-14177-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a quirk parameter to the arm_smccc_(smc/hvc) calls.
The quirk structure allows for specialized SMC operations due to SoC
specific requirements.  The current arm_smccc_(smc/hvc) is renamed and
macros are used instead to specify the standard arm_smccc_(smc/hvc) or
the arm_smccc_(smc/hvc)_quirk function.

This patch and partial implementation was suggested by Will Deacon.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/armksyms.c      |  4 ++--
 arch/arm/kernel/smccc-call.S    | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c  |  4 ++--
 arch/arm64/kernel/asm-offsets.c |  7 +++++--
 arch/arm64/kernel/smccc-call.S  | 14 ++++++++------
 include/linux/arm-smccc.h       | 40 ++++++++++++++++++++++++++++++++--------
 6 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 7e45f69..8e8d20c 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -178,6 +178,6 @@
 #endif
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
-EXPORT_SYMBOL(arm_smccc_smc);
-EXPORT_SYMBOL(arm_smccc_hvc);
+EXPORT_SYMBOL(__arm_smccc_smc);
+EXPORT_SYMBOL(__arm_smccc_hvc);
 #endif
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 2e48b67..e5d4306 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -46,17 +46,19 @@ UNWIND(	.fnend)
 /*
  * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
-ENTRY(arm_smccc_smc)
+ENTRY(__arm_smccc_smc)
 	SMCCC SMCCC_SMC
-ENDPROC(arm_smccc_smc)
+ENDPROC(__arm_smccc_smc)
 
 /*
  * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
-ENTRY(arm_smccc_hvc)
+ENTRY(__arm_smccc_hvc)
 	SMCCC SMCCC_HVC
-ENDPROC(arm_smccc_hvc)
+ENDPROC(__arm_smccc_hvc)
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 78f3680..e9c4dc9 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -73,5 +73,5 @@
 #endif
 
 	/* arm-smccc */
-EXPORT_SYMBOL(arm_smccc_smc);
-EXPORT_SYMBOL(arm_smccc_hvc);
+EXPORT_SYMBOL(__arm_smccc_smc);
+EXPORT_SYMBOL(__arm_smccc_hvc);
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index bc049af..b3bb7ef 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -143,8 +143,11 @@ int main(void)
   DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
   DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
-  DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
-  DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
+  DEFINE(ARM_SMCCC_RES_X0_OFFS,		offsetof(struct arm_smccc_res, a0));
+  DEFINE(ARM_SMCCC_RES_X2_OFFS,		offsetof(struct arm_smccc_res, a2));
+  DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
+  DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
+
   BLANK();
   DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
   DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index ae0496f..ba60a8c 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -27,17 +27,19 @@
 /*
  * void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
-ENTRY(arm_smccc_smc)
+ENTRY(__arm_smccc_smc)
 	SMCCC	smc
-ENDPROC(arm_smccc_smc)
+ENDPROC(__arm_smccc_smc)
 
 /*
  * void arm_smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
-ENTRY(arm_smccc_hvc)
+ENTRY(__arm_smccc_hvc)
 	SMCCC	hvc
-ENDPROC(arm_smccc_hvc)
+ENDPROC(__arm_smccc_hvc)
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index b5abfda..c66f8ae 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -72,33 +72,57 @@ struct arm_smccc_res {
 };
 
 /**
- * arm_smccc_smc() - make SMC calls
+ * struct arm_smccc_quirk - Contains quirk information
+ * @id: quirk identification
+ * @state: quirk specific information
+ * @a6: Qualcomm quirk entry for returning post-smc call contents of a6
+ */
+struct arm_smccc_quirk {
+	int	id;
+	union {
+		unsigned long a6;
+	} state;
+};
+
+/**
+ * __arm_smccc_smc() - make SMC calls
  * @a0-a7: arguments passed in registers 0 to 7
  * @res: result values from registers 0 to 3
+ * @quirk: points to an arm_smccc_quirk, or NULL when no quirks are required.
  *
  * This function is used to make SMC calls following SMC Calling Convention.
  * The content of the supplied param are copied to registers 0 to 7 prior
  * to the SMC instruction. The return values are updated with the content
- * from register 0 to 3 on return from the SMC instruction.
+ * from register 0 to 3 on return from the SMC instruction.  An optional
+ * quirk structure provides vendor specific behavior.
  */
-asmlinkage void arm_smccc_smc(unsigned long a0, unsigned long a1,
+asmlinkage void __arm_smccc_smc(unsigned long a0, unsigned long a1,
 			unsigned long a2, unsigned long a3, unsigned long a4,
 			unsigned long a5, unsigned long a6, unsigned long a7,
-			struct arm_smccc_res *res);
+			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
 
 /**
- * arm_smccc_hvc() - make HVC calls
+ * __arm_smccc_hvc() - make HVC calls
  * @a0-a7: arguments passed in registers 0 to 7
  * @res: result values from registers 0 to 3
  *
  * This function is used to make HVC calls following SMC Calling
  * Convention.  The content of the supplied param are copied to registers 0
  * to 7 prior to the HVC instruction. The return values are updated with
- * the content from register 0 to 3 on return from the HVC instruction.
+ * the content from register 0 to 3 on return from the HVC instruction.  An
+ * optional quirk structure provides vendor specific behavior.
  */
-asmlinkage void arm_smccc_hvc(unsigned long a0, unsigned long a1,
+asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			unsigned long a2, unsigned long a3, unsigned long a4,
 			unsigned long a5, unsigned long a6, unsigned long a7,
-			struct arm_smccc_res *res);
+			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
+
+#define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
+
+#define arm_smccc_smc_quirk(...) __arm_smccc_smc(__VA_ARGS__)
+
+#define arm_smccc_hvc(...) __arm_smccc_hvc(__VA_ARGS__, NULL)
+
+#define arm_smccc_hvc_quirk(...) __arm_smccc_hvc(__VA_ARGS__)
 
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
1.9.1
