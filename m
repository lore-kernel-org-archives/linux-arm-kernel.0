From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 13:10:49 -0800
Subject: [PATCH v4 05/10] powerpc: standardize mmap_rnd() usage
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <1425503454-7531-6-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for splitting out ET_DYN ASLR, this refactors the use of
mmap_rnd() to be used similarly to arm and x86.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
Can mmap ASLR be safely enabled in the legacy mmap case here? Other archs
use "mm->mmap_base = TASK_UNMAPPED_BASE + random_factor".
---
 arch/powerpc/mm/mmap.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index cb8bdbe4972f..1ad2299d795d 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -55,19 +55,18 @@ static inline int mmap_is_legacy(void)
 
 static unsigned long mmap_rnd(void)
 {
-	unsigned long rnd = 0;
+	unsigned long rnd;
+
+	/* 8MB for 32bit, 1GB for 64bit */
+	if (is_32bit_task())
+		rnd = (unsigned long)get_random_int() % (1<<(23-PAGE_SHIFT));
+	else
+		rnd = (unsigned long)get_random_int() % (1<<(30-PAGE_SHIFT));
 
-	if (current->flags & PF_RANDOMIZE) {
-		/* 8MB for 32bit, 1GB for 64bit */
-		if (is_32bit_task())
-			rnd = (long)(get_random_int() % (1<<(23-PAGE_SHIFT)));
-		else
-			rnd = (long)(get_random_int() % (1<<(30-PAGE_SHIFT)));
-	}
 	return rnd << PAGE_SHIFT;
 }
 
-static inline unsigned long mmap_base(void)
+static inline unsigned long mmap_base(unsigned long rnd)
 {
 	unsigned long gap = rlimit(RLIMIT_STACK);
 
@@ -76,7 +75,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
 }
 
 /*
@@ -85,6 +84,11 @@ static inline unsigned long mmap_base(void)
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
@@ -93,7 +97,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 		mm->mmap_base = TASK_UNMAPPED_BASE;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
-		mm->mmap_base = mmap_base();
+		mm->mmap_base = mmap_base(random_factor);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
1.9.1
