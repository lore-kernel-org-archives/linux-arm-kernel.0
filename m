From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  2 Oct 2017 15:14:25 +0900
Subject: [PATCH v4 04/10] kexec_file: factor out crashdump elf header function
 from x86
In-Reply-To: <20171002061431.11117-1-takahiro.akashi@linaro.org>
References: <20171002061431.11117-1-takahiro.akashi@linaro.org>
Message-ID: <20171002061431.11117-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prepare_elf_headers() can also be useful for other architectures,
including arm64. So let it factored out.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 324 ------------------------------------------------
 include/linux/kexec.h   |  17 +++
 kernel/kexec_file.c     | 308 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_internal.h |  20 +++
 4 files changed, 345 insertions(+), 324 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 44404e2307bb..3c6b880f6dbf 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -21,7 +21,6 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/export.h>
-#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 #include <asm/processor.h>
@@ -41,34 +40,6 @@
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-/* This primarily represents number of split ranges due to exclusion */
-#define CRASH_MAX_RANGES	16
-
-struct crash_mem_range {
-	u64 start, end;
-};
-
-struct crash_mem {
-	unsigned int nr_ranges;
-	struct crash_mem_range ranges[CRASH_MAX_RANGES];
-};
-
-/* Misc data about ram ranges needed to prepare elf headers */
-struct crash_elf_data {
-	struct kimage *image;
-	/*
-	 * Total number of ram ranges we have after various adjustments for
-	 * crash reserved region, etc.
-	 */
-	unsigned int max_nr_ranges;
-
-	/* Pointer to elf header */
-	void *ehdr;
-	/* Pointer to next phdr */
-	void *bufp;
-	struct crash_mem mem;
-};
-
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -209,301 +180,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_KEXEC_FILE
-static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
-{
-	unsigned int *nr_ranges = arg;
-
-	(*nr_ranges)++;
-	return 0;
-}
-
-
-/* Gather all the required information to prepare elf headers for ram regions */
-static void fill_up_crash_elf_data(struct crash_elf_data *ced,
-				   struct kimage *image)
-{
-	unsigned int nr_ranges = 0;
-
-	ced->image = image;
-
-	walk_system_ram_res(0, -1, &nr_ranges,
-				get_nr_ram_ranges_callback);
-
-	ced->max_nr_ranges = nr_ranges;
-
-	/* Exclusion of crash region could split memory ranges */
-	ced->max_nr_ranges++;
-
-	/* If crashk_low_res is not 0, another range split possible */
-	if (crashk_low_res.end)
-		ced->max_nr_ranges++;
-}
-
-static int exclude_mem_range(struct crash_mem *mem,
-		unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end;
-	struct crash_mem_range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			mstart = start;
-		if (mend > end)
-			mend = end;
-
-		/* Found completely overlapping range */
-		if (mstart == start && mend == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (mstart > start && mend < end) {
-			/* Split original range */
-			mem->ranges[i].end = mstart - 1;
-			temp_range.start = mend + 1;
-			temp_range.end = end;
-		} else if (mstart != start)
-			mem->ranges[i].end = mstart - 1;
-		else
-			mem->ranges[i].start = mend + 1;
-		break;
-	}
-
-	/* If a split happend, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == CRASH_MAX_RANGES - 1) {
-		pr_err("Too many crash ranges after split\n");
-		return -ENOMEM;
-	}
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-/*
- * Look for any unwanted ranges between mstart, mend and remove them. This
- * might lead to split and split ranges are put in ced->mem.ranges[] array
- */
-static int elf_header_exclude_ranges(struct crash_elf_data *ced,
-		unsigned long long mstart, unsigned long long mend)
-{
-	struct crash_mem *cmem = &ced->mem;
-	int ret = 0;
-
-	memset(cmem->ranges, 0, sizeof(cmem->ranges));
-
-	cmem->ranges[0].start = mstart;
-	cmem->ranges[0].end = mend;
-	cmem->nr_ranges = 1;
-
-	/* Exclude crashkernel region */
-	ret = exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		return ret;
-
-	if (crashk_low_res.end) {
-		ret = exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int prepare_elf64_ram_headers_callback(u64 start, u64 end, void *arg)
-{
-	struct crash_elf_data *ced = arg;
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long mstart, mend;
-	struct kimage *image = ced->image;
-	struct crash_mem *cmem;
-	int ret, i;
-
-	ehdr = ced->ehdr;
-
-	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(ced, start, end);
-	if (ret)
-		return ret;
-
-	/* Go through all the ranges in ced->mem.ranges[] and prepare phdr */
-	cmem = &ced->mem;
-
-	for (i = 0; i < cmem->nr_ranges; i++) {
-		mstart = cmem->ranges[i].start;
-		mend = cmem->ranges[i].end;
-
-		phdr = ced->bufp;
-		ced->bufp += sizeof(Elf64_Phdr);
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		/*
-		 * If a range matches backup region, adjust offset to backup
-		 * segment.
-		 */
-		if (mstart == image->arch.backup_src_start &&
-		    (mend - mstart + 1) == image->arch.backup_src_sz)
-			phdr->p_offset = image->arch.backup_load_addr;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-	}
-
-	return ret;
-}
-
-static int prepare_elf64_headers(struct crash_elf_data *ced,
-		void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf, *bufp;
-	unsigned int cpu;
-	unsigned long long notes_addr;
-	int ret;
-
-	/* extra phdr for vmcoreinfo elf note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += ced->max_nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area on x86_64 (ffffffff80000000 - ffffffffa0000000).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two elf headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	bufp = buf;
-	ehdr = (Elf64_Ehdr *)bufp;
-	bufp += sizeof(Elf64_Ehdr);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present cpu */
-	for_each_present_cpu(cpu) {
-		phdr = (Elf64_Phdr *)bufp;
-		bufp += sizeof(Elf64_Phdr);
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-
-#ifdef CONFIG_X86_64
-	/* Prepare PT_LOAD type program header for kernel text region */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
-	phdr->p_type = PT_LOAD;
-	phdr->p_flags = PF_R|PF_W|PF_X;
-	phdr->p_vaddr = (Elf64_Addr)_text;
-	phdr->p_filesz = phdr->p_memsz = _end - _text;
-	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-	(ehdr->e_phnum)++;
-#endif
-
-	/* Prepare PT_LOAD headers for system ram chunks. */
-	ced->ehdr = ehdr;
-	ced->bufp = bufp;
-	ret = walk_system_ram_res(0, -1, ced,
-			prepare_elf64_ram_headers_callback);
-	if (ret < 0)
-		return ret;
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-
-/* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
-{
-	struct crash_elf_data *ced;
-	int ret;
-
-	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
-	if (!ced)
-		return -ENOMEM;
-
-	fill_up_crash_elf_data(ced, image);
-
-	/* By default prepare 64bit headers */
-	ret =  prepare_elf64_headers(ced, addr, sz);
-	kfree(ced);
-	return ret;
-}
-
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c64c29c1fb0e..36d90fa41419 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -162,6 +162,23 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+extern int prepare_elf_headers(struct kimage *image, void **addr,
+				unsigned long *sz);
+
+/* This primarily represents number of split ranges due to exclusion */
+#define CRASH_MAX_RANGES        16
+
+struct crash_mem_range {
+	u64 start, end;
+};
+
+struct crash_mem {
+	unsigned int nr_ranges;
+	struct crash_mem_range ranges[CRASH_MAX_RANGES];
+};
+
+extern int exclude_mem_range(struct crash_mem *mem,
+		unsigned long long mstart, unsigned long long mend);
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 130965b28392..8a7f029c5995 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -22,6 +22,11 @@
 #include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -1074,3 +1079,306 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 
 	return 0;
 }
+
+static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
+{
+	unsigned int *nr_ranges = arg;
+
+	(*nr_ranges)++;
+	return 0;
+}
+
+
+/* Gather all the required information to prepare elf headers for ram regions */
+static void fill_up_crash_elf_data(struct crash_elf_data *ced,
+				   struct kimage *image)
+{
+	unsigned int nr_ranges = 0;
+
+	ced->image = image;
+
+	walk_system_ram_res(0, -1, &nr_ranges,
+				get_nr_ram_ranges_callback);
+
+	ced->max_nr_ranges = nr_ranges;
+
+	/* Exclusion of crash region could split memory ranges */
+	ced->max_nr_ranges++;
+
+#ifdef CONFIG_X86_64
+	/* If crashk_low_res is not 0, another range split possible */
+	if (crashk_low_res.end)
+		ced->max_nr_ranges++;
+#endif
+}
+
+int exclude_mem_range(struct crash_mem *mem,
+		unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end;
+	struct crash_mem_range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			mstart = start;
+		if (mend > end)
+			mend = end;
+
+		/* Found completely overlapping range */
+		if (mstart == start && mend == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (mstart > start && mend < end) {
+			/* Split original range */
+			mem->ranges[i].end = mstart - 1;
+			temp_range.start = mend + 1;
+			temp_range.end = end;
+		} else if (mstart != start)
+			mem->ranges[i].end = mstart - 1;
+		else
+			mem->ranges[i].start = mend + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == CRASH_MAX_RANGES - 1) {
+		pr_err("Too many crash ranges after split\n");
+		return -ENOMEM;
+	}
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
+/*
+ * Look for any unwanted ranges between mstart, mend and remove them. This
+ * might lead to split and split ranges are put in ced->mem.ranges[] array
+ */
+static int elf_header_exclude_ranges(struct crash_elf_data *ced,
+		unsigned long long mstart, unsigned long long mend)
+{
+	struct crash_mem *cmem = &ced->mem;
+	int ret = 0;
+
+	memset(cmem->ranges, 0, sizeof(cmem->ranges));
+
+	cmem->ranges[0].start = mstart;
+	cmem->ranges[0].end = mend;
+	cmem->nr_ranges = 1;
+
+	/* Exclude crashkernel region */
+	ret = exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_X86_64
+	if (crashk_low_res.end) {
+		ret = exclude_mem_range(cmem, crashk_low_res.start,
+							crashk_low_res.end);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return ret;
+}
+
+static int prepare_elf64_ram_headers_callback(u64 start, u64 end, void *arg)
+{
+	struct crash_elf_data *ced = arg;
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long mstart, mend;
+#ifdef CONFIG_X86_64
+	struct kimage *image = ced->image;
+#endif
+	struct crash_mem *cmem;
+	int ret, i;
+
+	ehdr = ced->ehdr;
+
+	/* Exclude unwanted mem ranges */
+	ret = elf_header_exclude_ranges(ced, start, end);
+	if (ret)
+		return ret;
+
+	/* Go through all the ranges in ced->mem.ranges[] and prepare phdr */
+	cmem = &ced->mem;
+
+	for (i = 0; i < cmem->nr_ranges; i++) {
+		mstart = cmem->ranges[i].start;
+		mend = cmem->ranges[i].end;
+
+		phdr = ced->bufp;
+		ced->bufp += sizeof(Elf64_Phdr);
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+#ifdef CONFIG_X86_64
+		/*
+		 * If a range matches backup region, adjust offset to backup
+		 * segment.
+		 */
+		if (mstart == image->arch.backup_src_start &&
+		    (mend - mstart + 1) == image->arch.backup_src_sz)
+			phdr->p_offset = image->arch.backup_load_addr;
+#endif
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+	}
+
+	return ret;
+}
+
+static int prepare_elf64_headers(struct crash_elf_data *ced,
+		void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf, *bufp;
+	unsigned int cpu;
+	unsigned long long notes_addr;
+	int ret;
+
+	/* extra phdr for vmcoreinfo elf note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += ced->max_nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area on x86_64 (ffffffff80000000 - ffffffffa0000000).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two elf headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	bufp = buf;
+	ehdr = (Elf64_Ehdr *)bufp;
+	bufp += sizeof(Elf64_Ehdr);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present cpu */
+	for_each_present_cpu(cpu) {
+		phdr = (Elf64_Phdr *)bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr = (Elf64_Phdr *)bufp;
+	bufp += sizeof(Elf64_Phdr);
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+
+#ifdef CONFIG_X86_64
+	/* Prepare PT_LOAD type program header for kernel text region */
+	phdr = (Elf64_Phdr *)bufp;
+	bufp += sizeof(Elf64_Phdr);
+	phdr->p_type = PT_LOAD;
+	phdr->p_flags = PF_R|PF_W|PF_X;
+	phdr->p_vaddr = (Elf64_Addr)_text;
+	phdr->p_filesz = phdr->p_memsz = _end - _text;
+	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+	(ehdr->e_phnum)++;
+#endif
+
+	/* Prepare PT_LOAD headers for system ram chunks. */
+	ced->ehdr = ehdr;
+	ced->bufp = bufp;
+	ret = walk_system_ram_res(0, -1, ced,
+			prepare_elf64_ram_headers_callback);
+	if (ret < 0)
+		return ret;
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+/* Prepare elf headers. Return addr and size */
+int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
+{
+	struct crash_elf_data *ced;
+	int ret;
+
+	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
+	if (!ced)
+		return -ENOMEM;
+
+	fill_up_crash_elf_data(ced, image);
+
+	/* By default prepare 64bit headers */
+	ret =  prepare_elf64_headers(ced, addr, sz);
+	kfree(ced);
+	return ret;
+}
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 50dfcb039a41..3c7a034f1fe1 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -16,6 +16,26 @@ extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
+
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+/* Misc data about ram ranges needed to prepare elf headers */
+struct crash_elf_data {
+	struct kimage *image;
+	/*
+	 * Total number of ram ranges we have after various adjustments for
+	 * crash reserved region, etc.
+	 */
+	unsigned int max_nr_ranges;
+
+	/* Pointer to elf header */
+	void *ehdr;
+	/* Pointer to next phdr */
+	void *bufp;
+	struct crash_mem mem;
+};
+
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
-- 
2.14.1
