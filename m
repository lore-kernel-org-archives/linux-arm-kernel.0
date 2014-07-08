From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 8 Jul 2014 16:42:12 +0100
Subject: [PATCH v2 3/3] xen/arm: remove mach_to_phys rbtree
In-Reply-To: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
Message-ID: <1404834132-15847-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the rbtree used to keep track of machine to physical mappings:
the frontend can grant the same page multiple times, leading to errors
inserting or removing entries from the mach_to_phys tree.

Linux only needed to know the physical address corresponding to a given
machine address in swiotlb-xen. Now that swiotlb-xen can call the
xen_dma_* functions passing the machine address directly, we can remove
it.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v2:
- do not check for mfn in xen_add_phys_to_mach_entry.
---
 arch/arm/include/asm/xen/page.h |    9 ------
 arch/arm/xen/p2m.c              |   66 +--------------------------------------
 2 files changed, 1 insertion(+), 74 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index ded062f..135c24a 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -33,7 +33,6 @@ typedef struct xpaddr {
 #define INVALID_P2M_ENTRY      (~0UL)
 
 unsigned long __pfn_to_mfn(unsigned long pfn);
-unsigned long __mfn_to_pfn(unsigned long mfn);
 extern struct rb_root phys_to_mach;
 
 static inline unsigned long pfn_to_mfn(unsigned long pfn)
@@ -51,14 +50,6 @@ static inline unsigned long pfn_to_mfn(unsigned long pfn)
 
 static inline unsigned long mfn_to_pfn(unsigned long mfn)
 {
-	unsigned long pfn;
-
-	if (phys_to_mach.rb_node != NULL) {
-		pfn = __mfn_to_pfn(mfn);
-		if (pfn != INVALID_P2M_ENTRY)
-			return pfn;
-	}
-
 	return mfn;
 }
 
diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 97baf44..0548577 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -21,14 +21,12 @@ struct xen_p2m_entry {
 	unsigned long pfn;
 	unsigned long mfn;
 	unsigned long nr_pages;
-	struct rb_node rbnode_mach;
 	struct rb_node rbnode_phys;
 };
 
 static rwlock_t p2m_lock;
 struct rb_root phys_to_mach = RB_ROOT;
 EXPORT_SYMBOL_GPL(phys_to_mach);
-static struct rb_root mach_to_phys = RB_ROOT;
 
 static int xen_add_phys_to_mach_entry(struct xen_p2m_entry *new)
 {
@@ -41,8 +39,6 @@ static int xen_add_phys_to_mach_entry(struct xen_p2m_entry *new)
 		parent = *link;
 		entry = rb_entry(parent, struct xen_p2m_entry, rbnode_phys);
 
-		if (new->mfn == entry->mfn)
-			goto err_out;
 		if (new->pfn == entry->pfn)
 			goto err_out;
 
@@ -88,64 +84,6 @@ unsigned long __pfn_to_mfn(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(__pfn_to_mfn);
 
-static int xen_add_mach_to_phys_entry(struct xen_p2m_entry *new)
-{
-	struct rb_node **link = &mach_to_phys.rb_node;
-	struct rb_node *parent = NULL;
-	struct xen_p2m_entry *entry;
-	int rc = 0;
-
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct xen_p2m_entry, rbnode_mach);
-
-		if (new->mfn == entry->mfn)
-			goto err_out;
-		if (new->pfn == entry->pfn)
-			goto err_out;
-
-		if (new->mfn < entry->mfn)
-			link = &(*link)->rb_left;
-		else
-			link = &(*link)->rb_right;
-	}
-	rb_link_node(&new->rbnode_mach, parent, link);
-	rb_insert_color(&new->rbnode_mach, &mach_to_phys);
-	goto out;
-
-err_out:
-	rc = -EINVAL;
-	pr_warn("%s: cannot add pfn=%pa -> mfn=%pa: pfn=%pa -> mfn=%pa already exists\n",
-			__func__, &new->pfn, &new->mfn, &entry->pfn, &entry->mfn);
-out:
-	return rc;
-}
-
-unsigned long __mfn_to_pfn(unsigned long mfn)
-{
-	struct rb_node *n = mach_to_phys.rb_node;
-	struct xen_p2m_entry *entry;
-	unsigned long irqflags;
-
-	read_lock_irqsave(&p2m_lock, irqflags);
-	while (n) {
-		entry = rb_entry(n, struct xen_p2m_entry, rbnode_mach);
-		if (entry->mfn <= mfn &&
-				entry->mfn + entry->nr_pages > mfn) {
-			read_unlock_irqrestore(&p2m_lock, irqflags);
-			return entry->pfn + (mfn - entry->mfn);
-		}
-		if (mfn < entry->mfn)
-			n = n->rb_left;
-		else
-			n = n->rb_right;
-	}
-	read_unlock_irqrestore(&p2m_lock, irqflags);
-
-	return INVALID_P2M_ENTRY;
-}
-EXPORT_SYMBOL_GPL(__mfn_to_pfn);
-
 int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 			    struct gnttab_map_grant_ref *kmap_ops,
 			    struct page **pages, unsigned int count)
@@ -192,7 +130,6 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
 			p2m_entry = rb_entry(n, struct xen_p2m_entry, rbnode_phys);
 			if (p2m_entry->pfn <= pfn &&
 					p2m_entry->pfn + p2m_entry->nr_pages > pfn) {
-				rb_erase(&p2m_entry->rbnode_mach, &mach_to_phys);
 				rb_erase(&p2m_entry->rbnode_phys, &phys_to_mach);
 				write_unlock_irqrestore(&p2m_lock, irqflags);
 				kfree(p2m_entry);
@@ -217,8 +154,7 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
 	p2m_entry->mfn = mfn;
 
 	write_lock_irqsave(&p2m_lock, irqflags);
-	if ((rc = xen_add_phys_to_mach_entry(p2m_entry) < 0) ||
-		(rc = xen_add_mach_to_phys_entry(p2m_entry) < 0)) {
+	if ((rc = xen_add_phys_to_mach_entry(p2m_entry)) < 0) {
 		write_unlock_irqrestore(&p2m_lock, irqflags);
 		return false;
 	}
-- 
1.7.10.4
