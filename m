From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 21 Oct 2010 20:09:42 +0300
Subject: [PATCH RESEND] ARM: fix spinlock recursion in adjust_pte()
In-Reply-To: <20101021164433.GH4772@gw.healthdatacare.com>
References: <20101021164433.GH4772@gw.healthdatacare.com>
Message-ID: <1287680982-22971-1-git-send-email-mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running following code in a machine which has VIVT caches and
USE_SPLIT_PTLOCKS is not defined:

  fd = open("/etc/passwd", O_RDONLY);
  addr = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);
  addr2 = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);

  v = *((int *)addr);

we will hang in spinlock recursion in the page fault handler:

  BUG: spinlock recursion on CPU#0, mmap_test/717
  lock: c5e295d8, .magic: dead4ead, .owner: mmap_test/717,
                  .owner_cpu: 0
  [<c0026604>] (unwind_backtrace+0x0/0xec)
  [<c014ee48>] (do_raw_spin_lock+0x40/0x140)
  [<c0027f68>] (update_mmu_cache+0x208/0x250)
  [<c0079db4>] (__do_fault+0x320/0x3ec)
  [<c007af7c>] (handle_mm_fault+0x2f0/0x6d8)
  [<c0027834>] (do_page_fault+0xdc/0x1cc)
  [<c00202d0>] (do_DataAbort+0x34/0x94)

Same thing can be achieved by running:

  # useradd dummy

This comes from the fact that when USE_SPLIT_PTLOCKS is not defined,
the only lock protecting the page tables is mm->page_table_lock
which is already locked before update_mmu_cache() is called.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mm/fault-armv.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 9b906de..56036ff 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -65,6 +65,30 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	return ret;
 }
 
+#if USE_SPLIT_PTLOCKS
+/*
+ * If we are using split PTE locks, then we need to take the page
+ * lock here.  Otherwise we are using shared mm->page_table_lock
+ * which is already locked, thus cannot take it.
+ */
+static inline void do_pte_lock(spinlock_t *ptl)
+{
+	/*
+	 * Use nested version here to indicate that we are already
+	 * holding one similar spinlock.
+	 */
+	spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+}
+
+static inline void do_pte_unlock(spinlock_t *ptl)
+{
+	spin_unlock(ptl);
+}
+#else /* !USE_SPLIT_PTLOCKS */
+static inline void do_pte_lock(spinlock_t *ptl) {}
+static inline void do_pte_unlock(spinlock_t *ptl) {}
+#endif /* USE_SPLIT_PTLOCKS */
+
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	unsigned long pfn)
 {
@@ -89,11 +113,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 */
 	ptl = pte_lockptr(vma->vm_mm, pmd);
 	pte = pte_offset_map_nested(pmd, address);
-	spin_lock(ptl);
+	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	spin_unlock(ptl);
+	do_pte_unlock(ptl);
 	pte_unmap_nested(pte);
 
 	return ret;
-- 
1.5.6.5
