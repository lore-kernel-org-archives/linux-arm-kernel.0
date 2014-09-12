From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 12 Sep 2014 18:17:18 +0800
Subject: [PATCH] arm64:free_initrd_mem should also free the memblock
Message-ID: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix the memblock statics for memblock
in file /sys/kernel/debug/memblock/reserved
if we don't call memblock_free the initrd will still
be marked as reserved, even they are freed.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5472c24..34605c8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -334,8 +334,10 @@ static int keep_initrd;
 
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
+	if (!keep_initrd) {
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
+		memblock_free(__pa(start), end - start);
+	}
 }
 
 static int __init keepinitrd_setup(char *__unused)
-- 
2.1.0
