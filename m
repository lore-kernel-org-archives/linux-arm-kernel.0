From: manjeet.p@samsung.com (Manjeet Pawar)
Date: Thu, 23 Jun 2016 17:43:40 +0530
Subject: [PATCH] arm64:swiotlb:Enable only when Input size through command line
Message-ID: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Thapliyal <r.thapliyal@samsung.com>

swiotlb default size of 64M is too big as
default value therefore it is made configurable
through command line through swiotlb_size parameter.
swiotlb allocation shall be done only when the
swiotlb size is given through command line.
Otherwise no swiotlb is allocated.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
Reviewed-by: Ajeet Kumar Yadav <ajeet.y@samsung.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 arch/arm64/mm/init.c                |    3 ++-
 include/linux/swiotlb.h             |    1 +
 lib/swiotlb.c                       |   33 +++++++++++++++++++++++++++++----
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 82b42c9..12b680f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3875,6 +3875,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 
+	swiotlb_sz= [KNL] enter swiotlb size.
+			Sets the swiotlb size for eg. swiotlb_sz=64M
+
 	switches=	[HW,M68k]
 
 	sysfs.deprecated=0|1 [KNL]
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d45f862..89c6b39 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -403,7 +403,8 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
-	swiotlb_init(1);
+	if (swiotlb_enabled)
+		swiotlb_init(1);
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 017fced..c7eb146 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -11,6 +11,7 @@ struct page;
 struct scatterlist;
 
 extern int swiotlb_force;
+extern int swiotlb_enabled;
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ec..e89296a 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -54,6 +54,7 @@
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 
 int swiotlb_force;
+int swiotlb_enabled;
 
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
@@ -96,6 +97,9 @@ static DEFINE_SPINLOCK(io_tlb_lock);
 
 static int late_alloc;
 
+unsigned long swiotlb_sz;
+unsigned int swiotlb_sz_shift;
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -112,6 +116,24 @@ setup_io_tlb_npages(char *str)
 	return 0;
 }
 early_param("swiotlb", setup_io_tlb_npages);
+
+static int __init
+setup_io_tlb_size(char *str)
+{
+	int len = strlen(str);
+
+	if (str[len-1] == 'M')
+		swiotlb_sz_shift = 20;
+	else if (str[len-1] == 'K')
+		swiotlb_sz_shift = 10;
+	str[len-1] = '\0';
+	if (isdigit(*str))
+		swiotlb_sz = kstrtoul(str, &str, 0);
+
+	swiotlb_enabled = 1;
+	return 0;
+}
+early_param("swiotlb_sz", setup_io_tlb_size);
 /* make io_tlb_overflow tunable too? */
 
 unsigned long swiotlb_nr_tbl(void)
@@ -120,8 +142,9 @@ unsigned long swiotlb_nr_tbl(void)
 }
 EXPORT_SYMBOL_GPL(swiotlb_nr_tbl);
 
-/* default to 64MB */
-#define IO_TLB_DEFAULT_SIZE (64UL<<20)
+/* Pass from command line as swiotlb_sz=64M (for eg.)*/
+#define IO_TLB_DEFAULT_SIZE (swiotlb_sz<<swiotlb_sz_shift)
+
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
@@ -153,10 +176,12 @@ void swiotlb_print_info(void)
 	vstart = phys_to_virt(io_tlb_start);
 	vend = phys_to_virt(io_tlb_end);
 
-	printk(KERN_INFO "software IO TLB [mem %#010llx-%#010llx] (%luMB) mapped at [%p-%p]\n",
+	pr_info("software IO TLB [mem %#010llx-%#010llx] (%lu%cB) mapped@[%p-%p]\n",
 	       (unsigned long long)io_tlb_start,
 	       (unsigned long long)io_tlb_end,
-	       bytes >> 20, vstart, vend - 1);
+		bytes >> swiotlb_sz_shift,
+		swiotlb_sz_shift == 20 ? 'M' : 'K',
+		vstart, vend - 1);
 }
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
-- 
1.7.9.5
