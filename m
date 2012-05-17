From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 17 May 2012 12:54:42 +0200
Subject: [PATCHv2 1/4] mm: vmalloc: use const void * for caller argument
In-Reply-To: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1337252085-22039-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'const void *' is a safer type for caller function type. This patch
updates all references to caller function type.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/vmalloc.h |    8 ++++----
 mm/vmalloc.c            |   18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index dcdfc2b..2e28f4d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -32,7 +32,7 @@ struct vm_struct {
 	struct page		**pages;
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
-	void			*caller;
+	const void		*caller;
 };
 
 /*
@@ -62,7 +62,7 @@ extern void *vmalloc_32_user(unsigned long size);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
 extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
-			pgprot_t prot, int node, void *caller);
+			pgprot_t prot, int node, const void *caller);
 extern void vfree(const void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
@@ -85,13 +85,13 @@ static inline size_t get_vm_area_size(const struct vm_struct *area)
 
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *get_vm_area_caller(unsigned long size,
-					unsigned long flags, void *caller);
+					unsigned long flags, const void *caller);
 extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 					unsigned long start, unsigned long end);
 extern struct vm_struct *__get_vm_area_caller(unsigned long size,
 					unsigned long flags,
 					unsigned long start, unsigned long end,
-					void *caller);
+					const void *caller);
 extern struct vm_struct *remove_vm_area(const void *addr);
 
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 94dff88..8bc7f3ef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1279,7 +1279,7 @@ DEFINE_RWLOCK(vmlist_lock);
 struct vm_struct *vmlist;
 
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, void *caller)
+			      unsigned long flags, const void *caller)
 {
 	vm->flags = flags;
 	vm->addr = (void *)va->va_start;
@@ -1305,7 +1305,7 @@ static void insert_vmalloc_vmlist(struct vm_struct *vm)
 }
 
 static void insert_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, void *caller)
+			      unsigned long flags, const void *caller)
 {
 	setup_vmalloc_vm(vm, va, flags, caller);
 	insert_vmalloc_vmlist(vm);
@@ -1313,7 +1313,7 @@ static void insert_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 
 static struct vm_struct *__get_vm_area_node(unsigned long size,
 		unsigned long align, unsigned long flags, unsigned long start,
-		unsigned long end, int node, gfp_t gfp_mask, void *caller)
+		unsigned long end, int node, gfp_t gfp_mask, const void *caller)
 {
 	struct vmap_area *va;
 	struct vm_struct *area;
@@ -1374,7 +1374,7 @@ EXPORT_SYMBOL_GPL(__get_vm_area);
 
 struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 				       unsigned long start, unsigned long end,
-				       void *caller)
+				       const void *caller)
 {
 	return __get_vm_area_node(size, 1, flags, start, end, -1, GFP_KERNEL,
 				  caller);
@@ -1396,7 +1396,7 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 }
 
 struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
-				void *caller)
+				const void *caller)
 {
 	return __get_vm_area_node(size, 1, flags, VMALLOC_START, VMALLOC_END,
 						-1, GFP_KERNEL, caller);
@@ -1567,9 +1567,9 @@ EXPORT_SYMBOL(vmap);
 
 static void *__vmalloc_node(unsigned long size, unsigned long align,
 			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, void *caller);
+			    int node, const void *caller);
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node, void *caller)
+				 pgprot_t prot, int node, const void *caller)
 {
 	const int order = 0;
 	struct page **pages;
@@ -1642,7 +1642,7 @@ fail:
  */
 void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
-			pgprot_t prot, int node, void *caller)
+			pgprot_t prot, int node, const void *caller)
 {
 	struct vm_struct *area;
 	void *addr;
@@ -1698,7 +1698,7 @@ fail:
  */
 static void *__vmalloc_node(unsigned long size, unsigned long align,
 			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, void *caller)
+			    int node, const void *caller)
 {
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
 				gfp_mask, prot, node, caller);
-- 
1.7.10.1
