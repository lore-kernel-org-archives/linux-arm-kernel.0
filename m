From: ottxor@gentoo.org (Christoph Junghans)
Date: Wed, 14 Jan 2015 19:08:13 -0700
Subject: [PATCH] Build a uImage with dtb already appended
In-Reply-To: <20110802143148.21599.22870.stgit@ponder>
References: <20110802143148.21599.22870.stgit@ponder>
Message-ID: <1421287693-23383-1-git-send-email-ottxor@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new targets to build zImage and uImage with DTB appended (i.e. make
'uImage-dtb.am335x-bone' or 'make zImage-dtb.omap3-evm').

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---

I don't know why this never got merged, but I think it is still useful.

V1: by Grant Likely (02 Aug 2011)
V2: by Domenico Andreoli (29 Jun 2012)
    added .gitignore change
V3: added archhelp

 arch/arm/Makefile        | 5 +++++
 arch/arm/boot/.gitignore | 2 ++
 arch/arm/boot/Makefile   | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c1785ee..b3d51e24 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -308,6 +308,9 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+uImage-dtb.%: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
 %.dtb: | scripts
 	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
@@ -330,9 +333,11 @@ i zi:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
+  echo  '  zImage-dtb.*  - zImage' with appended dtb blob for machine=*
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
   echo  '* xipImage      - XIP kernel image, if configured (arch/$(ARCH)/boot/xipImage)'
   echo  '  uImage        - U-Boot wrapped zImage'
+  echo  '  uImage-dtb.*  - U-Boot wrapped zImage' with appended dtb blob for machine=*
   echo  '  bootpImage    - Combined zImage and initial RAM disk'
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
   echo  '* dtbs          - Build device tree blobs for enabled boards'
diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
index 3c79f85..3d7e1c8 100644
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
index ec2f806..6bc21d2 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -55,6 +55,9 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@$(kecho) '  Kernel: $@ is ready'
 
+$(obj)/zImage-dtb.%:	$(obj)/dts/%.dtb $(obj)/zImage
+	cat $(obj)/zImage $< > $@
+
 endif
 
 ifneq ($(LOADADDR),)
@@ -80,6 +83,11 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
 	@$(kecho) '  Image $@ is ready'
 
+$(obj)/uImage-dtb.%:	$(obj)/zImage-dtb.% FORCE
+	@$(check_for_multiple_loadaddr)
+	$(call if_changed,uimage)
+	@echo '  Image $@ is ready'
+
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 	@:
-- 
2.0.5
