From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2011 18:23:15 +0100
Subject: [PATCH v3 4/9] ARM: idmap: add header file for identity mapping
	functions
In-Reply-To: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
References: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
Message-ID: <1308158600-7169-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The identity mappings functions are useful outside of SMP booting, so
expose them through their own header file.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/idmap.h   |   16 ++++++++++++++++
 arch/arm/include/asm/pgtable.h |    3 ---
 arch/arm/kernel/process.c      |    3 +--
 arch/arm/kernel/smp.c          |    1 +
 arch/arm/mm/idmap.c            |    1 +
 5 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/idmap.h

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
new file mode 100644
index 0000000..ea9517e
--- /dev/null
+++ b/arch/arm/include/asm/idmap.h
@@ -0,0 +1,16 @@
+#ifndef _ARM_IDMAP_H
+#define _ARM_IDMAP_H
+
+#include <asm/page.h>
+
+void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end);
+
+#ifdef CONFIG_SMP
+void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end);
+#else
+void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end) {};
+#endif
+
+void setup_mm_for_reboot(char mode);
+
+#endif	/* _ARM_IDMAP_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5750704..9d559a8 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -474,9 +474,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 #define pgtable_cache_init() do { } while (0)
 
-void identity_mapping_add(pgd_t *, unsigned long, unsigned long);
-void identity_mapping_del(pgd_t *, unsigned long, unsigned long);
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5e1e541..8bd9d94 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/hw_breakpoint.h>
 
 #include <asm/cacheflush.h>
+#include <asm/idmap.h>
 #include <asm/leds.h>
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -56,8 +57,6 @@ static const char *isa_modes[] = {
   "ARM" , "Thumb" , "Jazelle", "ThumbEE"
 };
 
-extern void setup_mm_for_reboot(char mode);
-
 static volatile int hlt_counter;
 
 #include <mach/system.h>
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 344e52b..dfc76aa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -39,6 +39,7 @@
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
+#include <asm/idmap.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..4ae0f09 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -1,6 +1,7 @@
 #include <linux/kernel.h>
 
 #include <asm/cputype.h>
+#include <asm/idmap.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-- 
1.7.0.4
