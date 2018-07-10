From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 9 Jul 2018 17:29:37 -0700
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
References: <20180709200956.31158-1-labbott@redhat.com>
 <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
Message-ID: <CAOi56cWmfq4YvhfLzCt+R2vsxGW+bgSyxPcOOaCHUcBJmo65kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 4:24 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 07/09/2018 01:09 PM, Laura Abbott wrote:
> > This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> >
> > This breaks compilation with Fedora gcc-8 tool chains:
> >
> >    CHK     include/generated/compile.h
> >    LD [M]  arch/arm64/crypto/sha512-ce.o
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
>
> The answer appears to be that Fedora binutils does not package the assembly
> scripts. The logic behind this is not immediately obvious but it's been
> removed since 2004. Obviously this is a packaging issue on Fedora's side
> but I'd still like to revert since it is a build breakage and fixing
> this might require some coordination. I'll send a v2 with clarified
> commit text if there's agreement.

Tested-by: Kevin Hilman <khilman@baylibre.com>

FWIW, the build is broken with debian packaged toolchain also.  I
noticed it on stretch[1], and this patch gets things building again.

Kevin

[1]
$ aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/aarch64-linux-gnu/6/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
6.3.0-18' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-6 --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libquadmath --enable-plugin --enable-default-pie
--with-system-zlib --disable-browser-plugin --enable-java-awt=gtk
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-arm64-cross/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-arm64-cross
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-arm64-cross
--with-arch-directory=aarch64
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj
--enable-multiarch --enable-fix-cortex-a53-843419
--enable-checking=release --build=x86_64-linux-gnu
--host=x86_64-linux-gnu --target=aarch64-linux-gnu
--program-prefix=aarch64-linux-gnu-
--includedir=/usr/aarch64-linux-gnu/include
Thread model: posix
gcc version 6.3.0 20170516 (Debian 6.3.0-18)
