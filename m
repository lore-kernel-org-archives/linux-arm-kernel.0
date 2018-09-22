From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:54 +0530
Subject: [PATCH 3/5] arm64/mm: Define esr_to_debug_fault_info()
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537630796-14756-4-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fault_info[] and debug_fault_info[] are static arrays defining memory abort
exception handling functions looking into ESR fault status code encodings.
As esr_to_fault_info() is already available providing fault_info[] array
lookup, it really makes sense to have a corresponding debug_fault_info[]
array lookup function as well. This just adds an equivalent helper function
esr_to_debug_fault_info().

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/fault.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 30e040c..9c64f93 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -56,12 +56,18 @@ struct fault_info {
 };
 
 static const struct fault_info fault_info[];
+static struct fault_info debug_fault_info[];
 
 static inline const struct fault_info *esr_to_fault_info(unsigned int esr)
 {
 	return fault_info + (esr & ESR_ELx_FSC);
 }
 
+static inline const struct fault_info *esr_to_debug_fault_info(unsigned int esr)
+{
+	return debug_fault_info + DBG_ESR_EVT(esr);
+}
+
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
 {
@@ -830,7 +836,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 					      unsigned int esr,
 					      struct pt_regs *regs)
 {
-	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
+	const struct fault_info *inf = esr_to_debug_fault_info(esr);
 	int rv;
 
 	/*
-- 
2.7.4
