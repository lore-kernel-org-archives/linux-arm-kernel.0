From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 26 Aug 2010 15:02:30 +0300
Subject: [PATCH v2 4/6] crash/diskdump: add ARM support
In-Reply-To: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <4077ca13865cabc9dafb64b4d533388897a4aa81.1282822832.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ARM support for makedumpfile generated diskdump files.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 diskdump.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/diskdump.c b/diskdump.c
index 79e72ad..3aab338 100644
--- a/diskdump.c
+++ b/diskdump.c
@@ -249,6 +249,9 @@ restart:
 	else if (STRNEQ(header->utsname.machine, "ppc64") &&
 	    machine_type_mismatch(file, "PPC64", NULL, 0))
 		goto err;
+	else if (STRNEQ(header->utsname.machine, "arm") &&
+	    machine_type_mismatch(file, "ARM", NULL, 0))
+		goto err;
 
 	if (header->block_size != block_size) {
 		block_size = header->block_size;
@@ -335,7 +338,9 @@ restart:
 
 	dd->header = header;
 
-	if (machine_type("X86"))
+	if (machine_type("ARM"))
+		dd->machine_type = EM_ARM;
+	else if (machine_type("X86"))
 		dd->machine_type = EM_386;
 	else if (machine_type("X86_64"))
 		dd->machine_type = EM_X86_64;
@@ -516,6 +521,17 @@ page_is_cached(physaddr_t paddr)
 }
 
 /*
+ * Translate physical address in paddr to PFN number. This means normally that
+ * we just shift paddr by some constant. Some architectures need special
+ * handling for this, however.
+ */
+static ulong
+paddr_to_pfn(physaddr_t paddr)
+{
+	return paddr >> dd->block_shift;
+}
+
+/*
  *  Cache the page's data.
  *
  *  If an empty page cache location is available, take it.  Otherwise, evict
@@ -560,7 +576,7 @@ cache_page(physaddr_t paddr)
 	dd->page_cache_hdr[i].pg_hit_count++;
 
 	/* find page descriptor */
-	pfn = paddr >> dd->block_shift;
+	pfn = paddr_to_pfn(paddr);
 	desc_pos = pfn_to_pos(pfn);
 	seek_offset = dd->data_offset
 			+ (off_t)(desc_pos - 1)*sizeof(page_desc_t);
@@ -613,7 +629,7 @@ read_diskdump(int fd, void *bufptr, int cnt, ulong addr, physaddr_t paddr)
 	physaddr_t curpaddr;
 	ulong pfn, page_offset;
 
-	pfn = paddr >> dd->block_shift;
+	pfn = paddr_to_pfn(paddr);
 
 	if (KDUMP_SPLIT()) {
 		/* Find proper dd */
@@ -687,6 +703,12 @@ get_diskdump_regs_ppc64(struct bt_info *bt, ulong *eip, ulong *esp)
 	machdep->get_stack_frame(bt, eip, esp);
 }
 
+static void
+get_diskdump_regs_arm(struct bt_info *bt, ulong *eip, ulong *esp)
+{
+	machdep->get_stack_frame(bt, eip, esp);
+}
+
 /*
  *  Send the request to the proper architecture hander.
  */
@@ -696,6 +718,10 @@ get_diskdump_regs(struct bt_info *bt, ulong *eip, ulong *esp)
 {
 	switch (dd->machine_type) 
 	{
+	case EM_ARM:
+		get_diskdump_regs_arm(bt, eip, esp);
+		break;
+
 	case EM_386:
 		return get_netdump_regs_x86(bt, eip, esp);
 		break;
@@ -784,6 +810,8 @@ __diskdump_memory_dump(FILE *fp)
         fprintf(fp, "      machine_type: %d ", dd->machine_type);
 	switch (dd->machine_type)
 	{
+	case EM_ARM:
+		fprintf(fp, "(EM_ARM)\n"); break;
 	case EM_386:
 		fprintf(fp, "(EM_386)\n"); break;
 	case EM_X86_64:
-- 
1.5.6.5
