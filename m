From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 5 May 2015 19:28:03 +0200
Subject: support status of gold (was: Bulid regression with VDSO enabled)
In-Reply-To: <5548F302.5040909@mentor.com>
References: <679194be9498c72543073a833e4a1719@agner.ch>
 <55423E48.7000506@mentor.com>
 <087d88d067bde8159185670b82357f0a@agner.ch>
 <55424ED1.9030005@mentor.com>
 <ec99281777f104866fbf49ec743eef2a@agner.ch>
 <55439A36.4040801@mentor.com> <5548F302.5040909@mentor.com>
Message-ID: <CAKv+Gu_BA+G+nQ0Q9Mva+TEZhM0vfeVF8gehLhXTwC9v05UmHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 18:42, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> (following up with a wider audience, with lots of investigation
> back-and-forth elided)
>
>>>>>> On 04/30/2015 06:44 AM, Stefan Agner wrote:
>>>>>>>   OBJCOPY arch/arm/vdso/vdso.so
>>>>>>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>>>>>>> linking with -N
>>>>>>> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]: Bad
>>>>>>> value
>>>>>>> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
>>>>>>> linking with -N
>>>>>>> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so: Bad value
>>>>>>> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
>>>>>>> make[1]: *** [arch/arm/vdso] Error 2
>>>>>>> make[1]: *** Waiting for unfinished jobs....
>>>>>>>
>>>>>>> I'm using GCC 4.8.3 (Linaro GCC 4.8-2014.04) on Fedora 21. Any specific
>>>>>>> new requirements to the toolchain or a bug?
>
> [...]
>
> On 05/01/2015 10:22 AM, Nathan Lynch wrote:
>>
>> A relevant difference would seem to be that ld defaults to gold for this
>> toolchain:
>>
>> $ arm-angstrom-linux-gnueabi-ld --version
>> GNU gold (GNU Binutils 2.24) 1.11
>> ...
>>
>> I've not been explicitly testing the vdso code with gold until now,
>> sorry.  Is gold a "supported" linker for the ARM kernel these days?
>
> To reiterate - is gold currently considered a suitable linker for the
> ARM kernel?
>
> I'm able to build a 4.0/multi_v7_defconfig kernel with gold and boot it
> successfully in qemu, but 4.1-rc1 introduced a couple of issues:
>
> - arch/arm/Makefile adds --pic-veneer to LDFLAGS, which ld.gold does not
> implement:
>     LD      init/built-in.o
>   arm-angstrom-linux-gnueabi-ld: --pic-veneer: unknown option
>

We could replace --pic-veneer with $(call ld-option,--pic-veneer) to
ensure that it is only passed if the linker supports it, but the
problem here is that the option was added for a reason, i.e., to
ensure that if the linker needs to insert veneers, they will be
position independent even if the binary we are building is not. This
specifically applies to the ARM kernel, since it is not compiled and
linked with -fpic but may still execute at another offset than it was
linked at (while running with the MMU off)

> - The VDSO linker script is interpreted differently by ld.gold,
> resulting in build errors (see original report above).  I've made some
> progress on resolving this, but I still don't have a working VDSO at
> runtime.
>
> Even when I successfully build the rest of the kernel with gold (4.0 or
> 4.1-rc), I see many warnings like this:
>
>   arm-angstrom-linux-gnueabi-ld: warning: unwinding may not work because
>   EXIDX input section 41 of arch/arm/mach-omap2/built-in.o is not in
>   EXIDX output section
>
> But I'm unsure of their significance.
>
