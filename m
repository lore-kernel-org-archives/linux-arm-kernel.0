From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 09:56:15 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110601142406.GJ3660@n2100.arm.linux.org.uk>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
Message-ID: <20110622075615.GJ6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 03:24:06PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 01, 2011 at 04:18:47PM +0200, Sascha Hauer wrote:
> > diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> > index 9128fdd..e3b6f02 100644
> > --- a/arch/arm/boot/Makefile
> > +++ b/arch/arm/boot/Makefile
> > @@ -59,6 +59,11 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
> >  
> >  endif
> >  
> > +ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
> > +$(obj)/uImage: $(obj)/zImage FORCE
> > +	@echo 'building uImages is incompatible with CONFIG_ARM_PATCH_PHYS_VIRT'
> > +	@false
> 
> It may be better to drop the zImage dependency too, so that folk don't get
> the message at the end of an otherwise successful kernel build - they may
> decide to turn p2v patching off which would result in a rebuild.
> 
> Or it could suggest the mkimage command which should be run, but with
> <LOAD-ADDRESS> inserted into it at the appropriate point - iow something
> like:
> 
>   mkimage -A arm -O linux -T kernel -C none \
> 	-a <LOAD-ADDRESS> -e <START-ADDRESS> \
> 	-n 'Linux-$(KERNELRELEASE)' -d arch/arm/boot/zImage uImage.<PLATFORM>
> 

Coming back to this topic after a longer time, here is an updated
patch doing exactly this.

8<------------------------------------------------------

[PATCH] ARM: do not allow to build uImages with ARM_PATCH_PHYS_VIRT

U-Boot uImages expect a load address and a entry point in
the image header. With CONFIG_ARM_PATCH_PHYS_VIRT these
become variable and thus can not be compiled into the uImage.
Instead of just failing we give a hint to the user how to
generate an uImage for his hardware.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9128fdd..934a67a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -72,9 +72,19 @@ endif
 
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 
+ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
+$(obj)/uImage:  $(obj)/zImage FORCE
+	@echo 'CONFIG_ARM_PATCH_PHYS_VIRT is enabled, cannot build an uImage'
+	@echo 'with multiple start/load addresses. To generate an uImage'
+	@echo 'suitable for you hardware run:'
+	@echo '$(MKIMAGE) -A arm -O linux -T kernel -C none -a <LOADADDR> \
+		-e <STARTADDR> -n 'Linux-$(KERNELRELEASE)' -d $< $@'
+	@false
+else
 $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
+endif
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
-- 
1.7.5.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
