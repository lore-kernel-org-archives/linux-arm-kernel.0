From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Aug 2017 17:18:01 +0900
Subject: [PATCH 04/14] kexec_file: factor out vmlinux (elf) parser from powerpc
In-Reply-To: <20170824081811.19299-1-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
Message-ID: <20170824081811.19299-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

build_elf_exec_info() can also be useful for other architectures,
including arm64. So let it factored out.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/Kconfig                       |   3 +
 arch/powerpc/Kconfig               |   1 +
 arch/powerpc/kernel/kexec_elf_64.c | 464 -------------------------------------
 include/linux/elf.h                |  62 +++++
 include/linux/kexec.h              |  19 ++
 kernel/Makefile                    |   1 +
 kernel/kexec_file_elf.c            | 454 ++++++++++++++++++++++++++++++++++++
 7 files changed, 540 insertions(+), 464 deletions(-)
 create mode 100644 kernel/kexec_file_elf.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 21d0089117fe..e940d16412f4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,9 @@ config KEXEC_CORE
 	select CRASH_CORE
 	bool
 
+config KEXEC_FILE_ELF
+	bool
+
 config HAVE_IMA_KEXEC
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c37ca7..f73921bbe29a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -529,6 +529,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select KEXEC_FILE_ELF
 	select HAVE_IMA_KEXEC
 	select BUILD_BIN2C
 	depends on PPC64
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 9a42309b091a..a0c92bd14259 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -26,475 +26,11 @@
 #include <linux/elf.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
-#include <linux/module.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
-#include <linux/types.h>
 
 #define PURGATORY_STACK_SIZE	(16 * 1024)
 
-#define elf_addr_to_cpu	elf64_to_cpu
-
-#ifndef Elf_Rel
-#define Elf_Rel		Elf64_Rel
-#endif /* Elf_Rel */
-
-struct elf_info {
-	/*
-	 * Where the ELF binary contents are kept.
-	 * Memory managed by the user of the struct.
-	 */
-	const char *buffer;
-
-	const struct elfhdr *ehdr;
-	const struct elf_phdr *proghdrs;
-	struct elf_shdr *sechdrs;
-};
-
-static inline bool elf_is_elf_file(const struct elfhdr *ehdr)
-{
-       return memcmp(ehdr->e_ident, ELFMAG, SELFMAG) == 0;
-}
-
-static uint64_t elf64_to_cpu(const struct elfhdr *ehdr, uint64_t value)
-{
-	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		value = le64_to_cpu(value);
-	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		value = be64_to_cpu(value);
-
-	return value;
-}
-
-static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
-{
-	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		value = le16_to_cpu(value);
-	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		value = be16_to_cpu(value);
-
-	return value;
-}
-
-static uint32_t elf32_to_cpu(const struct elfhdr *ehdr, uint32_t value)
-{
-	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
-		value = le32_to_cpu(value);
-	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
-		value = be32_to_cpu(value);
-
-	return value;
-}
-
-/**
- * elf_is_ehdr_sane - check that it is safe to use the ELF header
- * @buf_len:	size of the buffer in which the ELF file is loaded.
- */
-static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
-{
-	if (ehdr->e_phnum > 0 && ehdr->e_phentsize != sizeof(struct elf_phdr)) {
-		pr_debug("Bad program header size.\n");
-		return false;
-	} else if (ehdr->e_shnum > 0 &&
-		   ehdr->e_shentsize != sizeof(struct elf_shdr)) {
-		pr_debug("Bad section header size.\n");
-		return false;
-	} else if (ehdr->e_ident[EI_VERSION] != EV_CURRENT ||
-		   ehdr->e_version != EV_CURRENT) {
-		pr_debug("Unknown ELF version.\n");
-		return false;
-	}
-
-	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
-		size_t phdr_size;
-
-		/*
-		 * e_phnum is at most 65535 so calculating the size of the
-		 * program header cannot overflow.
-		 */
-		phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
-
-		/* Sanity check the program header table location. */
-		if (ehdr->e_phoff + phdr_size < ehdr->e_phoff) {
-			pr_debug("Program headers at invalid location.\n");
-			return false;
-		} else if (ehdr->e_phoff + phdr_size > buf_len) {
-			pr_debug("Program headers truncated.\n");
-			return false;
-		}
-	}
-
-	if (ehdr->e_shoff > 0 && ehdr->e_shnum > 0) {
-		size_t shdr_size;
-
-		/*
-		 * e_shnum is at most 65536 so calculating
-		 * the size of the section header cannot overflow.
-		 */
-		shdr_size = sizeof(struct elf_shdr) * ehdr->e_shnum;
-
-		/* Sanity check the section header table location. */
-		if (ehdr->e_shoff + shdr_size < ehdr->e_shoff) {
-			pr_debug("Section headers at invalid location.\n");
-			return false;
-		} else if (ehdr->e_shoff + shdr_size > buf_len) {
-			pr_debug("Section headers truncated.\n");
-			return false;
-		}
-	}
-
-	return true;
-}
-
-static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
-{
-	struct elfhdr *buf_ehdr;
-
-	if (len < sizeof(*buf_ehdr)) {
-		pr_debug("Buffer is too small to hold ELF header.\n");
-		return -ENOEXEC;
-	}
-
-	memset(ehdr, 0, sizeof(*ehdr));
-	memcpy(ehdr->e_ident, buf, sizeof(ehdr->e_ident));
-	if (!elf_is_elf_file(ehdr)) {
-		pr_debug("No ELF header magic.\n");
-		return -ENOEXEC;
-	}
-
-	if (ehdr->e_ident[EI_CLASS] != ELF_CLASS) {
-		pr_debug("Not a supported ELF class.\n");
-		return -ENOEXEC;
-	} else  if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
-		ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
-		pr_debug("Not a supported ELF data format.\n");
-		return -ENOEXEC;
-	}
-
-	buf_ehdr = (struct elfhdr *) buf;
-	if (elf16_to_cpu(ehdr, buf_ehdr->e_ehsize) != sizeof(*buf_ehdr)) {
-		pr_debug("Bad ELF header size.\n");
-		return -ENOEXEC;
-	}
-
-	ehdr->e_type      = elf16_to_cpu(ehdr, buf_ehdr->e_type);
-	ehdr->e_machine   = elf16_to_cpu(ehdr, buf_ehdr->e_machine);
-	ehdr->e_version   = elf32_to_cpu(ehdr, buf_ehdr->e_version);
-	ehdr->e_entry     = elf_addr_to_cpu(ehdr, buf_ehdr->e_entry);
-	ehdr->e_phoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_phoff);
-	ehdr->e_shoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_shoff);
-	ehdr->e_flags     = elf32_to_cpu(ehdr, buf_ehdr->e_flags);
-	ehdr->e_phentsize = elf16_to_cpu(ehdr, buf_ehdr->e_phentsize);
-	ehdr->e_phnum     = elf16_to_cpu(ehdr, buf_ehdr->e_phnum);
-	ehdr->e_shentsize = elf16_to_cpu(ehdr, buf_ehdr->e_shentsize);
-	ehdr->e_shnum     = elf16_to_cpu(ehdr, buf_ehdr->e_shnum);
-	ehdr->e_shstrndx  = elf16_to_cpu(ehdr, buf_ehdr->e_shstrndx);
-
-	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
-}
-
-/**
- * elf_is_phdr_sane - check that it is safe to use the program header
- * @buf_len:	size of the buffer in which the ELF file is loaded.
- */
-static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
-{
-
-	if (phdr->p_offset + phdr->p_filesz < phdr->p_offset) {
-		pr_debug("ELF segment location wraps around.\n");
-		return false;
-	} else if (phdr->p_offset + phdr->p_filesz > buf_len) {
-		pr_debug("ELF segment not in file.\n");
-		return false;
-	} else if (phdr->p_paddr + phdr->p_memsz < phdr->p_paddr) {
-		pr_debug("ELF segment address wraps around.\n");
-		return false;
-	}
-
-	return true;
-}
-
-static int elf_read_phdr(const char *buf, size_t len, struct elf_info *elf_info,
-			 int idx)
-{
-	/* Override the const in proghdrs, we are the ones doing the loading. */
-	struct elf_phdr *phdr = (struct elf_phdr *) &elf_info->proghdrs[idx];
-	const char *pbuf;
-	struct elf_phdr *buf_phdr;
-
-	pbuf = buf + elf_info->ehdr->e_phoff + (idx * sizeof(*buf_phdr));
-	buf_phdr = (struct elf_phdr *) pbuf;
-
-	phdr->p_type   = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_type);
-	phdr->p_offset = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_offset);
-	phdr->p_paddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_paddr);
-	phdr->p_vaddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_vaddr);
-	phdr->p_flags  = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_flags);
-
-	/*
-	 * The following fields have a type equivalent to Elf_Addr
-	 * both in 32 bit and 64 bit ELF.
-	 */
-	phdr->p_filesz = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_filesz);
-	phdr->p_memsz  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_memsz);
-	phdr->p_align  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_align);
-
-	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
-}
-
-/**
- * elf_read_phdrs - read the program headers from the buffer
- *
- * This function assumes that the program header table was checked for sanity.
- * Use elf_is_ehdr_sane() if it wasn't.
- */
-static int elf_read_phdrs(const char *buf, size_t len,
-			  struct elf_info *elf_info)
-{
-	size_t phdr_size, i;
-	const struct elfhdr *ehdr = elf_info->ehdr;
-
-	/*
-	 * e_phnum is at most 65535 so calculating the size of the
-	 * program header cannot overflow.
-	 */
-	phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
-
-	elf_info->proghdrs = kzalloc(phdr_size, GFP_KERNEL);
-	if (!elf_info->proghdrs)
-		return -ENOMEM;
-
-	for (i = 0; i < ehdr->e_phnum; i++) {
-		int ret;
-
-		ret = elf_read_phdr(buf, len, elf_info, i);
-		if (ret) {
-			kfree(elf_info->proghdrs);
-			elf_info->proghdrs = NULL;
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * elf_is_shdr_sane - check that it is safe to use the section header
- * @buf_len:	size of the buffer in which the ELF file is loaded.
- */
-static bool elf_is_shdr_sane(const struct elf_shdr *shdr, size_t buf_len)
-{
-	bool size_ok;
-
-	/* SHT_NULL headers have undefined values, so we can't check them. */
-	if (shdr->sh_type == SHT_NULL)
-		return true;
-
-	/* Now verify sh_entsize */
-	switch (shdr->sh_type) {
-	case SHT_SYMTAB:
-		size_ok = shdr->sh_entsize == sizeof(Elf_Sym);
-		break;
-	case SHT_RELA:
-		size_ok = shdr->sh_entsize == sizeof(Elf_Rela);
-		break;
-	case SHT_DYNAMIC:
-		size_ok = shdr->sh_entsize == sizeof(Elf_Dyn);
-		break;
-	case SHT_REL:
-		size_ok = shdr->sh_entsize == sizeof(Elf_Rel);
-		break;
-	case SHT_NOTE:
-	case SHT_PROGBITS:
-	case SHT_HASH:
-	case SHT_NOBITS:
-	default:
-		/*
-		 * This is a section whose entsize requirements
-		 * I don't care about.  If I don't know about
-		 * the section I can't care about it's entsize
-		 * requirements.
-		 */
-		size_ok = true;
-		break;
-	}
-
-	if (!size_ok) {
-		pr_debug("ELF section with wrong entry size.\n");
-		return false;
-	} else if (shdr->sh_addr + shdr->sh_size < shdr->sh_addr) {
-		pr_debug("ELF section address wraps around.\n");
-		return false;
-	}
-
-	if (shdr->sh_type != SHT_NOBITS) {
-		if (shdr->sh_offset + shdr->sh_size < shdr->sh_offset) {
-			pr_debug("ELF section location wraps around.\n");
-			return false;
-		} else if (shdr->sh_offset + shdr->sh_size > buf_len) {
-			pr_debug("ELF section not in file.\n");
-			return false;
-		}
-	}
-
-	return true;
-}
-
-static int elf_read_shdr(const char *buf, size_t len, struct elf_info *elf_info,
-			 int idx)
-{
-	struct elf_shdr *shdr = &elf_info->sechdrs[idx];
-	const struct elfhdr *ehdr = elf_info->ehdr;
-	const char *sbuf;
-	struct elf_shdr *buf_shdr;
-
-	sbuf = buf + ehdr->e_shoff + idx * sizeof(*buf_shdr);
-	buf_shdr = (struct elf_shdr *) sbuf;
-
-	shdr->sh_name      = elf32_to_cpu(ehdr, buf_shdr->sh_name);
-	shdr->sh_type      = elf32_to_cpu(ehdr, buf_shdr->sh_type);
-	shdr->sh_addr      = elf_addr_to_cpu(ehdr, buf_shdr->sh_addr);
-	shdr->sh_offset    = elf_addr_to_cpu(ehdr, buf_shdr->sh_offset);
-	shdr->sh_link      = elf32_to_cpu(ehdr, buf_shdr->sh_link);
-	shdr->sh_info      = elf32_to_cpu(ehdr, buf_shdr->sh_info);
-
-	/*
-	 * The following fields have a type equivalent to Elf_Addr
-	 * both in 32 bit and 64 bit ELF.
-	 */
-	shdr->sh_flags     = elf_addr_to_cpu(ehdr, buf_shdr->sh_flags);
-	shdr->sh_size      = elf_addr_to_cpu(ehdr, buf_shdr->sh_size);
-	shdr->sh_addralign = elf_addr_to_cpu(ehdr, buf_shdr->sh_addralign);
-	shdr->sh_entsize   = elf_addr_to_cpu(ehdr, buf_shdr->sh_entsize);
-
-	return elf_is_shdr_sane(shdr, len) ? 0 : -ENOEXEC;
-}
-
-/**
- * elf_read_shdrs - read the section headers from the buffer
- *
- * This function assumes that the section header table was checked for sanity.
- * Use elf_is_ehdr_sane() if it wasn't.
- */
-static int elf_read_shdrs(const char *buf, size_t len,
-			  struct elf_info *elf_info)
-{
-	size_t shdr_size, i;
-
-	/*
-	 * e_shnum is at most 65536 so calculating
-	 * the size of the section header cannot overflow.
-	 */
-	shdr_size = sizeof(struct elf_shdr) * elf_info->ehdr->e_shnum;
-
-	elf_info->sechdrs = kzalloc(shdr_size, GFP_KERNEL);
-	if (!elf_info->sechdrs)
-		return -ENOMEM;
-
-	for (i = 0; i < elf_info->ehdr->e_shnum; i++) {
-		int ret;
-
-		ret = elf_read_shdr(buf, len, elf_info, i);
-		if (ret) {
-			kfree(elf_info->sechdrs);
-			elf_info->sechdrs = NULL;
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * elf_read_from_buffer - read ELF file and sets up ELF header and ELF info
- * @buf:	Buffer to read ELF file from.
- * @len:	Size of @buf.
- * @ehdr:	Pointer to existing struct which will be populated.
- * @elf_info:	Pointer to existing struct which will be populated.
- *
- * This function allows reading ELF files with different byte order than
- * the kernel, byte-swapping the fields as needed.
- *
- * Return:
- * On success returns 0, and the caller should call elf_free_info(elf_info) to
- * free the memory allocated for the section and program headers.
- */
-int elf_read_from_buffer(const char *buf, size_t len, struct elfhdr *ehdr,
-			 struct elf_info *elf_info)
-{
-	int ret;
-
-	ret = elf_read_ehdr(buf, len, ehdr);
-	if (ret)
-		return ret;
-
-	elf_info->buffer = buf;
-	elf_info->ehdr = ehdr;
-	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
-		ret = elf_read_phdrs(buf, len, elf_info);
-		if (ret)
-			return ret;
-	}
-	if (ehdr->e_shoff > 0 && ehdr->e_shnum > 0) {
-		ret = elf_read_shdrs(buf, len, elf_info);
-		if (ret) {
-			kfree(elf_info->proghdrs);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * elf_free_info - free memory allocated by elf_read_from_buffer
- */
-void elf_free_info(struct elf_info *elf_info)
-{
-	kfree(elf_info->proghdrs);
-	kfree(elf_info->sechdrs);
-	memset(elf_info, 0, sizeof(*elf_info));
-}
-/**
- * build_elf_exec_info - read ELF executable and check that we can use it
- */
-static int build_elf_exec_info(const char *buf, size_t len, struct elfhdr *ehdr,
-			       struct elf_info *elf_info)
-{
-	int i;
-	int ret;
-
-	ret = elf_read_from_buffer(buf, len, ehdr, elf_info);
-	if (ret)
-		return ret;
-
-	/* Big endian vmlinux has type ET_DYN. */
-	if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN) {
-		pr_err("Not an ELF executable.\n");
-		goto error;
-	} else if (!elf_info->proghdrs) {
-		pr_err("No ELF program header.\n");
-		goto error;
-	}
-
-	for (i = 0; i < ehdr->e_phnum; i++) {
-		/*
-		 * Kexec does not support loading interpreters.
-		 * In addition this check keeps us from attempting
-		 * to kexec ordinay executables.
-		 */
-		if (elf_info->proghdrs[i].p_type == PT_INTERP) {
-			pr_err("Requires an ELF interpreter.\n");
-			goto error;
-		}
-	}
-
-	return 0;
-error:
-	elf_free_info(elf_info);
-	return -ENOEXEC;
-}
-
 static int elf64_probe(const char *buf, unsigned long len)
 {
 	struct elfhdr ehdr;
diff --git a/include/linux/elf.h b/include/linux/elf.h
index ba069e8f4f78..e758bb4365c1 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
+#include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/elf.h>
 #include <uapi/linux/elf.h>
 
@@ -55,4 +57,64 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
 extern int elf_coredump_extra_notes_size(void);
 extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
 #endif
+
+static inline u16 elf16_to_cpu(const struct elfhdr *ehdr, u16 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = le16_to_cpu(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = be16_to_cpu(value);
+
+	return value;
+}
+
+static inline u16 cpu_to_elf16(const struct elfhdr *ehdr, u16 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = cpu_to_le16(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = cpu_to_be16(value);
+
+	return value;
+}
+
+static inline u32 elf32_to_cpu(const struct elfhdr *ehdr, u32 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = le32_to_cpu(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = be32_to_cpu(value);
+
+	return value;
+}
+
+static inline u32 cpu_to_elf32(const struct elfhdr *ehdr, u32 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = cpu_to_le32(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = cpu_to_be32(value);
+
+	return value;
+}
+
+static inline u64 elf64_to_cpu(const struct elfhdr *ehdr, u64 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = le64_to_cpu(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = be64_to_cpu(value);
+
+	return value;
+}
+
+static inline u64 cpu_to_elf64(const struct elfhdr *ehdr, u64 value)
+{
+	if (ehdr->e_ident[EI_DATA] == ELFDATA2LSB)
+		value = cpu_to_le64(value);
+	else if (ehdr->e_ident[EI_DATA] == ELFDATA2MSB)
+		value = cpu_to_be64(value);
+
+	return value;
+}
 #endif /* _LINUX_ELF_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index dd056fab9e35..db98e3459e90 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -22,6 +22,7 @@
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
+#include <linux/elf.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <asm/kexec.h>
@@ -162,6 +163,24 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 			       int (*func)(u64, u64, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+
+#ifdef CONFIG_KEXEC_FILE_ELF
+struct elf_info {
+	/*
+	 * Where the ELF binary contents are kept.
+	 * Memory managed by the user of the struct.
+	 */
+	const char *buffer;
+
+	const struct elfhdr *ehdr;
+	const struct elf_phdr *proghdrs;
+	struct elf_shdr *sechdrs;
+};
+
+extern void elf_free_info(struct elf_info *elf_info);
+extern int build_elf_exec_info(const char *buf, size_t len, struct elfhdr *ehdr,
+				struct elf_info *elf_info);
+#endif /* CONFIG_KEXEC_FILE_ELF */
 #endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
diff --git a/kernel/Makefile b/kernel/Makefile
index d5f9748ab19f..d07492eb3804 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE) += crash_core.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
+obj-$(CONFIG_KEXEC_FILE_ELF) += kexec_file_elf.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_file_elf.c b/kernel/kexec_file_elf.c
new file mode 100644
index 000000000000..4fc049e9731b
--- /dev/null
+++ b/kernel/kexec_file_elf.c
@@ -0,0 +1,454 @@
+/*
+ * Load ELF vmlinux file for the kexec_file_load syscall.
+ *
+ * Copyright (C) 2004  Adam Litke (agl at us.ibm.com)
+ * Copyright (C) 2004  IBM Corp.
+ * Copyright (C) 2005  R Sharada (sharada at in.ibm.com)
+ * Copyright (C) 2006  Mohan Kumar M (mohan at in.ibm.com)
+ * Copyright (C) 2016  IBM Corporation
+ *
+ * Based on kexec-tools' kexec-elf-exec.c and kexec-elf-ppc64.c.
+ * Heavily modified for the kernel by
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
+ * Factored out for general use by
+ * AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	"kexec_elf_elf: " fmt
+
+#include <linux/elf.h>
+#include <linux/errno.h>
+#include <linux/kexec.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#if ELF_CLASS == ELFCLASS32
+#define elf_addr_to_cpu elf32_to_cpu
+#else
+#define elf_addr_to_cpu elf64_to_cpu
+#endif
+
+/**
+ * elf_is_ehdr_sane - check that it is safe to use the ELF header
+ * @buf_len:	size of the buffer in which the ELF file is loaded.
+ */
+static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
+{
+	if (ehdr->e_phnum > 0 && ehdr->e_phentsize != sizeof(struct elf_phdr)) {
+		pr_debug("Bad program header size.\n");
+		return false;
+	} else if (ehdr->e_shnum > 0 &&
+		   ehdr->e_shentsize != sizeof(struct elf_shdr)) {
+		pr_debug("Bad section header size.\n");
+		return false;
+	} else if (ehdr->e_ident[EI_VERSION] != EV_CURRENT ||
+		   ehdr->e_version != EV_CURRENT) {
+		pr_debug("Unknown ELF version.\n");
+		return false;
+	}
+
+	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
+		size_t phdr_size;
+
+		/*
+		 * e_phnum is at most 65535 so calculating the size of the
+		 * program header cannot overflow.
+		 */
+		phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
+
+		/* Sanity check the program header table location. */
+		if (ehdr->e_phoff + phdr_size < ehdr->e_phoff) {
+			pr_debug("Program headers at invalid location.\n");
+			return false;
+		} else if (ehdr->e_phoff + phdr_size > buf_len) {
+			pr_debug("Program headers truncated.\n");
+			return false;
+		}
+	}
+
+	if (ehdr->e_shoff > 0 && ehdr->e_shnum > 0) {
+		size_t shdr_size;
+
+		/*
+		 * e_shnum is at most 65536 so calculating
+		 * the size of the section header cannot overflow.
+		 */
+		shdr_size = sizeof(struct elf_shdr) * ehdr->e_shnum;
+
+		/* Sanity check the section header table location. */
+		if (ehdr->e_shoff + shdr_size < ehdr->e_shoff) {
+			pr_debug("Section headers at invalid location.\n");
+			return false;
+		} else if (ehdr->e_shoff + shdr_size > buf_len) {
+			pr_debug("Section headers truncated.\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
+{
+	struct elfhdr *buf_ehdr;
+
+	if (len < sizeof(*buf_ehdr)) {
+		pr_debug("Buffer is too small to hold ELF header.\n");
+		return -ENOEXEC;
+	}
+
+	memset(ehdr, 0, sizeof(*ehdr));
+	memcpy(ehdr->e_ident, buf, sizeof(ehdr->e_ident));
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
+		pr_debug("No ELF header magic.\n");
+		return -ENOEXEC;
+	}
+
+	if (ehdr->e_ident[EI_CLASS] != ELF_CLASS) {
+		pr_debug("Not a supported ELF class.\n");
+		return -ENOEXEC;
+	} else  if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
+		ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
+		pr_debug("Not a supported ELF data format.\n");
+		return -ENOEXEC;
+	}
+
+	buf_ehdr = (struct elfhdr *) buf;
+	if (elf16_to_cpu(ehdr, buf_ehdr->e_ehsize) != sizeof(*buf_ehdr)) {
+		pr_debug("Bad ELF header size.\n");
+		return -ENOEXEC;
+	}
+
+	ehdr->e_type      = elf16_to_cpu(ehdr, buf_ehdr->e_type);
+	ehdr->e_machine   = elf16_to_cpu(ehdr, buf_ehdr->e_machine);
+	ehdr->e_version   = elf32_to_cpu(ehdr, buf_ehdr->e_version);
+	ehdr->e_entry     = elf_addr_to_cpu(ehdr, buf_ehdr->e_entry);
+	ehdr->e_phoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_phoff);
+	ehdr->e_shoff     = elf_addr_to_cpu(ehdr, buf_ehdr->e_shoff);
+	ehdr->e_flags     = elf32_to_cpu(ehdr, buf_ehdr->e_flags);
+	ehdr->e_phentsize = elf16_to_cpu(ehdr, buf_ehdr->e_phentsize);
+	ehdr->e_phnum     = elf16_to_cpu(ehdr, buf_ehdr->e_phnum);
+	ehdr->e_shentsize = elf16_to_cpu(ehdr, buf_ehdr->e_shentsize);
+	ehdr->e_shnum     = elf16_to_cpu(ehdr, buf_ehdr->e_shnum);
+	ehdr->e_shstrndx  = elf16_to_cpu(ehdr, buf_ehdr->e_shstrndx);
+
+	return elf_is_ehdr_sane(ehdr, len) ? 0 : -ENOEXEC;
+}
+
+/**
+ * elf_is_phdr_sane - check that it is safe to use the program header
+ * @buf_len:	size of the buffer in which the ELF file is loaded.
+ */
+static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
+{
+
+	if (phdr->p_offset + phdr->p_filesz < phdr->p_offset) {
+		pr_debug("ELF segment location wraps around.\n");
+		return false;
+	} else if (phdr->p_offset + phdr->p_filesz > buf_len) {
+		pr_debug("ELF segment not in file.\n");
+		return false;
+	} else if (phdr->p_paddr + phdr->p_memsz < phdr->p_paddr) {
+		pr_debug("ELF segment address wraps around.\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int elf_read_phdr(const char *buf, size_t len, struct elf_info *elf_info,
+			 int idx)
+{
+	/* Override the const in proghdrs, we are the ones doing the loading. */
+	struct elf_phdr *phdr = (struct elf_phdr *) &elf_info->proghdrs[idx];
+	const char *pbuf;
+	struct elf_phdr *buf_phdr;
+
+	pbuf = buf + elf_info->ehdr->e_phoff + (idx * sizeof(*buf_phdr));
+	buf_phdr = (struct elf_phdr *) pbuf;
+
+	phdr->p_type   = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_type);
+	phdr->p_offset = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_offset);
+	phdr->p_paddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_paddr);
+	phdr->p_vaddr  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_vaddr);
+	phdr->p_flags  = elf32_to_cpu(elf_info->ehdr, buf_phdr->p_flags);
+
+	/*
+	 * The following fields have a type equivalent to Elf_Addr
+	 * both in 32 bit and 64 bit ELF.
+	 */
+	phdr->p_filesz = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_filesz);
+	phdr->p_memsz  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_memsz);
+	phdr->p_align  = elf_addr_to_cpu(elf_info->ehdr, buf_phdr->p_align);
+
+	return elf_is_phdr_sane(phdr, len) ? 0 : -ENOEXEC;
+}
+
+/**
+ * elf_read_phdrs - read the program headers from the buffer
+ *
+ * This function assumes that the program header table was checked for sanity.
+ * Use elf_is_ehdr_sane() if it wasn't.
+ */
+static int elf_read_phdrs(const char *buf, size_t len,
+			  struct elf_info *elf_info)
+{
+	size_t phdr_size, i;
+	const struct elfhdr *ehdr = elf_info->ehdr;
+
+	/*
+	 * e_phnum is at most 65535 so calculating the size of the
+	 * program header cannot overflow.
+	 */
+	phdr_size = sizeof(struct elf_phdr) * ehdr->e_phnum;
+
+	elf_info->proghdrs = kzalloc(phdr_size, GFP_KERNEL);
+	if (!elf_info->proghdrs)
+		return -ENOMEM;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		int ret;
+
+		ret = elf_read_phdr(buf, len, elf_info, i);
+		if (ret) {
+			kfree(elf_info->proghdrs);
+			elf_info->proghdrs = NULL;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * elf_is_shdr_sane - check that it is safe to use the section header
+ * @buf_len:	size of the buffer in which the ELF file is loaded.
+ */
+static bool elf_is_shdr_sane(const struct elf_shdr *shdr, size_t buf_len)
+{
+	bool size_ok;
+
+	/* SHT_NULL headers have undefined values, so we can't check them. */
+	if (shdr->sh_type == SHT_NULL)
+		return true;
+
+	/* Now verify sh_entsize */
+	switch (shdr->sh_type) {
+	case SHT_SYMTAB:
+		size_ok = shdr->sh_entsize == sizeof(Elf_Sym);
+		break;
+#ifdef Elf_Rela
+	case SHT_RELA:
+		size_ok = shdr->sh_entsize == sizeof(Elf_Rela);
+		break;
+#endif
+	case SHT_DYNAMIC:
+		size_ok = shdr->sh_entsize == sizeof(Elf_Dyn);
+		break;
+#ifdef Elf_Rel
+	case SHT_REL:
+		size_ok = shdr->sh_entsize == sizeof(Elf_Rel);
+		break;
+#endif
+	case SHT_NOTE:
+	case SHT_PROGBITS:
+	case SHT_HASH:
+	case SHT_NOBITS:
+	default:
+		/*
+		 * This is a section whose entsize requirements
+		 * I don't care about.  If I don't know about
+		 * the section I can't care about it's entsize
+		 * requirements.
+		 */
+		size_ok = true;
+		break;
+	}
+
+	if (!size_ok) {
+		pr_debug("ELF section with wrong entry size.\n");
+		return false;
+	} else if (shdr->sh_addr + shdr->sh_size < shdr->sh_addr) {
+		pr_debug("ELF section address wraps around.\n");
+		return false;
+	}
+
+	if (shdr->sh_type != SHT_NOBITS) {
+		if (shdr->sh_offset + shdr->sh_size < shdr->sh_offset) {
+			pr_debug("ELF section location wraps around.\n");
+			return false;
+		} else if (shdr->sh_offset + shdr->sh_size > buf_len) {
+			pr_debug("ELF section not in file.\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int elf_read_shdr(const char *buf, size_t len, struct elf_info *elf_info,
+			 int idx)
+{
+	struct elf_shdr *shdr = &elf_info->sechdrs[idx];
+	const struct elfhdr *ehdr = elf_info->ehdr;
+	const char *sbuf;
+	struct elf_shdr *buf_shdr;
+
+	sbuf = buf + ehdr->e_shoff + idx * sizeof(*buf_shdr);
+	buf_shdr = (struct elf_shdr *) sbuf;
+
+	shdr->sh_name      = elf32_to_cpu(ehdr, buf_shdr->sh_name);
+	shdr->sh_type      = elf32_to_cpu(ehdr, buf_shdr->sh_type);
+	shdr->sh_addr      = elf_addr_to_cpu(ehdr, buf_shdr->sh_addr);
+	shdr->sh_offset    = elf_addr_to_cpu(ehdr, buf_shdr->sh_offset);
+	shdr->sh_link      = elf32_to_cpu(ehdr, buf_shdr->sh_link);
+	shdr->sh_info      = elf32_to_cpu(ehdr, buf_shdr->sh_info);
+
+	/*
+	 * The following fields have a type equivalent to Elf_Addr
+	 * both in 32 bit and 64 bit ELF.
+	 */
+	shdr->sh_flags     = elf_addr_to_cpu(ehdr, buf_shdr->sh_flags);
+	shdr->sh_size      = elf_addr_to_cpu(ehdr, buf_shdr->sh_size);
+	shdr->sh_addralign = elf_addr_to_cpu(ehdr, buf_shdr->sh_addralign);
+	shdr->sh_entsize   = elf_addr_to_cpu(ehdr, buf_shdr->sh_entsize);
+
+	return elf_is_shdr_sane(shdr, len) ? 0 : -ENOEXEC;
+}
+
+/**
+ * elf_read_shdrs - read the section headers from the buffer
+ *
+ * This function assumes that the section header table was checked for sanity.
+ * Use elf_is_ehdr_sane() if it wasn't.
+ */
+static int elf_read_shdrs(const char *buf, size_t len,
+			  struct elf_info *elf_info)
+{
+	size_t shdr_size, i;
+
+	/*
+	 * e_shnum is at most 65536 so calculating
+	 * the size of the section header cannot overflow.
+	 */
+	shdr_size = sizeof(struct elf_shdr) * elf_info->ehdr->e_shnum;
+
+	elf_info->sechdrs = kzalloc(shdr_size, GFP_KERNEL);
+	if (!elf_info->sechdrs)
+		return -ENOMEM;
+
+	for (i = 0; i < elf_info->ehdr->e_shnum; i++) {
+		int ret;
+
+		ret = elf_read_shdr(buf, len, elf_info, i);
+		if (ret) {
+			kfree(elf_info->sechdrs);
+			elf_info->sechdrs = NULL;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * elf_read_from_buffer - read ELF file and sets up ELF header and ELF info
+ * @buf:	Buffer to read ELF file from.
+ * @len:	Size of @buf.
+ * @ehdr:	Pointer to existing struct which will be populated.
+ * @elf_info:	Pointer to existing struct which will be populated.
+ *
+ * This function allows reading ELF files with different byte order than
+ * the kernel, byte-swapping the fields as needed.
+ *
+ * Return:
+ * On success returns 0, and the caller should call elf_free_info(elf_info) to
+ * free the memory allocated for the section and program headers.
+ */
+static int elf_read_from_buffer(const char *buf, size_t len,
+				struct elfhdr *ehdr, struct elf_info *elf_info)
+{
+	int ret;
+
+	ret = elf_read_ehdr(buf, len, ehdr);
+	if (ret)
+		return ret;
+
+	elf_info->buffer = buf;
+	elf_info->ehdr = ehdr;
+	if (ehdr->e_phoff > 0 && ehdr->e_phnum > 0) {
+		ret = elf_read_phdrs(buf, len, elf_info);
+		if (ret)
+			return ret;
+	}
+	if (ehdr->e_shoff > 0 && ehdr->e_shnum > 0) {
+		ret = elf_read_shdrs(buf, len, elf_info);
+		if (ret) {
+			kfree(elf_info->proghdrs);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * elf_free_info - free memory allocated by elf_read_from_buffer
+ */
+void elf_free_info(struct elf_info *elf_info)
+{
+	kfree(elf_info->proghdrs);
+	kfree(elf_info->sechdrs);
+	memset(elf_info, 0, sizeof(*elf_info));
+}
+
+/**
+ * build_elf_exec_info - read ELF executable and check that we can use it
+ */
+int build_elf_exec_info(const char *buf, size_t len, struct elfhdr *ehdr,
+			struct elf_info *elf_info)
+{
+	int i;
+	int ret;
+
+	ret = elf_read_from_buffer(buf, len, ehdr, elf_info);
+	if (ret)
+		return ret;
+
+	/* Big endian vmlinux has type ET_DYN. */
+	if (ehdr->e_type != ET_EXEC && ehdr->e_type != ET_DYN) {
+		pr_err("Not an ELF executable.\n");
+		goto error;
+	} else if (!elf_info->proghdrs) {
+		pr_err("No ELF program header.\n");
+		goto error;
+	}
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		/*
+		 * Kexec does not support loading interpreters.
+		 * In addition this check keeps us from attempting
+		 * to kexec ordinary executables.
+		 */
+		if (elf_info->proghdrs[i].p_type == PT_INTERP) {
+			pr_err("Requires an ELF interpreter.\n");
+			goto error;
+		}
+	}
+
+	return 0;
+error:
+	elf_free_info(elf_info);
+	return -ENOEXEC;
+}
-- 
2.14.1
