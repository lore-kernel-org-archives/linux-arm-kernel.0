From: orca.chen@gmail.com (Min-Hua Chen)
Date: Thu, 11 Jun 2015 02:59:33 +0800
Subject: [PATCHv3 2/2] arm: use max_lowmem_limit in find_limit()
In-Reply-To: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
References: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
Message-ID: <1433962773-8402-3-git-send-email-orca.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit: 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76, the max_low is
set by memblock_get_current_limit(). However memblock.current_limit
can be changed by memblock_set_current_limit() any point before
find_limits().

It's better to use arm_lowmem_limit to be max_lowmem in two ways:
First, arm_lowmem_limit cannot be changed by a public API. Second, the
high_memory is set by arm_lowmem_limit and is a natural limit of
low memory area in bootmem_init().

Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be92fa0..b4f9513 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -89,7 +89,7 @@ __tagtable(ATAG_INITRD2, parse_tag_initrd2);
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
 {
-	*max_low = PFN_DOWN(memblock_get_current_limit());
+	*max_low = PFN_DOWN(arm_lowmem_limit);
 	*min = PFN_UP(memblock_start_of_DRAM());
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
-- 
1.7.10.4
