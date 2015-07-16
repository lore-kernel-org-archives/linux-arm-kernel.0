From: olof@lixom.net (Olof Johansson)
Date: Thu, 16 Jul 2015 11:04:12 -0700
Subject: [PATCH] arm64: enable more compressed Image formats
Message-ID: <1437069852-8393-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Plumb up Makefile arguments for the already supported formats in the kbuild
system: lz4, bzip2, lzma, and lzo.

Note that just as with Image.gz, these images are not self-decompressing and
the booting firmware still needs to handle decompression before launching the
kernel image.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/Makefile      |  2 +-
 arch/arm64/boot/Makefile | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4d2a925998f9..435618941c24 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -58,7 +58,7 @@ all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 
 boot := arch/arm64/boot
 
-Image Image.gz: vmlinux
+Image Image.%: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zinstall install: vmlinux
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 5a0e3ab854a5..abcbba2f01ba 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -19,9 +19,21 @@ targets := Image Image.gz
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
+$(obj)/Image.bz2: $(obj)/Image FORCE
+	$(call if_changed,bzip2)
+
 $(obj)/Image.gz: $(obj)/Image FORCE
 	$(call if_changed,gzip)
 
+$(obj)/Image.lz4: $(obj)/Image FORCE
+	$(call if_changed,lz4)
+
+$(obj)/Image.lzma: $(obj)/Image FORCE
+	$(call if_changed,lzma)
+
+$(obj)/Image.lzo: $(obj)/Image FORCE
+	$(call if_changed,lzo)
+
 install: $(obj)/Image
 	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
-- 
2.0.1.473.gc4d58ca
