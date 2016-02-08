From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  8 Feb 2016 15:41:27 +0900
Subject: [PATCH v2 2/2] ARM: descend into arch/arm/boot only once to generate
 boot images
In-Reply-To: <1454913687-9325-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454913687-9325-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1454913687-9325-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") fixed bad images generation in the parallel
building, but it is not efficient to descend into arch/arm/boot over
and over again.  It is also clumsy to display the same log message
"Kernel: arch/arm/boot/Image is ready" a couple of times.

  $ make ARCH=arm UIMAGE_LOADADDR=0x80208000 all uImage
      [snip]
    Kernel: arch/arm/boot/Image is ready
    Kernel: arch/arm/boot/Image is ready
    Kernel: arch/arm/boot/zImage is ready
    Building modules, stage 2.
    MODPOST 279 modules
    Kernel: arch/arm/boot/Image is ready
    Kernel: arch/arm/boot/zImage is ready
    UIMAGE  arch/arm/boot/uImage
  Image Name:   Linux-4.5.0-rc3
  Created:      Mon Feb  8 13:22:53 2016
  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    6768768 Bytes = 6610.12 kB = 6.46 MB
  Load Address: 80208000
  Entry Point:  80208000
    Image arch/arm/boot/uImage is ready

This commit allows arch/arm/boot/Makefile to build boot images at once
instead of generating them one by one.  Of course, it works correctly
also in parallel building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix build error

 arch/arm/Makefile | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d6d453f..be1e146 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -315,13 +315,17 @@ archprepare:
 BOOT_TARGETS	= zImage Image xipImage bootpImage uImage
 INSTALL_TARGETS	= zinstall uinstall install
 
-PHONY += $(BOOT_TARGETS) $(INSTALL_TARGETS)
+PHONY += $(BOOT_TARGETS) $(INSTALL_TARGETS) __build_images
 
-bootpImage uImage: zImage
-zImage: Image
+$(BOOT_TARGETS): __build_images
+	@:
 
-$(BOOT_TARGETS): vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+__build_images: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) \
+	$(addprefix $(boot)/, \
+		$(sort $(filter $(BOOT_TARGETS),$(MAKECMDGOALS)) \
+			$(if $(filter all,$(MAKECMDGOALS)), $(KBUILD_IMAGE)) \
+			$(if $(MAKECMDGOALS),,$(KBUILD_IMAGE))))
 
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
-- 
1.9.1
