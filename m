From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 30 Mar 2010 10:11:24 +0300
Subject: [RFC 07/10] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <20100329211208.GE28468@n2100.arm.linux.org.uk>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<20100329211208.GE28468@n2100.arm.linux.org.uk>
Message-ID: <20100330071124.GD31448@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 11:12:08PM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Mar 29, 2010 at 12:26:33PM +0300, Mika Westerberg wrote:
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
> A smaller patch:
> 
> -#define elf_check_arch elf_check_arch
> +#define elf_check_arch(x) elf_check_arch((const struct elf32_hdr *)(x))

With this I get:

arch/arm/kernel/elf.c:7: error: expected declaration specifiers or '...' before
'(' token
arch/arm/kernel/elf.c: In function 'elf_check_arch':
arch/arm/kernel/elf.c:8: error: number of arguments doesn't match prototype
/home/westeri/devel/maemo/linux/linux-2.6/arch/arm/include/asm/elf.h:95: error:
prototype declaration
arch/arm/kernel/elf.c:12: error: 'x' undeclared (first use in this function)
arch/arm/kernel/elf.c:12: error: (Each undeclared identifier is reported only
once
arch/arm/kernel/elf.c:12: error: for each function it appears in.)
make[1]: *** [arch/arm/kernel/elf.o] Error 1
make: *** [arch/arm/kernel] Error 2

That's why I changed name of the function to arm_elf_check_arch().

Thanks,
MW
