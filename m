From: sdu.liu@huawei.com (Liu Hua)
Date: Tue, 18 Mar 2014 18:20:42 +0800
Subject: [PATCH] ARM: kdump: Avoid overflow when converting pfn to physaddr
Message-ID: <1395138042-62364-1-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we configure CONFIG_LPAE=y, pfn << PAGE_SHIFT will
overflow if pfn >= 0x100000 in copy_oldmem_page.

So use __pfn_to_phys for converting.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 arch/arm/kernel/crash_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
index 90c50d4..5d1286d 100644
--- a/arch/arm/kernel/crash_dump.c
+++ b/arch/arm/kernel/crash_dump.c
@@ -39,7 +39,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	vaddr = ioremap(__pfn_to_phys(pfn), PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 
-- 
1.8.5.5.dirty
