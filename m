From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 29 Oct 2012 09:34:25 -0600
Subject: [PATCH] ARM: quiet down the non make -s output
Message-ID: <20121029153425.GA9486@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit edc88ceb0c7d285b9f58bc29a638cd8163b59989 silenced the make -s build, but
inadvertently made louder the non-silent build.  Fix by prepending '@' to each
of the added $(kecho) statements.

Build with edc88ceb0c7d285b9f58bc29a638cd8163b59989:

  CHK     include/generated/compile.h
echo '  Kernel: arch/arm/boot/Image is ready'
  Kernel: arch/arm/boot/Image is ready
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
echo '  Kernel: arch/arm/boot/zImage is ready'
  Kernel: arch/arm/boot/zImage is ready

Build with this fix:
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/boot/Makefile  | 10 +++++-----
 arch/arm/tools/Makefile |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index f2aa09e..9137df5 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -33,7 +33,7 @@ ifeq ($(CONFIG_XIP_KERNEL),y)
 
 $(obj)/xipImage: vmlinux FORCE
 	$(call if_changed,objcopy)
-	$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
+	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
 
 $(obj)/Image $(obj)/zImage: FORCE
 	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
@@ -48,14 +48,14 @@ $(obj)/xipImage: FORCE
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
-	$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
-	$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready'
 
 endif
 
@@ -90,7 +90,7 @@ fi
 $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
-	$(kecho) '  Image $@ is ready'
+	@$(kecho) '  Image $@ is ready'
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
@@ -98,7 +98,7 @@ $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
-	$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready'
 
 PHONY += initrd FORCE
 initrd:
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index cd60a81..32d05c8 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -5,6 +5,6 @@
 #
 
 include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types
-	$(kecho) '  Generating $@'
+	@$(kecho) '  Generating $@'
 	@mkdir -p $(dir $@)
 	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
-- 
1.8.0
