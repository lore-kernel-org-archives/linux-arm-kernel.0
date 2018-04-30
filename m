From: chandan.vn@samsung.com (CHANDAN VN)
Date: Mon, 30 Apr 2018 09:43:45 +0530
Subject: [PATCHv2 1/1] arm64: To remove initrd reserved area entry from
 memblock
References: <CGME20180430041448epcas1p228a727858328da77c67c01c25802b86d@epcas1p2.samsung.com>
Message-ID: <1525061625-7940-1-git-send-email-chandan.vn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

INITRD reserved area entry is not removed from memblock
even though initrd reserved area is freed. After freeing
the memory it is released from memblock. The same can be
checked from /sys/kernel/debug/memblock/reserved.

The patch makes sure that the initrd entry is removed from
memblock when keepinitrd is not enabled.

The patch only affects accounting and debugging. This does not
fix any memory leak.

Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
---
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f3c47a..1b18b47 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -646,8 +646,10 @@ void free_initmem(void)
 
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
+	if (!keep_initrd) {
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
+		memblock_free(__virt_to_phys(start), end - start);
+	}
 }
 
 static int __init keepinitrd_setup(char *__unused)
-- 
1.9.1
