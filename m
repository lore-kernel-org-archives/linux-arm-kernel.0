From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  1 Apr 2016 01:43:02 +0900
Subject: [PATCH 2/2] ARM: delete "*Image is ready" log
In-Reply-To: <1459442582-23121-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459442582-23121-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459442582-23121-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") fixed bad image generation in case of
parallel building, but as a side effect, Kbuild now descends into
arch/arm/boot/ again and again, duplicating the same log messages.
This is clumsy.

In the example below (incremental build),
  "Kernel: arch/arm/boot/Image is ready" is displayed three times.
  "Kernel: arch/arm/boot/zImage is ready" is displayed twice.

$ make ARCH=arm UIMAGE_LOADADDR=0x80208000  uImage
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1310:2: warning: #warning syscall preadv2 not implemented [-Wcpp]
<stdin>:1313:2: warning: #warning syscall pwritev2 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Image arch/arm/boot/uImage is ready

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 446705a..966104e 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -31,7 +31,6 @@ ifeq ($(CONFIG_XIP_KERNEL),y)
 
 $(obj)/xipImage: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready (physical address: $(CONFIG_XIP_PHYS_ADDR))'
 
 $(obj)/Image $(obj)/zImage: FORCE
 	@echo 'Kernel configured for XIP (CONFIG_XIP_KERNEL=y)'
@@ -46,14 +45,12 @@ $(obj)/xipImage: FORCE
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 $(obj)/compressed/vmlinux: $(obj)/Image FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 endif
 
@@ -78,7 +75,6 @@ fi
 $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
-	@$(kecho) '  Image $@ is ready'
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
@@ -86,7 +82,6 @@ $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
-	@$(kecho) '  Kernel: $@ is ready'
 
 PHONY += initrd install zinstall uinstall
 initrd:
-- 
1.9.1
