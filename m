From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  7 Jun 2017 18:20:52 +0000
Subject: [PATCH] mm: vmalloc: simplify vread/vwrite to use existing mappings
Message-ID: <20170607182052.31447-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vread() and vwrite() routines contain elaborate plumbing to access
the contents of vmalloc/vmap regions safely. According to the comments,
this removes the need for locking, but given that both these routines
execute with the vmap_area_lock spinlock held anyway, this is not much
of an advantage, and so the only safety these routines provide is the
assurance that only valid mappings are dereferenced.

The current safe path iterates over each mapping page by page, and
kmap()'s each one individually, which is expensive and unnecessary.
Instead, let's use kern_addr_valid() to establish on a per-VMA basis
whether we may safely derefence them, and do so via its mapping in
the VMALLOC region. This can be done safely due to the fact that we
are holding the vmap_area_lock spinlock.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 mm/vmalloc.c | 103 ++------------------
 1 file changed, 10 insertions(+), 93 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 34a1c3e46ed7..982d29511f92 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1983,87 +1983,6 @@ void *vmalloc_32_user(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_32_user);
 
-/*
- * small helper routine , copy contents to buf from addr.
- * If the page is not present, fill zero.
- */
-
-static int aligned_vread(char *buf, char *addr, unsigned long count)
-{
-	struct page *p;
-	int copied = 0;
-
-	while (count) {
-		unsigned long offset, length;
-
-		offset = offset_in_page(addr);
-		length = PAGE_SIZE - offset;
-		if (length > count)
-			length = count;
-		p = vmalloc_to_page(addr);
-		/*
-		 * To do safe access to this _mapped_ area, we need
-		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calles for this _debug_
-		 * interface, rarely used. Instead of that, we'll use
-		 * kmap() and get small overhead in this access function.
-		 */
-		if (p) {
-			/*
-			 * we can expect USER0 is not used (see vread/vwrite's
-			 * function description)
-			 */
-			void *map = kmap_atomic(p);
-			memcpy(buf, map + offset, length);
-			kunmap_atomic(map);
-		} else
-			memset(buf, 0, length);
-
-		addr += length;
-		buf += length;
-		copied += length;
-		count -= length;
-	}
-	return copied;
-}
-
-static int aligned_vwrite(char *buf, char *addr, unsigned long count)
-{
-	struct page *p;
-	int copied = 0;
-
-	while (count) {
-		unsigned long offset, length;
-
-		offset = offset_in_page(addr);
-		length = PAGE_SIZE - offset;
-		if (length > count)
-			length = count;
-		p = vmalloc_to_page(addr);
-		/*
-		 * To do safe access to this _mapped_ area, we need
-		 * lock. But adding lock here means that we need to add
-		 * overhead of vmalloc()/vfree() calles for this _debug_
-		 * interface, rarely used. Instead of that, we'll use
-		 * kmap() and get small overhead in this access function.
-		 */
-		if (p) {
-			/*
-			 * we can expect USER0 is not used (see vread/vwrite's
-			 * function description)
-			 */
-			void *map = kmap_atomic(p);
-			memcpy(map + offset, buf, length);
-			kunmap_atomic(map);
-		}
-		addr += length;
-		buf += length;
-		copied += length;
-		count -= length;
-	}
-	return copied;
-}
-
 /**
  *	vread() -  read vmalloc area in a safe way.
  *	@buf:		buffer for reading data
@@ -2083,10 +2002,8 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
  *	If [addr...addr+count) doesn't includes any intersects with alive
  *	vm_struct area, returns 0. @buf should be kernel's buffer.
  *
- *	Note: In usual ops, vread() is never necessary because the caller
- *	should know vmalloc() area is valid and can use memcpy().
- *	This is for routines which have to access vmalloc area without
- *	any informaion, as /dev/kmem.
+ *	Note: This routine executes with the vmap_area_lock spinlock held,
+ *	which means it can safely access mappings at their virtual address.
  *
  */
 
@@ -2125,8 +2042,9 @@ long vread(char *buf, char *addr, unsigned long count)
 		n = vaddr + get_vm_area_size(vm) - addr;
 		if (n > count)
 			n = count;
-		if (!(vm->flags & VM_IOREMAP))
-			aligned_vread(buf, addr, n);
+		if (!(vm->flags & VM_IOREMAP) &&
+		    kern_addr_valid((unsigned long)addr))
+			memcpy(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);
 		buf += n;
@@ -2165,10 +2083,8 @@ long vread(char *buf, char *addr, unsigned long count)
  *	If [addr...addr+count) doesn't includes any intersects with alive
  *	vm_struct area, returns 0. @buf should be kernel's buffer.
  *
- *	Note: In usual ops, vwrite() is never necessary because the caller
- *	should know vmalloc() area is valid and can use memcpy().
- *	This is for routines which have to access vmalloc area without
- *	any informaion, as /dev/kmem.
+ *	Note: This routine executes with the vmap_area_lock spinlock held,
+ *	which means it can safely access mappings at their virtual address.
  */
 
 long vwrite(char *buf, char *addr, unsigned long count)
@@ -2206,8 +2122,9 @@ long vwrite(char *buf, char *addr, unsigned long count)
 		n = vaddr + get_vm_area_size(vm) - addr;
 		if (n > count)
 			n = count;
-		if (!(vm->flags & VM_IOREMAP)) {
-			aligned_vwrite(buf, addr, n);
+		if (!(vm->flags & VM_IOREMAP) &&
+		    kern_addr_valid((unsigned long)addr)) {
+			memcpy(addr, buf, n);
 			copied++;
 		}
 		buf += n;
-- 
2.9.3
