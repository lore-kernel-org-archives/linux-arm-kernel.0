From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 10 May 2010 15:09:20 +0300
Subject: [PATCH v2 6/8] arm: allow passing an ELF64 header to
	elf_check_arch()
In-Reply-To: <20100510112036.GC14337@n2100.arm.linux.org.uk>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
	<3c8da055f0a84cfd1c6659d9fda24e4eb97ab9fb.1273041358.git.ext-mika.1.westerberg@nokia.com>
	<20100510112036.GC14337@n2100.arm.linux.org.uk>
Message-ID: <20100510120920.GD11783@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 01:20:36PM +0200, ext Russell King - ARM Linux wrote:
> On Wed, May 05, 2010 at 09:54:18AM +0300, Mika Westerberg wrote:
> > This is needed to shut following compiler warning when CONFIG_PROC_VMCORE is
> > enabled:
> > 
> > fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
> > fs/proc/vmcore.c:500: warning: passing argument 1 of 'elf_check_arch' from
> > incompatible pointer type
> > 
> > ELF32 and ELF64 headers have common fields of same size (namely e_ident and
> > e_machine) which are checked in arm_elf_check_arch().
> 
> This patch is bogus - and shows the dangers of throwing casts into C code
> to shut up warnings without first analysing the code.
> 
> Our elf_check_arch() uses:
> 	e_machine
> 	e_entry
> 	e_flags
> thusly:
>         if (x->e_machine != EM_ARM)
>         if (x->e_entry & 1) {
>         } else if (x->e_entry & 3)
>         eflags = x->e_flags;
> 
> Now, the Elf32 header looks like this:
> 
> typedef struct elf32_hdr{
>   unsigned char e_ident[EI_NIDENT];	/* 0x00 - 0x0F */
>   Elf32_Half    e_type;			/* 0x10 - 0x11 */
>   Elf32_Half    e_machine;		/* 0x12 - 0x13 */
>   Elf32_Word    e_version;		/* 0x14 - 0x17 */
>   Elf32_Addr    e_entry;		/* 0x18 - 0x1b */
>   Elf32_Off     e_phoff;		/* 0x1c - 0x1f */
>   Elf32_Off     e_shoff;		/* 0x20 - 0x23 */
>   Elf32_Word    e_flags;		/* 0x24 - 0x27 */
> 
> and Elf64 header:
> 
> typedef struct elf64_hdr {
>   unsigned char e_ident[EI_NIDENT];	/* 0x00 - 0x0F */
>   Elf64_Half e_type;			/* 0x10 - 0x11 */
>   Elf64_Half e_machine;			/* 0x12 - 0x13 */
>   Elf64_Word e_version;			/* 0x14 - 0x17 */
>   Elf64_Addr e_entry;			/* 0x18 - 0x1f */
>   Elf64_Off e_phoff;			/* 0x20 - 0x27 */
>   Elf64_Off e_shoff;			/* 0x28 - 0x2f */
>   Elf64_Word e_flags;			/* 0x30 - 0x33 */
> 
> Notice that e_entry and e_flags are different sizes and/or different
> offsets, so ARMs elf_check_arch can not work with elf64 headers.  So
> with an ELF64 header, accessing e_flags will result in actually
> accessing the top half of the 64-bit e_phoff, and accessing 32-bit
> e_entry will get us the lower half of the 64-bit e_entry.

Thanks for comments.

I believe that when passing ELF64 header, it fails in following checks:

	/* Make sure it's an ARM executable */
	if (x->e_ident[EI_CLASS] != ELF_CLASS)
		return 0;
	if (x->e_machine != EM_ARM)
		return 0;

ELF_CLASS is defined in arch/arm/include/asm/elf.h:

#define ELF_CLASS       ELFCLASS32

So if class is different than ELFCLASS32 it returns 0 and never even try to
access other fields, right?

> Now, here's the question: why does this crashkernel stuff want to
> parse a 64-bit ELF header on a 32-bit only platform where the crashing
> kernel will never generate a 64-bit ELF core file?

I really don't know but fs/proc/vmcore.c is coded in such way that it supports
both types of ELF headers. It however, passes the header to elf_check_arch()
which in our case should fail if it is something else than ELF32 header.

Thanks,
MW
