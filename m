From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Jan 2018 12:09:06 +0000
Subject: [PATCH 2/3] arm: Invalidate BTB on fatal signal for Cortex A8, A9, A12,
 A15 and A17
In-Reply-To: <20180106120907.26701-1-marc.zyngier@arm.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
Message-ID: <20180106120907.26701-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent aliasing attacks on the branch predictor,
invalidate the BTB on CPUs that are known to be affected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/cp15.h |  2 ++
 arch/arm/mm/fault.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 4c9fa72b59f5..9e900ae855aa 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -65,6 +65,8 @@
 #define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
+#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 42f585379e19..62da5f99eda0 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
+#include <asm/cp15.h>
 #include <asm/exception.h>
 #include <asm/pgtable.h>
 #include <asm/system_misc.h>
@@ -181,6 +182,16 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	si.si_errno = 0;
 	si.si_code = code;
 	si.si_addr = (void __user *)addr;
+
+	switch(read_cpuid_part()) {
+	case ARM_CPU_PART_CORTEX_A8:
+	case ARM_CPU_PART_CORTEX_A9:
+	case ARM_CPU_PART_CORTEX_A12:
+	case ARM_CPU_PART_CORTEX_A15:
+	case ARM_CPU_PART_CORTEX_A17:
+		write_sysreg(0, BPIALL);
+		break;
+	}
 	force_sig_info(sig, &si, tsk);
 }
 
-- 
2.14.2
