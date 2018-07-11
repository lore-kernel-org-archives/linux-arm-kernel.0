From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 11 Jul 2018 16:41:59 +0900
Subject: [PATCH v11 11/15] arm64: kexec_file: add crash dump support
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Message-ID: <20180711074203.3019-12-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling crash dump (kdump) includes
* prepare contents of ELF header of a core dump file, /proc/vmcore,
  using crash_prepare_elf64_headers(), and
* add two device tree properties, "linux,usable-memory-range" and
  "linux,elfcorehdr", which represent respectively a memory range
  to be used by crash dump kernel and the header's location

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/kexec_image.c        |   9 +-
 arch/arm64/kernel/machine_kexec_file.c | 114 ++++++++++++++++++++++++-
 3 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 69333694e3e2..eeb5766928b0 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	phys_addr_t dtb_mem;
 	void *dtb_buf;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_sz;
+	unsigned long elf_load_addr;
 };
 
 /**
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index a47cf9bc699e..df1e341d3a28 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -67,8 +67,13 @@ static void *image_load(struct kimage *image,
 
 	/* Load the kernel */
 	kbuf.image = image;
-	kbuf.buf_min = 0;
-	kbuf.buf_max = ULONG_MAX;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
 	kbuf.top_down = false;
 
 	kbuf.buffer = kernel;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a0b44fe18b95..261564df7210 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,7 +16,9 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
@@ -29,6 +31,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb_buf);
 	image->arch.dtb_buf = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -38,13 +44,31 @@ static int setup_dtb(struct kimage *image,
 		char **dtb_buf, size_t *dtb_buf_len)
 {
 	char *buf = NULL;
-	size_t buf_size;
+	size_t buf_size, range_size;
 	int nodeoffset;
 	u64 value;
 	int ret;
 
+	/* check ranges against root's #address-cells and #size-cells */
+	if (image->type == KEXEC_TYPE_CRASH &&
+		(!of_fdt_cells_size_fitted(image->arch.elf_load_addr,
+				image->arch.elf_headers_sz) ||
+		 !of_fdt_cells_size_fitted(crashk_res.start,
+				crashk_res.end - crashk_res.start + 1))) {
+		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
+		ret = -EINVAL;
+		goto out_err;
+	}
+
 	/* duplicate dt blob */
 	buf_size = fdt_totalsize(initial_boot_params);
+	range_size = of_fdt_reg_cells_size();
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
+		buf_size += fdt_prop_len("linux,usable-memory-range",
+								range_size);
+	}
 
 	if (initrd_load_addr) {
 		/* can be redundant, but trimmed at the end */
@@ -74,6 +98,23 @@ static int setup_dtb(struct kimage *image,
 		goto out_err;
 	}
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_reg(buf, nodeoffset, "linux,elfcorehdr",
+				image->arch.elf_load_addr,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out_err;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_reg(buf, nodeoffset,
+				"linux,usable-memory-range",
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out_err;
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(buf, nodeoffset, "bootargs", cmdline);
@@ -132,6 +173,45 @@ static int setup_dtb(struct kimage *image,
 	return ret;
 }
 
+static int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	struct crash_mem *cmem;
+	unsigned int nr_ranges;
+	int ret;
+	u64 i;
+	phys_addr_t start, end;
+
+	nr_ranges = 1; /* for exclusion of crashkernel region */
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
+							&start, &end, NULL)
+		nr_ranges++;
+
+	cmem = kmalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
+							&start, &end, NULL) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+out:
+	kfree(cmem);
+	return ret;
+}
+
 int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
@@ -139,11 +219,43 @@ int load_other_segments(struct kimage *image,
 			char *cmdline, unsigned long cmdline_len)
 {
 	struct kexec_buf kbuf;
+	void *hdrs_addr;
+	unsigned long hdrs_sz;
 	unsigned long initrd_load_addr = 0;
 	char *dtb = NULL;
 	unsigned long dtb_len = 0;
 	int ret = 0;
 
+	/* load elf core header */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&hdrs_addr, &hdrs_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.image = image;
+		kbuf.buffer = hdrs_addr;
+		kbuf.bufsz = hdrs_sz;
+		kbuf.memsz = hdrs_sz;
+		kbuf.buf_align = PAGE_SIZE;
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(hdrs_addr);
+			goto out_err;
+		}
+		image->arch.elf_headers = hdrs_addr;
+		image->arch.elf_headers_sz = hdrs_sz;
+		image->arch.elf_load_addr = kbuf.mem;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
+	}
+
 	kbuf.image = image;
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
-- 
2.17.0
