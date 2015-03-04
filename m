From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:50 -0800
Subject: [PATCH v4 06/10] s390: standardize mmap_rnd() usage
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <1425503454-7531-7-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for splitting out ET_DYN ASLR, this refactors the use of
mmap_rnd() to be used similarly to arm and x86, and extracts the checking
of PF_RANDOMIZE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/mm/mmap.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 179a2c20b01f..db57078075c5 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -62,20 +62,18 @@ static inline int mmap_is_legacy(void)
 
 static unsigned long mmap_rnd(void)
 {
-	if (!(current->flags & PF_RANDOMIZE))
-		return 0;
 	if (is_32bit_task())
 		return (get_random_int() & 0x7ff) << PAGE_SHIFT;
 	else
 		return (get_random_int() & mmap_rnd_mask) << PAGE_SHIFT;
 }
 
-static unsigned long mmap_base_legacy(void)
+static unsigned long mmap_base_legacy(unsigned long rnd)
 {
-	return TASK_UNMAPPED_BASE + mmap_rnd();
+	return TASK_UNMAPPED_BASE + rnd;
 }
 
-static inline unsigned long mmap_base(void)
+static inline unsigned long mmap_base(unsigned long rnd)
 {
 	unsigned long gap = rlimit(RLIMIT_STACK);
 
@@ -84,7 +82,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 	gap &= PAGE_MASK;
-	return STACK_TOP - stack_maxrandom_size() - mmap_rnd() - gap;
+	return STACK_TOP - stack_maxrandom_size() - rnd - gap;
 }
 
 unsigned long
@@ -187,7 +185,11 @@ unsigned long randomize_et_dyn(void)
 	if (!is_32bit_task())
 		/* Align to 4GB */
 		base &= ~((1UL << 32) - 1);
-	return base + mmap_rnd();
+
+	if (current->flags & PF_RANDOMIZE)
+		base += mmap_rnd();
+
+	return base;
 }
 
 #ifndef CONFIG_64BIT
@@ -198,15 +200,20 @@ unsigned long randomize_et_dyn(void)
  */
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
+	unsigned long random_factor = 0UL;
+
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
+
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
 	 */
 	if (mmap_is_legacy()) {
-		mm->mmap_base = mmap_base_legacy();
+		mm->mmap_base = mmap_base_legacy(random_factor);
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
-		mm->mmap_base = mmap_base();
+		mm->mmap_base = mmap_base(random_factor);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
@@ -273,15 +280,20 @@ s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
  */
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
+	unsigned long random_factor = 0UL;
+
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
+
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
 	 */
 	if (mmap_is_legacy()) {
-		mm->mmap_base = mmap_base_legacy();
+		mm->mmap_base = mmap_base_legacy(random_factor);
 		mm->get_unmapped_area = s390_get_unmapped_area;
 	} else {
-		mm->mmap_base = mmap_base();
+		mm->mmap_base = mmap_base(random_factor);
 		mm->get_unmapped_area = s390_get_unmapped_area_topdown;
 	}
 }
-- 
1.9.1
