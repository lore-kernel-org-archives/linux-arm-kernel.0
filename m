From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 11 May 2010 10:17:35 +0300
Subject: [PATCH v2 6/8] arm: allow passing an ELF64 header to
	elf_check_arch()
In-Reply-To: <20100510122156.GA7796@n2100.arm.linux.org.uk>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
	<3c8da055f0a84cfd1c6659d9fda24e4eb97ab9fb.1273041358.git.ext-mika.1.westerberg@nokia.com>
	<20100510112036.GC14337@n2100.arm.linux.org.uk>
	<20100510120920.GD11783@esdhcp04058.research.nokia.com>
	<20100510122156.GA7796@n2100.arm.linux.org.uk>
Message-ID: <20100511071735.GF11783@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 02:21:56PM +0200, ext Russell King - ARM Linux wrote:
> 
> > > Now, here's the question: why does this crashkernel stuff want to
> > > parse a 64-bit ELF header on a 32-bit only platform where the crashing
> > > kernel will never generate a 64-bit ELF core file?
> > 
> > I really don't know but fs/proc/vmcore.c is coded in such way that it supports
> > both types of ELF headers. It however, passes the header to elf_check_arch()
> > which in our case should fail if it is something else than ELF32 header.
> 
> There's other arches which want elf_check_arch to be a function call, so
> I think my question needs to be looked at more closely - and possibly
> the code changed such that we don't end up with this situation.

I quickly checked and it seems that only one arch in addition to ARM wants this
to be a function:

arch/frv/include/asm/elf.h:
...
extern int elf_check_arch(const struct elf32_hdr *hdr);

and they don't (yet) support kdump.

> Maybe a cleaner solution would be for vmcore.c to split its calls to
> elf_check_arch() - to be elf32_check_arch() and elf64_check_arch() ?

True. However, there already is another macro in vmcore.c:
vmcore_elf_check_arch() which is used by 64-bit code. So adding 32- and 64-bit
versions of elf_check_arch() might be overkill.

Also elf_check_arch() is used outside vmcore.c as well.

> Platforms where it's just a macro can define both to be elf_check_arch()
> but those where only one flavour is supported should define the unsupported
> flavour to zero - which incidentally would allow the compiler to optimize
> away the unnecessary parts of parse_crash_elf*_headers().

I agree but changing these needs to be performed on every arch and it might
cause regressions (at least because it is hard to test on archs that I don't
have). So I'm not sure if it is worth a risk.

It's up to you, I can implement it this way also if you don't accept the current
version of the patch.

Thanks again,
MW
