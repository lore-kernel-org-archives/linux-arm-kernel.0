From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 16:58:28 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110622090321.GO23234@n2100.arm.linux.org.uk>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601142406.GJ3660@n2100.arm.linux.org.uk>
	<20110622075615.GJ6069@pengutronix.de>
	<20110622081141.GN23234@n2100.arm.linux.org.uk>
	<20110622083257.GK6069@pengutronix.de>
	<20110622090321.GO23234@n2100.arm.linux.org.uk>
Message-ID: <20110622145828.GL6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 10:03:21AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 22, 2011 at 10:32:57AM +0200, Sascha Hauer wrote:
> > LOADADDR ends up being 0xA0008000 when all of the above are enabled.
> > Another idea I had was to replace the := with += so that we can
> > count the words in zreladdr-y and bail out if we have multiple
> > zreladdrs. I haven't really followed this approach as it means adjusting
> > all Makefile.boot.
> > 
> > CONFIG_AUTO_ZRELADDR=y also does not necessarily mean that the resulting
> > uImage will not work. In the above example the image will work on i.MX27
> 
> But conversely, PATCH_PHYS_TO_VIRT doesn't mean that the uImage won't
> work either - I already build several kernels with it enabled for
> testing purposes, and the result boots fine.

Yes.

> 
> That's rather my point: PATCH_PHYS_TO_VIRT=y does not mean that the
> uImage is unbootable - it's only unbootable if the uImage has a
> load/start address which is invalid for the platform.
> 
> So, maybe the idea of changing LOADADDR is better.  Or maybe providing
> Makefile.boot with a new variable 'nouimage' which can provide the
> same functionality - and you may wish to provide LOADADDR on the command
> line and detect that, in which case it should override this lockout.

Then I have the same problem in my platform because I have no clear
condition on which to set this variable. Currently there is no "more
than one zreladdr" indicator. Maybe a variant of the following patch
is the least of all evils. A mechanism to specify the load address on
the command line could be added.

> 
> Lastly, as PATCH_PHYS_TO_VIRT is relatively cheap, it's possible that
> we may eventually end up with it enabled mostly everywhere, which with
> the current approach would mean we might as well rip out the uboot
> targets from the kernel entirely.

I don't want to go this way. Personally I prefer zImages but often
enough U-Boot forces me to use uImages and generating uImages by hand is
no fun.

8<-----------------------------------------

[PATCH] ARM i.MX: Do not allow building uImage with different
 zreladdrs

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/Makefile          |    6 ++++++
 arch/arm/mach-imx/Makefile.boot |   10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9128fdd..40c9bbf 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -59,6 +59,11 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 
 endif
 
+ifneq ($(words $(ZRELADDR)), 1)
+$(obj)/uImage: FORCE
+	@echo 'Multiple zreladdrs, cannot build uImage'
+	exit 1
+else
 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
 		   -C none -a $(LOADADDR) -e $(STARTADDR) \
@@ -75,6 +80,7 @@ $(obj)/uImage: STARTADDR=$(LOADADDR)
 $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
+endif
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index ebee18b..dbe6120 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,19 +1,19 @@
-zreladdr-$(CONFIG_ARCH_MX1)	:= 0x08008000
+zreladdr-$(CONFIG_ARCH_MX1)	+= 0x08008000
 params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
 initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
 
-zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
+zreladdr-$(CONFIG_MACH_MX21)	+= 0xC0008000
 params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
 initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
 
-zreladdr-$(CONFIG_ARCH_MX25)	:= 0x80008000
+zreladdr-$(CONFIG_ARCH_MX25)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX25)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
 
-zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
+zreladdr-$(CONFIG_MACH_MX27)	+= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
 
-zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
+zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
-- 
1.7.5.3


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
