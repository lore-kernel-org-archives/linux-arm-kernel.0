From: yun.hsiang@mediatek.com (yun.hsiang at mediatek.com)
Date: Fri, 18 Mar 2016 17:49:27 +0800
Subject: [PATCH] ARM: Handle non-pmd-aligned end of first memblock.
Message-ID: <1458294567-19308-1-git-send-email-yun.hsiang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yun Hsiang <yun.hsiang@mediatek.com>

In paging_init(), if the end address of first memblock
is non-PMD-aligned,we need to create a next-level page table
for mapping the non-PMD-sized area.
The memory of this next-level page table will be allocated
from address of memblock.limit with a top-down order.
sanity_check_meminfo() will find the address of
first non-pmd-aligned page in memblock.memory,
round down the address, and set it to memblock.current_limit.

There is a risk if arm_memblock_init()execute before
sanity_check_meminfo(). arm_memblock_init() parse the device tree
and modified memblock if there are no-map node in device tree.
It might produce a new non-PMD-aligned block. While creating mapping
to this new non-PMD-aligned block, the page table will be allocated
from the memblock.limit which is still unmapped.

Signed-off-by: Yun Hsiang <yun.hsiang@mediatek.com>
---
 arch/arm/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7d0cba6f..940e4bd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1036,11 +1036,11 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	setup_dma_zone(mdesc);
 	efi_init();
-	sanity_check_meminfo();
 	arm_memblock_init(mdesc);
 
 	early_ioremap_reset();
 
+	sanity_check_meminfo();
 	paging_init(mdesc);
 	request_standard_resources(mdesc);
 
-- 
1.9.1
