From: panand@redhat.com (Pratyush Anand)
Date: Tue, 23 May 2017 10:32:08 +0530
Subject: [PATCH v3 1/2] kexec: arm64: create identity page table to be used in
 purgatory
In-Reply-To: <cover.1495514291.git.panand@redhat.com>
References: <cover.1495514291.git.panand@redhat.com>
Message-ID: <3355da35facd39ed02e66c0d7d50f86692d565a1.1495514291.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Purgatory sha verification is very slow when D-cache is not enabled there.
We need to enable MMU as well to enable D-Cache.Therefore,we need to
have an identity mapped page table in purgatory.

Since debugging is very difficult in purgatory therefore we prefer to do as
much work as possible in kexec.

This patch prepares page table for purgatory in advance. We support only 4K
page table,because it will be available on most of the platform. This page
table is passed to the purgatory as a new segment.

VA bit is fixed as 48, page table level is 3 where 3rd level page table
contains 2M block entries.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 119 +++++++++++++++++++++++++++++++++++++++++
 kexec/arch/arm64/kexec-mmu.h   |  58 ++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-mmu.h

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 62f37585b788..af5dab331e97 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -17,6 +17,7 @@
 
 #include "kexec.h"
 #include "kexec-arm64.h"
+#include "kexec-mmu.h"
 #include "crashdump.h"
 #include "crashdump-arm64.h"
 #include "dt-ops.h"
@@ -33,6 +34,10 @@
 #define PROP_ELFCOREHDR "linux,elfcorehdr"
 #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
 
+typedef unsigned long guest_addr_t;
+typedef unsigned long host_addr_t;
+static int next_tbl_cnt = 1;
+
 /* Global varables the core kexec routines expect. */
 
 unsigned char reuse_initrd;
@@ -519,6 +524,118 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
 	return hole;
 }
 
+static host_addr_t *create_table_entry(host_addr_t *pgtbl_buf,
+		guest_addr_t pgtbl_mem, host_addr_t *tbl,
+		guest_addr_t virt, int shift,
+		unsigned long ptrs)
+{
+	unsigned long index, desc, offset;
+
+	index = (virt >> shift) & (ptrs - 1);
+	/* check if we have allocated a table already for this index */
+	if (tbl[index]) {
+		/*
+		 * table index will have entry as per purgatory (guest)page
+		 * table memory. Find out corresponding buffer address of
+		 * table (host).
+		 */
+		desc = tbl[index] & ~3UL;
+		offset = desc - pgtbl_mem;
+		return &pgtbl_buf[offset >> 3];
+	}
+
+	if (next_tbl_cnt >= MAX_PGTBLE_SZ / PAGE_SIZE)
+		die("%s:No more memory for page table\n", __func__);
+	/*
+	 * Always write page table content as per page table memory
+	 * allocated for purgatory(guest) area, but return corresponding
+	 * buffer area allocated in kexec (host).
+	 */
+
+	tbl[index] = (pgtbl_mem + PAGE_SIZE * next_tbl_cnt) | PMD_TYPE_TABLE;
+
+	return &pgtbl_buf[(next_tbl_cnt++ * PAGE_SIZE) >> 3];
+}
+
+static void create_block_entry(host_addr_t *tbl, unsigned long flags,
+				guest_addr_t virt)
+{
+	unsigned long index;
+	unsigned long desc;
+
+	index = pmd_index(virt);
+	desc = virt & PMD_MASK;
+	desc |= flags;
+	tbl[index] = desc;
+}
+
+static void create_identity_entry(host_addr_t *pgtbl_buf,
+		guest_addr_t pgtbl_mem, guest_addr_t virt,
+		unsigned long flags)
+{
+	host_addr_t *tbl = pgtbl_buf;
+
+	tbl = create_table_entry(pgtbl_buf, pgtbl_mem, tbl, virt,
+			EXTRA_SHIFT, EXTRA_PTRS);
+	tbl = create_table_entry(pgtbl_buf, pgtbl_mem, tbl, virt,
+			IDENTITY_SHIFT, PTRS_PER_PTE);
+	create_block_entry(tbl, flags, virt);
+}
+
+/**
+ * arm64_create_pgtbl_segment - Create page table segments to be used by
+ * purgatory. Page table will have entries to access memory area of all
+ * those segments which becomes part of sha verification in purgatory.
+ * Additionally, we also create page table for purgatory segment as well.
+ */
+
+static int arm64_create_pgtbl_segment(struct kexec_info *info,
+		unsigned long hole_min, unsigned long hole_max)
+{
+	host_addr_t *pgtbl_buf;
+	guest_addr_t pgtbl_mem, mstart, mend;
+	int i;
+	unsigned long purgatory_base, purgatory_len;
+
+	pgtbl_buf = xmalloc(MAX_PGTBLE_SZ);
+	memset(pgtbl_buf, 0, MAX_PGTBLE_SZ);
+	pgtbl_mem = add_buffer_phys_virt(info, pgtbl_buf, MAX_PGTBLE_SZ,
+			MAX_PGTBLE_SZ, PAGE_SIZE, hole_min, hole_max, 1, 0);
+	for (i = 0; i < info->nr_segments; i++) {
+		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
+			purgatory_base = (unsigned long)info->segment[i].mem;
+			purgatory_len = info->segment[i].memsz;
+		}
+		mstart = (unsigned long)info->segment[i].mem;
+		mend = mstart + info->segment[i].memsz;
+		mstart &= ~(SECTION_SIZE - 1);
+		while (mstart < mend) {
+			create_identity_entry(pgtbl_buf, pgtbl_mem,
+					mstart, MMU_FLAGS_NORMAL);
+			mstart += SECTION_SIZE;
+		}
+	}
+
+	/* we will need pgtble_base in purgatory for enabling d-cache */
+	elf_rel_set_symbol(&info->rhdr, "pgtble_base", &pgtbl_mem,
+		sizeof(pgtbl_mem));
+	/*
+	 * We need to disable d-cache before we exit from purgatory.
+	 * Since, only d-cache flush by VAs is recommended, therefore we
+	 * will also need memory location of all those area which will be
+	 * accessed in purgatory with enabled d-cache. sha256_regions
+	 * already have start and length for all the segments except
+	 * purgatory. Therefore, we will need to pass start and length of
+	 * purgatory additionally.
+	 */
+	elf_rel_set_symbol(&info->rhdr, "purgatory_base", &purgatory_base,
+		sizeof(purgatory_base));
+	elf_rel_set_symbol(&info->rhdr, "purgatory_len", &purgatory_len,
+		sizeof(purgatory_len));
+
+	return 0;
+}
+
 /**
  * arm64_load_other_segments - Prepare the dtb, initrd and purgatory segments.
  */
@@ -630,6 +747,8 @@ int arm64_load_other_segments(struct kexec_info *info,
 	elf_rel_set_symbol(&info->rhdr, "arm64_dtb_addr", &dtb_base,
 		sizeof(dtb_base));
 
+	arm64_create_pgtbl_segment(info, hole_min, hole_max);
+
 	return 0;
 }
 
diff --git a/kexec/arch/arm64/kexec-mmu.h b/kexec/arch/arm64/kexec-mmu.h
new file mode 100644
index 000000000000..55354b5e3002
--- /dev/null
+++ b/kexec/arch/arm64/kexec-mmu.h
@@ -0,0 +1,58 @@
+#if !defined(KEXEC_MMU_H)
+#define KEXEC_MMU_H
+/*
+ * kexec creates identity page table to be used in purgatory so that
+ * dcache verification becomes faster.
+ *
+ * These are the definitions to be used by page table creation routine.
+ *
+ * Only 4K page table, 3 level, 2M block mapping, 48bit VA is supported
+ */
+#define PAGE_SHIFT		12
+#define PGTABLE_LEVELS		3
+#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n) ((PAGE_SHIFT - 3) * (4 - (n)) + 3)
+#define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - PGTABLE_LEVELS)
+#define EXTRA_SHIFT		(PGDIR_SHIFT + PAGE_SHIFT - 3)
+#define EXTRA_PTRS		(1 << (48 - EXTRA_SHIFT))
+#define PUD_SHIFT		PGDIR_SHIFT
+#define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
+#define PMD_SIZE		(1UL << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE-1))
+#define IDENTITY_SHIFT		PUD_SHIFT
+#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
+#define PTRS_PER_PMD		PTRS_PER_PTE
+#define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define PMD_TYPE_TABLE		(3UL << 0)
+#define PMD_TYPE_SECT		(1UL << 0)
+#define PMD_SECT_AF		(1UL << 10)
+#define PMD_ATTRINDX(t)		((unsigned long)(t) << 2)
+#define MT_NORMAL		0
+#define PMD_FLAGS_NORMAL	(PMD_TYPE_SECT | PMD_SECT_AF)
+#define MMU_FLAGS_NORMAL	(PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS_NORMAL)
+#define SECTION_SHIFT		PMD_SHIFT
+#define SECTION_SIZE		(1UL << SECTION_SHIFT)
+#define PAGE_SIZE		(1 << PAGE_SHIFT)
+/*
+ * Since we are using 3 level of page tables, therefore minimum number of
+ * table will be 3. Each entry in level 3 page table can map 2MB memory
+ * area. Thus a level 3 page table indexed by bit 29:21 can map a total of
+ * 1G memory area. Therefore, if any segment crosses 1G boundary, then we
+ * will need one more level 3 table. Similarly, level 2 page table indexed
+ * by bit 38:30 can map a total of 512G memory area. If segment addresses
+ * are more than 512G apart then we will need two more table for each such
+ * block.
+ * Lets consider 2G as the maximum size of crashkernel. This 2G memory
+ * location might not be allocated at 1G aligned boundary, so in that case
+ * we need to have 5 table size resrved to map any location of the crash
+ * kernel region.
+ *
+ * If we will ever wish to support uart debugging in purgatory then that
+ * might cross the boundary and therefore additional 2 more table space. In
+ * that case, we will need a total of 7 table space.
+ *
+ * As of now keep it fixed@5. Increase it if any platform either
+ * supports uart or more than 2G of crash kernel size.
+ */
+#define MAX_PGTBLE_SZ	(5 * PAGE_SIZE)
+
+#endif
-- 
2.9.3
