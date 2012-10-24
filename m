From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Oct 2012 14:45:24 -0400 (EDT)
Subject: [PATCH] ARM: boot: Fix usage of kecho
In-Reply-To: <1351103848-30900-1-git-send-email-festevam@gmail.com>
References: <1351103848-30900-1-git-send-email-festevam@gmail.com>
Message-ID: <alpine.LFD.2.02.1210241444090.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2012, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit edc88ceb0 (ARM: be really quiet when building with 'make -s') the
> following output is generated when building a kernel for ARM:
> 
> echo '  Kernel: arch/arm/boot/Image is ready'
>   Kernel: arch/arm/boot/Image is ready
>   Building modules, stage 2.
> echo '  Kernel: arch/arm/boot/zImage is ready'
>   Kernel: arch/arm/boot/zImage is ready
> 
> As per Documentation/kbuild/makefiles.txt the correct way of using kecho is
> '@$(kecho)'.
> 
> Make this change so no more unwanted 'echo' messages are displayed.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/boot/Makefile  |   10 +++++-----
>  arch/arm/tools/Makefile |    2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index f2aa09e..9137df5 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -33,7 +33,7 @@ ifeq ($(CONFIG_XIP_KERNEL),y)
>  
>  $(obj)/xipImage: vmlinux FORCE
>  	$(call if_changed,objcopy)
> -	$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
> +	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
>  
>  $(obj)/Image $(obj)/zImage: FORCE
>  	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
> @@ -48,14 +48,14 @@ $(obj)/xipImage: FORCE
>  
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> -	$(kecho) '  Kernel: $@ is ready'
> +	@$(kecho) '  Kernel: $@ is ready'
>  
>  $(obj)/compressed/vmlinux: $(obj)/Image FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
>  
>  $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
>  	$(call if_changed,objcopy)
> -	$(kecho) '  Kernel: $@ is ready'
> +	@$(kecho) '  Kernel: $@ is ready'
>  
>  endif
>  
> @@ -90,7 +90,7 @@ fi
>  $(obj)/uImage:	$(obj)/zImage FORCE
>  	@$(check_for_multiple_loadaddr)
>  	$(call if_changed,uimage)
> -	$(kecho) '  Image $@ is ready'
> +	@$(kecho) '  Image $@ is ready'
>  
>  $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
> @@ -98,7 +98,7 @@ $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
>  
>  $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
>  	$(call if_changed,objcopy)
> -	$(kecho) '  Kernel: $@ is ready'
> +	@$(kecho) '  Kernel: $@ is ready'
>  
>  PHONY += initrd FORCE
>  initrd:
> diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
> index cd60a81..32d05c8 100644
> --- a/arch/arm/tools/Makefile
> +++ b/arch/arm/tools/Makefile
> @@ -5,6 +5,6 @@
>  #
>  
>  include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types
> -	$(kecho) '  Generating $@'
> +	@$(kecho) '  Generating $@'
>  	@mkdir -p $(dir $@)
>  	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
> -- 
> 1.7.9.5
> 
