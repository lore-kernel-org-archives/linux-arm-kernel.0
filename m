From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 21 Nov 2016 16:08:40 +0000
Subject: [PATCH 2/2] ARM: mm: allow set_memory_*() to be used on the vmalloc
 region
Message-ID: <E1c8r96-0007wR-JK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can allow modules to be loaded into the vmalloc region, where they
should also benefit from the same protections as those loaded into
the more efficient module region.  Allow these functions to operate
there as well.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index db09f2e7efda..ad8032bfe734 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -55,7 +55,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (!size)
 		return 0;
 
-	if (!in_range(start, size, MODULES_VADDR, MODULES_END))
+	if (!in_range(start, size, MODULES_VADDR, MODULES_END) &&
+	    !in_range(start, size, VMALLOC_START, VMALLOC_END))
 		return -EINVAL;
 
 	data.set_mask = set_mask;
-- 
2.7.4
