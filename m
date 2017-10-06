From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 6 Oct 2017 16:11:53 +0900
Subject: [PATCH v4 08/10] arm64: kexec_file: set up for crash dump adding
 elf core header
In-Reply-To: <74f89c3b-fd2e-0ed5-5be4-4b1fd8d95617@arm.com>
References: <20171002061431.11117-1-takahiro.akashi@linaro.org>
 <20171002061431.11117-9-takahiro.akashi@linaro.org>
 <74f89c3b-fd2e-0ed5-5be4-4b1fd8d95617@arm.com>
Message-ID: <20171006071152.GC6756@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 03:15:52PM +0100, Julien Thierry wrote:
> 
> 
> On 02/10/17 07:14, AKASHI Takahiro wrote:
> >load_crashdump_segments() creates and loads a memory segment of elf core
> >header for crash dump.
> >
> >"linux,usable-memory-range" and "linux,elfcorehdr" will add to the 2nd
> >kernel's device-tree blob. The logic of this cod is also from kexec-tools.
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >---
> >  arch/arm64/include/asm/kexec.h         |   5 ++
> >  arch/arm64/kernel/machine_kexec_file.c | 149 +++++++++++++++++++++++++++++++++
> >  kernel/kexec_file.c                    |   2 +-
> >  3 files changed, 155 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> >index 2fadd3cbf3af..edb702e64a8a 100644
> >--- a/arch/arm64/include/asm/kexec.h
> >+++ b/arch/arm64/include/asm/kexec.h
> >@@ -98,6 +98,10 @@ static inline void crash_post_resume(void) {}
> >  struct kimage_arch {
> >  	void *dtb_buf;
> >+	/* Core ELF header buffer */
> >+	void *elf_headers;
> >+	unsigned long elf_headers_sz;
> >+	unsigned long elf_load_addr;
> >  };
> >  struct kimage;
> >@@ -113,6 +117,7 @@ extern int load_other_segments(struct kimage *image,
> >  		unsigned long kernel_load_addr,
> >  		char *initrd, unsigned long initrd_len,
> >  		char *cmdline, unsigned long cmdline_len);
> >+extern int load_crashdump_segments(struct kimage *image);
> >  #endif
> >  #endif /* __ASSEMBLY__ */
> >diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >index 8a09d89f6266..1d30b4773af5 100644
> >--- a/arch/arm64/kernel/machine_kexec_file.c
> >+++ b/arch/arm64/kernel/machine_kexec_file.c
> >@@ -32,6 +32,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  	vfree(image->arch.dtb_buf);
> >  	image->arch.dtb_buf = NULL;
> >+	vfree(image->arch.elf_headers);
> >+	image->arch.elf_headers = NULL;
> >+	image->arch.elf_headers_sz = 0;
> >+
> >  	return _kexec_kernel_post_load_cleanup(image);
> >  }
> >@@ -48,6 +52,77 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf, int (*func)(u64, u64, void *))
> >  		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
> >  }
> >+static int __init arch_kexec_file_init(void)
> >+{
> >+	/* Those values are used later on loading the kernel */
> >+	__dt_root_addr_cells = dt_root_addr_cells;
> >+	__dt_root_size_cells = dt_root_size_cells;
> >+
> >+	return 0;
> >+}
> >+late_initcall(arch_kexec_file_init);
> >+
> >+#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> >+#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
> >+
> >+static int fdt_prop_len(const char *prop_name, int len)
> >+{
> >+	return (strlen(prop_name) + 1) +
> >+		sizeof(struct fdt_property) +
> >+		FDT_TAGALIGN(len);
> >+}
> >+
> >+static bool cells_size_fitted(unsigned long base, unsigned long size)
> >+{
> >+	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> >+	if ((__dt_root_addr_cells == 1) && (base >= (1ULL << 32)))
> >+		return false;
> >+
> >+	if ((__dt_root_size_cells == 1) && (size >= (1ULL << 32)))
> >+		return false;
> >+
> >+	return true;
> >+}
> >+
> >+static void fill_property(void *buf, u64 val64, int cells)
> >+{
> >+	u32 val32;
> >+	int i;
> >+
> >+	if (cells == 1) {
> >+		val32 = cpu_to_fdt32((u32)val64);
> >+		memcpy(buf, &val32, sizeof(val32));
> >+	} else {
> >+		for (i = 0; i < (cells * sizeof(u32) - sizeof(u64)); i++)
> >+			*(char *)buf++ = 0;
> >+
> 
> Should we use memset for this?

Sure.

> >+		val64 = cpu_to_fdt64(val64);
> >+		memcpy(buf, &val64, sizeof(val64));
> >+	}
> >+}
> >+
> >+static int fdt_setprop_range(void *fdt, int nodeoffset, const char *name,
> >+				unsigned long addr, unsigned long size)
> >+{
> >+	u64 range[2];
> 
> Could we just add some BUG/WARN when either __dt_root_addr_cells or
> __dt_root_size_cells is greater than 2?

Since I want to keep this function generic, I will change it to use
vmalloc().

> Both to make sure we have sane values and because it will be easier to debug
> than overwriting things on the stack.
> 
> >+	void *prop;
> >+	size_t buf_size;
> >+	int result;
> >+
> >+	prop = range;
> >+	buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
> >+
> >+	fill_property(prop, addr, __dt_root_addr_cells);
> >+	prop += __dt_root_addr_cells * sizeof(u32);
> >+
> >+	fill_property(prop, size, __dt_root_size_cells);
> >+	prop += __dt_root_size_cells * sizeof(u32);
> 
> This is not needed (or at least we aren't doing anything with it).

Sure.

> Apart from that, patch seems fine.

Thank you for reviewing.

-Takahiro AKASHI

> Cheers,
> 
> >+
> >+	result = fdt_setprop(fdt, nodeoffset, name, range, buf_size);
> >+
> >+	return result;
> >+}
> >+
> >  int setup_dtb(struct kimage *image,
> >  		unsigned long initrd_load_addr, unsigned long initrd_len,
> >  		char *cmdline, unsigned long cmdline_len,
> >@@ -60,10 +135,26 @@ int setup_dtb(struct kimage *image,
> >  	int range_len;
> >  	int ret;
> >+	/* check ranges against root's #address-cells and #size-cells */
> >+	if (image->type == KEXEC_TYPE_CRASH &&
> >+		(!cells_size_fitted(image->arch.elf_load_addr,
> >+				image->arch.elf_headers_sz) ||
> >+		 !cells_size_fitted(crashk_res.start,
> >+				crashk_res.end - crashk_res.start + 1))) {
> >+		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
> >+		ret = -EINVAL;
> >+		goto out_err;
> >+	}
> >+
> >  	/* duplicate dt blob */
> >  	buf_size = fdt_totalsize(initial_boot_params);
> >  	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
> >+	if (image->type == KEXEC_TYPE_CRASH)
> >+		buf_size += fdt_prop_len("linux,elfcorehdr", range_len)
> >+				+ fdt_prop_len("linux,usable-memory-range",
> >+								range_len);
> >+
> >  	if (initrd_load_addr)
> >  		buf_size += fdt_prop_len("initrd-start", sizeof(u64))
> >  				+ fdt_prop_len("initrd-end", sizeof(u64));
> >@@ -85,6 +176,23 @@ int setup_dtb(struct kimage *image,
> >  	if (nodeoffset < 0)
> >  		goto out_err;
> >+	if (image->type == KEXEC_TYPE_CRASH) {
> >+		/* add linux,elfcorehdr */
> >+		ret = fdt_setprop_range(buf, nodeoffset, "linux,elfcorehdr",
> >+				image->arch.elf_load_addr,
> >+				image->arch.elf_headers_sz);
> >+		if (ret)
> >+			goto out_err;
> >+
> >+		/* add linux,usable-memory-range */
> >+		ret = fdt_setprop_range(buf, nodeoffset,
> >+				"linux,usable-memory-range",
> >+				crashk_res.start,
> >+				crashk_res.end - crashk_res.start + 1);
> >+		if (ret)
> >+			goto out_err;
> >+	}
> >+
> >  	/* add bootargs */
> >  	if (cmdline) {
> >  		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> >@@ -211,3 +319,44 @@ int load_other_segments(struct kimage *image, unsigned long kernel_load_addr,
> >  	image->arch.dtb_buf = NULL;
> >  	return ret;
> >  }
> >+
> >+int load_crashdump_segments(struct kimage *image)
> >+{
> >+	void *elf_addr;
> >+	unsigned long elf_sz;
> >+	struct kexec_buf kbuf;
> >+	int ret;
> >+
> >+	if (image->type != KEXEC_TYPE_CRASH)
> >+		return 0;
> >+
> >+	/* Prepare elf headers and add a segment */
> >+	ret = prepare_elf_headers(image, &elf_addr, &elf_sz);
> >+	if (ret) {
> >+		pr_err("Preparing elf core header failed\n");
> >+		return ret;
> >+	}
> >+
> >+	kbuf.image = image;
> >+	kbuf.buffer = elf_addr;
> >+	kbuf.bufsz = elf_sz;
> >+	kbuf.memsz = elf_sz;
> >+	kbuf.buf_align = PAGE_SIZE;
> >+	kbuf.buf_min = crashk_res.start;
> >+	kbuf.buf_max = crashk_res.end + 1;
> >+	kbuf.top_down = 1;
> >+
> >+	ret = kexec_add_buffer(&kbuf);
> >+	if (ret) {
> >+		vfree(elf_addr);
> >+		return ret;
> >+	}
> >+	image->arch.elf_headers = elf_addr;
> >+	image->arch.elf_headers_sz = elf_sz;
> >+	image->arch.elf_load_addr = kbuf.mem;
> >+
> >+	pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> >+			 image->arch.elf_load_addr, elf_sz, elf_sz);
> >+
> >+	return ret;
> >+}
> >diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >index 8a7f029c5995..82a98f284cf5 100644
> >--- a/kernel/kexec_file.c
> >+++ b/kernel/kexec_file.c
> >@@ -1340,7 +1340,7 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
> >  	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> >  	(ehdr->e_phnum)++;
> >-#ifdef CONFIG_X86_64
> >+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> >  	/* Prepare PT_LOAD type program header for kernel text region */
> >  	phdr = (Elf64_Phdr *)bufp;
> >  	bufp += sizeof(Elf64_Phdr);
> >
> 
> -- 
> Julien Thierry
