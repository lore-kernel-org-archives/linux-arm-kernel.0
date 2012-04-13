From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 13 Apr 2012 16:05:48 +0200
Subject: [PATCH 2/4] mm: vmalloc: export find_vm_area() function
In-Reply-To: <1334325950-7881-1-git-send-email-m.szyprowski@samsung.com>
References: <1334325950-7881-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1334325950-7881-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

find_vm_area() function is usefull for other core subsystems (like
dma-mapping) to get access to vm_area internals.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2e28f4d..6071e91 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -93,6 +93,7 @@ extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long start, unsigned long end,
 					const void *caller);
 extern struct vm_struct *remove_vm_area(const void *addr);
+extern struct vm_struct *find_vm_area(const void *addr);
 
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page ***pages);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8bc7f3e..8cb7f22 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1402,7 +1402,15 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 						-1, GFP_KERNEL, caller);
 }
 
-static struct vm_struct *find_vm_area(const void *addr)
+/**
+ *	find_vm_area  -  find a continuous kernel virtual area
+ *	@addr:		base address
+ *
+ *	Search for the kernel VM area starting at @addr, and return it.
+ *	It is up to the caller to do all required locking to keep the returned
+ *	pointer valid.
+ */
+struct vm_struct *find_vm_area(const void *addr)
 {
 	struct vmap_area *va;
 
-- 
1.7.1.569.g6f426
