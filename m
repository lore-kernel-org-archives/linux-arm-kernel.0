From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Wed, 19 Sep 2018 09:04:10 +0530
Subject: [PATCH 3/3] arm64/cpufeatures: Emulate MRS instructions by parsing
 ESR_ELx.ISS
In-Reply-To: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
References: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537328050-29176-4-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armv8.4-A extension enables MRS instruction encodings inside ESR_ELx.ISS
during exception class ESR_ELx_EC_SYS64 (0x18). This encoding can be used
to emulate MRS instructions which can avoid fetch/decode from user space
thus improving performance. This adds a new sys64_hook structure element
with applicable ESR mask/value pair for MRS instructions on various system
registers but constrained by sysreg encodings which is currently allowed
to be emulated.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/esr.h | 12 ++++++++++++
 arch/arm64/kernel/traps.c    | 17 +++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index cc2d9e7..37e84f2 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -208,6 +208,18 @@
 #define ESR_ELx_SYS64_ISS_EL0_CACHE_OP_VAL \
 				(ESR_ELx_SYS64_ISS_SYS_VAL(1, 3, 1, 7, 0) | \
 				 ESR_ELx_SYS64_ISS_DIR_WRITE)
+/*
+ * User space MRS operations which are supported for emulation
+ * have the following sysreg encoding in System instructions.
+ * op0 = 3, op1= 0, crn = 0, {crm = 0, 4-7}, READ (L = 1)
+ */
+#define ESR_ELx_SYS64_ISS_SYS_MRS_OP_MASK	(ESR_ELx_SYS64_ISS_OP0_MASK | \
+						 ESR_ELx_SYS64_ISS_OP1_MASK | \
+						 ESR_ELx_SYS64_ISS_CRN_MASK | \
+						 ESR_ELx_SYS64_ISS_DIR_MASK)
+#define ESR_ELx_SYS64_ISS_SYS_MRS_OP_VAL \
+				(ESR_ELx_SYS64_ISS_SYS_VAL(3, 0, 0, 0, 0) | \
+				 ESR_ELx_SYS64_ISS_DIR_READ)
 
 #define ESR_ELx_SYS64_ISS_SYS_CTR	ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 1, 0, 0)
 #define ESR_ELx_SYS64_ISS_SYS_CTR_READ	(ESR_ELx_SYS64_ISS_SYS_CTR | \
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 15276b2..3a2e61b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -496,6 +496,17 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
 
+static void mrs_handler(unsigned int esr, struct pt_regs *regs)
+{
+	u32 sysreg, rt;
+
+	rt = ESR_ELx_SYS64_ISS_RT(esr);
+	sysreg = esr_sys64_to_sysreg(esr);
+
+	if (do_emulate_mrs(regs, sysreg, rt) != 0)
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -526,6 +537,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTFRQ,
 		.handler = cntfrq_read_handler,
 	},
+	{
+		/* Trap read access to CPUID registers */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_MRS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_MRS_OP_VAL,
+		.handler = mrs_handler,
+	},
 	{},
 };
 
-- 
2.7.4
