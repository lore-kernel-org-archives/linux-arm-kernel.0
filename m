From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 10:50:53 +0200
Subject: [PATCH 3/5] [ARM] Make TEXT_OFFSET a configurable option
In-Reply-To: <1275550613-9553-4-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-4-git-send-email-eric.miao@canonical.com>
Message-ID: <20100610085053.GC3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 03:36:51PM +0800, Eric Miao wrote:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> ---
>  arch/arm/Kconfig         |   13 +++++++++++++
>  arch/arm/Makefile        |   13 +------------
>  arch/arm/kernel/Makefile |    4 ++--
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1f254bd..e340193 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1484,6 +1484,19 @@ config ATAGS_PROC
>  	  Should the atags used to boot the kernel be exported in an "atags"
>  	  file in procfs. Useful with kexec.
>  
> +config TEXT_OFFSET
> +	hex "Offset of the kernel image from the start of RAM"
IMHO this should not be user configurable.

> +	default 0x00008000
> +	default 0x00028000 if ARCH_CLPS711X
> +	# We don't want the htc bootloader to corrupt kernel during resume
> +	default 0x00108000 if PM_H1940
> +	# SA1111 DMA bug: we don't want the kernel to live in precious
> +	# DMA-able memory
> +	default 0x00208000 if (ARCH_SA1100 && SA1111)
> +	help
> +	  TEXT_OFFSET is the offset of the decompressed kernel image from
> +	  memory start. Currently, it is expected the least significant 16
> +	  bits to be 0x8000, so to leave space for the initial page table.
>  endmenu
>  
>  menu "CPU Power Management"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 64ba313..df8f73d 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -108,14 +108,6 @@ CHECKFLAGS	+= -D__arm__
>  
>  #Default value
>  head-y		:= arch/arm/kernel/head$(MMUEXT).o arch/arm/kernel/init_task.o
> -textofs-y	:= 0x00008000
> -textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
> -# We don't want the htc bootloader to corrupt kernel during resume
> -textofs-$(CONFIG_PM_H1940)      := 0x00108000
> -# SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
> -ifeq ($(CONFIG_ARCH_SA1100),y)
> -textofs-$(CONFIG_SA1111) := 0x00208000
> -endif
>  
>  # Machine directory name.  This list is sorted alphanumerically
>  # by CONFIG_* macro name.
> @@ -209,9 +201,6 @@ CFLAGS_3c589_cs.o :=-DISA_SIXTEEN_BIT_PERIPHERAL
>  export CFLAGS_3c589_cs.o
>  endif
>  
> -# The byte offset of the kernel image in RAM from the start of RAM.
> -TEXT_OFFSET := $(textofs-y)
> -
>  # The first directory contains additional information for the boot setup code
>  ifneq ($(machine-y),)
>  MACHINE  := arch/arm/mach-$(word 1,$(machine-y))/
> @@ -228,7 +217,7 @@ else
>  KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
>  endif
>  
> -export	TEXT_OFFSET GZFLAGS MMUEXT
> +export	GZFLAGS MMUEXT
>  
>  # Do we have FASTFPE?
>  FASTFPE		:=arch/arm/fastfpe
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 26d302c..50a0d7e 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -2,8 +2,8 @@
>  # Makefile for the linux kernel.
>  #
>  
> -CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(TEXT_OFFSET)
> -AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
> +CPPFLAGS_vmlinux.lds := -DTEXT_OFFSET=$(CONFIG_TEXT_OFFSET)
> +AFLAGS_head.o        := -DTEXT_OFFSET=$(CONFIG_TEXT_OFFSET)
Why not use CONFIG_TEXT_OFFSET directly in head.S?
Is CONFIG_TEXT_OFFSET available in vmlinux.lds?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
