From: ytk.lee@samsung.com (Yongtaek Lee)
Date: Thu, 03 Sep 2015 11:24:47 +0900
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than 0xf0000000
Message-ID: <1441247087-10342-1-git-send-email-ytk.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

default value of vmalloc_min was set 0xf0000000 for ARM by commit
0536bdf3. But actually vmalloc_min is 0xef800000 not 0xf0000000.

VMALLOC_END - (240 << 20) - VMALLOC_OFFSET)
0xff000000 - 0x0f000000 - 0x00800000 = 0xef800000

In case of 768MB ram without CONFIG_HIGHMEM=y, last 8MB could not be
allocated. Kernel log also print out warning message as below.
"Truncating RAM at 80000000-afffffff to -af7fffff (vmalloc region overlap)."

Although it could be solved by state "vmalloc=size" in cmdline but i think
it would be better to change default value to 232 from 240.

Signed-off-by: Yongtaek Lee <ytk.lee@samsung.com>

---
 arch/arm/mm/mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8348ed6..9a1bab4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1040,12 +1040,12 @@ void __init debug_ll_io_init(void)
 #endif
 
 static void * __initdata vmalloc_min =
-	(void *)(VMALLOC_END - (240 << 20) - VMALLOC_OFFSET);
+	(void *)(VMALLOC_END - (232 << 20) - VMALLOC_OFFSET);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the vmalloc
- * area - the default is 240m.
+ * area - the default is 232m.
  */
 static int __init early_vmalloc(char *arg)
 {
-- 
1.7.9
