From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 02 Aug 2011 15:31:48 +0100
Subject: [PATCH] Build a uImage with dtb already appended
Message-ID: <20110802143148.21599.22870.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not commit to mainline; this is a useful hack only for now.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/Makefile      |    3 +++
 arch/arm/boot/Makefile |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 70c424e..0677b86 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -282,6 +282,9 @@ zImage Image xipImage bootpImage uImage: vmlinux
 zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+uImage-dtb.%:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
 %.dtb:
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index a1edfd5..a64493b 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -57,6 +57,9 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
+$(obj)/zImage-dtb.%:	$(obj)/%.dtb $(obj)/zImage
+	cat $(obj)/zImage $< > $@
+
 endif
 
 # Rule to build device tree blobs
@@ -77,11 +80,16 @@ $(obj)/uImage: LOADADDR=$(ZRELADDR)
 endif
 
 $(obj)/uImage: STARTADDR=$(LOADADDR)
+$(obj)/uImage-dtb.%: STARTADDR=$(LOADADDR)
 
 $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
+$(obj)/uImage-dtb.%:	$(obj)/zImage-dtb.% FORCE
+	$(call if_changed,uimage)
+	@echo '  Image $@ is ready'
+
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 	@:
