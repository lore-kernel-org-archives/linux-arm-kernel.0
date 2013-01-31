From: cyril@ti.com (Cyril Chemparathy)
Date: Thu, 31 Jan 2013 16:58:30 -0500
Subject: [PATCH v4 11/13] ARM: mm: cleanup checks for membank overlap with
 vmalloc area
In-Reply-To: <1359669512-31276-1-git-send-email-cyril@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
Message-ID: <1359669512-31276-12-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Keystone platforms, physical memory is entirely outside the 32-bit
addressible range.  Therefore, the (bank->start > ULONG_MAX) check below marks
the entire system memory as highmem, and this causes unpleasentness all over.

This patch eliminates the extra bank start check (against ULONG_MAX) by
checking bank->start against the physical address corresponding to vmalloc_min
instead.

In the process, this patch also cleans up parts of the highmem sanity check
code by removing what has now become a redundant check for banks that entirely
overlap with the vmalloc range.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mm/mmu.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e8875cb..85ed732 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -935,15 +935,12 @@ void __init sanity_check_meminfo(void)
 		struct membank *bank = &meminfo.bank[j];
 		*bank = meminfo.bank[i];
 
-		if (bank->start > ULONG_MAX)
-			highmem = 1;
-
-#ifdef CONFIG_HIGHMEM
 		if (bank->start >= vmalloc_limit)
 			highmem = 1;
 
 		bank->highmem = highmem;
 
+#ifdef CONFIG_HIGHMEM
 		/*
 		 * Split those memory banks which are partially overlapping
 		 * the vmalloc area greatly simplifying things later.
@@ -966,8 +963,6 @@ void __init sanity_check_meminfo(void)
 			bank->size = vmalloc_limit - bank->start;
 		}
 #else
-		bank->highmem = highmem;
-
 		/*
 		 * Highmem banks not allowed with !CONFIG_HIGHMEM.
 		 */
@@ -980,18 +975,6 @@ void __init sanity_check_meminfo(void)
 		}
 
 		/*
-		 * Check whether this memory bank would entirely overlap
-		 * the vmalloc area.
-		 */
-		if (bank->start >= vmalloc_limit) {
-			printk(KERN_NOTICE "Ignoring RAM at %.8llx-%.8llx "
-			       "(vmalloc region overlap).\n",
-			       (unsigned long long)bank->start,
-			       (unsigned long long)bank->start + bank->size - 1);
-			continue;
-		}
-
-		/*
 		 * Check whether this memory bank would partially overlap
 		 * the vmalloc area.
 		 */
-- 
1.7.9.5
