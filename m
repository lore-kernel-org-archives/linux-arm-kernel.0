From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 14:44:15 +0200
Subject: [PATCH] ARM: mm: implement no-highmem fast path in kmap_atomic_pfn()
Message-ID: <1404305055-16769-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_HIGHMEM got enabled on ARMv5 Kirkwood, we have noticed a
very significant drop in networking performance. The test were
conducted on an OpenBlocks A7 board. Without this patch, the outgoing
performance measured with iperf are:

 - highmem OFF, TSO OFF   544 Mbit/s
 - highmem OFF, TSO ON	  942 Mbit/s
 - highmem ON,  TSO OFF   306 Mbit/s
 - highmem ON,  TSO ON    246 Mbit/s

On this Kirkwood platform, the L2 cache is a Feroceon cache, and with
this cache, all the range operations have to be done on virtual
addresses and not physical addresses. Therefore, whenever
CONFIG_HIGHMEM is enabled, the cache maintenance operations call
kmap_atomic_pfn() and kunmap_atomic().

However, kmap_atomic_pfn() does not implement the same fast path for
non-highmem pages as the one implemented in kmap_atomic(), and this is
one of the reason for the performance drop. While this patch does not
fully restore the performances, it clearly improves them a lot:

      	      	        without patch  with patch

 - highmem ON, TSO OFF   306 Mbit/s     387 Mbit/s
 - highmem ON, TSO ON    246 Mbit/s     434 Mbit/s

We're still far from the !CONFIG_HIGHMEM performances, but it does
improve a bit the situation.

Thanks a lot to Ezequiel Garcia and Gregory Clement for all the
testing work around this topic.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/highmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 45aeaac..e17ed00 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -127,8 +127,11 @@ void *kmap_atomic_pfn(unsigned long pfn)
 {
 	unsigned long vaddr;
 	int idx, type;
+	struct page *page = pfn_to_page(pfn);
 
 	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR * smp_processor_id();
-- 
2.0.0
