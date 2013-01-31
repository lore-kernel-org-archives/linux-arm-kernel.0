From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jan 2013 15:09:09 +0000
Subject: [PATCH v2 2/2] ARM: memory: define TASK_UNMAPPED_BASE in terms of
 TASK_SIZE
In-Reply-To: <1359644949-18550-1-git-send-email-will.deacon@arm.com>
References: <1359644949-18550-1-git-send-email-will.deacon@arm.com>
Message-ID: <1359644949-18550-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TASK_UNMAPPED_BASE is defined directly in terms of PAGE_OFFSET, which is
confusing given that the modules area sits between here and TASK_SIZE
and is not available for user allocations.

This patch defines TASK_UNMAPPED_BASE in terms of TASK_SIZE instead and
fixes a bug introduced by 394ef6403abc ("mm: use vm_unmapped_area() on
arm architecture") whereby TASK_UNMAPPED_BASE is no longer page-aligned
for bottom-up mmap, causing get_unmapped_area to choke on misaligned
addresses.

Reported-by: Christoffer Dall <cdall@cs.columbia.edu>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 924320f..64c770d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -37,7 +37,7 @@
  */
 #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
 #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
-#define TASK_UNMAPPED_BASE	(UL(CONFIG_PAGE_OFFSET) / 3)
+#define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_16M)
 
 /*
  * The maximum size of a 26-bit user space task.
-- 
1.8.0
