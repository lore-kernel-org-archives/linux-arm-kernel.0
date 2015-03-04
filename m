From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:45 -0800
Subject: [PATCH v4 01/10] arm: factor out mmap ASLR into mmap_rnd
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <1425503454-7531-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for splitting out ET_DYN ASLR, this moves the ASLR calculations
for mmap on ARM into a separate routine, similar to x86. This also removes
the redundant check of personality (PF_RANDOMIZE is already set before calling
arch_pick_mmap_layout).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/mmap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 5e85ed371364..15a8160096b3 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,14 +169,22 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
+static unsigned long mmap_rnd(void)
+{
+	unsigned long rnd;
+
+	/* 8 bits of randomness in 20 address space bits */
+	rnd = (unsigned long)get_random_int() % (1 << 8);
+
+	return rnd << PAGE_SHIFT;
+}
+
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
 
-	/* 8 bits of randomness in 20 address space bits */
-	if ((current->flags & PF_RANDOMIZE) &&
-	    !(current->personality & ADDR_NO_RANDOMIZE))
-		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-- 
1.9.1
