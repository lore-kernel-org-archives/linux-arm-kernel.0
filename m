From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 9 Feb 2017 18:46:57 +0800
Subject: Aarch64 kernel with 32bit userspace question
In-Reply-To: <5fcfa6eb-b6ba-b5ae-89c1-96d3d7587cd5@denx.de>
References: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
 <20170209182915.6d909f3f@xhacker>
 <5fcfa6eb-b6ba-b5ae-89c1-96d3d7587cd5@denx.de>
Message-ID: <20170209184657.20d7e027@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Feb 2017 11:43:03 +0100 Marek Vasut wrote:

> On 02/09/2017 11:29 AM, Jisheng Zhang wrote:
> > On Thu, 9 Feb 2017 11:14:19 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> Hi,
> >>
> >> I'm trying multilib userland on aarch64, but I'm running into a problem.
> >> I have a simple test code:
> >>  
> >> -->8--    
> >> #include <signal.h>
> >>
> >> int main(void) {
> >>     return 0;
> >> }
> >> --8<--
> >>
> >> If I compile that with aarch64 gcc , it compiles just fine.
> >>
> >> If I compile the same thing with 32bit armv7ahf multilib gcc, the
> >> build fails on "unknown type name '__uint128_t'". This comes from
> >> arch/arm64/include/uapi/asm/sigcontext.h , which has __uint128_t in
> >> struct fpsimd_context {} . The signal.h includes that (through a few
> >> glibc headers) and that's what triggers the failure. __uint128_t is
> >> defined on aarch64 , but it is not on armv7a (32bit).
> >>  
> > 
> > which 32bit toolchain are you using?  
> 
> Multilib toolchain from poky 2.2 (gcc 6.2 , glibc 2.24).
> 
> > I didn't see any problems with 32bit armhf linaro toolchain, or the
> > toolchain in debian armhf or ubuntu  
> 
> Can you be more specific about the version ?
> 

the one I'm using:

Using built-in specs.
COLLECT_GCC=arm-linux-gnueabihf-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/arm-linux-gnueabihf/6/lto-wrapper
Target: arm-linux-gnueabihf
Configured with: ../src/configure -v --with-pkgversion='Debian 6.3.0-5' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs --enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-6 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libitm --disable-libquadmath --enable-plugin --enable-default-pie --with-system-zlib --disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-armhf-cross/jre --enable-java-home --with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-armhf-cross --with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-armhf-cross --with-arch-directory=arm --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj --with-targ
 et-system-zlib --enable-objc-gc=auto --enable-multiarch --disable-sjlj-exceptions --with-arch=armv7-a --with-fpu=vfpv3-d16 --with-float=hard --with-mode=thumb --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=arm-linux-gnueabihf --program-prefix=arm-linux-gnueabihf- --includedir=/usr/arm-linux-gnueabihf/include
Thread model: posix
gcc version 6.3.0 20170124 (Debian 6.3.0-5) 
