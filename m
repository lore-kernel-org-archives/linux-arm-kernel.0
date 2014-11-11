From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Nov 2014 22:32:23 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141024182509.GA31232@gate.crashing.org>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <20141024094412.GN27405@n2100.arm.linux.org.uk>
 <20141024182509.GA31232@gate.crashing.org>
Message-ID: <2480226.26bJjjL2fl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 13:25:09 Segher Boessenkool wrote:
> On Fri, Oct 24, 2014 at 10:44:12AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Oct 24, 2014 at 11:13:27AM +0200, Arnd Bergmann wrote:
> > > Ok, that also explains the problems with the missing __linux__ macro, given
> > > Ard's reply about bare-metal gcc.
> > > 
> > > I think we have two choices here:
> > > 
> > > a) change the buildall script so it actually builds a compiler that behaves
> > >    in the way we expect for the kernel (__SIZE_TYPE__ and __linux__ at least,
> > >    possibly others)
> > > 
> > > b) change the kernel to work with the way the bare-metal compiler is built,
> > >    adding -D__linux__ in the ARM Makefile and applying Ard's workaround for
> > >    __SIZE_TYPE__/__INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__.
> > > 
> > > Both options are a little hacky and I don't really like them, but I think
> > > it makes sense to do one of them.
> > 
> > Well, (a) is probably the right answer.  EABI had (or still has) the
> > idea that enums can be a dynamic size, and this was taken out of the
> > Linux version of EABI.  What this means is that an enum used across an
> > interface between a compiler targetting Linux and one not targetting
> > Linux may not be compatible.
> 
> Hi!  Happy to hear some people still find buildall useful.
> 
> The standard arm toolchains it builds are configured for arm-linux-eabi,
> not "plain" eabi.  So what goes wrong?
> 
> Oh.  I changed that april this year; so just update your buildall.
> 
> [But of course it would be good if the kernel build would work with *any*
> reasonable toolchain.  OTOH it seems that most arm toolchains aren't
> reasonable.]
> 

I've decided to investigate it further. It seems that your change to
'arm-linux-eabi' did not have the intended effect. I got it to work with
this patch:

diff --git a/build b/build
index 10416a8..b2d38ec 100755
--- a/build
+++ b/build
@@ -36,7 +36,7 @@ case $ARCH in
 	*-eabi)		TARGET=$ARCH ;;
 	*-elf)		TARGET=$ARCH ;;
 
-	arm)		TARGET=arm-linux-eabi ;;
+	arm)		TARGET=arm-linux-gnueabi ;;
 	avr32)		TARGET=avr-linux ;;
 	blackfin)	TARGET=bfin-uclinux ;;
 	h8300)		TARGET=h8300-elf ;;


What happens in gcc apparently is that the configuration logic gets confused
and uses this entry in gcc/config.gcc:

arm*-*-eabi*)
        default_use_cxa_atexit=yes
        tm_file="dbxelf.h elfos.h arm/unknown-elf.h arm/elf.h arm/bpabi.h"
        tmake_file="${tmake_file} arm/t-arm arm/t-arm-elf"
        tm_file="$tm_file newlib-stdint.h"
        tmake_file="${tmake_file} arm/t-bpabi"
        use_gcc_stdint=wrap
        tm_file="${tm_file} arm/aout.h vxworks-dummy.h arm/arm.h"
        ;;

instead of this one:

arm*-*-linux-*)                 # ARM GNU/Linux with ELF
        tm_file="dbxelf.h elfos.h gnu-user.h linux.h linux-android.h glibc-stdint.h arm/elf.h arm/linux-gas.h arm/linux-elf.h"
        extra_options="${extra_options} linux-android.opt"
        tmake_file="${tmake_file} arm/t-arm arm/t-arm-elf arm/t-bpabi arm/t-linux-eabi"
        tm_file="$tm_file arm/bpabi.h arm/linux-eabi.h arm/aout.h vxworks-dummy.h arm/arm.h"
        # The EABI requires the use of __cxa_atexit.
        default_use_cxa_atexit=yes
        with_tls=${with_tls:-gnu}
        ;;

so among other things, we are missing linux.h and glibc-stdint.h.

	Arnd
