From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 15:48:18 +0100
Subject: [PATCH] arm64: errata: add module build workaround for erratum
 #843419
In-Reply-To: <CAKv+Gu-o6=1NQzCoLd_+Y196X+BVN6u1E6Gd39BKJJqXc5BO4w@mail.gmail.com>
References: <1442402197-20306-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu-o6=1NQzCoLd_+Y196X+BVN6u1E6Gd39BKJJqXc5BO4w@mail.gmail.com>
Message-ID: <20150917144818.GI25634@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 03:24:01PM +0100, Ard Biesheuvel wrote:
> Hi Will,

Hi Ard,

> On 16 September 2015 at 13:16, Will Deacon <will.deacon@arm.com> wrote:
> > Cortex-A53 processors <= r0p4 are affected by erratum #843419 which can
> > lead to a memory access using an incorrect address in certain sequences
> > headed by an ADRP instruction.
> >
> > There is a linker fix to generate veneers for ADRP instructions, but
> > this doesn't work for kernel modules which are built as unlinked ELF
> > objects.
> >
> 
> Considering that the kernel is built without -fpic but still appears
> at a different offset when the MMU is off, those veneers had better be
> position independent.

They seem to be ok, from what I've tested. You should also be able to
take a recent ld and see for yourself what it gets up to.

> > This patch adds a new config option for the erratum which, when enabled,
> > builds kernel modules with the mcmodel=large flag. This uses absolute
> > addressing for all kernel symbols, thereby removing the use of ADRP as
> > a PC-relative form of addressing. The ADRP relocs are removed from the
> > module loader so that we fail to load any potentially affected modules.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/Kconfig         | 16 ++++++++++++++++
> >  arch/arm64/Makefile        |  4 ++++
> >  arch/arm64/kernel/module.c |  2 ++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 7d95663c0160..11ff4d57c92a 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -331,6 +331,22 @@ config ARM64_ERRATUM_845719
> >
> >           If unsure, say Y.
> >
> > +config ARM64_ERRATUM_843419
> > +       bool "Cortex-A53: 843419: A load or store might access an incorrect address"
> > +       depends on MODULES
> > +       default y
> > +       help
> > +         This option builds kernel modules using the large memory model in
> > +         order to avoid the use of the ADRP instruction, which can cause
> > +         a subsequent memory access to use an incorrect address on Cortex-A53
> > +         parts up to r0p4.
> > +
> > +         Note that the kernel itself must be linked with a version of ld
> > +         which fixes potentially affected ADRP instructions through the
> > +         use of veneers.
> > +
> > +         If unsure, say Y.
> > +
> >  endmenu
> >
> >
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 15ff5b4156fd..f9914d7c1bb0 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -41,6 +41,10 @@ endif
> >
> >  CHECKFLAGS     += -D__aarch64__
> >
> > +ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
> > +CFLAGS_MODULE  += -mcmodel=large
> > +endif
> > +
> 
> Ouch.
> 
> Couldn't we handle this at runtime? According to the erratum, the
> problem only occurs when the adrp is in either of the last two
> instruction slots of a 4 KB page, and we could easily turn adrp
> instructions into adr if the symbol is within 1 MB of the place (which
> would typically cover all internal references in the module), and emit
> a veneer otherwise?

I'd have thought the internal references would already be using smaller
relocs if they could get away with it, but it's worth looking at.

> I'm happy to hack something up

Sure, fill your boots! I just wanted something simple for stable and I
have limited patience in working around these kind of things. I think
there are some testcases in the binutils tree if you want to adapt them
for the module loader [1].

Will

[1]
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=ld/testsuite/ld-aarch64/erratum843419.s;h=35c21ae95a65913050dafc857abe35d8ee6fe9ed;hb=HEAD
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=ld/testsuite/ld-aarch64/erratum843419.d;h=4be8f9e585095898dae9a8677d565edb4089e97a;hb=HEAD
