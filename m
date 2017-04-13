From: credmonster@gmail.com (Chris Redmon)
Date: Wed, 12 Apr 2017 22:20:40 -0400
Subject: [PATCH 3/3] arm64: Utilize trace events for major and minor page
 faults
In-Reply-To: <20170413022040.10156-1-credmonster@gmail.com>
References: <20170413022040.10156-1-credmonster@gmail.com>
Message-ID: <20170413022040.10156-4-credmonster@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Redmon <credmonster@gmail.com>
---
 arch/arm64/mm/fault.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1b35b8bddbfb..d3097ff6fb8e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -42,6 +42,9 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fault.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr,
 		      struct pt_regs *regs);
@@ -315,6 +318,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	int fault, sig, code;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	ktime_t start_time;
+	bool trace_fault_enabled = false;
 
 	if (notify_page_fault(regs, esr))
 		return 0;
@@ -351,6 +356,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			die("Accessing user space memory outside uaccess.h routines", regs, esr);
 	}
 
+	if (trace_fault_major_enabled() || trace_fault_minor_enabled()) {
+		start_time = ktime_get();
+		trace_fault_enabled = true;
+	}
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -395,10 +405,14 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			tsk->maj_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
 				      addr);
+			if (trace_fault_enabled)
+				trace_fault_major(addr, regs, esr, start_time, mm_flags, fault);
 		} else {
 			tsk->min_flt++;
 			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
 				      addr);
+			if (trace_fault_enabled)
+				trace_fault_minor(addr, regs, esr, start_time, mm_flags, fault);
 		}
 		if (fault & VM_FAULT_RETRY) {
 			/*
-- 
2.12.2.599.gcf11a67
