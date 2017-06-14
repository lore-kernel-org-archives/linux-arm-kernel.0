From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 14 Jun 2017 14:14:03 +0100
Subject: [PATCH] arm64: Decode information from ESR upon mem faults
Message-ID: <1497446043-50944-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When receiving unhandled faults from the CPU, description is very sparse.
Adding information about faults decoded from ESR.

Added defines to esr.h corresponding ESR fields. Values are based on ARM
Archtecture Reference Manual (DDI 0487B.a), section D7.2.28 ESR_ELx, Exception
Syndrome Register (ELx) (pages D7-2275 to D7-2280).

New output is of the form:
[  122.109118] Mem abort info:
[  122.111884]   Exception class = DABT (current EL)
[  122.116564]   IL = 32 bits
[  122.119242]   SET = 0
[  122.121507]   FnV = 0
[  122.123754]   EA = 0
[  122.125928]   S1PTW = 0
[  122.128347] Data abort info:
[  122.131212]   ISS[23:14] invalid
[  122.134417]   CM = 0
[  122.136589]   WnR = 1

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/esr.h | 38 +++++++++++++++++++++++++++++---------
 arch/arm64/mm/fault.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 85997c0..1aad4fe 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -76,15 +76,23 @@
 #define ESR_ELx_EC_MASK		(UL(0x3F) << ESR_ELx_EC_SHIFT)
 #define ESR_ELx_EC(esr)		(((esr) & ESR_ELx_EC_MASK) >> ESR_ELx_EC_SHIFT)
 
-#define ESR_ELx_IL		(UL(1) << 25)
+#define ESR_ELx_IL_SHIFT	(25)
+#define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
 #define ESR_ELx_ISS_MASK	(ESR_ELx_IL - 1)
 
 /* ISS field definitions shared by different classes */
-#define ESR_ELx_WNR		(UL(1) << 6)
+#define ESR_ELx_WNR_SHIFT	(6)
+#define ESR_ELx_WNR		(UL(1) << ESR_ELx_WNR_SHIFT)
 
 /* Shared ISS field definitions for Data/Instruction aborts */
-#define ESR_ELx_EA		(UL(1) << 9)
-#define ESR_ELx_S1PTW		(UL(1) << 7)
+#define ESR_ELx_SET_SHIFT	(11)
+#define ESR_ELx_SET_MASK	(UL(3) << ESR_ELx_SET_SHIFT)
+#define ESR_ELx_FNV_SHIFT	(10)
+#define ESR_ELx_FNV		(UL(1) << ESR_ELx_FNV_SHIFT)
+#define ESR_ELx_EA_SHIFT	(9)
+#define ESR_ELx_EA		(UL(1) << ESR_ELx_EA_SHIFT)
+#define ESR_ELx_S1PTW_SHIFT	(7)
+#define ESR_ELx_S1PTW		(UL(1) << ESR_ELx_S1PTW_SHIFT)
 
 /* Shared ISS fault status code(IFSC/DFSC) for Data/Instruction aborts */
 #define ESR_ELx_FSC		(0x3F)
@@ -95,15 +103,20 @@
 #define ESR_ELx_FSC_PERM	(0x0C)
 
 /* ISS field definitions for Data Aborts */
-#define ESR_ELx_ISV		(UL(1) << 24)
+#define ESR_ELx_ISV_SHIFT	(24)
+#define ESR_ELx_ISV		(UL(1) << ESR_ELx_ISV_SHIFT)
 #define ESR_ELx_SAS_SHIFT	(22)
 #define ESR_ELx_SAS		(UL(3) << ESR_ELx_SAS_SHIFT)
-#define ESR_ELx_SSE		(UL(1) << 21)
+#define ESR_ELx_SSE_SHIFT	(21)
+#define ESR_ELx_SSE		(UL(1) << ESR_ELx_SSE_SHIFT)
 #define ESR_ELx_SRT_SHIFT	(16)
 #define ESR_ELx_SRT_MASK	(UL(0x1F) << ESR_ELx_SRT_SHIFT)
-#define ESR_ELx_SF 		(UL(1) << 15)
-#define ESR_ELx_AR 		(UL(1) << 14)
-#define ESR_ELx_CM 		(UL(1) << 8)
+#define ESR_ELx_SF_SHIFT	(15)
+#define ESR_ELx_SF 		(UL(1) << ESR_ELx_SF_SHIFT)
+#define ESR_ELx_AR_SHIFT	(14)
+#define ESR_ELx_AR 		(UL(1) << ESR_ELx_AR_SHIFT)
+#define ESR_ELx_CM_SHIFT	(8)
+#define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
 
 /* ISS field definitions for exceptions taken in to Hyp */
 #define ESR_ELx_CV		(UL(1) << 24)
@@ -184,6 +197,13 @@
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
+static inline bool esr_is_data_abort(u32 esr)
+{
+	const u32 ec = ESR_ELx_EC(esr);
+
+	return ec == ESR_ELx_EC_DABT_LOW || ec == ESR_ELx_EC_DABT_CUR;
+}
+
 const char *esr_get_class_string(u32 esr);
 #endif /* __ASSEMBLY */
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95df..118a4b3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -79,6 +79,42 @@ static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
 }
 #endif
 
+static void data_abort_decode(unsigned int esr)
+{
+	pr_alert("Data abort info:\n");
+
+	if (esr & ESR_ELx_ISV) {
+		pr_alert("  Access size = %u byte(s)\n", 1U << ((esr & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT));
+		pr_alert("  SSE = %lu\n", (esr & ESR_ELx_SSE) >> ESR_ELx_SSE_SHIFT);
+		pr_alert("  SRT = %lu\n", (esr & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT);
+		pr_alert("  SF = %lu\n", (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT);
+		pr_alert("  AR = %lu\n", (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
+	} else {
+		pr_alert("  Instruction syndrome details in ISS[23:14] unavailable\n");
+	}
+
+	pr_alert("  CM = %lu\n", (esr & ESR_ELx_CM) >> ESR_ELx_CM_SHIFT);
+	pr_alert("  WnR = %lu\n", (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT);
+}
+
+/*
+ * Decode mem abort information
+ */
+static void mem_abort_decode(unsigned int esr)
+{
+	pr_alert("Mem abort info:\n");
+
+	pr_alert("  Exception class = %s\n", esr_get_class_string(esr));
+	pr_alert("  IL = %lu bits\n", (esr & ESR_ELx_IL) ? 32 : 16);
+	pr_alert("  SET = %lu\n", (esr & ESR_ELx_SET_MASK) >> ESR_ELx_SET_SHIFT);
+	pr_alert("  FnV = %lu\n", (esr & ESR_ELx_FNV) >> ESR_ELx_FNV_SHIFT);
+	pr_alert("  EA = %lu\n", (esr & ESR_ELx_EA) >> ESR_ELx_EA_SHIFT);
+	pr_alert("  S1PTW = %lu\n", (esr & ESR_ELx_S1PTW) >> ESR_ELx_S1PTW_SHIFT);
+
+	if (esr_is_data_abort(esr))
+		data_abort_decode(esr);
+}
+
 /*
  * Dump out the page tables associated with 'addr' in mm 'mm'.
  */
@@ -227,6 +263,8 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
 	pr_alert("Unable to handle kernel %s at virtual address %08lx\n", msg,
 		 addr);
 
+	mem_abort_decode(esr);
+
 	show_pte(mm, addr);
 	die("Oops", regs, esr);
 	bust_spinlocks(0);
@@ -604,6 +642,8 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	pr_alert("Unhandled fault: %s (0x%08x) at 0x%016lx\n",
 		 inf->name, esr, addr);
 
+	mem_abort_decode(esr);
+
 	info.si_signo = inf->sig;
 	info.si_errno = 0;
 	info.si_code  = inf->code;
-- 
1.9.1
