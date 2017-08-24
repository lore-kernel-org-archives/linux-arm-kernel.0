From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Aug 2017 10:10:37 +0100
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <20170824081811.19299-9-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
Message-ID: <CAKv+Gu9UUF-36iEkpsweOAPKOX8nQcoRy1+ushr6GTJiUC6fKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This is a basic purgtory, or a kind of glue code between the two kernel,
> for arm64. We will later add a feature of verifying a digest check against
> loaded memory segments.
>
> arch_kexec_apply_relocations_add() is responsible for re-linking any
> relative symbols in purgatory. Please note that the purgatory is not
> an executable, but a non-linked archive of binaries so relative symbols
> contained here must be resolved at kexec load time.

This sounds fragile to me. What is the reason we cannot let the linker
deal with this, similar to, e.g., how the VDSO gets linked?

Otherwise, couldn't we reuse the module loader to get these objects
relocated in memory? I'm sure there are differences that would require
some changes there, but implementing all of this again sounds like
overkill to me.


> Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> variables now, arch_kexec_apply_relocations_add() can manage more various
> types of relocations.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Makefile                    |   1 +
>  arch/arm64/kernel/Makefile             |   1 +
>  arch/arm64/kernel/machine_kexec_file.c | 199 +++++++++++++++++++++++++++++++++
>  arch/arm64/purgatory/Makefile          |  24 ++++
>  arch/arm64/purgatory/entry.S           |  28 +++++
>  5 files changed, 253 insertions(+)
>  create mode 100644 arch/arm64/kernel/machine_kexec_file.c
>  create mode 100644 arch/arm64/purgatory/Makefile
>  create mode 100644 arch/arm64/purgatory/entry.S
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 9b41f1e3b1a0..429f60728c0a 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -105,6 +105,7 @@ core-$(CONFIG_XEN) += arch/arm64/xen/
>  core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
>  libs-y         := arch/arm64/lib/ $(libs-y)
>  core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +core-$(CONFIG_KEXEC_FILE) += arch/arm64/purgatory/
>
>  # Default target when executing plain make
>  boot           := arch/arm64/boot
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index f2b4e816b6de..16e9f56b536a 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -50,6 +50,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)    += kaslr.o
>  arm64-obj-$(CONFIG_HIBERNATION)                += hibernate.o hibernate-asm.o
>  arm64-obj-$(CONFIG_KEXEC)              += machine_kexec.o relocate_kernel.o    \
>                                            cpu-reset.o
> +arm64-obj-$(CONFIG_KEXEC_FILE)         += machine_kexec_file.o
>  arm64-obj-$(CONFIG_ARM64_RELOC_TEST)   += arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)         += crash_dump.o
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..183f7776d6dd
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -0,0 +1,199 @@
> +/*
> + * kexec_file for arm64
> + *
> + * Copyright (C) 2017 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * Most code is derived from arm64 port of kexec-tools
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "kexec_file: " fmt
> +
> +#include <linux/elf.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +/*
> + * Apply purgatory relocations.
> + *
> + * ehdr: Pointer to elf headers
> + * sechdrs: Pointer to section headers.
> + * relsec: section index of SHT_RELA section.
> + *
> + * Note:
> + * Currently R_AARCH64_ABS64, R_AARCH64_LD_PREL_LO19 and R_AARCH64_CALL26
> + * are the only types to be generated from purgatory code.
> + * If we add more functionalities, other types may also be used.
> + */
> +int arch_kexec_apply_relocations_add(const Elf64_Ehdr *ehdr,
> +                                    Elf64_Shdr *sechdrs, unsigned int relsec)
> +{
> +       Elf64_Rela *rel;
> +       Elf64_Shdr *section, *symtabsec;
> +       Elf64_Sym *sym;
> +       const char *strtab, *name, *shstrtab;
> +       unsigned long address, sec_base, value;
> +       void *location;
> +       u64 *loc64;
> +       u32 *loc32, imm;
> +       unsigned int i;
> +
> +       /*
> +        * ->sh_offset has been modified to keep the pointer to section
> +        * contents in memory
> +        */
> +       rel = (void *)sechdrs[relsec].sh_offset;
> +
> +       /* Section to which relocations apply */
> +       section = &sechdrs[sechdrs[relsec].sh_info];
> +
> +       pr_debug("reloc: Applying relocate section %u to %u\n", relsec,
> +                sechdrs[relsec].sh_info);
> +
> +       /* Associated symbol table */
> +       symtabsec = &sechdrs[sechdrs[relsec].sh_link];
> +
> +       /* String table */
> +       if (symtabsec->sh_link >= ehdr->e_shnum) {
> +               /* Invalid strtab section number */
> +               pr_err("reloc: Invalid string table section index %d\n",
> +                      symtabsec->sh_link);
> +               return -ENOEXEC;
> +       }
> +
> +       strtab = (char *)sechdrs[symtabsec->sh_link].sh_offset;
> +
> +       /* section header string table */
> +       shstrtab = (char *)sechdrs[ehdr->e_shstrndx].sh_offset;
> +
> +       for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
> +
> +               /*
> +                * rel[i].r_offset contains byte offset from beginning
> +                * of section to the storage unit affected.
> +                *
> +                * This is location to update (->sh_offset). This is temporary
> +                * buffer where section is currently loaded. This will finally
> +                * be loaded to a different address later, pointed to by
> +                * ->sh_addr. kexec takes care of moving it
> +                *  (kexec_load_segment()).
> +                */
> +               location = (void *)(section->sh_offset + rel[i].r_offset);
> +
> +               /* Final address of the location */
> +               address = section->sh_addr + rel[i].r_offset;
> +
> +               /*
> +                * rel[i].r_info contains information about symbol table index
> +                * w.r.t which relocation must be made and type of relocation
> +                * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
> +                * these respectively.
> +                */
> +               sym = (Elf64_Sym *)symtabsec->sh_offset +
> +                               ELF64_R_SYM(rel[i].r_info);
> +
> +               if (sym->st_name)
> +                       name = strtab + sym->st_name;
> +               else
> +                       name = shstrtab + sechdrs[sym->st_shndx].sh_name;
> +
> +               pr_debug("Symbol: %-16s info: %02x shndx: %02x value=%llx size: %llx reloc type:%d\n",
> +                        name, sym->st_info, sym->st_shndx, sym->st_value,
> +                        sym->st_size, (int)ELF64_R_TYPE(rel[i].r_info));
> +
> +               if (sym->st_shndx == SHN_UNDEF) {
> +                       pr_err("reloc: Undefined symbol: %s\n", name);
> +                       return -ENOEXEC;
> +               }
> +
> +               if (sym->st_shndx == SHN_COMMON) {
> +                       pr_err("reloc: symbol '%s' in common section\n", name);
> +                       return -ENOEXEC;
> +               }
> +
> +               if (sym->st_shndx == SHN_ABS) {
> +                       sec_base = 0;
> +               } else if (sym->st_shndx < ehdr->e_shnum) {
> +                       sec_base = sechdrs[sym->st_shndx].sh_addr;
> +               } else {
> +                       pr_err("reloc: Invalid section %d for symbol %s\n",
> +                              sym->st_shndx, name);
> +                       return -ENOEXEC;
> +               }
> +
> +               value = sym->st_value;
> +               value += sec_base;
> +               value += rel[i].r_addend;
> +
> +               switch (ELF64_R_TYPE(rel[i].r_info)) {
> +               case R_AARCH64_ABS64:
> +                       loc64 = location;
> +                       *loc64 = cpu_to_elf64(ehdr,
> +                                       elf64_to_cpu(ehdr, *loc64) + value);
> +                       break;
> +               case R_AARCH64_PREL32:
> +                       loc32 = location;
> +                       *loc32 = cpu_to_elf32(ehdr,
> +                                       elf32_to_cpu(ehdr, *loc32) + value
> +                                                               - address);
> +                       break;
> +               case R_AARCH64_LD_PREL_LO19:
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + (((value - address) << 3) & 0xffffe0));
> +                       break;
> +               case R_AARCH64_ADR_PREL_LO21:
> +                       if (value & 3) {
> +                               pr_err("reloc: Unaligned value: %lx\n", value);
> +                               return -ENOEXEC;
> +                       }
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + (((value - address) << 3) & 0xffffe0));
> +                       break;
> +               case R_AARCH64_ADR_PREL_PG_HI21:
> +                       imm = ((value & ~0xfff) - (address & ~0xfff)) >> 12;
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + ((imm & 3) << 29)
> +                               + ((imm & 0x1ffffc) << (5 - 2)));
> +                       break;
> +               case R_AARCH64_ADD_ABS_LO12_NC:
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + ((value & 0xfff) << 10));
> +                       break;
> +               case R_AARCH64_JUMP26:
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + (((value - address) >> 2) & 0x3ffffff));
> +                       break;
> +               case R_AARCH64_CALL26:
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + (((value - address) >> 2) & 0x3ffffff));
> +                       break;
> +               case R_AARCH64_LDST64_ABS_LO12_NC:
> +                       if (value & 7) {
> +                               pr_err("reloc: Unaligned value: %lx\n", value);
> +                               return -ENOEXEC;
> +                       }
> +                       loc32 = location;
> +                       *loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +                               + ((value & 0xff8) << (10 - 3)));
> +                       break;
> +               default:
> +                       pr_err("reloc: Unknown relocation type: %llu\n",
> +                              ELF64_R_TYPE(rel[i].r_info));
> +                       return -ENOEXEC;
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/arch/arm64/purgatory/Makefile b/arch/arm64/purgatory/Makefile
> new file mode 100644
> index 000000000000..c2127a2cbd51
> --- /dev/null
> +++ b/arch/arm64/purgatory/Makefile
> @@ -0,0 +1,24 @@
> +OBJECT_FILES_NON_STANDARD := y
> +
> +purgatory-y := entry.o
> +
> +targets += $(purgatory-y)
> +PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
> +
> +LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined \
> +                                       -nostdlib -z nodefaultlib
> +targets += purgatory.ro
> +
> +$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> +               $(call if_changed,ld)
> +
> +targets += kexec_purgatory.c
> +
> +CMD_BIN2C = $(objtree)/scripts/basic/bin2c
> +quiet_cmd_bin2c = BIN2C $@
> +       cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
> +
> +$(obj)/kexec_purgatory.c: $(obj)/purgatory.ro FORCE
> +       $(call if_changed,bin2c)
> +
> +obj-${CONFIG_KEXEC_FILE}       += kexec_purgatory.o
> diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> new file mode 100644
> index 000000000000..bc4e6b3bf8a1
> --- /dev/null
> +++ b/arch/arm64/purgatory/entry.S
> @@ -0,0 +1,28 @@
> +/*
> + * kexec core purgatory
> + */
> +#include <linux/linkage.h>
> +
> +.text
> +
> +ENTRY(purgatory_start)
> +       /* Start new image. */
> +       ldr     x17, arm64_kernel_entry
> +       ldr     x0, arm64_dtb_addr
> +       mov     x1, xzr
> +       mov     x2, xzr
> +       mov     x3, xzr
> +       br      x17
> +END(purgatory_start)
> +
> +.data
> +
> +.align 3
> +
> +ENTRY(arm64_kernel_entry)
> +       .quad   0
> +END(arm64_kernel_entry)
> +
> +ENTRY(arm64_dtb_addr)
> +       .quad   0
> +END(arm64_dtb_addr)
> --
> 2.14.1
>
