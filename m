From: andrew@lunn.ch (Andrew Lunn)
Date: Mon,  3 Sep 2012 18:58:07 +0200
Subject: [PATCH v2 RESEND] ARM: Build dtb files in all target
Message-ID: <1346691487-17534-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tools like kisskb are good at finding build regressions in the kernel
sources. However, regressions in the DT desscriptions are not found,
because generally these build systems don't build the DT binary blobs.

Extend the ARM all target to build all enabled DTB files.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Makefile |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..0457ef4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -268,7 +268,12 @@ else
 KBUILD_IMAGE := zImage
 endif
 
-all:	$(KBUILD_IMAGE)
+# Build the DT binary blobs if we have OF configured
+ifeq ($(CONFIG_USE_OF),y)
+KBUILD_DTBS := dtbs
+endif
+
+all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 
 boot := arch/arm/boot
 
@@ -306,7 +311,7 @@ define archhelp
   echo  '  uImage        - U-Boot wrapped zImage'
   echo  '  bootpImage    - Combined zImage and initial RAM disk' 
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
-  echo  '  dtbs          - Build device tree blobs for enabled boards'
+  echo  '* dtbs          - Build device tree blobs for enabled boards'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '  uinstall      - Install U-Boot wrapped compressed kernel'
-- 
1.7.10.4
