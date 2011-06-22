From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 09:11:41 +0100
Subject: i.MX consolidation patches
In-Reply-To: <20110622075615.GJ6069@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110622075615.GJ6069@pengutronix.de>
Message-ID: <20110622081141.GN23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 09:56:15AM +0200, Sascha Hauer wrote:
> Coming back to this topic after a longer time, here is an updated
> patch doing exactly this.

I'm not sure that this is actually correct.  Whether ARM_PATCH_PHYS_VIRT
is enabled or not only affects the Image and not the zImage - provided
the mach-* provides the zreladdr in their Makefile.boot, you can build
a uImage with ARM_PATCH_PHYS_VIRT.

Where things become sticky is when AUTO_ZRELADDR is enabled - this is where
the ZRELADDR may be omitted, and therefore there is no load/start address
which can be provided to uboot.

>  $(obj)/uImage: STARTADDR=$(LOADADDR)
>  
> +ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)

So maybe this wants to be ifeq ($(LOADADDR),) or CONFIG_AUTO_ZRELADDR?

> +$(obj)/uImage:  $(obj)/zImage FORCE
> +	@echo 'CONFIG_ARM_PATCH_PHYS_VIRT is enabled, cannot build an uImage'

and this CONFIG_AUTO_ZRELADDR

> +	@echo 'with multiple start/load addresses. To generate an uImage'
> +	@echo 'suitable for you hardware run:'
> +	@echo '$(MKIMAGE) -A arm -O linux -T kernel -C none -a <LOADADDR> \
> +		-e <STARTADDR> -n 'Linux-$(KERNELRELEASE)' -d $< $@'
> +	@false
> +else
>  $(obj)/uImage:	$(obj)/zImage FORCE
>  	$(call if_changed,uimage)
>  	@echo '  Image $@ is ready'
> +endif
>  
>  $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
>  	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
> -- 
> 1.7.5.3
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
