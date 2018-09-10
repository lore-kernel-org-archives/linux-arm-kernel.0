From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 09:35:29 -0500
Subject: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
References: <20180905235327.5996-1-robh@kernel.org>
 <20180905235327.5996-7-robh@kernel.org>
 <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
Message-ID: <CAL_JsqKS+h0B5AuUh=vk0m1_7KSj4h2zZUo22rdt1w7oee=QwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 9, 2018 at 6:28 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
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
> > Please ack so I can take the whole series via the DT tree.
> >
> > v2:
> >  - Fix $arch/boot/dts path check for out of tree builds
> >  - Fix dtc dependency for building built-in dtbs
> >  - Fix microblaze built-in dtb building
> >
> >  Makefile                          | 32 +++++++++++++++++++++++++++++++
> >  arch/arc/Makefile                 |  6 ------
> >  arch/arm/Makefile                 | 20 +------------------
> >  arch/arm64/Makefile               | 17 +---------------
> >  arch/c6x/Makefile                 |  2 --
> >  arch/h8300/Makefile               | 11 +----------
> >  arch/microblaze/Makefile          |  4 +---
> >  arch/microblaze/boot/dts/Makefile |  2 ++
> >  arch/mips/Makefile                | 15 +--------------
> >  arch/nds32/Makefile               |  2 +-
> >  arch/nios2/Makefile               |  7 -------
> >  arch/nios2/boot/Makefile          |  4 ----
> >  arch/powerpc/Makefile             |  3 ---
> >  arch/xtensa/Makefile              | 12 +-----------
> >  scripts/Makefile.lib              |  2 +-
> >  15 files changed, 42 insertions(+), 97 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2b458801ba74..bc18dbbc16c5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1212,6 +1212,32 @@ kselftest-merge:
> >                 $(srctree)/tools/testing/selftests/*/config
> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >
> > +# ---------------------------------------------------------------------------
> > +# Devicetree files
> > +
> > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > +dtstree := arch/$(SRCARCH)/boot/dts
> > +endif
> > +
> > +ifdef CONFIG_OF_EARLY_FLATTREE
> > +
> > +%.dtb %.dtb.S %.dtb.o: | dtc
> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
>
> Hmm, I was worried about '%.dtb.o: | dtc'
> but seems working.
>
> Compiling %.S -> %.o requires objtool for x86,
> but x86 does not support DT.

Well, x86 does support DT to some extent. There's 2 platforms and the
DT unittests build and run on x86.

Actually, we can remove "%.dtb.S %.dtb.o" because we don't need those
as top-level build targets. Must have been a copy-n-paste relic from
before having common rules.

>
> If CONFIG_MODVERSIONS=y, scripts/genksyms/genksyms is required,
> %.dtb.S does not contain EXPORT_SYMBOL.

Okay, but that shouldn't affect any of this. We only build *.dtb.S
when doing built-in dtbs.

> BTW, 'dtc' should be a PHONY target.

Right, I found that too.

Rob
