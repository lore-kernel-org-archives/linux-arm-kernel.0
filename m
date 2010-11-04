From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 04 Nov 2010 20:38:42 +0000
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
Message-ID: <yw1xy698ygbx.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent <rabin@rab.in> writes:

> Fix the following error which occurs when building an ARM kernel with
> GCC 4.5.0:
>
>   arm-linux-gcc -Wp,-MD,kernel/.bounds.s.d  -nostdinc
>   [command line edited to remove paths]
>   -D__KERNEL__ -mlittle-endian
>   -Wall -Wundef
>   -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
>   -Werror-implicit-function-declaration -Wno-format-security
>   -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm
>   -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=5
>   -march=armv5te -mtune=arm9tdmi -msoft-float -Uarm -fomit-frame-pointer -g
>   -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=#s"
>   -D"KBUILD_BASENAME=KBUILD_STR(bounds)"  -D"KBUILD_MODNAME=KBUILD_STR(bounds)"
>   -fverbose-asm -S -o kernel/bounds.s kernel/bounds.c
>   kernel/bounds.c:1:0: error: FPA is unsupported in the AAPCS
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
> Seen with this compiler:
>
> http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.5.0/x86_64-gcc-4.5.0-nolibc_arm-linux.tar.bz2
>
>  arch/arm/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index b87aed0..c06d9ed 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -91,7 +91,7 @@ tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
>  tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
>
>  ifeq ($(CONFIG_AEABI),y)
> -CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork
> +CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp

The real question is why something is trying to use floating-point.
It shouldn't.

-- 
M?ns Rullg?rd
mans at mansr.com
