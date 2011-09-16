From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:28 -0400
Subject: [PATCH 17/19] ARM: simplify __iounmap() when dealing with section
	based mapping
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-18-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Firstly, there is no need to have a double pointer here as we're only
walking the vmlist and not modifying it.

Secondly, for the same reason, we don't need a write lock but only a
read lock here, since the lock only protects the coherency of the list
nothing else.

Lastly, the reason for holding a lock is not what the comment says, so
let's remove that misleading piece of information.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/ioremap.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab506272b2..1ddcd8aa34 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -293,26 +293,24 @@ void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
 #ifndef CONFIG_SMP
-	struct vm_struct **p, *tmp;
+	struct vm_struct *vm;
 
 	/*
 	 * If this is a section based mapping we need to handle it
 	 * specially as the VM subsystem does not know how to handle
-	 * such a beast. We need the lock here b/c we need to clear
-	 * all the mappings before the area can be reclaimed
-	 * by someone else.
+	 * such a beast.
 	 */
-	write_lock(&vmlist_lock);
-	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
-		if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
-			if (tmp->flags & VM_ARM_SECTION_MAPPING) {
-				unmap_area_sections((unsigned long)tmp->addr,
-						    tmp->size);
+	read_lock(&vmlist_lock);
+	for (vm = vmlist; vm; vm = vm->next) {
+		if ((vm->flags & VM_IOREMAP) && (vm->addr == addr)) {
+			if (vm->flags & VM_ARM_SECTION_MAPPING) {
+				unmap_area_sections((unsigned long)vm->addr,
+						    vm->size);
 			}
 			break;
 		}
 	}
-	write_unlock(&vmlist_lock);
+	read_unlock(&vmlist_lock);
 #endif
 
 	vunmap(addr);
-- 
1.7.7-rc0
