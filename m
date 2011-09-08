From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 09:32:09 -0700
Subject: [PATCH] ARM: supply a DTB file to be appended
In-Reply-To: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
References: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110908163209.GB22308@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 12:14:44PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds a Kconfig string where you can specify a
> file to be appended to the zImage on build, then
> auto-appends it. The idea is to mimic how we supply
> an initramfs image by a similar parameter.
> 
> This makes it easy to script the kernel build with
> different device trees, and it also vastly simplifies
> building uImages since "make uImage" will now pick
> up the devcie tree and include it in the final image
> as part of the build process.

The other option is to encode the .dtb filename into the zImage target
name (something like zImage.%).  The advantage being that the build
can emit multiple .dtb bound images without changing the kernel
config.  This is what PowerPC currently does.

Also, the way this is implemented means that it is no longer possible
to emit a zImage without a dtb if the DTB config is set.  Personally,
I'd use a different target name regardless instead of adjusting the
semantics of zImage.

g.

> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This builds on top of Nicos pending appended device tree
> patches. Nico, if this gains some liking, please include
> it in your series.
> ---
>  arch/arm/Kconfig       |   10 ++++++++++
>  arch/arm/boot/Makefile |    8 +++++++-
>  2 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4ea9974..cb8ee68 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1789,6 +1789,16 @@ config ARM_APPENDED_DTB
>  	  (dtb) appended to zImage
>  	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
>  
> +config ARM_APPENDED_DTB_FILE
> +	string "DTB file"
> +	depends on ARM_APPENDED_DTB
> +	default ""
> +	help
> +	  This gives the name of file from the build directory to append
> +	  to the zImage after it has been built.
> +
> +	  If you are not sure, leave it blank.
> +
>  config ARM_ATAG_DTB_COMPAT
>  	bool "Supplement the appended DTB with traditional ATAG information"
>  	depends on ARM_APPENDED_DTB
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index a1edfd5..5ab6abf 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -53,8 +53,14 @@ $(obj)/Image: vmlinux FORCE
>  $(obj)/compressed/vmlinux: $(obj)/Image FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
>  
> -$(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
> +# Rule to optionally append a DTB
> +dtbfile := $(shell echo $(CONFIG_ARM_APPENDED_DTB_FILE))
> +quiet_cmd_append = CAT     $@
> +      cmd_append = (cat /dev/null $(dtbfile) >> $@)
> +
> +$(obj)/zImage:	$(obj)/compressed/vmlinux $(dtbfile) FORCE
>  	$(call if_changed,objcopy)
> +	$(call if_changed,append)
>  	@echo '  Kernel: $@ is ready'
>  
>  endif
> -- 
> 1.7.3.2
> 
