From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Dec 2017 13:46:33 +0000
Subject: [PATCH, RFT] ARM: use --fix-v4bx to allow building ARMv4 with
 future gcc
In-Reply-To: <20171220130016.3156090-1-arnd@arndb.de>
References: <20171220130016.3156090-1-arnd@arndb.de>
Message-ID: <CAKv+Gu_viATGXTQjywxv8Yyy2iP-nBnAJZBmtnfhsQvS-ueWUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 20 December 2017 at 13:00, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc-6.0 and later marks support for ARMv3 and ARMv4 as 'deprecated',
> meaning that this is expected to be removed at some point in the future,
> with gcc-8.0 as the earliest.
>
> When building the kernel, the difference between ARMv4 and ARMv4T
> is relatively small because the kernel never runs THUMB instructions
> on ARMv4T and does not need any support for interworking.
>
> For any future compiler that does not support -march=armv4, we now
> fall back to -march=armv4t as the architecture level selection,
> but keep using -march=armv4 by default as long as that is supported
> by the compiler.
>
> Similarly, the -mtune=strongarm110 and -mtune=strongarm1100 options
> will go away at the same time as -march=armv4, so this adds a check
> to see if the compiler supports them, falling back to no -mtune
> option otherwise.
>
> Compiling with -march=armv4t leads the compiler to using 'bx reg'
> instructions instead of 'mov pc,reg'. This is not supported on
> ARMv4 based CPUs, but the linker can work around this by rewriting
> those instructions to the ARMv4 version if we pass --fix-v4bx
> to the linker. This should work with binutils-2.15 (released
> May 2004) or higher, and we can probably assume that anyone using
> gcc-7.x will have a much more recent binutils version as well.
>
> However, in order to still allow users of old toolchains to link
> the kernel, we only pass the option to linkers that support it,
> based on a $(ld-option ...) call. I'm intentionally passing the
> flag to all linker versions here regardless of whether it's needed
> or not, so we can more easily spot any regressions if something
> goes wrong.
>
> For consistency, I'm passing the --fix-v4bx flag for both the
> vmlinux final link and the individual loadable modules.
> The module loader code already interprets the R_ARM_V4BX relocations
> in loadable modules and converts bx instructions into mov even
> when running on ARMv4T or ARMv5 processors. This is now redundant
> when we pass --fix-v4bx to the linker for building modules, but
> I see no harm in leaving the current implementation and doing both.
>

Are you sure --fix-v4bx is taken into account during a partial link?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please test by making the -march=armv4t switch unconditional
> and see if that results in a working kernel
>
>  arch/arm/Makefile | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e83f5161fdd8..33b7eb4502aa 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -19,6 +19,11 @@ LDFLAGS_vmlinux      += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
>  endif
>
> +ifeq ($(CONFIG_CPU_32v4),y)
> +LDFLAGS_vmlinux        += $(call ld-option,--fix-v4bx)
> +LDFLAGS_MODULE += $(call ld-option,--fix-v4bx)
> +endif
> +
>  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
>  KBUILD_LDFLAGS_MODULE  += -T $(srctree)/arch/arm/kernel/module.lds
>  endif
> @@ -76,7 +81,7 @@ arch-$(CONFIG_CPU_32v6K)      =-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,
>  endif
>  arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
>  arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
> -arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 -march=armv4
> +arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 $(call cc-option,-march=armv4,-march=armv4t)
>  arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>
>  # Evaluate arch cc-option calls now
> @@ -94,8 +99,8 @@ tune-$(CONFIG_CPU_ARM922T)    =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_ARM925T)     =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_ARM926T)     =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_FA526)       =-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_SA110)       =-mtune=strongarm110
> -tune-$(CONFIG_CPU_SA1100)      =-mtune=strongarm1100
> +tune-$(CONFIG_CPU_SA110)       =$(call cc-option,-mtune=strongarm110)
> +tune-$(CONFIG_CPU_SA1100)      =$(call cc-option,-mtune=strongarm1100)
>  tune-$(CONFIG_CPU_XSCALE)      =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
>  tune-$(CONFIG_CPU_XSC3)                =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale

Shouldn't these two be updated as well?

>  tune-$(CONFIG_CPU_FEROCEON)    =$(call cc-option,-mtune=marvell-f,-mtune=xscale)
> --
> 2.9.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
