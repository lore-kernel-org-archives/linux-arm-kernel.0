From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 11:03:51 +0900
Subject: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-Reply-To: <20170824173049.GG29665@leverpostej>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
Message-ID: <20170825020348.GA7308@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > memory. The other PT_LOAD segments are placed relative to the first one.
> 
> I really don't like assuming things about the vmlinux ELF file.

If so, vmlinux is not an appropriate format for loading.

> > Regarding kernel verification, since there is no standard way to contain
> > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
> > approach, that is, appending a signature right after the kernel binary
> > itself like module signing.
> 
> I also *really* don't like this. It's a bizarre in-band mechanism,
> without explcit information. It's not a nice ABI.
> 
> If we can load an Image, why do we need to be able to load a vmlinux?

Well, kexec-tools does. I don't know why Geoff wanted to support vmlinux.
I'm just trying to support what kexec-tools does support.

> [...]
> 
> > diff --git a/arch/arm64/kernel/kexec_elf.c b/arch/arm64/kernel/kexec_elf.c
> > new file mode 100644
> > index 000000000000..7bd3c1e1f65a
> > --- /dev/null
> > +++ b/arch/arm64/kernel/kexec_elf.c
> > @@ -0,0 +1,216 @@
> > +/*
> > + * Kexec vmlinux loader
> > +
> > + * Copyright (C) 2017 Linaro Limited
> > + * Authors: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define pr_fmt(fmt)	"kexec_file(elf): " fmt
> > +
> > +#include <linux/elf.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kexec.h>
> > +#include <linux/module_signature.h>
> > +#include <linux/types.h>
> > +#include <linux/verification.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/kexec_file.h>
> > +#include <asm/memory.h>
> > +
> > +static int elf64_probe(const char *buf, unsigned long len)
> > +{
> > +	struct elfhdr ehdr;
> > +
> > +	/* Check for magic and architecture */
> > +	memcpy(&ehdr, buf, sizeof(ehdr));
> > +	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) ||
> > +		(elf16_to_cpu(&ehdr, ehdr.e_machine) != EM_AARCH64))
> > +		return -ENOEXEC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int elf_exec_load(struct kimage *image, struct elfhdr *ehdr,
> > +			 struct elf_info *elf_info,
> > +			 unsigned long *kernel_load_addr)
> > +{
> > +	struct kexec_buf kbuf;
> > +	const struct elf_phdr *phdr;
> > +	const struct arm64_image_header *h;
> > +	unsigned long text_offset, rand_offset;
> > +	unsigned long page_offset, phys_offset;
> > +	int first_segment, i, ret = -ENOEXEC;
> > +
> > +	kbuf.image = image;
> > +	if (image->type == KEXEC_TYPE_CRASH) {
> > +		kbuf.buf_min = crashk_res.start;
> > +		kbuf.buf_max = crashk_res.end + 1;
> > +	} else {
> > +		kbuf.buf_min = 0;
> > +		kbuf.buf_max = ULONG_MAX;
> > +	}
> > +	kbuf.top_down = 0;
> > +
> > +	/* Load PT_LOAD segments. */
> > +	for (i = 0, first_segment = 1; i < ehdr->e_phnum; i++) {
> > +		phdr = &elf_info->proghdrs[i];
> > +		if (phdr->p_type != PT_LOAD)
> > +			continue;
> > +
> > +		kbuf.buffer = (void *) elf_info->buffer + phdr->p_offset;
> > +		kbuf.bufsz = min(phdr->p_filesz, phdr->p_memsz);
> > +		kbuf.memsz = phdr->p_memsz;
> > +		kbuf.buf_align = phdr->p_align;
> > +
> > +		if (first_segment) {
> > +			/*
> > +			 * Identify TEXT_OFFSET:
> > +			 * When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y the image
> > +			 * header could be offset in the elf segment. The linker
> > +			 * script sets ehdr->e_entry to the start of text.
> 
> Please, let's not have to go delving into the vmlinux, knowing intimate
> details about how it's put together.

If we don't need to take care of RANDOMIZE_TEXT_OFFSET, the code would
be much simpler and look similar to Image code.

> 
> > +			 *
> > +			 * NOTE: In v3.16 or older, h->text_offset is 0,
> > +			 * so use the default, 0x80000
> > +			 */
> > +			rand_offset = ehdr->e_entry - phdr->p_vaddr;
> > +			h = (struct arm64_image_header *)
> > +					(elf_info->buffer + phdr->p_offset +
> > +					rand_offset);
> > +
> > +			if (!arm64_header_check_magic(h))
> > +				goto out;
> > +
> > +			if (h->image_size)
> > +				text_offset = le64_to_cpu(h->text_offset);
> > +			else
> > +				text_offset = 0x80000;
> 
> Surely we can share the Image header parsing with the Image parser?
> 
> The Image code had practically the exact same logic operating on the
> header struct.

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
