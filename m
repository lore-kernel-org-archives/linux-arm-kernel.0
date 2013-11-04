From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Nov 2013 12:00:51 +0100
Subject: [PATCH v4 2/4] ARM: make mach-xyz/Makefile.boot optional for
 !ARCH_MULTIPLATFORM
In-Reply-To: <20131104105836.GI14892@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
Message-ID: <1383562853-17202-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makefile.boot is supposed to define zreladdr-y, params_phys-y and
initrd_phys-y. The first one is only needed in the absence of AUTO_ZRELADDR
and when building a zImage. The latters are only needed for bootp stuff.
So ignore errors on including Makefile.boot and error out in the targets
that need the corresponding settings.

This makes it unnecessary to create dummy Makefile.boot files.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 84aa2ca..44203b3 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -12,7 +12,7 @@
 #
 
 ifneq ($(MACHINE),)
-include $(srctree)/$(MACHINE)/Makefile.boot
+sinclude $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
 # Note: the following conditions must always be true:
@@ -51,10 +51,19 @@ $(obj)/Image: vmlinux FORCE
 $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
+ifneq ($(CONFIG_AUTO_ZRELADDR)$(ZRELADDR),)
+
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@$(kecho) '  Kernel: $@ is ready'
 
+else
+
+$(obj)/zImage: FORCE
+	@echo 'Either enable CONFIG_AUTO_ZRELADDR or provide zreladdr-y in Makefile.boot'
+	@false
+
+endif
 endif
 
 ifneq ($(LOADADDR),)
@@ -81,6 +90,8 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(kecho) '  Image $@ is ready'
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
+	@test -n "$(PARAMS_PHYS)" || \
+	(echo This machine does not support BOOTP; exit -1)
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 	@:
 
-- 
1.8.4.rc3
