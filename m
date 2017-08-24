From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Aug 2017 17:18:11 +0900
Subject: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-Reply-To: <20170824081811.19299-1-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
Message-ID: <20170824081811.19299-15-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
will be loaded at the offset of TEXT_OFFSET from the begining of system
memory. The other PT_LOAD segments are placed relative to the first one.

Regarding kernel verification, since there is no standard way to contain
a signature within elf binary, we follow PowerPC's (not yet upstreamed)
approach, that is, appending a signature right after the kernel binary
itself like module signing.
This way, the signature can be easily retrieved and verified with
verify_pkcs7_signature().

We can sign the kernel with sign-file command.

Unlike PowerPC, we don't support ima-based kexec for now since arm64
doesn't have any secure solution for system appraisal at this moment.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                     |   8 ++
 arch/arm64/include/asm/kexec_file.h    |   1 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/kexec_elf.c          | 216 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   3 +
 5 files changed, 229 insertions(+)
 create mode 100644 arch/arm64/kernel/kexec_elf.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c8f603700bdd..94021e66b826 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -772,11 +772,19 @@ config KEXEC_FILE_IMAGE_FMT
 	---help---
 	  Select this option to enable 'Image' kernel loading.
 
+config KEXEC_FILE_ELF_FMT
+	bool "Enable vmlinux/elf support"
+	depends on KEXEC_FILE
+	select KEXEC_FILE_ELF
+	---help---
+	  Select this option to enable 'vmlinux' kernel loading.
+
 config KEXEC_VERIFY_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	select SYSTEM_DATA_VERIFICATION
 	select SIGNED_PE_FILE_VERIFICATION if KEXEC_FILE_IMAGE_FMT
+	select MODULE_SIG_FORMAT if KEXEC_FILE_ELF_FMT
 	---help---
 	  This option makes kernel signature verification mandatory for
 	  the kexec_file_load() syscall.
diff --git a/arch/arm64/include/asm/kexec_file.h b/arch/arm64/include/asm/kexec_file.h
index 5df899aa0d2e..eaf2adc1121c 100644
--- a/arch/arm64/include/asm/kexec_file.h
+++ b/arch/arm64/include/asm/kexec_file.h
@@ -2,6 +2,7 @@
 #define _ASM_KEXEC_FILE_H
 
 extern struct kexec_file_ops kexec_image_ops;
+extern struct kexec_file_ops kexec_elf64_ops;
 
 /**
  * struct arm64_image_header - arm64 kernel image header.
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a1161bab6810..1463337160ea 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -52,6 +52,7 @@ arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_KEXEC_FILE_IMAGE_FMT)	+= kexec_image.o
+arm64-obj-$(CONFIG_KEXEC_FILE_ELF_FMT)	+= kexec_elf.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_elf.c b/arch/arm64/kernel/kexec_elf.c
new file mode 100644
index 000000000000..7bd3c1e1f65a
--- /dev/null
+++ b/arch/arm64/kernel/kexec_elf.c
@@ -0,0 +1,216 @@
+/*
+ * Kexec vmlinux loader
+
+ * Copyright (C) 2017 Linaro Limited
+ * Authors: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	"kexec_file(elf): " fmt
+
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/module_signature.h>
+#include <linux/types.h>
+#include <linux/verification.h>
+#include <asm/byteorder.h>
+#include <asm/kexec_file.h>
+#include <asm/memory.h>
+
+static int elf64_probe(const char *buf, unsigned long len)
+{
+	struct elfhdr ehdr;
+
+	/* Check for magic and architecture */
+	memcpy(&ehdr, buf, sizeof(ehdr));
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) ||
+		(elf16_to_cpu(&ehdr, ehdr.e_machine) != EM_AARCH64))
+		return -ENOEXEC;
+
+	return 0;
+}
+
+static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
+			 struct elf_info *elf_info,
+			 unsigned long *kernel_load_addr)
+{
+	struct kexec_buf kbuf;
+	const struct elf_phdr *phdr;
+	const struct arm64_image_header *h;
+	unsigned long text_offset, rand_offset;
+	unsigned long page_offset, phys_offset;
+	int first_segment, i, ret = -ENOEXEC;
+
+	kbuf.image = image;
+	if (image->type == KEXEC_TYPE_CRASH) {
+		kbuf.buf_min = crashk_res.start;
+		kbuf.buf_max = crashk_res.end + 1;
+	} else {
+		kbuf.buf_min = 0;
+		kbuf.buf_max = ULONG_MAX;
+	}
+	kbuf.top_down = 0;
+
+	/* Load PT_LOAD segments. */
+	for (i = 0, first_segment = 1; i < ehdr->e_phnum; i++) {
+		phdr = &elf_info->proghdrs[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		kbuf.buffer = (void *) elf_info->buffer + phdr->p_offset;
+		kbuf.bufsz = min(phdr->p_filesz, phdr->p_memsz);
+		kbuf.memsz = phdr->p_memsz;
+		kbuf.buf_align = phdr->p_align;
+
+		if (first_segment) {
+			/*
+			 * Identify TEXT_OFFSET:
+			 * When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y the image
+			 * header could be offset in the elf segment. The linker
+			 * script sets ehdr->e_entry to the start of text.
+			 *
+			 * NOTE: In v3.16 or older, h->text_offset is 0,
+			 * so use the default, 0x80000
+			 */
+			rand_offset = ehdr->e_entry - phdr->p_vaddr;
+			h = (struct arm64_image_header *)
+					(elf_info->buffer + phdr->p_offset +
+					rand_offset);
+
+			if (!arm64_header_check_magic(h))
+				goto out;
+
+			if (h->image_size)
+				text_offset = le64_to_cpu(h->text_offset);
+			else
+				text_offset = 0x80000;
+
+			/* Adjust kernel segment with TEXT_OFFSET */
+			kbuf.memsz += text_offset - rand_offset;
+
+			ret = kexec_add_buffer(&kbuf);
+			if (ret)
+				goto out;
+
+			image->segment[image->nr_segments - 1].mem
+					+= text_offset - rand_offset;
+			image->segment[image->nr_segments - 1].memsz
+					-= text_offset - rand_offset;
+
+			*kernel_load_addr = kbuf.mem + text_offset;
+
+			/* for succeeding segmemts */
+			page_offset = ALIGN_DOWN(phdr->p_vaddr, SZ_2M);
+			phys_offset = kbuf.mem;
+
+			first_segment = 0;
+		} else {
+			/* Calculate physical address */
+			kbuf.mem = phdr->p_vaddr - page_offset + phys_offset;
+
+			ret = kexec_add_segment(&kbuf);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static void *elf64_load(struct kimage *image, char *kernel_buf,
+			unsigned long kernel_len, char *initrd,
+			unsigned long initrd_len, char *cmdline,
+			unsigned long cmdline_len)
+{
+	struct elfhdr ehdr;
+	struct elf_info elf_info;
+	unsigned long kernel_load_addr;
+	int ret;
+
+	/* Create elf core header segment */
+	ret = load_crashdump_segments(image);
+	if (ret)
+		goto out;
+
+	/* Load the kernel */
+	ret = build_elf_exec_info(kernel_buf, kernel_len, &ehdr, &elf_info);
+	if (ret)
+		goto out;
+
+	ret = elf_exec_load(image, &ehdr, &elf_info, &kernel_load_addr);
+	if (ret)
+		goto out;
+	pr_debug("Loaded the kernel at 0x%lx\n", kernel_load_addr);
+
+	/* Load additional data */
+	ret = load_other_segments(image, kernel_load_addr,
+				initrd, initrd_len, cmdline, cmdline_len);
+
+out:
+	elf_free_info(&elf_info);
+
+	return ERR_PTR(ret);
+}
+
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+/*
+ * The file format is the exact same as module signing:
+ *   <kernel> := <Image> + <signature part> + <marker>
+ *   <signature part> := <signature data> + <struct module_signature>
+ */
+static int elf64_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	const size_t marker_len = sizeof(MODULE_SIG_STRING) - 1;
+	const struct module_signature *sig;
+	size_t file_len = kernel_len;
+	size_t sig_len;
+	const void *p;
+	int rc;
+
+	if (kernel_len <= marker_len + sizeof(*sig))
+		return -ENOENT;
+
+	/* Check for marker */
+	p = kernel + kernel_len - marker_len;
+	if (memcmp(p, MODULE_SIG_STRING, marker_len)) {
+		pr_err("probably the kernel is not signed.\n");
+		return -ENOENT;
+	}
+
+	/* Validate signature */
+	sig = (const struct module_signature *) (p - sizeof(*sig));
+	file_len -= marker_len;
+
+	rc = validate_module_sig(sig, kernel_len - marker_len);
+	if (rc) {
+		pr_err("signature is not valid\n");
+		return rc;
+	}
+
+	/* Verify kernel with signature */
+	sig_len = be32_to_cpu(sig->sig_len);
+	p -= sig_len + sizeof(*sig);
+	file_len -= sig_len + sizeof(*sig);
+
+	rc = verify_pkcs7_signature(kernel, p - (void *)kernel, p, sig_len,
+					NULL, VERIFYING_MODULE_SIGNATURE,
+					NULL, NULL);
+
+	return rc;
+}
+#endif
+
+struct kexec_file_ops kexec_elf64_ops = {
+	.probe = elf64_probe,
+	.load = elf64_load,
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	.verify_sig = elf64_verify_sig,
+#endif
+};
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ab3b19d51727..cb1f24d98f87 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -31,6 +31,9 @@ static struct kexec_file_ops *kexec_file_loaders[] = {
 #ifdef CONFIG_KEXEC_FILE_IMAGE_FMT
 	&kexec_image_ops,
 #endif
+#ifdef CONFIG_KEXEC_FILE_ELF_FMT
+	&kexec_elf64_ops,
+#endif
 };
 
 int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-- 
2.14.1
