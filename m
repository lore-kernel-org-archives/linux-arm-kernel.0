From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Tue, 11 Dec 2012 17:37:53 -0800
Subject: [PATCH] ARM: mm: Split memory banks that span multiple sections when
 sparsemem is enabled
Message-ID: <1355276275-17859-1-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a crash in mem_init which assumes all pages in a memory bank
are part of the same page array.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 arch/arm/mm/mmu.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 941dfb9..516956c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -917,6 +917,28 @@ void __init sanity_check_meminfo(void)
 		struct membank *bank = &meminfo.bank[j];
 		*bank = meminfo.bank[i];
 
+#ifdef CONFIG_SPARSEMEM
+		if (pfn_to_section_nr(bank_pfn_start(bank)) !=
+		    pfn_to_section_nr(bank_pfn_end(bank) - 1)) {
+			phys_addr_t sz;
+			unsigned long start_pfn = bank_pfn_start(bank);
+			unsigned long end_pfn = SECTION_ALIGN_UP(start_pfn + 1);
+			sz = ((phys_addr_t)(end_pfn - start_pfn) << PAGE_SHIFT);
+			
+			if (meminfo.nr_banks >= NR_BANKS) {
+				pr_crit("NR_BANKS too low, ignoring %lld bytes of memory\n",
+					(unsigned long long)(bank->size - sz));
+			} else {
+				memmove(bank + 1, bank,
+					(meminfo.nr_banks - i) * sizeof(*bank));
+				meminfo.nr_banks++;
+				bank[1].size -= sz;
+				bank[1].start = __pfn_to_phys(end_pfn);
+			}
+			bank->size = sz;
+		}
+#endif
+
 		if (bank->start > ULONG_MAX)
 			highmem = 1;
 
-- 
1.7.7.3
