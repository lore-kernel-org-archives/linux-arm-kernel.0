From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 15:24:06 +0100
Subject: i.MX consolidation patches
In-Reply-To: <20110601141847.GG23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
Message-ID: <20110601142406.GJ3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 04:18:47PM +0200, Sascha Hauer wrote:
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 9128fdd..e3b6f02 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -59,6 +59,11 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
>  
>  endif
>  
> +ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
> +$(obj)/uImage: $(obj)/zImage FORCE
> +	@echo 'building uImages is incompatible with CONFIG_ARM_PATCH_PHYS_VIRT'
> +	@false

It may be better to drop the zImage dependency too, so that folk don't get
the message at the end of an otherwise successful kernel build - they may
decide to turn p2v patching off which would result in a rebuild.

Or it could suggest the mkimage command which should be run, but with
<LOAD-ADDRESS> inserted into it at the appropriate point - iow something
like:

  mkimage -A arm -O linux -T kernel -C none \
	-a <LOAD-ADDRESS> -e <START-ADDRESS> \
	-n 'Linux-$(KERNELRELEASE)' -d arch/arm/boot/zImage uImage.<PLATFORM>
