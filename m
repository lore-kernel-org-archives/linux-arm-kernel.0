From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 22:50:42 +0000
Subject: [PATCH 1/4] proc/vmcore: allow archs to override
	vmcore_elf_check_arch()
In-Reply-To: <20101116142850.df5e9805.akpm@linux-foundation.org>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
	<df680f67f33d8b0ef815045b53f205b3ff35de63.1289292124.git.mika.westerberg@iki.fi>
	<20101116142850.df5e9805.akpm@linux-foundation.org>
Message-ID: <20101116225042.GH21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 02:28:50PM -0800, Andrew Morton wrote:
> On Tue,  9 Nov 2010 11:06:10 +0200
> Mika Westerberg <mika.westerberg@iki.fi> wrote:
> 
> > From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > 
> > Allow architectures to redefine this macro if needed. This is useful for
> > example in architectures where 64-bit ELF vmcores are not supported.
> > Specifying zero vmcore_elf64_check_arch() allows compiler to optimize
> > away unnecessary parts of parse_crash_elf64_headers().
> > 
> > We also rename the macro to vmcore_elf64_check_arch() to reflect that it
> > is used for 64-bit vmcores only.
> > 
> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > ---
> >  fs/proc/vmcore.c           |    2 +-
> >  include/linux/crash_dump.h |    9 ++++++++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 2367fb3..74802bc5 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -499,7 +499,7 @@ static int __init parse_crash_elf64_headers(void)
> >  	/* Do some basic Verification. */
> >  	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
> >  		(ehdr.e_type != ET_CORE) ||
> > -		!vmcore_elf_check_arch(&ehdr) ||
> > +		!vmcore_elf64_check_arch(&ehdr) ||
> >  		ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
> >  		ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
> >  		ehdr.e_version != EV_CURRENT ||
> > diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> > index 0026f26..088cd4a 100644
> > --- a/include/linux/crash_dump.h
> > +++ b/include/linux/crash_dump.h
> > @@ -20,7 +20,14 @@ extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
> >  #define vmcore_elf_check_arch_cross(x) 0
> >  #endif
> >  
> > -#define vmcore_elf_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
> > +/*
> > + * Architecture code can redefine this if there are any special checks
> > + * needed for 64-bit ELF vmcores. In case of 32-bit only architecture,
> > + * this can be set to zero.
> > + */
> > +#ifndef vmcore_elf64_check_arch
> > +#define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
> > +#endif
> >  
> 
> Looks OK to me.  I'd suggest that this patch be merged along with the
> others, via whatever tree they're taken into.  Russell's ARM tree, I
> assume.
> 
> Should elf_check_arch() be renamed to elf64_check_arch()?

Some background...

Well, the reason this has come up with is because someone's brilliant
idea was to pass either a 32-bit or 64-bit ELF header to elf_check_arch,
and hope it worked it out for itself.

This works when elf_check_arch() is a macro, because the structure
members are identically named - the compiler gets to sort it out by
itself.

However, if you have a complex elf_check_arch() (as we do on ARM) which
requires it to be implemented as a C function, you end up with warnings
when the crash dump code wants to pass a 64-bit ELF header into
elf_check_arch().

Now, this would all be simple except that fs/binfmt_elf.c is coded to
be oblivious to whether an architecture is 32-bit or 64-bit - so the
architecture has to decide what kind of header elf_check_arch() actually
takes.  We can't say that elf_check_arch() always takes a 32-bit ELF
header.

I'm not sure what the right way out of this is - other than requiring
the crash dump code to avoid using elf_check_arch() itself, and provide
a pair of new macros - elf32_check_arch() and elf64_check_arch().  For
those architectures (basically everything but ARM) where their elf_check_arch()
is a macro, the elf32 and elf64 versions can be mere preprocessor aliases.
On ARM, we can then have our properly-typed functions.

The last point I'll make is that elf_check_arch() on ARM is also used to
limit the type of user executable that can be run, to prevent binaries
with incompatible floating point implementations from running or where
the support code for the floating point hardware is missing from the
kernel.  Some of these checks probably don't make sense for the crash
dump code.

So, as far as the above patch goes, I think it's sane, as it now
allows architectures to deal with the 64-bit/32-bit ELF issues in the
crash dump code in a more sane manner.
