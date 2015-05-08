From: stefan@agner.ch (Stefan Agner)
Date: Fri, 08 May 2015 14:23:38 +0200
Subject: Bulid regression with VDSO enabled
In-Reply-To: <20150508112831.GF2067@n2100.arm.linux.org.uk>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <20150508112831.GF2067@n2100.arm.linux.org.uk>
Message-ID: <84576df23991f1fb0d9bdab8592cb165@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-08 13:28, Russell King - ARM Linux wrote:
> On Fri, May 08, 2015 at 01:13:50PM +0200, Stefan Agner wrote:
>> On 2015-05-01 17:22, Nathan Lynch wrote:
>> > A relevant difference would seem to be that ld defaults to gold for this
>> > toolchain:
>> >
>> > $ arm-angstrom-linux-gnueabi-ld --version
>> > GNU gold (GNU Binutils 2.24) 1.11
>> > ...
>> >
>> > I've not been explicitly testing the vdso code with gold until now,
>> > sorry.  Is gold a "supported" linker for the ARM kernel these days?  If
>> > I disable CONFIG_VDSO I encounter this during final link:
>> >
>> >   LD      init/built-in.o
>> > arm-angstrom-linux-gnueabi-ld: --pic-veneer: unknown option
>> > arm-angstrom-linux-gnueabi-ld: use the --help option for usage information
>> >
>> >
>> > I've managed to recreate this locally now, and I'll see what can be
>> > done.  Commit 378ed3ccd2a0 "x86, vdso: Make the vdso linker script
>> > compatible with Gold" looks relevant.
>>
>> This error does not look like the error I have:
>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>> linking with -N
>> /build/ags/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]:
>> Bad value
>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>> linking with -N
>> /build/ags/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so:
>> Bad value
>> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
>> make[1]: *** [arch/arm/vdso] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>
>> Also, I used the BFD linker by adding LD=${CROSS_COMPILE}ld.bfd to the
>> build command. Interestingly thought, I had the same issue when using
>> gold linker...
>>
>> I just updated my toolchain to Linaro's 2014.11 based version, still
>> using meta-linaro/OpenEmbedded build system, but still the same issue.
>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>> linking with -N
>> /build/linuxdev/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]:
>> Bad value
>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>> linking with -N
>> /build/linuxdev/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so:
>> Bad value
>> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
>> make[1]: *** [arch/arm/vdso] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>>
>> The toolchain comes with GCC version 4.9.3... So the problem seems to be
>> quite unrelated to the toolchain version, but more to the actual
>> configuration of the toolchain.
> 
> This kind of thing annoys me.  Your statement here is totally incorrect
> because you're counting the number of apples and reporting it as the
> number of oranges.
> 
> The version of GCC has nothing to do with the version of the linker.
> The linker is part of binutils, which is an entirely separate software
> package from the compiler.

Yeah sure, sorry about that. The essence I wanted to convey was that it
happens with two different releases of the Linaro toolchain, which
happens to be denoted with the GCC version number + that year.month
thing. The two versions which come with Angstrom/meta-linaro are:

- Linaro toolchain 4.8-2014.04 (which comes with Angstrom 2014.06,
meta-linaro, daisy branch)
- Linaro toolchain 4.9-2014.11 (which comes with Angstrom 2014.12,
meta-linaro, dizzy branch)

> What I know is that this works with the stock GNU binutils version 2.22,
> which is what I'm using here.  Can you report which version of binutils
> you're using please (and I hope that if it has non-upstream changes,
> that the version number reflects that fact.)

The newer toolchain does, while the older does not:

...ld.bfd --version
GNU ld (GNU Binutils) Linaro 2014.11-2 2.24.0.20141017

...ld.bfd --version
GNU ld (GNU Binutils) 2.24

It looks like the Linaro release 2014.04 really did not alter binutils.
However, meta-linaro, the OpenEmbedded build layer, puts several patches
on-top of that, but failing to alter the version number.

https://git.linaro.org/openembedded/meta-linaro.git/tree/refs/heads/daisy:/meta-linaro-toolchain/recipes-devtools/binutils/binutils-linaro-2.24

Quite likely that the problem come with one of those patches. But the
linaro-dev mailing list on CC, maybe somebody knows more?

--
Stefan
