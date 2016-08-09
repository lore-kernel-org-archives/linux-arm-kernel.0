From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Aug 2016 11:30:54 -0700
Subject: [PATCH v3 2/3] arm64: Add arm64 kexec support
In-Reply-To: <20160809030513.GO7995@linaro.org>
References: <cover.1470693832.git.geoff@infradead.org>
 <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
 <20160809030513.GO7995@linaro.org>
Message-ID: <1470767454.19503.41.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-09 at 12:05 +0900, AKASHI Takahiro wrote:
> On Mon, Aug 08, 2016 at 10:19:33PM +0000, Geoff Levand wrote:
> > +/**
> > + * struct arm64_image_header - arm64 kernel image header.
> > + *
> > + * @pe_sig: Optional PE format 'MZ' signature.
> > + * @branch_code: Reserved for instructions to branch to stext.
> > + * @text_offset: The image load offset in LSB byte order.
> > + * @image_size: An estimated size of the memory image size in LSB byte order.
> > + * @flags: Bit flags in LSB byte order:
> > + *   Bit 0:   Image byte order: 1=MSB.
> > + *   Bit 1-2: Kernel page size: 1=4K, 2=16K, 3=64K.
> > + *   Bit 3:   Image placement: 0=low.
> > + * @reserved_1: Reserved.
> > + * @magic: Magic number, "ARM\x64".
> > + * @pe_header: Optional offset to a PE format header.
> > + **/
> > +
> > +struct arm64_image_header {
> > +> > 	> > uint8_t pe_sig[2];
> > +> > 	> > uint16_t branch_code[3];
> > +> > 	> > uint64_t text_offset;
> > +> > 	> > uint64_t image_size;
> > +> > 	> > uint64_t flags;
> > +> > 	> > uint64_t reserved_1[3];
> > +> > 	> > uint8_t magic[4];
> > +> > 	> > uint32_t pe_header;
> > +};
> > +
> > +static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
> > +static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
> > +static const uint64_t arm64_image_flag_be = (1UL << 0);
> > +static const uint64_t arm64_image_flag_page_size = (3UL << 1);
> > +static const uint64_t arm64_image_flag_placement = (1UL << 3);
> 
> Why not define like:
> #define ARM64_FLAG_PAGE_SIZE_4K  1
> #define ARM64_FLAG_PAGE_SIZE_16K 2
> #define ARM64_FLAG_PAGE_SIZE_64K 3
> if you have arm64_header_page_size()?

To give them a type, I added these in as enum arm64_header_page_size.

> 
> > +
> > +/**
> > + * arm64_header_check_magic - Helper to check the arm64 image header.
> > + *
> > + * Returns non-zero if header is OK.
> > + */
> > +
> > +static inline int arm64_header_check_magic(const struct arm64_image_header *h)
> > +{
> > +> > 	> > if (!h)
> > +> > 	> > 	> > return 0;
> > +
> > +> > 	> > return (h->magic[0] == arm64_image_magic[0]
> > +> > 	> > 	> > && h->magic[1] == arm64_image_magic[1]
> > +> > 	> > 	> > && h->magic[2] == arm64_image_magic[2]
> > +> > 	> > 	> > && h->magic[3] == arm64_image_magic[3]);
> > +}
> > +
> > +/**
> > + * arm64_header_check_pe_sig - Helper to check the arm64 image header.
> > + *
> > + * Returns non-zero if 'MZ' signature is found.
> > + */
> > +
> > +static inline int arm64_header_check_pe_sig(const struct arm64_image_header *h)
> > +{
> > +> > 	> > if (!h)
> > +> > 	> > 	> > return 0;
> 
> Why not add assert() here like get_phys_offset()?

The assert in get_phys_offset() is to check for incorrect usage.
arm64_header_check_pe_sig is a generic routine, and having a null
value may be OK.

> > +
> > +static inline uint64_t arm64_header_text_offset(
> > +> > 	> > const struct arm64_image_header *h)
> > +{
> 
> Why not check for !h?

ok.

> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > +static int get_memory_ranges_dt(struct memory_range *array, unsigned int *count)
> > +{
> > +> > 	> > struct region {uint64_t base; uint64_t size;};
> > +> > 	> > struct dtb dtb = {.name = "range_dtb"};
> > +> > 	> > int offset;
> > +> > 	> > int result;
> > +
> > +> > 	> > *count = 0;
> > +
> > +> > 	> > result = read_1st_dtb(&dtb);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > result = fdt_check_header(dtb.buf);
> > +
> > +> > 	> > if (result) {
> > +> > 	> > 	> > dbgprintf("%s:%d: %s: fdt_check_header failed:%s\n", __func__,
> > +> > 	> > 	> > 	> > __LINE__, dtb.path, fdt_strerror(result));
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > for (offset = 0; ; ) {
> > +> > 	> > 	> > const struct region *region;
> > +> > 	> > 	> > const struct region *end;
> > +> > 	> > 	> > int len;
> > +
> > +> > 	> > 	> > offset = fdt_subnode_offset(dtb.buf, offset, "memory");
> > +
> > +> > 	> > 	> > if (offset == -FDT_ERR_NOTFOUND)
> > +> > 	> > 	> > 	> > break;
> > +
> > +> > 	> > 	> > if (offset <= 0) {
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d: fdt_subnode_offset failed: %d %s\n",
> > +> > 	> > 	> > 	> > 	> > __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > 	> > fdt_strerror(offset));
> > +> > 	> > 	> > 	> > goto on_error;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > dbgprintf("%s:%d: node_%d %s\n", __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > fdt_get_name(dtb.buf, offset, NULL));
> > +
> > +> > 	> > 	> > region = fdt_getprop(dtb.buf, offset, "reg", &len);
> > +
> > +> > 	> > 	> > if (region <= 0) {
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d: fdt_getprop failed: %d %s\n",
> > +> > 	> > 	> > 	> > 	> > __func__, __LINE__, offset,
> > +> > 	> > 	> > 	> > 	> > fdt_strerror(offset));
> > +> > 	> > 	> > 	> > goto on_error;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > for (end = region + len / sizeof(*region);
> > +> > 	> > 	> > 	> > region < end && *count < KEXEC_SEGMENT_MAX;
> > +> > 	> > 	> > 	> > region++) {
> > +> > 	> > 	> > 	> > struct memory_range r;
> > +
> > +> > 	> > 	> > 	> > r.type = RANGE_RAM;
> > +> > 	> > 	> > 	> > r.start = fdt64_to_cpu(region->base);
> > +> > 	> > 	> > 	> > r.end = r.start + fdt64_to_cpu(region->size) - 1;
> > +
> > +> > 	> > 	> > 	> > if (!region->size) {
> > +> > 	> > 	> > 	> > 	> > dbgprintf("%s:%d: SKIP: %016llx - %016llx\n",
> > +> > 	> > 	> > 	> > 	> > 	> > __func__, __LINE__, r.start, r.end);
> > +> > 	> > 	> > 	> > 	> > continue;
> > +> > 	> > 	> > 	> > }
> > +
> > +> > 	> > 	> > 	> > dbgprintf("%s:%d:  RAM: %016llx - %016llx\n", __func__,
> > +> > 	> > 	> > 	> > 	> > __LINE__, r.start, r.end);
> > +
> > +> > 	> > 	> > 	> > array[(*count)++] = r;
> > +
> > +> > 	> > 	> > 	> > set_phys_offset(r.start);
> > +> > 	> > 	> > }
> > +> > 	> > }
> > +
> > +> > 	> > if (!*count) {
> > +> > 	> > 	> > dbgprintf("%s:%d: %s: No RAM found.\n", __func__, __LINE__,
> > +> > 	> > 	> > 	> > dtb.path);
> > +> > 	> > 	> > goto on_error;
> > +> > 	> > }
> > +
> > +> > 	> > dbgprintf("%s:%d: %s: Success\n", __func__, __LINE__, dtb.path);
> > +> > 	> > result = 0;
> > +> > 	> > goto on_exit;
> > +
> > +on_error:
> > +> > 	> > fprintf(stderr, "%s:%d: %s: Unusable device-tree file\n", __func__,
> > +> > 	> > 	> > __LINE__, dtb.path);
> > +> > 	> > result = -1;
> 
> EFAILED?
> 
> > +
> > +on_exit:
> > +> > 	> > free(dtb.buf);
> > +> > 	> > return -EFAILED;
> 
> return result?

OK.

> 
> > +}
> > +
> > +/**
> > + * get_memory_ranges - Try to get the memory ranges some how.
> > + */
> > +
> > +int get_memory_ranges(struct memory_range **range, int *ranges,
> > +> > 	> > unsigned long kexec_flags)
> > +{
> > +> > 	> > static struct memory_range array[KEXEC_SEGMENT_MAX];
> > +> > 	> > unsigned int count;
> > +> > 	> > int result;
> > +
> > +> > 	> > result = get_memory_ranges_iomem(array, &count);
> > +
> > +> > 	> > if (result)
> > +> > 	> > 	> > result = get_memory_ranges_dt(array, &count);
> > +
> > +> > 	> > *range = result ? NULL : array;
> > +> > 	> > *ranges = result ? 0 : count;
> > +
> > +> > 	> > return -EFAILED;
> 
> return result?

OK.

> 
> > +}
> > +
> > +int arch_compat_trampoline(struct kexec_info *info)
> > +{
> > +> > 	> > return 0;
> > +}
> > +
> > +int machine_verify_elf_rel(struct mem_ehdr *ehdr)
> > +{
> > +> > 	> > return (ehdr->e_machine == EM_AARCH64);
> > +}
> > +
> > +void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
> > +> > 	> > unsigned long r_type, void *ptr, unsigned long address,
> > +> > 	> > unsigned long value)
> > +{
> > +#if !defined(R_AARCH64_ABS64)
> > +# define R_AARCH64_ABS64 257
> > +#endif
> > +
> > +#if !defined(R_AARCH64_LD_PREL_LO19)
> > +# define R_AARCH64_LD_PREL_LO19 273
> > +#endif
> > +
> > +#if !defined(R_AARCH64_ADR_PREL_LO21)
> > +# define R_AARCH64_ADR_PREL_LO21 274
> > +#endif
> > +
> > +#if !defined(R_AARCH64_JUMP26)
> > +# define R_AARCH64_JUMP26 282
> > +#endif
> > +
> > +#if !defined(R_AARCH64_CALL26)
> > +# define R_AARCH64_CALL26 283
> > +#endif
> 
> I still believe those definitons should go into elf.h.

They should be comming from the c library headers.  When
toolchains catch up these can be removed.

> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-arm64.h
> > @@ -0,0 +1,70 @@
> > +/*
> > + * ARM64 kexec.
> > + */
> > +
> > +#if !defined(KEXEC_ARM64_H)
> > +#define KEXEC_ARM64_H
> > +
> > +#include 
> > +#include 
> > +
> > +#include "image-header.h"
> > +#include "kexec.h"
> > +
> > +#define KEXEC_SEGMENT_MAX 16
> > +
> > +#define BOOT_BLOCK_VERSION 17
> > +#define BOOT_BLOCK_LAST_COMP_VERSION 16
> > +#define COMMAND_LINE_SIZE 512
> > +
> > +#define KiB(x) ((x) * 1024UL)
> > +#define MiB(x) (KiB(x) * 1024UL)
> > +#define GiB(x) (MiB(x) * 1024UL)
> > +
> > +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size);
> > +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info);
> > +void elf_arm64_usage(void);
> > +
> > +int image_arm64_probe(const char *kernel_buf, off_t kernel_size);
> > +int image_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info);
> > +void image_arm64_usage(void);
> > +
> > +off_t initrd_base;
> > +off_t initrd_size;
> > +
> > +/**
> > + * struct arm64_mem - Memory layout info.
> > + */
> > +
> > +struct arm64_mem {
> > +> > 	> > uint64_t phys_offset;
> > +> > 	> > uint64_t text_offset;
> > +> > 	> > uint64_t image_size;
> > +> > 	> > uint64_t page_offset;
> > +};
> > +
> > +#define arm64_mem_ngv UINT64_MAX
> 
> In image_header.h, you define "const" variables,
> here you define a macro.

Yes, because arm64_mem_ngv is used as a static
initializer of arm64_mem.

> > +struct arm64_mem arm64_mem;
> > +
> > +uint64_t get_phys_offset(void);
> > +uint64_t get_page_offset(void);
> > +
> > +static inline void reset_page_offset(void)
> > +{
> > +> > 	> > arm64_mem.page_offset = arm64_mem_ngv;
> > +}
> > +
> > +static inline void set_phys_offset(uint64_t v)
> > +{
> > +> > 	> > if (arm64_mem.phys_offset == arm64_mem_ngv
> > +> > 	> > 	> > || v < arm64_mem.phys_offset)
> > +> > 	> > 	> > arm64_mem.phys_offset = v;
> > +}
> > +
> > +int arm64_process_image_header(const struct arm64_image_header *h);
> > +int arm64_load_other_segments(struct kexec_info *info,
> > +> > 	> > uint64_t kernel_entry);
> > +
> > +#endif
> > diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
> > new file mode 100644
> > index 0000000..fcac9bb
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-elf-arm64.c
> > @@ -0,0 +1,130 @@
> > +/*
> > + * ARM64 kexec elf support.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include 
> > +#include 
> > +#include 
> > +
> > +#include "kexec-arm64.h"
> > +#include "kexec-elf.h"
> > +#include "kexec-syscall.h"
> > +
> > +int elf_arm64_probe(const char *kernel_buf, off_t kernel_size)
> > +{
> > +> > 	> > struct mem_ehdr ehdr;
> > +> > 	> > int result;
> > +
> > +> > 	> > result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> > +
> > +> > 	> > if (result < 0) {
> > +> > 	> > 	> > dbgprintf("%s: Not an ELF executable.\n", __func__);
> > +> > 	> > 	> > goto on_exit;
> > +> > 	> > }
> > +
> > +> > 	> > if (ehdr.e_machine != EM_AARCH64) {
> > +> > 	> > 	> > dbgprintf("%s: Not an AARCH64 ELF executable.\n", __func__);
> > +> > 	> > 	> > result = -1;
> > +> > 	> > 	> > goto on_exit;
> > +> > 	> > }
> > +
> > +> > 	> > result = 0;
> > +on_exit:
> > +> > 	> > free_elf_info(&ehdr);
> > +> > 	> > return result;
> > +}
> > +
> > +int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
> > +> > 	> > off_t kernel_size, struct kexec_info *info)
> > +{
> > +> > 	> > struct mem_ehdr ehdr;
> > +> > 	> > int result;
> > +> > 	> > int i;
> > +
> > +> > 	> > if (info->kexec_flags & KEXEC_ON_CRASH) {
> > +> > 	> > 	> > fprintf(stderr, "kexec: kdump not yet supported on arm64\n");
> > +> > 	> > 	> > return -EFAILED;
> > +> > 	> > }
> > +
> > +> > 	> > result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
> > +
> > +> > 	> > if (result < 0) {
> > +> > 	> > 	> > dbgprintf("%s: build_elf_exec_info failed\n", __func__);
> > +> > 	> > 	> > goto exit;
> > +> > 	> > }
> > +
> > +> > 	> > /* Find and process the arm64 image header. */
> > +
> > +> > 	> > for (i = 0; i < ehdr.e_phnum; i++) {
> > +> > 	> > 	> > struct mem_phdr *phdr = &ehdr.e_phdr[i];
> > +> > 	> > 	> > const struct arm64_image_header *h;
> > +> > 	> > 	> > unsigned long header_offset;
> > +
> > +> > 	> > 	> > if (phdr->p_type != PT_LOAD)
> > +> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > /*
> > +> > 	> > 	> >  * When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y the image header
> > +> > 	> > 	> >  * could be offset in the elf segment.  The linker script sets
> > +> > 	> > 	> >  * ehdr.e_entry to the start of text.
> > +> > 	> > 	> >  */
> > +
> > +> > 	> > 	> > header_offset = ehdr.e_entry - phdr->p_vaddr;
> > +
> > +> > 	> > 	> > h = (const struct arm64_image_header *)(
> > +> > 	> > 	> > 	> > kernel_buf + phdr->p_offset + header_offset);
> > +
> > +> > 	> > 	> > if (arm64_process_image_header(h))
> > +> > 	> > 	> > 	> > continue;
> > +
> > +> > 	> > 	> > arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;
> > +
> > +> > 	> > 	> > dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
> > +> > 	> > 	> > 	> > ehdr.e_entry,
> > +> > 	> > 	> > 	> > virt_to_phys(ehdr.e_entry));
> > +> > 	> > 	> > dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
> > +> > 	> > 	> > 	> > phdr->p_vaddr,
> > +> > 	> > 	> > 	> > virt_to_phys(phdr->p_vaddr));
> > +> > 	> > 	> > dbgprintf("%s: header_offset: %016lx\n", __func__,
> > +> > 	> > 	> > 	> > header_offset);
> > +> > 	> > 	> > dbgprintf("%s: text_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.text_offset);
> > +> > 	> > 	> > dbgprintf("%s: image_size:    %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.image_size);
> > +> > 	> > 	> > dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.phys_offset);
> > +> > 	> > 	> > dbgprintf("%s: page_offset:   %016lx\n", __func__,
> > +> > 	> > 	> > 	> > arm64_mem.page_offset);
> > +> > 	> > 	> > dbgprintf("%s: PE format:     %s\n", __func__,
> > +> > 	> > 	> > 	> > (arm64_header_check_pe_sig(h) ? "yes" : "no"));
> > +
> > +> > 	> > 	> > result = elf_exec_load(&ehdr, info);
> > +
> > +> > 	> > 	> > if (result) {
> > +> > 	> > 	> > 	> > fprintf(stderr, "kexec: Elf load failed.\n");
> 
> dbgprintf?
> You use this for build_elf_exec_info() above.
> 
> > +> > 	> > 	> > 	> > goto exit;
> > +> > 	> > 	> > }
> > +
> > +> > 	> > 	> > result = arm64_load_other_segments(info,
> > +> > 	> > 	> > 	> > virt_to_phys(ehdr.e_entry));
> > +> > 	> > 	> > goto exit;
> > +> > 	> > }
> > +
> > +> > 	> > fprintf(stderr, "kexec: Bad arm64 image header.\n");
> 
> Is this an appropriate message?

I changed elf_arm64_load to output dbgprintf during its operation, then
a final message to stderr on exit.

> 
> > +> > 	> > result = -EFAILED;
> > +> > 	> > goto exit;
> > +
> > +exit:
> > +> > 	> > reset_page_offset();
> > +> > 	> > free_elf_info(&ehdr);
> > +> > 	> > return result;
> > +}
> > +
> > --- /dev/null
> > +++ b/kexec/arch/arm64/kexec-image-arm64.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * ARM64 kexec binary image support.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include 
> 
> Not used.

OK.

Thanks for the review.

-Geoff
