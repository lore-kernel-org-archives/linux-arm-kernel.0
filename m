From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 10 Oct 2018 10:59:09 +0900
Subject: [PATCH v15 07/16] arm64: add image head flag definitions
In-Reply-To: <20181009150404.cqpkmi2wumututwa@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
 <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
 <20181002075939.GG32578@linaro.org>
 <20181009150404.cqpkmi2wumututwa@lakrids.cambridge.arm.com>
Message-ID: <20181010015908.GX32578@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Tue, Oct 09, 2018 at 04:04:05PM +0100, Mark Rutland wrote:
> On Tue, Oct 02, 2018 at 04:59:40PM +0900, AKASHI Takahiro wrote:
> > Hi Mark,
> > 
> > On Mon, Oct 01, 2018 at 01:52:26PM +0100, Mark Rutland wrote:
> > > On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> > > > Those image head's flags will be used later by kexec_file loader.
> > > > 
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Acked-by: James Morse <james.morse@arm.com>
> > > > ---
> > > >  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
> > > >  arch/arm64/kernel/head.S      |  2 +-
> > > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> > > > index 355e552a9175..0bab7eed3012 100644
> > > > --- a/arch/arm64/include/asm/boot.h
> > > > +++ b/arch/arm64/include/asm/boot.h
> > > > @@ -5,6 +5,21 @@
> > > >  
> > > >  #include <asm/sizes.h>
> > > >  
> > > > +#define ARM64_MAGIC		"ARM\x64"
> > > > +
> > > > +#define HEAD_FLAG_BE_SHIFT		0
> > > > +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> > > > +#define HEAD_FLAG_BE_MASK		0x1
> > > > +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> > > > +
> > > > +#define HEAD_FLAG_BE			1
> > > 
> > > These already exist in some form in arch/arm64/kernel/image.h; can we
> > > please factor those out rather than duplicating them?
> > 
> > Sure.
> > 
> > > I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
> > > and removed the old definitions.
> > 
> > I want to make sure two things;
> > 
> > 1. Do you assume all the existing __HEAD_FLAG_xyz's NOT be renamed
> >    (say, to HEAD_FLAG_xyz)?
> 
> I'm perfectly happy for them to be renamed, I just don't want duplicate
> definitions.

IMO, it's not duplication.
HEAD_FLAG_xyz is a definition of a specific field. On the other hand,
__HEAD_FLAG_xyz is a value to be put in a kernel header.
To be clear, please look at my current code attached below.

> Let's rename them to ARM64_IMAGE_FLAG_<foo>, and place them in a new
> header, arch/arm64/include/asm/image.h, which arch/arm64/kernel/image.h
> can include and make use of.

Okay.

> > 2. Do you mind removing this check in image.h?
> >    (we also need to manage 'CONFIG_EFI' part of image.h.)
> 
> What exactly do we need from that? AFAICT that's all linker script
> stuff that shouldn't matter for kexec.

You're right if all the definitions, as you suggested above,
are moved to a new header, asm/image.h.

-Takahiro Akashi

> Thanks,
> Mark.

arch/arm64/kernel/image.h
---8<---
/*
 * Linker script macros to generate Image header fields.
 *
 * Copyright (C) 2014 ARM Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef __ASM_IMAGE_H
#define __ASM_IMAGE_H

#define HEAD_FLAG_BE_SHIFT		0
#define HEAD_FLAG_PAGE_SIZE_SHIFT	(HEAD_FLAG_BE_SHIFT + 1)
#define HEAD_FLAG_PHYS_BASE_SHIFT	(HEAD_FLAG_PAGE_SIZE_SHIFT + 2)
#define HEAD_FLAG_BE_MASK		0x1
#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
#define HEAD_FLAG_PHYS_BASE_MASK	0x1

#define HEAD_FLAG_LE			0
#define HEAD_FLAG_BE			1
#define HEAD_FLAG_PAGE_SIZE_4K		1
#define HEAD_FLAG_PAGE_SIZE_16K		2
#define HEAD_FLAG_PAGE_SIZE_64K		3
#define HEAD_FLAG_PHYS_BASE		1

#define head_flag_field(flags, field) \
				(((flags) >> field##_SHIFT) & field##_MASK)

#ifdef LINKER_SCRIPT
/*
 * There aren't any ELF relocations we can use to endian-swap values known only
 * at link time (e.g. the subtraction of two symbol addresses), so we must get
 * the linker to endian-swap certain values before emitting them.
 *
 * Note that, in order for this to work when building the ELF64 PIE executable
 * (for KASLR), these values should not be referenced via R_AARCH64_ABS64
 * relocations, since these are fixed up at runtime rather than at build time
 * when PIE is in effect. So we need to split them up in 32-bit high and low
 * words.
 */
#ifdef CONFIG_CPU_BIG_ENDIAN
#define DATA_LE32(data)				\
	((((data) & 0x000000ff) << 24) |	\
	 (((data) & 0x0000ff00) << 8)  |	\
	 (((data) & 0x00ff0000) >> 8)  |	\
	 (((data) & 0xff000000) >> 24))
#else
#define DATA_LE32(data) ((data) & 0xffffffff)
#endif

#define DEFINE_IMAGE_LE64(sym, data)				\
	sym##_lo32 = DATA_LE32((data) & 0xffffffff);		\
	sym##_hi32 = DATA_LE32((data) >> 32)

#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
					HEAD_FLAG_##field##_SHIFT)

#ifdef CONFIG_CPU_BIG_ENDIAN
#define __HEAD_FLAG_BE		HEAD_FLAG_BE
#else
#define __HEAD_FLAG_BE		HEAD_FLAG_LE
#endif

#define __HEAD_FLAG_PAGE_SIZE	((PAGE_SHIFT - 10) / 2)

#define __HEAD_FLAG_PHYS_BASE	HEAD_FLAG_PHYS_BASE

#define __HEAD_FLAGS		(__HEAD_FLAG(BE) 	| \
				 __HEAD_FLAG(PAGE_SIZE) | \
				 __HEAD_FLAG(PHYS_BASE))

/*
 * These will output as part of the Image header, which should be little-endian
 * regardless of the endianness of the kernel. While constant values could be
 * endian swapped in head.S, all are done here for consistency.
 */
#define HEAD_SYMBOLS						\
	DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
	DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);	\
	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);

#ifdef CONFIG_EFI

__efistub_stext_offset = stext - _text;

/*
 * Prevent the symbol aliases below from being emitted into the kallsyms
 * table, by forcing them to be absolute symbols (which are conveniently
 * ignored by scripts/kallsyms) rather than section relative symbols.
 * The distinction is only relevant for partial linking, and only for symbols
 * that are defined within a section declaration (which is not the case for
 * the definitions below) so the resulting values will be identical.
 */
#define KALLSYMS_HIDE(sym)	ABSOLUTE(sym)

/*
 * The EFI stub has its own symbol namespace prefixed by __efistub_, to
 * isolate it from the kernel proper. The following symbols are legally
 * accessed by the stub, so provide some aliases to make them accessible.
 * Only include data symbols here, or text symbols of functions that are
 * guaranteed to be safe when executed@another offset than they were
 * linked at. The routines below are all implemented in assembler in a
 * position independent manner
 */
__efistub_memcmp		= KALLSYMS_HIDE(__pi_memcmp);
__efistub_memchr		= KALLSYMS_HIDE(__pi_memchr);
__efistub_memcpy		= KALLSYMS_HIDE(__pi_memcpy);
__efistub_memmove		= KALLSYMS_HIDE(__pi_memmove);
__efistub_memset		= KALLSYMS_HIDE(__pi_memset);
__efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
__efistub_strnlen		= KALLSYMS_HIDE(__pi_strnlen);
__efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
__efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
__efistub_strrchr		= KALLSYMS_HIDE(__pi_strrchr);
__efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);

#ifdef CONFIG_KASAN
__efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
__efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
__efistub___memset		= KALLSYMS_HIDE(__pi_memset);
#endif

__efistub__text			= KALLSYMS_HIDE(_text);
__efistub__end			= KALLSYMS_HIDE(_end);
__efistub__edata		= KALLSYMS_HIDE(_edata);
__efistub_screen_info		= KALLSYMS_HIDE(screen_info);

#endif /* CONFIG_EFI */

#endif /* LINKER_SCRIPT */

#endif /* __ASM_IMAGE_H */
