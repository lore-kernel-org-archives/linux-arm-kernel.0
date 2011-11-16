From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:36 -0500
Subject: [PATCH 18/23] mm: add vm_area_add_early()
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-19-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The existing vm_area_register_early() allows for early vmalloc space
allocation.  However upcoming cleanups in the ARM architecture require
that some fixed locations in the vmalloc area be reserved also very early.

The name "vm_area_register_early" would have been a good name for the
reservation part without the allocation.  Since it is already in use with
different semantics, let's create vm_area_add_early() instead.

Both vm_area_register_early() and vm_area_add_early() can be used together
meaning that the former is now implemented using the later where it is
ensured that no conflicting areas are added, but no attempt is made to
make the allocation scheme in vm_area_register_early() more sophisticated.
After all, you must know what you're doing when using those functions.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mm at kvack.org
---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |   28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 687fb11e20..4115d6aa80 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -131,6 +131,7 @@ extern long vwrite(char *buf, char *addr, unsigned long count);
  */
 extern rwlock_t vmlist_lock;
 extern struct vm_struct *vmlist;
+extern __init void vm_area_add_early(struct vm_struct *vm);
 extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
 
 #ifdef CONFIG_SMP
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b669aa6f6c..3f6a3f1aa8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1118,6 +1118,31 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 EXPORT_SYMBOL(vm_map_ram);
 
 /**
+ * vm_area_add_early - add vmap area early during boot
+ * @vm: vm_struct to add
+ *
+ * This function is used to add fixed kernel vm area to vmlist before
+ * vmalloc_init() is called.  @vm->addr, @vm->size, and @vm->flags
+ * should contain proper values and the other fields should be zero.
+ *
+ * DO NOT USE THIS FUNCTION UNLESS YOU KNOW WHAT YOU'RE DOING.
+ */
+void __init vm_area_add_early(struct vm_struct *vm)
+{
+	struct vm_struct *tmp, **p;
+
+	for (p = &vmlist; (tmp = *p) != NULL; p = &tmp->next) {
+		if (tmp->addr >= vm->addr) {
+			BUG_ON(tmp->addr < vm->addr + vm->size);
+			break;
+		} else
+			BUG_ON(tmp->addr + tmp->size > vm->addr);
+	}
+	vm->next = *p;
+	*p = vm;
+}
+
+/**
  * vm_area_register_early - register vmap area early during boot
  * @vm: vm_struct to register
  * @align: requested alignment
@@ -1139,8 +1164,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 
 	vm->addr = (void *)addr;
 
-	vm->next = vmlist;
-	vmlist = vm;
+	vm_area_add_early(vm);
 }
 
 void __init vmalloc_init(void)
-- 
1.7.7.1.431.g10b2a
