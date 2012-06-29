From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 29 Jun 2012 22:39:20 +0200
Subject: [PATCH v2] Build a zImage or uImage with dtb already appended
In-Reply-To: <20110802143148.21599.22870.stgit@ponder>
References: <20110802143148.21599.22870.stgit@ponder>
Message-ID: <20120629203919.GA18617@raptus.dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Add new targets to build zImage and uImage with DTB appended (i.e. make
'uImage-dtb.am335x-bone' or 'make zImage-dtb.omap3-evm').

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---

On Tue, Aug 02, 2011 at 03:31:48PM +0100, Grant Likely wrote:
> Do not commit to mainline; this is a useful hack only for now.
> 

Is this a better moment for this patch?

Anyway, here is an update for v3.5-rc4. Added zImage-dtb.* as a valid
target and the .gitignore entries.

cheers
Domenico

---
 arch/arm/Makefile        |    6 ++++++
 arch/arm/boot/.gitignore |    2 ++
 arch/arm/boot/Makefile   |    7 +++++++
 3 files changed, 15 insertions(+)

Index: b/arch/arm/Makefile
===================================================================
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -283,6 +283,12 @@ zImage Image xipImage bootpImage uImage:
 zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
+zImage-dtb.%:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
+uImage-dtb.%:
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+
 %.dtb:
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
Index: b/arch/arm/boot/Makefile
===================================================================
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -55,6 +55,9 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
+$(obj)/zImage-dtb.%:	$(obj)/%.dtb $(obj)/zImage
+	cat $(obj)/zImage $< > $@
+
 endif
 
 targets += $(dtb-y)
@@ -90,6 +93,10 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
+$(obj)/uImage-dtb.%:	$(obj)/zImage-dtb.% FORCE
+	$(call if_changed,uimage)
+	@echo '  Image $@ is ready'
+
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 	@:
Index: b/arch/arm/boot/.gitignore
===================================================================
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
