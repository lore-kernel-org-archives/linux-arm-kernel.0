From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Feb 2015 14:03:53 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
 <20150220133806.GG8656@n2100.arm.linux.org.uk>
 <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
Message-ID: <CAKv+Gu99XCwnFjzJsRQ8SYD36CRYLh36wU3zD-94kbQtoc_ieA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2015 at 13:49, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Feb 20, 2015 at 11:38 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> From what I can see, this doesn't _build_ a compiler.  It grabs
>> gcc-linaro-aarch64-linux-gnu-4.9-2014.08_linux.tar.xz from
>> http://releases.linaro.org/14.08/components/toolchain/binaries
>> and installs that - which contains a load of binaries.
>
> That's correct. It uses the pre-built binaries from Linaro.

OK, so this is the command line GCC uses to invoke the assembler when
building aes-ce-cipher.o

 /usr/local/gcc-linaro-aarch64-linux-gnu-4.9-2014.07_linux/bin/../lib/gcc/aarch64-linux-gnu/4.9.1/../../../../aarch64-linux-gnu/bin/as
-v -I /home/ard/linux-2.6/arch/arm64/include -I
arch/arm64/include/generated/uapi -I arch/arm64/include/generated -I
/home/ard/linux-2.6/include -I include -I
/home/ard/linux-2.6/arch/arm64/include/uapi -I
arch/arm64/include/generated/uapi -I /home/ard/linux-2.6/include/uapi
-I include/generated/uapi -I /home/ard/linux-2.6/arch/arm64/crypto -I
arch/arm64/crypto -EL -march=armv8-a+crypto -mabi=lp64 -o
arch/arm64/crypto/aes-ce-cipher.o /tmp/ccqUB3dr.s

So in my case, it correctly relays the -march option to GAS, and it
builds fine. Note that I am not using a bare metal compiler, but I
don't think that that should make a difference.

GCC -v output:

Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/local/gcc-linaro-aarch64-linux-gnu-4.9-2014.07_linux/bin/../libexec/gcc/aarch64-linux-gnu/4.9.1/lto-wrapper
Target: aarch64-linux-gnu
Configured with:
/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/src/gcc-linaro-4.9-2014.06/configure
--build=i686-build_pc-linux-gnu --host=i686-build_pc-linux-gnu
--target=aarch64-linux-gnu
--prefix=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install
--with-sysroot=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install/aarch64-linux-gnu/libc
--enable-languages=c,c++,fortran --disable-multilib --enable-multiarch
--with-arch=armv8-a --with-pkgversion='crosstool-NG
linaro-1.13.1-4.9-2014.07 - Linaro GCC 4.9-2014.06'
--with-bugurl=https://bugs.launchpad.net/gcc-linaro
--enable-__cxa_atexit --disable-libmudflap --enable-libgomp
--disable-libssp
--with-gmp=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--with-mpfr=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--with-mpc=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--with-isl=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--with-cloog=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--with-libelf=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static
--enable-threads=posix --disable-libstdcxx-pch
--enable-linker-build-id --enable-plugin
--with-local-prefix=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install/aarch64-linux-gnu/libc
--enable-c99 --enable-long-long
Thread model: posix
gcc version 4.9.1 20140529 (prerelease) (crosstool-NG
linaro-1.13.1-4.9-2014.07 - Linaro GCC 4.9-2014.06)

Anyone care to try the same with the non-working toolchain?
