From: mhkelley58@gmail.com (Michael Kelley)
Date: Tue, 19 Jun 2018 14:23:11 -0700
Subject: [PATCH 1/5] arm64: mm: Add slow_virt_to_phys()
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Message-ID: <1529443395-20874-2-git-send-email-mikelley@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add slow_virt_to_phys() function for ARM64 that parallels the same
function on x86/x64. This is needed by the architecture independent
Hyper-V VMbus driver at drivers/hv/channel.c.  The implementation
directly translates the virtual address using the ARM64 'at'
instruction.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 arch/arm64/include/asm/memory.h |  6 ++++++
 arch/arm64/mm/pageattr.c        | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 49d9921..3f68dcf 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -265,6 +265,12 @@ static inline void *phys_to_virt(phys_addr_t x)
 }
 
 /*
+ * For memory where the underlying physical pages may not
+ * be contiguous.
+ */
+extern phys_addr_t slow_virt_to_phys(void *vaddr);
+
+/*
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a563593..8a42cac 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -19,6 +19,8 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
+#include <asm/sysreg.h>
+#include <asm/barrier.h>
 
 struct page_change_data {
 	pgprot_t set_mask;
@@ -185,3 +187,38 @@ bool kernel_page_present(struct page *page)
 }
 #endif /* CONFIG_HIBERNATION */
 #endif /* CONFIG_DEBUG_PAGEALLOC */
+
+/*
+ * For virtual addresses where the underlyine physical memory may not be
+ * contiguous and the normal virt_to_phys gives the wrong result. This
+ * function does an actual translation using the 'at' instruction.
+ */
+phys_addr_t slow_virt_to_phys(void *virt_addr)
+{
+	phys_addr_t	result;
+	unsigned long	input = (unsigned long)virt_addr;
+	char		touch;
+	int		i;
+
+	/* Try up to 3 times (an arbitrary number) */
+	for (i = 0; i < 3; i++) {
+		/* Do the translation and check that it worked */
+		asm volatile("at s1e1r, %0" : : "r" (input));
+		isb();
+		result = read_sysreg(par_el1);
+		if (likely(!(result & 0x1)))
+			return (result & GENMASK_ULL(51, 12)) |
+				(input & GENMASK_ULL(11, 0));
+		/*
+		 * Something failed. Read the page to fault in anything
+		 * that isn't resident, then try again. "Anything"
+		 * could include the page itself or hypervisor page tables.
+		 */
+		touch = READ_ONCE(*(char *)input);
+		dmb(sy);
+	}
+
+	/* Let the caller sort it out. */
+	return  -1;
+}
+EXPORT_SYMBOL_GPL(slow_virt_to_phys);
-- 
1.8.3.1
