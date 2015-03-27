From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Mar 2015 11:18:00 +0100
Subject: [PATCH] ARM, arm64: kvm: get rid of the bounce page
Message-ID: <1427451481-16053-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HYP init bounce page is a runtime construct that ensures that the
HYP init code does not cross a page boundary. However, this is something
we can do perfectly well at build time, by aligning the code appropriately.

For both ARM and arm64, we just align to 4 KB, and enforce that the code
size is less than 4 KB, regardless of the chosen page size.

Note that this also fixes a benign off-by-one error in the original bounce
page code, where a bounce page would be allocated unnecessarily if the code
was exactly 1 page in size.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S   | 11 +++++++----
 arch/arm/kvm/mmu.c              | 42 +++++------------------------------------
 arch/arm64/kernel/vmlinux.lds.S | 17 +++++++++++------
 3 files changed, 23 insertions(+), 47 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73e8076..f2db429ea75d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -23,7 +23,7 @@
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
-	. = ALIGN(32);							\
+	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
@@ -346,8 +346,11 @@ SECTIONS
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+
 /*
- * The HYP init code can't be more than a page long.
+ * The HYP init code can't be more than a page long,
+ * and should not cross a page boundary.
  * The above comment applies as well.
  */
-ASSERT(((__hyp_idmap_text_end - __hyp_idmap_text_start) <= PAGE_SIZE), "HYP init code too big")
+ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & PAGE_MASK) <= PAGE_SIZE,
+	"HYP init code too big or misaligned")
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 3e6859bc3e11..42a24d6b003b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -37,7 +37,6 @@ static pgd_t *boot_hyp_pgd;
 static pgd_t *hyp_pgd;
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
-static void *init_bounce_page;
 static unsigned long hyp_idmap_start;
 static unsigned long hyp_idmap_end;
 static phys_addr_t hyp_idmap_vector;
@@ -405,9 +404,6 @@ void free_boot_hyp_pgd(void)
 	if (hyp_pgd)
 		unmap_range(NULL, hyp_pgd, TRAMPOLINE_VA, PAGE_SIZE);
 
-	free_page((unsigned long)init_bounce_page);
-	init_bounce_page = NULL;
-
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }
 
@@ -1498,39 +1494,11 @@ int kvm_mmu_init(void)
 	hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
 	hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
 
-	if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
-		/*
-		 * Our init code is crossing a page boundary. Allocate
-		 * a bounce page, copy the code over and use that.
-		 */
-		size_t len = __hyp_idmap_text_end - __hyp_idmap_text_start;
-		phys_addr_t phys_base;
-
-		init_bounce_page = (void *)__get_free_page(GFP_KERNEL);
-		if (!init_bounce_page) {
-			kvm_err("Couldn't allocate HYP init bounce page\n");
-			err = -ENOMEM;
-			goto out;
-		}
-
-		memcpy(init_bounce_page, __hyp_idmap_text_start, len);
-		/*
-		 * Warning: the code we just copied to the bounce page
-		 * must be flushed to the point of coherency.
-		 * Otherwise, the data may be sitting in L2, and HYP
-		 * mode won't be able to observe it as it runs with
-		 * caches off at that point.
-		 */
-		kvm_flush_dcache_to_poc(init_bounce_page, len);
-
-		phys_base = kvm_virt_to_phys(init_bounce_page);
-		hyp_idmap_vector += phys_base - hyp_idmap_start;
-		hyp_idmap_start = phys_base;
-		hyp_idmap_end = phys_base + len;
-
-		kvm_info("Using HYP init bounce page @%lx\n",
-			 (unsigned long)phys_base);
-	}
+	/*
+	 * We rely on the linker script to ensure at build time that the HYP
+	 * init code does not cross a page boundary.
+	 */
+	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
 
 	hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
 	boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5d9d2dca530d..a2c29865c3fe 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -23,10 +23,14 @@ jiffies = jiffies_64;
 
 #define HYPERVISOR_TEXT					\
 	/*						\
-	 * Force the alignment to be compatible with	\
-	 * the vectors requirements			\
+	 * Align to 4 KB so that			\
+	 * a) the HYP vector table is@its minimum	\
+	 *    alignment of 2048 bytes			\
+	 * b) the HYP init code will not cross a page	\
+	 *    boundary if its size does not exceed	\
+	 *    4 KB (see related ASSERT() below)		\
 	 */						\
-	. = ALIGN(2048);				\
+	. = ALIGN(SZ_4K);				\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
 	*(.hyp.idmap.text)				\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
@@ -163,10 +167,11 @@ SECTIONS
 }
 
 /*
- * The HYP init code can't be more than a page long.
+ * The HYP init code can't be more than a page long,
+ * and should not cross a page boundary.
  */
-ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) > __hyp_idmap_text_end),
-       "HYP init code too big")
+ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
+	"HYP init code too big or misaligned")
 
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
-- 
1.8.3.2
