From: andrew_gabbasov@mentor.com (Andrew Gabbasov)
Date: Fri, 17 Feb 2017 06:09:39 -0700
Subject: [PATCH 3/3] ARM: mm: Fix checks for supporting caches for mapping
 color alignment
In-Reply-To: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
References: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
Message-ID: <1487336979-14245-4-git-send-email-andrew_gabbasov@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When making memory mapping, the page is aligned to the appropriate
page color for the cases of cache types, supporting memory aliasing.
Initially the cache type checking was implemented by looking at
appropriate color restriction indicating bits for both data and
instruction caches, but after checking macros were introduced
and later split to separate aliasing support for data and instuction
caches, page alignment is done for aliasing data cache only.

Handling of aliasing instruction cache case is added to page mapping
color alignment, but, on the other hand, the case of instruction
cache, supporting aliasing, but not having page color restrictions
(namely, ARMv7+), is excluded from color alignment.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 arch/arm/mm/mmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 66353ca..97e440a 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -58,7 +58,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_align = 0;
-	int aliasing = cache_is_vipt_aliasing();
+	int aliasing = cache_is_vipt_aliasing() ||
+		       (icache_is_vipt_aliasing() && icache_is_vipt_coloring());
 	struct vm_unmapped_area_info info;
 
 	/*
@@ -111,7 +112,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	int do_align = 0;
-	int aliasing = cache_is_vipt_aliasing();
+	int aliasing = cache_is_vipt_aliasing() ||
+		       (icache_is_vipt_aliasing() && icache_is_vipt_coloring());
 	struct vm_unmapped_area_info info;
 
 	/*
-- 
2.1.0
