From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Oct 2015 08:54:52 +0100
Subject: [PATCH] arm: Omit fixmap calls in text patching code if CONFIG_MMU=n
Message-ID: <1445846092-1979-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_JUMP_LABEL=y and CONFIG_MMU=n:

    arch/arm/kernel/patch.c: In function 'patch_map':
    arch/arm/kernel/patch.c:39:129: error: 'L_PTE_YOUNG' undeclared (first use in this function)
      set_fixmap(fixmap, page_to_phys(page));
																     ^
    arch/arm/kernel/patch.c:39:129: note: each undeclared identifier is reported only once for each function it appears in
    arch/arm/kernel/patch.c:39:143: error: 'L_PTE_PRESENT' undeclared (first use in this function)
      set_fixmap(fixmap, page_to_phys(page));
																		   ^
    arch/arm/kernel/patch.c:39:159: error: 'L_PTE_XN' undeclared (first use in this function)
      set_fixmap(fixmap, page_to_phys(page));
																				   ^
    arch/arm/kernel/patch.c:39:170: error: 'L_PTE_DIRTY' undeclared (first use in this function)
      set_fixmap(fixmap, page_to_phys(page));
																					      ^
    arch/arm/kernel/patch.c:39:185: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function)
      set_fixmap(fixmap, page_to_phys(page));
																							     ^

Protect the calls to set_fixmap() and clear_fixmap() by #ifdef
CONFIG_MMU to fix this.

Fixes: commit ab0615e2d6fb0747 ("arm: use fixmap for text patching when text is RO")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/12531538/

 arch/arm/kernel/patch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a5707ee826..447b53a68be5bd6f 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -36,7 +36,9 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	else
 		__acquire(&patch_lock);
 
+#ifdef CONFIG_MMU
 	set_fixmap(fixmap, page_to_phys(page));
+#endif
 
 	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
 }
@@ -44,7 +46,9 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	__releases(&patch_lock)
 {
+#ifdef CONFIG_MMU
 	clear_fixmap(fixmap);
+#endif
 
 	if (flags)
 		spin_unlock_irqrestore(&patch_lock, *flags);
-- 
1.9.1
