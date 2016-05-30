From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 May 2016 11:01:23 +0900
Subject: [PATCH] ARM: avoid duplicating "Kernel: arch/arm/boot/*Image is ready"
Message-ID: <1464573683-30795-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to
not generate invalid images") fixed bad image generation for the
parallel building, but as its side effect, Kbuild now descends into
arch/arm/boot/ again and again, duplicating the log messages.
It looks clumsy, so let's display the same message only once.

This commit moves the log rules from arch/arm/boot/Makefile to
arch/arm/Makefile.  I did not delete them completely because *Image
are the final targets that users are interested in.

Without this commit, the log of incremental build is like follows:

$ make ARCH=arm UIMAGE_LOADADDR=0x80208000 uImage
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Image arch/arm/boot/uImage is ready

With this commit, it will look like follows:

$ make ARCH=arm UIMAGE_LOADADDR=0x80208000 uImage
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Kernel: arch/arm/boot/uImage is ready

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
KernelVersion: v4.7-rc1


 arch/arm/Makefile      | 1 +
 arch/arm/boot/Makefile | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 274e8a6..229afaf 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -327,6 +327,7 @@ zImage: Image
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 5be33a2..bdc1d5a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -31,7 +31,7 @@ ifeq ($(CONFIG_XIP_KERNEL),y)
 
 $(obj)/xipImage: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
+	@$(kecho) '  Physical Address of xipImage: $(CONFIG_XIP_PHYS_ADDR)'
 
 $(obj)/Image $(obj)/zImage: FORCE
 	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
@@ -46,14 +46,12 @@ $(obj)/xipImage: FORCE
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 endif
 
@@ -78,14 +76,12 @@ fi
 $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
-	@$(kecho) '  Image $@ is ready'
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 PHONY += initrd install zinstall uinstall
 initrd:
-- 
1.9.1
