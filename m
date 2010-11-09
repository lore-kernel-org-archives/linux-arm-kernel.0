From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 14:04:55 +0000
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20101109140455.GA6680@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is it really faster to copy an uncompressed image than it is to
decompress using LZMA with caches on?

Remember that in terms of fast boot, uboot sucks - it's way over the
top of what you need.  Eg, it always copies the image to RAM before
executing it.  That gives two problems:

1. the image has to be copied, which takes time
2. the image then decompresses itself, but because its more often than
   not living at the address which the decompressed image has to reside,
   it then has to copy the decompressed image afterwards.

(2) is solved by loading the kernel compressed image elsewhere in memory.
(1) is solved by having a boot loader which can call the image where-ever
it resides (eg, in flash) and using the ZBOOT_ROM options.

I suspect that if you do both 1 and 2, you'll be faster than having uboot
copy an uncompressed image into system memory.

On Tue, Nov 09, 2010 at 02:50:56PM +0100, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  arch/arm/boot/Makefile |   10 ++++++++--
>  init/Kconfig           |    7 +++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 4a590f4..37618b8 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -77,11 +77,17 @@ else
>  $(obj)/uImage: STARTADDR=$(LOADADDR)
>  endif
>  
> -$(obj)/uImage:	$(obj)/zImage FORCE
> +ifeq ($(CONFIG_KERNEL_NONE),y)
> +ARM_IMAGE := Image
> +else
> +ARM_IMAGE := zImage
> +endif
> +
> +$(obj)/uImage:	$(obj)/$(ARM_IMAGE) FORCE
>  	$(call if_changed,uimage)
>  	@echo '  Image $@ is ready'
>  
> -$(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
> +$(obj)/bootp/bootp: $(obj)/$(ARM_IMAGE) initrd FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
>  	@:
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 88c1046..355d7a5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -155,6 +155,13 @@ choice
>  
>  	  If in doubt, select 'gzip'
>  
> +config KERNEL_NONE
> +	bool "None"
> +	depends on ARM
> +	help
> +	  If you want to use get a fast startup at the cost of kernel size
> +	  you can use an uncompressed kernel.
> +
>  config KERNEL_GZIP
>  	bool "Gzip"
>  	depends on HAVE_KERNEL_GZIP
> -- 
> 1.7.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
