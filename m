From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jul 2015 21:37:04 +0900
Subject: [PATCH] ARM: add boot image dependencies not to generate invalid
 images
Message-ID: <1436186224-6673-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-Boot is often used to boot the kernel on ARM boards, but uImage
is not built by "make all", so we are often inclined to do
"make all uImage" in a single command, but we should notice a
pitfall behind it.  In fact, "make all uImage" could generate an
invalid uImage if it is run with the parallel option (-j).

You can reproduce this problem with the following procedure:

[1] First, build "all" and "uImage" separately.
    You will get a valid uImage
  $ export CROSS_COMPILE=<your-tools-prefix>
  $ make -s -j8 ARCH=arm multi_v7_defconfig
  $ make -s -j8 ARCH=arm all
  $ make -s -j8 ARCH=arm UIMAGE_LOADADDR=0x80208000 uImage
  Image Name:   Linux-4.2.0-rc1-00008-g1c4c715
  Created:      Mon Jul  6 17:49:52 2015
  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    6145624 Bytes = 6001.59 kB = 5.86 MB
  Load Address: 80208000
  Entry Point:  80208000
  $ cat arch/arm/boot/uImage | wc
      17553  107879 6145688

[2] Update some source file(s)
  $ touch init/main.c

[3] Then, re-build "all" and "uImage" simultaneously.
    You will get an invalid uImage at random.
  $ make -s -j8 ARCH=arm UIMAGE_LOADADDR=0x80208000 all uImage
  Image Name:   Linux-4.2.0-rc1-00008-g1c4c715-d
  Created:      Mon Jul  6 17:52:22 2015
  Image Type:   ARM Linux Kernel Image (uncompressed)
  Data Size:    26768 Bytes = 26.14 kB = 0.03 MB
  Load Address: 80208000
  Entry Point:  80208000
  $ cat arch/arm/boot/uImage | wc
      266    1063   26832

Please notice the uImage is extremely small when this issue is
encountered.  The root cause of this is the race condition between
zImage and uImage targets.

"make uImage" could descend into arch/arm/boot/Makefile before
"make zImage" is completed because arch/arm/Makefile describes no
dependency among boot targets.

The same problem could happen on bootpImage.

Add correct dependencies among Image, zImage, uImage, and bootpImage
to eliminate this pit-fall.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 07ab3d2..7451b44 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -312,6 +312,9 @@ INSTALL_TARGETS	= zinstall uinstall install
 
 PHONY += bzImage $(BOOT_TARGETS) $(INSTALL_TARGETS)
 
+bootpImage uImage: zImage
+zImage: Image
+
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
-- 
1.9.1
