From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Aug 2018 18:56:14 -0500
Subject: [PATCH 6/8] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
References: <20180821215524.23040-1-robh@kernel.org>
 <20180821215524.23040-7-robh@kernel.org>
 <CAK7LNATcYSvwh0BEEdyUuDa_Y9X-AqQAzA5MrbNhOSMmSzqhTg@mail.gmail.com>
Message-ID: <CAL_JsqJJ6DCT8AjVYqkbFuJ+fO0VmVch24B=XRp4pJPkUQYAww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2018 at 9:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> 2018-08-22 6:55 GMT+09:00 Rob Herring <robh@kernel.org>:
> > There is nothing arch specific about building dtb files other than their
> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> > The dependencies and supported targets are all slightly different.
> > Also, a cross-compiler for each arch is needed, but really the host
> > compiler preprocessor is perfectly fine for building dtbs. Move the
> > build rules to a common location and remove the arch specific ones. This
> > is done in a single step to avoid warnings about overriding rules.
> >
> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> > These pull in several dependencies some of which need a target compiler
> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> > All that is really needed is dtc, so adjust the dependencies to only be
> > dtc.
> >
> > This change enables support 'dtbs_install' on some arches which were
> > missing the target.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: linux-kbuild at vger.kernel.org
> > Cc: linux-snps-arc at lists.infradead.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: uclinux-h8-devel at lists.sourceforge.jp
> > Cc: linux-mips at linux-mips.org
> > Cc: nios2-dev at lists.rocketboards.org
> > Cc: linuxppc-dev at lists.ozlabs.org
> > Cc: linux-xtensa at linux-xtensa.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Makefile                 | 30 ++++++++++++++++++++++++++++++
> >  arch/arc/Makefile        |  6 ------
> >  arch/arm/Makefile        | 20 +-------------------
> >  arch/arm64/Makefile      | 17 +----------------
> >  arch/c6x/Makefile        |  2 --
> >  arch/h8300/Makefile      | 11 +----------
> >  arch/microblaze/Makefile |  4 +---
> >  arch/mips/Makefile       | 15 +--------------
> >  arch/nds32/Makefile      |  2 +-
> >  arch/nios2/Makefile      |  7 -------
> >  arch/nios2/boot/Makefile |  4 ----
> >  arch/powerpc/Makefile    |  3 ---
> >  arch/xtensa/Makefile     | 12 +-----------
> >  scripts/Makefile         |  1 -
> >  scripts/Makefile.lib     |  2 +-
> >  15 files changed, 38 insertions(+), 98 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c13f8b85ba60..6d89e673f192 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1212,6 +1212,30 @@ kselftest-merge:
> >                 $(srctree)/tools/testing/selftests/*/config
> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >
> > +# ---------------------------------------------------------------------------
> > +# Devicetree files
> > +
> > +dtstree := $(wildcard arch/$(SRCARCH)/boot/dts)

BTW, there's an error here too. It doesn't work right with
KBUILD_OUTPUT set and should be:

ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
dtstree := arch/$(SRCARCH)/boot/dts
endif

> > +
> > +ifdef CONFIG_OF_EARLY_FLATTREE
> > +
> > +%.dtb %.dtb.S %.dtb.o: | dtc
>
> I think the pipe operator is unnecessary
> because Kbuild will descend to $(dtstree) anyway.

The pipe means 'order-only', right? So it is just a weaker dependency
for things which are not input files as dtc is not. The 'dtc' here is
just the dtc rule below, not the actual executable. Or am I missing
something?

> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > +
> > +PHONY += dtbs
> > +dtbs: | dtc
>
> Ditto.
>
>
> > +       $(Q)$(MAKE) $(build)=$(dtstree)
> > +
> > +dtbs_install: dtbs
> > +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> > +
> > +all: dtbs
> > +
> > +dtc:
> > +       $(Q)$(MAKE) $(build)=scripts/dtc
> > +
> > +endif
> > +
>
>
> arch/*/boot/dts/ are not only directories that
> require dtc.

Ah yes, of course...

> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index 61affa300d25..a716a6b10954 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -39,7 +39,6 @@ build_unifdef: $(obj)/unifdef
> >  subdir-$(CONFIG_MODVERSIONS) += genksyms
> >  subdir-y                     += mod
> >  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> > -subdir-$(CONFIG_DTC)         += dtc
> >  subdir-$(CONFIG_GDB_SCRIPTS) += gdb
> >
> >  # Let clean descend into subdirs

Looks like I need to leave this line to fix the above and cleaning.

Thanks for the review.

Rob
