From: pullip.cho@samsung.com (KyongHo)
Date: Thu, 24 May 2012 17:32:56 +0900
Subject: mm: fix faulty initialization in vmalloc_init()
Message-ID: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vmalloc_init() adds 'vmap_area's for early 'vm_struct's.
This patch fixes vmalloc_init() to correctly initialize
vmap_area for the given vm_struct.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 mm/vmalloc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 94dff88..1196c77 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1185,9 +1185,10 @@ void __init vmalloc_init(void)
 	/* Import existing vmlist entries. */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
-		va->flags = tmp->flags | VM_VM_AREA;
+		va->flags = VM_VM_AREA;
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
+		va->vm = tmp;
 		__insert_vmap_area(va);
 	}
 
-- 
1.7.1
