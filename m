From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 12 Sep 2014 18:05:04 +0800
Subject: [PATCH] arm:free_initrd_mem should also free the memblock
Message-ID: <35FD53F367049845BC99AC72306C23D103CDBFBFB028@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix the memblock statics for memblock
in file /sys/kernel/debug/memblock/reserved
if we don't call memblock_free the initrd will still
be marked as reserved, even they are freed.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 arch/arm/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d..7bc8e5b 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -638,6 +638,7 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	if (!keep_initrd) {
 		poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
 		free_reserved_area((void *)start, (void *)end, -1, "initrd");
+		memblock_free(__pa(start), end - start);
 	}
 }
 
-- 
2.1.0
