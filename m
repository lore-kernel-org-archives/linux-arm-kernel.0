From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 May 2015 12:28:31 +0100
Subject: Bulid regression with VDSO enabled
In-Reply-To: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
Message-ID: <20150508112831.GF2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 01:13:50PM +0200, Stefan Agner wrote:
> On 2015-05-01 17:22, Nathan Lynch wrote:
> > A relevant difference would seem to be that ld defaults to gold for this
> > toolchain:
> > 
> > $ arm-angstrom-linux-gnueabi-ld --version
> > GNU gold (GNU Binutils 2.24) 1.11
> > ...
> > 
> > I've not been explicitly testing the vdso code with gold until now,
> > sorry.  Is gold a "supported" linker for the ARM kernel these days?  If
> > I disable CONFIG_VDSO I encounter this during final link:
> > 
> >   LD      init/built-in.o
> > arm-angstrom-linux-gnueabi-ld: --pic-veneer: unknown option
> > arm-angstrom-linux-gnueabi-ld: use the --help option for usage information
> > 
> > 
> > I've managed to recreate this locally now, and I'll see what can be
> > done.  Commit 378ed3ccd2a0 "x86, vdso: Make the vdso linker script
> > compatible with Gold" looks relevant.
> 
> This error does not look like the error I have:
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> /build/ags/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]:
> Bad value
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> /build/ags/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so:
> Bad value
> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
> make[1]: *** [arch/arm/vdso] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> Also, I used the BFD linker by adding LD=${CROSS_COMPILE}ld.bfd to the
> build command. Interestingly thought, I had the same issue when using
> gold linker...
> 
> I just updated my toolchain to Linaro's 2014.11 based version, still
> using meta-linaro/OpenEmbedded build system, but still the same issue.
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> /build/linuxdev/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]:
> Bad value
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> /build/linuxdev/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so:
> Bad value
> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
> make[1]: *** [arch/arm/vdso] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> The toolchain comes with GCC version 4.9.3... So the problem seems to be
> quite unrelated to the toolchain version, but more to the actual
> configuration of the toolchain.

This kind of thing annoys me.  Your statement here is totally incorrect
because you're counting the number of apples and reporting it as the
number of oranges.

The version of GCC has nothing to do with the version of the linker.
The linker is part of binutils, which is an entirely separate software
package from the compiler.

What I know is that this works with the stock GNU binutils version 2.22,
which is what I'm using here.  Can you report which version of binutils
you're using please (and I hope that if it has non-upstream changes,
that the version number reflects that fact.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
