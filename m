From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 May 2010 13:21:56 +0100
Subject: [PATCH v2 6/8] arm: allow passing an ELF64 header to
	elf_check_arch()
In-Reply-To: <20100510120920.GD11783@esdhcp04058.research.nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
	<3c8da055f0a84cfd1c6659d9fda24e4eb97ab9fb.1273041358.git.ext-mika.1.westerberg@nokia.com>
	<20100510112036.GC14337@n2100.arm.linux.org.uk>
	<20100510120920.GD11783@esdhcp04058.research.nokia.com>
Message-ID: <20100510122156.GA7796@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 03:09:20PM +0300, Mika Westerberg wrote:
> I believe that when passing ELF64 header, it fails in following checks:
> 
> 	/* Make sure it's an ARM executable */
> 	if (x->e_ident[EI_CLASS] != ELF_CLASS)
> 		return 0;
> 	if (x->e_machine != EM_ARM)
> 		return 0;
> 
> ELF_CLASS is defined in arch/arm/include/asm/elf.h:
> 
> #define ELF_CLASS       ELFCLASS32
> 
> So if class is different than ELFCLASS32 it returns 0 and never even try to
> access other fields, right?

Yes.

> > Now, here's the question: why does this crashkernel stuff want to
> > parse a 64-bit ELF header on a 32-bit only platform where the crashing
> > kernel will never generate a 64-bit ELF core file?
> 
> I really don't know but fs/proc/vmcore.c is coded in such way that it supports
> both types of ELF headers. It however, passes the header to elf_check_arch()
> which in our case should fail if it is something else than ELF32 header.

There's other arches which want elf_check_arch to be a function call, so
I think my question needs to be looked at more closely - and possibly
the code changed such that we don't end up with this situation.

Maybe a cleaner solution would be for vmcore.c to split its calls to
elf_check_arch() - to be elf32_check_arch() and elf64_check_arch() ?
Platforms where it's just a macro can define both to be elf_check_arch()
but those where only one flavour is supported should define the unsupported
flavour to zero - which incidentally would allow the compiler to optimize
away the unnecessary parts of parse_crash_elf*_headers().
