From: cjb@laptop.org (Chris Ball)
Date: Sun, 08 Apr 2012 21:36:35 -0400
Subject: [PATCH v2 5/7] ARM: mmp: append OF support on pxa168
In-Reply-To: <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
 (Haojian Zhuang's message of "Mon, 5 Mar 2012 20:21:49 +0800")
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <87y5q5znx8.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 05 2012, Haojian Zhuang wrote:
> Enable PXA168 and aspenite support.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  arch/arm/mach-mmp/Kconfig  |   10 ++++++
>  arch/arm/mach-mmp/Makefile |    1 +
>  arch/arm/mach-mmp/mmp-dt.c |   75 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mmp/mmp-dt.c
>
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 323d4c9..5a90b9a 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -2,6 +2,16 @@ if ARCH_MMP
>  
>  menu "Marvell PXA168/910/MMP2 Implmentations"
>  
> +config MACH_MMP_DT
> +	bool "Support MMP2 platforms from device tree"
> +	select CPU_PXA168
> +	select CPU_PXA910
> +	select USE_OF
> +	help
> +	  Include support for Marvell MMP2 based platforms using
> +	  the device tree. Needn't select any other machine while
> +	  MACH_MMP_DT is enabled.
> +

This patch breaks the build with MACH_MMP_DT=y in 3.4-rc2 for me:

MACH_MMP_DT selects CPU_PXA168 which selects CPU_32v5, which results in:

  armv7-unknown-linux-gnueabi-gcc -Wp,-MD,arch/arm/mm/.dma-mapping.o.d  -nostdinc -isystem /opt/crosstool/gcc-4.6.0/lib/gcc/armv7-unknown-linux-gnueabi/4.6.0/include -I/home/cjb/git/olpc-kernel/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/cjb/git/olpc-kernel/include -include /home/cjb/git/olpc-kernel/include/linux/kconfig.h  -I/home/cjb/git/olpc-kernel/arch/arm/mm -Iarch/arm/mm -D__KERNEL__ -mlittle-endian   -I/home/cjb/git/olpc-kernel/arch/arm/mach-mmp/include   -I/home/cjb/git/olpc-kernel/arch/arm/plat-pxa/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=5 -march=armv5te -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(dma_mapping)"  -D"KBUILD_MODNAME=KBUILD_STR(dma_mapping)" -c -o arch/arm/mm/dma-mapping.o /home/cjb/git/olpc-kernel/arch/arm/mm/dma-mapping.c
/home/cjb/git/olpc-kernel/arch/arm/kernel/entry-armv.S: Assembler messages:
/home/cjb/git/olpc-kernel/arch/arm/kernel/entry-armv.S:207: Error: selected processor does not support ARM mode `clrex'

CPU_32v5=y adds:

arch/arm/Makefile:arch-$(CONFIG_CPU_32v5) :=-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
