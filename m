From: miles.chen@mediatek.com (miles.chen at mediatek.com)
Date: Thu, 25 Feb 2016 00:01:48 +0800
Subject: [PATCH] arm64/mm: fix virtual address boundary check
Message-ID: <1456329708-2042-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miles Chen <miles.chen@mediatek.com>

The MODULES_VADDR is not the lowest possible
kernel virtual address. TASK_SIZE_64 may be larger than
MODULES_VADDR, FIXADDR_TOP, and PCI_IO_START.

Fix this by comparing TASK_SIZE_64 (highest user virtual address)
with VA_START (lowest kernel virtual address).

 #define VA_BITS		(CONFIG_ARM64_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
 #define TASK_SIZE_64		(UL(1) << VA_BITS)

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3b061e..7d75697 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -343,8 +343,8 @@ void __init mem_init(void)
 #ifdef CONFIG_COMPAT
 	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
 #endif
-	BUILD_BUG_ON(TASK_SIZE_64			> MODULES_VADDR);
-	BUG_ON(TASK_SIZE_64				> MODULES_VADDR);
+	BUILD_BUG_ON(TASK_SIZE_64			> VA_START);
+	BUG_ON(TASK_SIZE_64				> VA_START);
 
 	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
 		extern int sysctl_overcommit_memory;
-- 
1.9.1
