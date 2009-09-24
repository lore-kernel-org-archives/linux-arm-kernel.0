From: gerg@snapgear.com (Greg Ungerer)
Date: Thu, 24 Sep 2009 16:24:04 +1000
Subject: [PATCH] arm: fix valid_phys_addr_range() range check
Message-ID: <200909240624.n8O6O4MO002196@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm: fix valid_phys_addr_range() range check

Commit 1522ac3ec95ff0230e7aa516f86b674fdf72866c
("Fix virtual to physical translation macro corner cases")
breaks the end of memory check in valid_phys_addr_range().
The modified expression results in the apparent /dev/mem size
being 2 bytes smaller than what it actually is.

This patch reworks the expression to correctly check the address,
while maintaining use of a valid address to __pa().

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mm/mmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index f7457fe..2b79964 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -124,7 +124,7 @@ int valid_phys_addr_range(unsigned long addr, size_t size)
 {
 	if (addr < PHYS_OFFSET)
 		return 0;
-	if (addr + size >= __pa(high_memory - 1))
+	if (addr + size > __pa(high_memory - 1) + 1)
 		return 0;
 
 	return 1;
-- 
1.5.5.1
