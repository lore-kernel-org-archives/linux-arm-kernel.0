From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 5 Nov 2010 10:31:50 +0100
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
In-Reply-To: <AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
	<AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
Message-ID: <19667.52998.909668.596635@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent writes:
 > 2010/11/5 Mikael Pettersson <mikpe@it.uu.se>:
 > > M?ns Rullg?rd writes:
 > > ?> Rabin Vincent <rabin@rab.in> writes:
 > > ?>
 > > ?> > Fix the following error which occurs when building an ARM kernel with
 > > ?> > GCC 4.5.0:
 > > ?> >
 > > ?> > ? arm-linux-gcc -Wp,-MD,kernel/.bounds.s.d ?-nostdinc
 > > ?> > ? [command line edited to remove paths]
 > > ?> > ? -D__KERNEL__ -mlittle-endian
 > > ?> > ? -Wall -Wundef
 > > ?> > ? -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
 > > ?> > ? -Werror-implicit-function-declaration -Wno-format-security
 > > ?> > ? -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm
 > > ?> > ? -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=5
 > > ?> > ? -march=armv5te -mtune=arm9tdmi -msoft-float -Uarm -fomit-frame-pointer -g
 > > ?> > ? -DCC_HAVE_ASM_GOTO ? ?-D"KBUILD_STR(s)=#s"
 > > ?> > ? -D"KBUILD_BASENAME=KBUILD_STR(bounds)" ?-D"KBUILD_MODNAME=KBUILD_STR(bounds)"
 > > ?> > ? -fverbose-asm -S -o kernel/bounds.s kernel/bounds.c
 > > ?> > ? kernel/bounds.c:1:0: error: FPA is unsupported in the AAPCS
 > > ?> >
 > > ?> > Signed-off-by: Rabin Vincent <rabin@rab.in>
 > > ?> > ---
 > > ?> > Seen with this compiler:
 > > ?> >
 > > ?> > http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.5.0/x86_64-gcc-4.5.0-nolibc_arm-linux.tar.bz2
 > > ?> >
 > > ?> > ?arch/arm/Makefile | ? ?2 +-
 > > ?> > ?1 files changed, 1 insertions(+), 1 deletions(-)
 > > ?> >
 > > ?> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
 > > ?> > index b87aed0..c06d9ed 100644
 > > ?> > --- a/arch/arm/Makefile
 > > ?> > +++ b/arch/arm/Makefile
 > > ?> > @@ -91,7 +91,7 @@ tune-$(CONFIG_CPU_FEROCEON) ? ? ?:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
 > > ?> > ?tune-$(CONFIG_CPU_V6) ? ? ? ? ? ? :=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 > > ?> >
 > > ?> > ?ifeq ($(CONFIG_AEABI),y)
 > > ?> > -CFLAGS_ABI ? ? ? ?:=-mabi=aapcs-linux -mno-thumb-interwork
 > > ?> > +CFLAGS_ABI ? ? ? ?:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
 > > ?>
 > > ?> The real question is why something is trying to use floating-point.
 > > ?> It shouldn't.
 > >
 > > Indeed. I suspect an improperly patched or configured gcc-4.5.0,
 > > or broken kernel sources. Especially considering that the kernel
 > > passes -msoft-float to gcc (see above).
 > >
 > > I know gcc-4.5.0 configured for arm-linux-gnueabi built working EABI
 > > kernels a few months ago.
 > 
 > The kernel sources are clean Linus' tree, so I guess it must be the
 > compiler configuration then.  Indeed, running the above mentioned cross
 > compiler with -msoft-float -mabi=aapcs-linux even on an empty source
 > file yields the same error.  I've cc'd Tony here who I believe builds
 > these prebuilt compilers at http://kernel.org/pub/tools/crosstool/.

How was that gcc configured? You can find out by running `arm-linux-gcc -v'.
