From: keescook@chromium.org (Kees Cook)
Date: Thu, 26 Feb 2015 19:07:10 -0800
Subject: [PATCH 1/5] arm: factor out mmap ASLR into mmap_rnd
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
Message-ID: <1425006434-3106-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move logic for mmap ASLR into separate function.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/mmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 5e85ed371364..0f8bc158f2c6 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,14 +169,21 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm)
+static unsigned long mmap_rnd(void)
 {
-	unsigned long random_factor = 0UL;
+	unsigned long rnd = 0UL;
 
 	/* 8 bits of randomness in 20 address space bits */
 	if ((current->flags & PF_RANDOMIZE) &&
 	    !(current->personality & ADDR_NO_RANDOMIZE))
-		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
+		rnd = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
+
+	return rnd;
+}
+
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	unsigned long random_factor = mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-- 
1.9.1
