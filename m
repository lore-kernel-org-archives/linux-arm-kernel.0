From: trini@konsulko.com (Tom Rini)
Date: Wed, 23 Aug 2017 09:30:13 -0400
Subject: [PATCHv4][DO NOT MERGE] Build a zImage or uImage with dtb already
 appended
Message-ID: <1503495013-7931-1-git-send-email-trini@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Add new targets to build zImage and uImage with DTB appended (i.e. make
'uImage-dtb.am335x-bone' or 'make zImage-dtb.omap3-evm').

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
There are still times where you will run into the need to run a modern
kernel on a board with old firmware that you cannot update.  This patch
is not intended for merging anywhere, but just to make use of this
mechanism when needed easier.

V1: by Grant Likely (02 Aug 2011)
V2: by Domenico Andreoli (29 Jun 2012)
    added .gitignore change
V3: by Christoph Junghans (14 Jan 2015)
    added archhelp
V4: Rebase to v4.13-rc6, update depends
---
 arch/arm/Makefile        | 8 ++++++++
 arch/arm/boot/.gitignore | 2 ++
 arch/arm/boot/Makefile   | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..d169430c79e4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -337,6 +337,12 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+zImage-dtb.%:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
+uImage-dtb.%:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
 %.dtb: | scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
@@ -364,9 +370,11 @@ bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
+  echo  '  zImage-dtb.*  - zImage' with appended dtb blob for machine=*'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '* xipImage      - XIP kernel image, if configured (arch/$(ARCH)/boot/xipImage)'
   echo  '  uImage        - U-Boot wrapped zImage'
+  echo  '  uImage-dtb.*  - U-Boot wrapped zImage' with appended dtb blob for machine=*'
   echo  '  bootpImage    - Combined zImage and initial RAM disk'
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
   echo  '* dtbs          - Build device tree blobs for enabled boards'
diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
index 3c79f85975aa..3d7e1c88c488 100644
--- a/arch/arm/boot/.gitignore
+++ b/arch/arm/boot/.gitignore
@@ -1,6 +1,8 @@
 Image
 zImage
+zImage-dtb.*
 xipImage
 bootpImage
 uImage
+uImage-dtb.*
 *.dtb
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 50f8d1be7fcb..6c4435b44e8f 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -55,6 +55,9 @@ $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 
+$(obj)/zImage-dtb.%:	$(obj)/dts/%.dtb $(obj)/zImage
+	cat $(obj)/zImage $< > $@
+
 endif
 
 ifneq ($(LOADADDR),)
@@ -79,6 +82,10 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
 
+$(obj)/uImage-dtb.%:	$(obj)/zImage-dtb.% FORCE
+	$(call if_changed,uimage)
+	@echo '  Image $@ is ready'
+
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 
-- 
1.9.1
