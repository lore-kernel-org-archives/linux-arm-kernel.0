From: yromanenko@carrietech.com (Yuriy Romanenko)
Date: Tue, 20 Sep 2016 19:00:28 -0700
Subject: [PATCH] ARM: *: mm: Implement get_user_pages_fast()
Message-ID: <CACOPJM6AC5TwSEPUA7Df8F-FuChrjVP1TWVNeSrHt6ZaSyFiGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 6be781314e78ad43d797915189145a0aae41f639 Mon Sep 17 00:00:00 2001
From: Yuriy Romanenko <yromanenko@carrietech.com>
Date: Tue, 20 Sep 2016 18:50:16 -0700
Subject: [PATCH] ARM: *: mm: Implement get_user_pages_fast()

Will do an unlocked walk of the page table, if that provides everything
necessary, it will succeed and return, otherwise it will call the old
slow path on the remainder

Signed-off-by: Yuriy Romanenko <yromanenko@carrietech.com>
---
 arch/arm/mm/Makefile |  2 +-
 arch/arm/mm/gup.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mm/gup.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f76d96..096cfcb 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -6,7 +6,7 @@ obj-y := dma-mapping.o extable.o fault.o init.o \
    iomap.o

 obj-$(CONFIG_MMU) += fault-armv.o flush.o idmap.o ioremap.o \
-   mmap.o pgd.o mmu.o pageattr.o
+   mmap.o pgd.o mmu.o pageattr.o gup.o

 ifneq ($(CONFIG_MMU),y)
 obj-y += nommu.o
diff --git a/arch/arm/mm/gup.c b/arch/arm/mm/gup.c
new file mode 100644
index 0000000..6e57bc9
--- /dev/null
+++ b/arch/arm/mm/gup.c
@@ -0,0 +1,90 @@
+/*
+ * Lockless get_user_pages_fast for ARM
+ *
+ * Copyright (C) 2014 Lytro, Inc.
+ */
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
+#include <linux/highmem.h>
+#include <linux/swap.h>
+
+#include <asm/pgtable.h>
+
+struct gup_private_data {
+ int nr;
+ struct page **pages;
+ int write;
+};
+
+static int gup_pte_entry(pte_t *ptep, unsigned long start,
+ unsigned long end, struct mm_walk *walk)
+{
+ struct gup_private_data *private_data =
+ (struct gup_private_data *)walk->private;
+ struct page * page;
+ pte_t pte = *ptep;
+ if (!pte_present(pte) ||
+ pte_special(pte) ||
+ (private_data->write && !pte_write(pte)))
+ {
+ return private_data->nr;
+ }
+ page = pte_page(pte);
+ get_page(page);
+ private_data->pages[private_data->nr++] = page;
+ return 0;
+}
+
+static int gup_pte_hole_entry(unsigned long start, unsigned long end,
+ struct mm_walk *walk)
+{
+ struct gup_private_data *private_data =
+ (struct gup_private_data *)walk->private;
+ return private_data->nr;
+}
+
+
+int get_user_pages_fast(unsigned long start, int nr_pages, int write,
+ struct page **pages)
+{
+ struct mm_struct *mm = current->mm;
+ int ret;
+ unsigned long page_addr = (start & PAGE_MASK);
+ int nr = 0;
+
+ struct gup_private_data private_data = {
+ .nr = 0,
+ .pages = pages,
+ .write = write
+ };
+
+ struct mm_walk gup_walk = {
+ .pte_entry = gup_pte_entry,
+ .pte_hole = gup_pte_hole_entry,
+ .mm = mm,
+ .private = (void *)&private_data
+ };
+
+ ret = walk_page_range(page_addr,
+ page_addr + nr_pages * PAGE_SIZE,
+ &gup_walk);
+ nr = ret ? ret : nr_pages;
+
+ if (nr == nr_pages)
+ {
+ return nr;
+ }
+ else
+ {
+ page_addr += (nr << PAGE_SHIFT);
+ }
+
+ down_read(&mm->mmap_sem);
+ ret = get_user_pages(current, mm, page_addr,
+ nr_pages - nr, write, 0, pages + nr, NULL);
+ up_read(&mm->mmap_sem);
+
+ return (ret < 0) ? nr : (ret + nr);
+}
\ No newline@end of file
-- 
2.7.4
