From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Feb 2011 16:39:03 -0500
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
Message-ID: <1297892343-29064-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently presume a 4x expansion to guess the decompressed kernel size
in order to determine if the decompressed kernel is in conflict with
the location where zImage is loaded.  This guess may cause many issues
by overestimating the final kernel image size:

- This may force a needless relocation if the location of zImage was
  fine, wasting some precious microseconds of boot time.

- The relocation may be located way too far, possibly overwriting the
  initrd image in RAM.

- If the kernel image includes a large already-compressed initramfs image
  then the problem is even more exacerbated.

And if by some strange means the 4x guess is too low then we may overwrite
ourselves with the decompressed image.

So let's use the exact decompressed kernel image size instead.  For that
we need to rely on the stat command, but this is hardly a new build
dependency as the kernel already depends on many commands provided by
the same coreutils package where stat is found to be built.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/Makefile       |    4 +++-
 arch/arm/boot/compressed/vmlinux.lds.in |    3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0a8f748..9d328be 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -83,9 +83,11 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
+# Provide size of uncompressed kernel to the decompressor via a linker symbol.
+LDFLAGS_vmlinux := --defsym _image_size=$(shell stat -c "%s" $(obj)/../Image)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
-LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
+LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
 endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 366a924..5309909 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -43,9 +43,6 @@ SECTIONS
 
   _etext = .;
 
-  /* Assume size of decompressed image is 4x the compressed image */
-  _image_size = (_etext - _text) * 4;
-
   _got_start = .;
   .got			: { *(.got) }
   _got_end = .;
-- 
1.7.4
