From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:20 -0400
Subject: [PATCH 2/5] [ARM] add address randomization to mmap()
In-Reply-To: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
Message-ID: <1276720403-27918-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/mmap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index f5abc51..4f5b396 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -7,6 +7,7 @@
 #include <linux/shm.h>
 #include <linux/sched.h>
 #include <linux/io.h>
+#include <linux/random.h>
 #include <asm/cputype.h>
 #include <asm/system.h>
 
@@ -80,6 +81,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	        start_addr = addr = TASK_UNMAPPED_BASE;
 	        mm->cached_hole_size = 0;
 	}
+	/* 8 bits of randomness in 20 address space bits */
+	if (current->flags & PF_RANDOMIZE)
+		addr += (get_random_int() % (1 << 8)) << PAGE_SHIFT;
 
 full_search:
 	if (do_align)
-- 
1.7.1.337.gbd0bc
