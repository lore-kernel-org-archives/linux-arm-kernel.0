From: keescook@chromium.org (Kees Cook)
Date: Tue,  3 Mar 2015 18:10:19 -0800
Subject: [PATCH v3 04/10] mips: extract logic for mmap_rnd()
In-Reply-To: <1425435025-30284-1-git-send-email-keescook@chromium.org>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
Message-ID: <1425435025-30284-5-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for splitting out ET_DYN ASLR, extract the mmap ASLR
selection into a separate function.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/mm/mmap.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index f1baadd56e82..673a5cfe082f 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -142,18 +142,26 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 			addr0, len, pgoff, flags, DOWN);
 }
 
+static unsigned long mmap_rnd(void)
+{
+	unsigned long rnd;
+
+	rnd = (unsigned long)get_random_int();
+	rnd <<= PAGE_SHIFT;
+	if (TASK_IS_32BIT_ADDR)
+		random_factor &= 0xfffffful;
+	else
+		random_factor &= 0xffffffful;
+
+	return rnd;
+}
+
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
 
-	if (current->flags & PF_RANDOMIZE) {
-		random_factor = get_random_int();
-		random_factor = random_factor << PAGE_SHIFT;
-		if (TASK_IS_32BIT_ADDR)
-			random_factor &= 0xfffffful;
-		else
-			random_factor &= 0xffffffful;
-	}
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-- 
1.9.1
