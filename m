From: roy.franz@linaro.org (Roy Franz)
Date: Tue,  2 Jul 2013 20:45:10 -0700
Subject: [PATCH] ARM: Add kernel build # to build message
Message-ID: <1372823110-18170-1-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

from: Roy Franz <roy.franz@linaro.org>

Add the display of the incrementing kernel build number, similar
to the x86 build.  Example output:
Kernel: arch/arm/boot/zImage is ready  (#94)

Signed-off-by: Roy Franz <roy.franz@linaro.org>

---
 arch/arm/boot/Makefile |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 84aa2ca..f1192f5 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -31,7 +31,7 @@ ifeq ($(CONFIG_XIP_KERNEL),y)
 
 $(obj)/xipImage: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
+	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))' ' (#'`cat .version`')'
 
 $(obj)/Image $(obj)/zImage: FORCE
 	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
@@ -46,14 +46,14 @@ $(obj)/xipImage: FORCE
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready' ' (#'`cat .version`')'
 
 endif
 
@@ -78,7 +78,7 @@ fi
 $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
-	@$(kecho) '  Image $@ is ready'
+	@$(kecho) '  Image $@ is ready' ' (#'`cat .version`')'
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
@@ -86,7 +86,7 @@ $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
+	@$(kecho) '  Kernel: $@ is ready' ' (#'`cat .version`')'
 
 PHONY += initrd FORCE
 initrd:
-- 
1.7.10.4
