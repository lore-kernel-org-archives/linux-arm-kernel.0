From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 11:01:14 +0200
Subject: [PATCH 5/5] [ARM] Move inclusion of Makefile.boot into
	arch/arm/boot/bootp
In-Reply-To: <1275550613-9553-6-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-6-git-send-email-eric.miao@canonical.com>
Message-ID: <20100610090114.GE3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 03:36:53PM +0800, Eric Miao wrote:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Since zreladdr-y, params_phys-y and initrd_phys-y are no longer
> used in arch/arm/boot/compressed, move the inclusion into bootp/.
> 
> Now unless you are building for an bootpImage, no per machine
> class Makefile.boot needs to be included.
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/Makefile       |   21 +--------------------
>  arch/arm/boot/bootp/Makefile |   19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 8cc4669..5e1b5f4 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -13,18 +13,6 @@
>  
>  MKIMAGE         := $(srctree)/scripts/mkuboot.sh
>  
> -ifneq ($(MACHINE),)
> --include $(srctree)/$(MACHINE)/Makefile.boot
> -endif
> -
> -# Note: the following conditions must always be true:
> -#   PARAMS_PHYS must be within 4MB of ZRELADDR
> -#   INITRD_PHYS must be in RAM
> -PARAMS_PHYS := $(params_phys-y)
> -INITRD_PHYS := $(initrd_phys-y)
> -
> -export INITRD_PHYS PARAMS_PHYS
> -
>  targets := Image zImage xipImage bootpImage uImage
>  
>  ifeq ($(CONFIG_XIP_KERNEL),y)
> @@ -81,7 +69,7 @@ $(obj)/uImage:	$(obj)/zImage FORCE
>  	$(call if_changed,uimage)
>  	@echo '  Image $@ is ready'
>  
> -$(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
> +$(obj)/bootp/bootp: $(obj)/zImage FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
>  	@:
>  
> @@ -89,13 +77,6 @@ $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
>  	$(call if_changed,objcopy)
>  	@echo '  Kernel: $@ is ready'
>  
> -PHONY += initrd FORCE
> -initrd:
> -	@test "$(INITRD_PHYS)" != "" || \
> -	(echo This machine does not support INITRD; exit -1)
> -	@test "$(INITRD)" != "" || \
> -	(echo You must specify INITRD; exit -1)
> -
>  install: $(obj)/Image
>  	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>  	$(obj)/Image System.map "$(INSTALL_PATH)"
> diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
> index c394e30..4b32d92 100644
> --- a/arch/arm/boot/bootp/Makefile
> +++ b/arch/arm/boot/bootp/Makefile
> @@ -5,6 +5,16 @@
>  # architecture-specific flags and dependencies.
>  #
>  
> +ifneq ($(MACHINE),)
> +-include $(srctree)/$(MACHINE)/Makefile.boot
> +endif
> +
> +# Note: the following conditions must always be true:
> +#   PARAMS_PHYS must be within 4MB of ZRELADDR
> +#   INITRD_PHYS must be in RAM
> +PARAMS_PHYS := $(params_phys-y)
> +INITRD_PHYS := $(initrd_phys-y)
> +
>  LDFLAGS_bootp	:=-p --no-undefined -X \
>  		 --defsym initrd_phys=$(INITRD_PHYS) \
>  		 --defsym params_phys=$(PARAMS_PHYS) -T
> @@ -17,11 +27,18 @@ $(obj)/bootp:	$(src)/bootp.lds $(addprefix $(obj)/,init.o kernel.o initrd.o) FOR
>  	$(call if_changed,ld)
>  	@:
>  
> +PHONY += initrd FORCE
> +initrd:
> +	@test "$(INITRD_PHYS)" != "" || \
> +	(echo This machine does not support INITRD; exit -1)
> +	@test "$(INITRD)" != "" || \
> +	(echo You must specify INITRD; exit -1)
> +
>  # kernel.o and initrd.o includes a binary image using
>  # .incbin, a dependency which is not tracked automatically
>  
>  $(obj)/kernel.o: arch/arm/boot/zImage FORCE
>  
> -$(obj)/initrd.o: $(INITRD) FORCE
> +$(obj)/initrd.o: $(INITRD) initrd FORCE
>  
>  PHONY += $(INITRD) FORCE
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
