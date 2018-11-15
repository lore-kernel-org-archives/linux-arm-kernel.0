From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:51 +0900
Subject: [PATCH v16 12/16] arm64: kexec_file: add crash dump support
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-13-takahiro.akashi@linaro.org>
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
Reviewed-by: James Morse <james.morse@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree at vger.kernel.org
---
 arch/arm64/include/asm/kexec.h         |  4 ++
 arch/arm64/kernel/machine_kexec_file.c | 97 +++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 67e4cb75d1fd..660705515e33 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+	/* Core ELF header buffer */
+	void *elf_headers;
+	unsigned long elf_headers_mem;
+	unsigned long elf_headers_sz;
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7e9d5ed3e238..ab296b98d633 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,11 +16,15 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
+#define FDT_PSTR_KEXEC_ELFHDR	"linux,elfcorehdr"
+#define FDT_PSTR_MEM_RANGE	"linux,usable-memory-range"
 #define FDT_PSTR_INITRD_STA	"linux,initrd-start"
 #define FDT_PSTR_INITRD_END	"linux,initrd-end"
 #define FDT_PSTR_BOOTARGS	"bootargs"
@@ -35,6 +39,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
+	vfree(image->arch.elf_headers);
+	image->arch.elf_headers = NULL;
+	image->arch.elf_headers_sz = 0;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
 
@@ -49,6 +57,22 @@ static int setup_dtb(struct kimage *image,
 	if (nodeoffset < 0)
 		return -EINVAL;
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_setprop_reg(dtb, nodeoffset, FDT_PSTR_KEXEC_ELFHDR,
+				image->arch.elf_headers_mem,
+				image->arch.elf_headers_sz);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		/* add linux,usable-memory-range */
+		ret = fdt_setprop_reg(dtb, nodeoffset, FDT_PSTR_MEM_RANGE,
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	}
+
 	/* add bootargs */
 	if (cmdline) {
 		ret = fdt_setprop_string(dtb, nodeoffset, FDT_PSTR_BOOTARGS,
@@ -86,7 +110,8 @@ static int setup_dtb(struct kimage *image,
 }
 
 /*
- * More space needed so that we can add initrd and bootargs.
+ * More space needed so that we can add initrd, bootargs,
+ * userable-memory-range and elfcorehdr.
  */
 #define DTB_EXTRA_SPACE 0x1000
 
@@ -132,6 +157,43 @@ static int create_dtb(struct kimage *image,
 	}
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
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+					MEMBLOCK_NONE, &start, &end, NULL)
+		nr_ranges++;
+
+	cmem = kmalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
+	if (!cmem)
+		return -ENOMEM;
+
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+					MEMBLOCK_NONE, &start, &end, NULL) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+
+	if (!ret)
+		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+
+	kfree(cmem);
+	return ret;
+}
+
 int load_other_segments(struct kimage *image,
 			unsigned long kernel_load_addr,
 			unsigned long kernel_size,
@@ -139,14 +201,43 @@ int load_other_segments(struct kimage *image,
 			char *cmdline)
 {
 	struct kexec_buf kbuf;
-	void *dtb = NULL;
-	unsigned long initrd_load_addr = 0, dtb_len;
+	void *headers, *dtb = NULL;
+	unsigned long headers_sz, initrd_load_addr = 0, dtb_len;
 	int ret = 0;
 
 	kbuf.image = image;
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
+	/* load elf core header */
+	if (image->type == KEXEC_TYPE_CRASH) {
+		ret = prepare_elf_headers(&headers, &headers_sz);
+		if (ret) {
+			pr_err("Preparing elf core header failed\n");
+			goto out_err;
+		}
+
+		kbuf.buffer = headers;
+		kbuf.bufsz = headers_sz;
+		kbuf.mem = 0;
+		kbuf.memsz = headers_sz;
+		kbuf.buf_align = SZ_64K; /* largest supported page size */
+		kbuf.buf_max = ULONG_MAX;
+		kbuf.top_down = true;
+
+		ret = kexec_add_buffer(&kbuf);
+		if (ret) {
+			vfree(headers);
+			goto out_err;
+		}
+		image->arch.elf_headers = headers;
+		image->arch.elf_headers_mem = kbuf.mem;
+		image->arch.elf_headers_sz = headers_sz;
+
+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			 image->arch.elf_headers_mem, headers_sz, headers_sz);
+	}
+
 	/* load initrd */
 	if (initrd) {
 		kbuf.buffer = initrd;
-- 
2.19.0
