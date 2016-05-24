From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 24 May 2016 19:16:37 +0800
Subject: [PATCH 1/1] arm64: fix flush_cache_range
Message-ID: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we ran mprotect04(a test case in LTP) infinitely, it would always
failed after a few seconds. The case can be described briefly that: copy
a empty function from code area into a new memory area(created by mmap),
then call mprotect to change the protection to PROT_EXEC. The syscall
sys_mprotect will finally invoke flush_cache_range, but this function
currently only invalid icache, the operation of flush dcache is missed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index dbd12ea..eda4124 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -31,7 +31,7 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end)
 {
 	if (vma->vm_flags & VM_EXEC)
-		__flush_icache_all();
+		flush_icache_range(start, end);
 }

 static void sync_icache_aliases(void *kaddr, unsigned long len)
--
2.5.0
