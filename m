From: yalin.wang2010@gmail.com (yalin wang)
Date: Thu, 23 Jul 2015 19:45:53 +0800
Subject: [RFC] arm64:use set_fixmap_offset to make it more clear
Message-ID: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little change to patch_map() function,
use set_fixmap_offset() to make code more clear.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/kernel/insn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index dd9671c..7dafd5a 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
 		return addr;
 
 	BUG_ON(!page);
-	set_fixmap(fixmap, page_to_phys(page));
-
-	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
+	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
+			(addr & ~PAGE_MASK));
 }
 
 static void __kprobes patch_unmap(int fixmap)
-- 
1.9.1
