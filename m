From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 14:11:06 +0100
Subject: [PATCHv2 2/2] arm64: hibernate: handle allocation failures
In-Reply-To: <1470921066-27421-1-git-send-email-mark.rutland@arm.com>
References: <1470921066-27421-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1470921066-27421-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In create_safe_exec_page(), we create a copy of the hibernate exit text,
along with some page tables to map this via TTBR0. We then install the
new tables in TTBR0.

In swsusp_arch_resume() we call create_safe_exec_page() before trying a
number of operations which may fail (e.g. copying the linear map page
tables). If these fail, we bail out of swsusp_arch_resume() and return
an error code, but leave TTBR0 as-is. Subsequently, the core hibernate
code will call free_basic_memory_bitmaps(), which will free all of the
memory allocations we made, including the page tables installed in
TTBR0.

Thus, we may have TTBR0 pointing at dangling freed memory for some
period of time. If the hibernate attempt was triggered by a user
requesting a hibernate test via the reboot syscall, we may return to
userspace with the clobbered TTBR0 value.

Avoid these issues by reorganising swsusp_arch_resume() such that we
have no failure paths after create_safe_exec_page(). We also add a check
that the zero page allocation succeeded, matching what we have for other
allocations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 82869ac57b5d3b55 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
---
 arch/arm64/kernel/hibernate.c | 59 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b2e7de8..65d81f9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -405,6 +405,38 @@ int swsusp_arch_resume(void)
 					  void *, phys_addr_t, phys_addr_t);
 
 	/*
+	 * Restoring the memory image will overwrite the ttbr1 page tables.
+	 * Create a second copy of just the linear map, and use this when
+	 * restoring.
+	 */
+	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!tmp_pg_dir) {
+		pr_err("Failed to allocate memory for temporary page tables.");
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
+	if (rc)
+		goto out;
+
+	/*
+	 * Since we only copied the linear map, we need to find restore_pblist's
+	 * linear map address.
+	 */
+	lm_restore_pblist = LMADDR(restore_pblist);
+
+	/*
+	 * We need a zero page that is zero before & after resume in order to
+	 * to break before make on the ttbr1 page tables.
+	 */
+	zero_page = (void *)get_safe_page(GFP_ATOMIC);
+	if (!zero_page) {
+		pr_err("Failed to allocate zero page.");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/*
 	 * Locate the exit code in the bottom-but-one page, so that *NULL
 	 * still has disastrous affects.
 	 */
@@ -430,27 +462,6 @@ int swsusp_arch_resume(void)
 	__flush_dcache_area(hibernate_exit, exit_size);
 
 	/*
-	 * Restoring the memory image will overwrite the ttbr1 page tables.
-	 * Create a second copy of just the linear map, and use this when
-	 * restoring.
-	 */
-	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
-	if (!tmp_pg_dir) {
-		pr_err("Failed to allocate memory for temporary page tables.");
-		rc = -ENOMEM;
-		goto out;
-	}
-	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
-	if (rc)
-		goto out;
-
-	/*
-	 * Since we only copied the linear map, we need to find restore_pblist's
-	 * linear map address.
-	 */
-	lm_restore_pblist = LMADDR(restore_pblist);
-
-	/*
 	 * KASLR will cause the el2 vectors to be in a different location in
 	 * the resumed kernel. Load hibernate's temporary copy into el2.
 	 *
@@ -464,12 +475,6 @@ int swsusp_arch_resume(void)
 		__hyp_set_vectors(el2_vectors);
 	}
 
-	/*
-	 * We need a zero page that is zero before & after resume in order to
-	 * to break before make on the ttbr1 page tables.
-	 */
-	zero_page = (void *)get_safe_page(GFP_ATOMIC);
-
 	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
 		       resume_hdr.reenter_kernel, lm_restore_pblist,
 		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
-- 
1.9.1
