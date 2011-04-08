From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Apr 2011 22:51:32 -0400 (EDT)
Subject: [PATCH 1/2] ARM: the ADDR_NO_RANDOMIZE personality flag should be
	honored with mmap()
Message-ID: <alpine.LFD.2.00.1104072249260.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/mmap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index afe209e..74be05f 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -7,6 +7,7 @@
 #include <linux/shm.h>
 #include <linux/sched.h>
 #include <linux/io.h>
+#include <linux/personality.h>
 #include <linux/random.h>
 #include <asm/cputype.h>
 #include <asm/system.h>
@@ -82,7 +83,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	        mm->cached_hole_size = 0;
 	}
 	/* 8 bits of randomness in 20 address space bits */
-	if (current->flags & PF_RANDOMIZE)
+	if ((current->flags & PF_RANDOMIZE) &&
+	    !(current->personality & ADDR_NO_RANDOMIZE))
 		addr += (get_random_int() % (1 << 8)) << PAGE_SHIFT;
 
 full_search:
-- 
1.7.4
