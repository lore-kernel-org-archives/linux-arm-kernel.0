From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Jun 2011 16:18:47 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110601134749.GI3660@n2100.arm.linux.org.uk>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
Message-ID: <20110601141847.GG23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 02:47:49PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 01, 2011 at 02:35:22PM +0200, Sascha Hauer wrote:
> > This series should be orthogonal to yours. I will prepare an update to
> > this series. In particular I'm not comfortable with breaking uImage
> > support.
> 
> We probably should disable the uImage target when p2v patching is
> enabled to prevent people getting nasty surprises.
> 

Agreed. Here is a patch. I added Wolfgang Denk to Cc, maybe
he can prove me wrong.

8<----------------------------------------------------------
ARM: do not allow to build uImages with ARM_PATCH_PHYS_VIRT

U-Boot uImages expect a load address and a entry point in
the image header. With CONFIG_ARM_PATCH_PHYS_VIRT these
become variable and thus can not be compiled into the uImage.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/arm/boot/Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9128fdd..e3b6f02 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -59,6 +59,11 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 
 endif
 
+ifeq ($(CONFIG_ARM_PATCH_PHYS_VIRT),y)
+$(obj)/uImage: $(obj)/zImage FORCE
+	@echo 'building uImages is incompatible with CONFIG_ARM_PATCH_PHYS_VIRT'
+	@false
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
-- 
1.7.5.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
