From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 21:02:45 +0100
Subject: [PATCH, RFT] ARM: use --fix-v4bx to allow building ARMv4 with
 future gcc
In-Reply-To: <CAK8P3a1MF-ezKyHhzqW0eGDa_2sCEyGZ62Qcxh2itpwHiLHxaA@mail.gmail.com>
References: <20171220130016.3156090-1-arnd@arndb.de>
 <CACRpkday7Z8NM9_tapSHUNVdNbdZcup-kagg65p+sEzwNXqp5g@mail.gmail.com>
 <CAK8P3a1MF-ezKyHhzqW0eGDa_2sCEyGZ62Qcxh2itpwHiLHxaA@mail.gmail.com>
Message-ID: <CACRpkdbtFAROwD52tg7GDRnBQpuddJuy1wNLuhBuHV+Z8cTVNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 6:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Dec 21, 2017 at 5:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Dec 20, 2017 at 2:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> gcc-6.0 and later marks support for ARMv3 and ARMv4 as 'deprecated',
>>> meaning that this is expected to be removed at some point in the future,
>>> with gcc-8.0 as the earliest.
>>>
>>> When building the kernel, the difference between ARMv4 and ARMv4T
>>> is relatively small because the kernel never runs THUMB instructions
>>> on ARMv4T and does not need any support for interworking.
>>>
>>> For any future compiler that does not support -march=armv4, we now
>>> fall back to -march=armv4t as the architecture level selection,
>>> but keep using -march=armv4 by default as long as that is supported
>>> by the compiler.
>>>
>>> Similarly, the -mtune=strongarm110 and -mtune=strongarm1100 options
>>> will go away at the same time as -march=armv4, so this adds a check
>>> to see if the compiler supports them, falling back to no -mtune
>>> option otherwise.
>>>
>>> Compiling with -march=armv4t leads the compiler to using 'bx reg'
>>> instructions instead of 'mov pc,reg'. This is not supported on
>>> ARMv4 based CPUs, but the linker can work around this by rewriting
>>> those instructions to the ARMv4 version if we pass --fix-v4bx
>>> to the linker. This should work with binutils-2.15 (released
>>> May 2004) or higher, and we can probably assume that anyone using
>>> gcc-7.x will have a much more recent binutils version as well.
>>>
>>> However, in order to still allow users of old toolchains to link
>>> the kernel, we only pass the option to linkers that support it,
>>> based on a $(ld-option ...) call. I'm intentionally passing the
>>> flag to all linker versions here regardless of whether it's needed
>>> or not, so we can more easily spot any regressions if something
>>> goes wrong.
>>>
>>> For consistency, I'm passing the --fix-v4bx flag for both the
>>> vmlinux final link and the individual loadable modules.
>>> The module loader code already interprets the R_ARM_V4BX relocations
>>> in loadable modules and converts bx instructions into mov even
>>> when running on ARMv4T or ARMv5 processors. This is now redundant
>>> when we pass --fix-v4bx to the linker for building modules, but
>>> I see no harm in leaving the current implementation and doing both.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>> Please test by making the -march=armv4t switch unconditional
>>> and see if that results in a working kernel
>>
>> I did this:
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 66e46aec0cd0..3944ecd6cd31 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -81,7 +81,7 @@ arch-$(CONFIG_CPU_32v6K)
>> =-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,
>>  endif
>>  arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 $(call
>> cc-option,-march=armv5te,-march=armv4t)
>>  arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
>> -arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 $(call
>> cc-option,-march=armv4,-march=armv4t)
>> +arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 -march=armv4t
>>  arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>>
>> Built and booted on the Gemini platform.
>>
>> It crashes immediately and goes into the boot loader
>> on thos FA-526 based platform.
>
> Hmm, maybe the decompressor needs the fixup separately. Can you try
> something like this completely untested patch on top?
>
>      Arnd
>
> diff --git a/arch/arm/boot/compressed/Makefile
> b/arch/arm/boot/compressed/Makefile
> index f0548b6948f1..0e141b2cae98 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -134,6 +134,11 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> +
> +ifdef CONFIG_CPU_32v4
> +LDFLAGS_vmlinux += --fix-v4bx
> +endif
> +

Yes this work! The kernel and userspace comes up.

With this folded in:
Tested-by: Linus Walleij <linus.walleij@linaro.org> for FA526

I will try to test it on SA110 (NetWinder) tomorrow.

Yours,
Linus Walleij
