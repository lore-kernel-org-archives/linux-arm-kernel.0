From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 11:30:39 +0200
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <20180710090125.GA28924@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
Message-ID: <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> Thanks, Laura.
> 
> I'll take this as a fix, and add a comment to the Makefile to justify
> why we need the linux target.

So this comes down to either breaking fedora/debian toolchains (that
don't support elf emulation mode) or breaking bare-metal toolchains
(that don't support linux emulation mode).

Since Linux is a bare-metal project that does not technically require
the linux target (who said using "Linux" for all things is confusing?),
I think it should aim for the elf target in the long term.

But well, breaking Linux build in common distros isn't good either, so I
guess it makes sense to revert this while distros toolchains are being
fixed. Hopefully, it won't take too long.

What do you think?

Cheers,

Paul

> Will
> 
> On Mon, Jul 09, 2018 at 01:09:56PM -0700, Laura Abbott wrote:
> > This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> > 
> > This breaks compilation with Fedora gcc-8 tool chains:
> > 
> >   CHK     include/generated/compile.h
> >   LD [M]  arch/arm64/crypto/sha512-ce.o
> > aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> > make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> > make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> > 
> > Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > A bit rushed and I'm still debugging but I wanted to send this out
> > before anyone else gets hit since it is -rc4. Seeing this on both native
> > and cross compiles.
> > ---
> >  arch/arm64/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 7976d2d242fa..f476d52ad8d6 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
> >  KBUILD_CPPFLAGS	+= -mbig-endian
> >  CHECKFLAGS	+= -D__AARCH64EB__
> >  AS		+= -EB
> > -LDFLAGS		+= -EB -maarch64elfb
> > +LDFLAGS		+= -EB -maarch64linuxb
> >  UTS_MACHINE	:= aarch64_be
> >  else
> >  KBUILD_CPPFLAGS	+= -mlittle-endian
> >  CHECKFLAGS	+= -D__AARCH64EL__
> >  AS		+= -EL
> > -LDFLAGS		+= -EL -maarch64elf
> > +LDFLAGS		+= -EL -maarch64linux
> >  UTS_MACHINE	:= aarch64
> >  endif
> >  
> > -- 
> > 2.17.1
> > 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
