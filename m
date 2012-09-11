From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 11 Sep 2012 16:10:14 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911154308.3355a480@archvile>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20558.61974.299424.536837@pilspetsen.it.uu.se>
 <20120911104925.3461603e@archvile>
 <20559.1844.786507.216580@pilspetsen.it.uu.se>
 <20120911123743.29e0ed40@archvile>
 <20559.8716.124212.451155@pilspetsen.it.uu.se>
 <20120911135212.187bd224@archvile>
 <20559.13391.264611.307105@pilspetsen.it.uu.se>
 <20120911154308.3355a480@archvile>
Message-ID: <20559.17990.950313.939717@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Jander writes:
 > On Tue, 11 Sep 2012 14:53:35 +0200
 > Mikael Pettersson <mikpe@it.uu.se> wrote:
 > 
 > > David Jander writes:
 > >  > On Tue, 11 Sep 2012 13:35:40 +0200
 > >  > Mikael Pettersson <mikpe@it.uu.se> wrote:
 > >  > 
 > >  > > David Jander writes:
 > >  > >  > > I can make the patches available if there's confirmation that a vanilla
 > >  > >  > > upstream gcc-4.6.3 doesn't work.
 > >  > >  > 
 > >  > >  > I am pretty sure this is the case... do you have a patch series that you can
 > >  > >  > easily tar and mail to me? I'd like to try those patches with OSELAS, to see
 > >  > >  > if I can indeed build a gcc-4.6.3 toolchain that generates correct code.... I
 > >  > >  > already know that I can generate one that doesn't ;-)
 > >  > >  > 
 > >  > > ...
 > >  > >  > > If you're sure no add-on patches were applied, then yes please do.
 > >  > >  > 
 > >  > >  > Pretty sure, but not 100%, so I'd like to try your patches first if you don't
 > >  > >  > mind....
 > >  > > 
 > >  > > And I'd like to confirm first. Please tell us the following:
 > >  > > 
 > >  > >  > >  > > 2: include the output of gcc -v which tells how that gcc was configured,
 > >  > 
 > >  > Using built-in specs.
 > >  > COLLECT_GCC=/opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/bin/arm-v5te-linux-gnueabi-gcc-4.6.3
 > >  > COLLECT_LTO_WRAPPER=/opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/libexec/gcc/arm-v5te-linux-gnueabi/4.6.3/lto-wrapper
 > >  > Target: arm-v5te-linux-gnueabi
 > >  > Configured with: /home/djander/ptxdist/OSELAS.Toolchain-2011.11.1/platform-arm-v5te-linux-gnueabi-gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/build-cross/gcc-4.6.3/configure --target=arm-v5te-linux-gnueabi --with-sysroot=/opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3
 > >  > -glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/sysroot-arm-v5te-linux-gnueabi --disable-multilib --with-float=soft --with-fpu=vfp --with-cpu=arm926ej-s --enable-__cxa_atexit --disable-sjlj-exceptions --disable-nls --disable-decimal-float --disable-fixed-point --disable-win32-registry --enable-symvers=gnu --with-pkgversion=OSELAS.Toolchain-2011.11.1 --with-system-zlib --with-gmp=/home/djander/ptxdist/OSELAS.Toolchain-2011.11.1/platform-arm-v5te
 > >  > -linux-gnueabi-gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/sysroot-host --with-mpfr=/home/djander/ptxdist/OSELAS.Toolchain-2011.11.1/platform-arm-v5te-linux-gnueabi-gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/sysroot-host --prefix=/opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized --enable-languages=c,c++ --enable-threads=posix --enable-c99 --enable-long-long --enable-libstdcxx-debug --enable-profile --enable-shared --disable-libssp --enable-checking=release
 > >  > Thread model: posix
 > >  > gcc version 4.6.3 (OSELAS.Toolchain-2011.11.1)
 > >  > 
 > >  > >  > >  > > 3: give the exact set of gcc options used then compiling the test case.
 > >  > 
 > >  > If I type this in a terminal:
 > >  > 
 > >  > 
 > >  > $ /opt/OSELAS.Toolchain-2011.11.1/arm-v5te-linux-gnueabi/gcc-4.6.3-glibc-2.14.1-binutils-2.21.1a-kernel-2.6.39-sanitized/bin/arm-v5te-linux-gnueabi-gcc-4.6.3 -Os -S -o - -x c -
 > >  > 
 > >  > struct flexcan_regs {
 > >  >         unsigned int mcr;
 > >  >         unsigned int rxfgmask;
 > >  > };
 > >  > 
 > >  > #define flexcan_read(a) (*(volatile unsigned int *)(a))
 > >  > #define flexcan_write(v,a)      (*(volatile unsigned int *)(a) = (v))
 > >  > 
 > >  > int flexcan_chip_start(int ver, struct flexcan_regs *regs)
 > >  > {
 > >  >         flexcan_write(0, &regs->mcr);
 > >  > 
 > >  >         if (ver >= 10)
 > >  >                 flexcan_write(0, &regs->rxfgmask);
 > >  > 
 > >  >         return 0;
 > >  > }
 > >  > 
 > >  > 
 > >  > I get this output after hitting <CTRL-D>:
 > >  > 
 > >  >         .cpu arm926ej-s
 > >  >         .fpu softvfp
 > >  >         .eabi_attribute 20, 1
 > >  >         .eabi_attribute 21, 1
 > >  >         .eabi_attribute 23, 3
 > >  >         .eabi_attribute 24, 1
 > >  >         .eabi_attribute 25, 1
 > >  >         .eabi_attribute 26, 2
 > >  >         .eabi_attribute 30, 4
 > >  >         .eabi_attribute 18, 4
 > >  >         .file   ""
 > >  >         .text
 > >  >         .align  2
 > >  >         .global flexcan_chip_start
 > >  >         .type   flexcan_chip_start, %function
 > >  > flexcan_chip_start:
 > >  >         @ args = 0, pretend = 0, frame = 0
 > >  >         @ frame_needed = 0, uses_anonymous_args = 0
 > >  >         @ link register save eliminated.
 > >  >         mov     r3, #0
 > >  >         cmp     r0, #9
 > >  >         str     r3, [r1, #0]
 > >  >         ldrle   r3, [r1, #4]
 > >  >         mov     r0, #0
 > >  >         str     r3, [r1, #4]
 > >  >         bx      lr
 > >  >         .size   flexcan_chip_start, .-flexcan_chip_start
 > >  >         .ident  "GCC: (OSELAS.Toolchain-2011.11.1) 4.6.3"
 > >  >         .section        .note.GNU-stack,"",%progbits
 > >  > 
 > >  > 
 > >  > Do you need more information?
 > > 
 > > No, I can reproduce the bug with vanilla gcc-4.6.3; vanilla 4.7.1 and 4.5.4 are Ok.
 > > 
 > > I'll bisect my 4.6.3 patch series to see which patch fixes it.
 > 
 > Great. Thanks a lot for your help so far. Looking forward to see what fixes
 > this issue. Are you implying that you will also file the bug (and possible
 > patch) with gcc.gnu.org, or do you prefer me to do that?

This is a known bug: <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52445>.
It was reported and fixed in gcc trunk on March 1 this year, but missed
the gcc-4.6.3 release made the same day (and frozen a week or so before),
and it hasn't been applied to gcc-4.6.4 branch yet either.

I've been using and testing the fix in my own gcc-4.6 branch since March 4
without regressions. I'm attaching my backport of the fix below.

I'll ping gcc upstream about getting this into gcc-4.6.4.

/Mikael

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: gcc-4.6.3-pr52445.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/d7fc3996/attachment-0001.ksh>
