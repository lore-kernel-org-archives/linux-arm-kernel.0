From: will.deacon@arm.com (Will Deacon)
Date: Thu,  9 Jun 2011 16:58:59 +0100
Subject: [PATCH v2 07/10] ARM: multi-cpu: remove arguments from CPU proc macros
In-Reply-To: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
References: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307635142-11312-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros for invoking functions via the processor struct in the
MULTI_CPU case define the arguments as part of the macros, making it
impossible to take the address of those functions.

This patch removes the arguments from the macro definitions so that we
can take the address of these functions like we can for the !MULTI_CPU
case.

Reported-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/proc-fns.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8ec535e..633d1cb 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -82,13 +82,13 @@ extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 #else
-#define cpu_proc_init()			processor._proc_init()
-#define cpu_proc_fin()			processor._proc_fin()
-#define cpu_reset(addr)			processor.reset(addr)
-#define cpu_do_idle()			processor._do_idle()
-#define cpu_dcache_clean_area(addr,sz)	processor.dcache_clean_area(addr,sz)
-#define cpu_set_pte_ext(ptep,pte,ext)	processor.set_pte_ext(ptep,pte,ext)
-#define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
+#define cpu_proc_init			processor._proc_init
+#define cpu_proc_fin			processor._proc_fin
+#define cpu_reset			processor.reset
+#define cpu_do_idle			processor._do_idle
+#define cpu_dcache_clean_area		processor.dcache_clean_area
+#define cpu_set_pte_ext			processor.set_pte_ext
+#define cpu_do_switch_mm		processor.switch_mm
 #endif
 
 extern void cpu_resume(void);
-- 
1.7.0.4
