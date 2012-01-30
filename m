From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:16 +0800
Subject: [PATCH 5/7] Using do_page_fault for section fault handling
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1327910238-18704-6-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/mm/fault.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bb7eac3..af6703d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/hugetlb.h>
 
 #include <asm/exception.h>
 #include <asm/system.h>
@@ -485,6 +486,7 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 }
 #endif					/* CONFIG_MMU */
 
+#ifndef CONFIG_ARM_HUGETLB_SUPPORT
 /*
  * Some section permission faults need to be handled gracefully.
  * They can happen due to a __{get,put}_user during an oops.
@@ -496,6 +498,19 @@ do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 0;
 }
 
+#else
+
+/* Since normal 4K page based vma will never fault into section traps,
+ * This will enable us to use do_page_fault for section permission fault.
+ */
+static int
+do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	do_page_fault(addr, fsr, regs);
+	return 0;
+}
+#endif
+
 /*
  * This abort handler always returns "fault".
  */
-- 
1.7.1
