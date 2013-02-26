From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Tue, 26 Feb 2013 15:24:30 +0900
Subject: [RFC PATCH v2 4/4] x86: Add support for LZ4-compressed kernel
In-Reply-To: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
Message-ID: <1361859870-15751-5-git-send-email-kyungsik.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the LZ4 decompression code to the x86 pre-boot code.
And it depends on two patchs below

lib: Add support for LZ4-compressed kernel
decompressor: Add LZ4 decompressor module

Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
---
 arch/x86/Kconfig                  | 1 +
 arch/x86/boot/compressed/Makefile | 5 ++++-
 arch/x86/boot/compressed/misc.c   | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 225543b..ab916fd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -63,6 +63,7 @@ config X86
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_LZ4
 	select HAVE_HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 8a84501..c275db5 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -4,7 +4,7 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo head_$(BITS).o misc.o string.o cmdline.o early_serial_console.o piggy.o
+targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 head_$(BITS).o misc.o string.o cmdline.o early_serial_console.o piggy.o
 
 KBUILD_CFLAGS := -m$(BITS) -D__KERNEL__ $(LINUX_INCLUDE) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIC
@@ -64,12 +64,15 @@ $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
+$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,lz4)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
 suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
+suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
 
 quiet_cmd_mkpiggy = MKPIGGY $@
       cmd_mkpiggy = $(obj)/mkpiggy $< > $@ || ( rm -f $@ ; false )
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 88f7ff6..166a0a8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -145,6 +145,10 @@ static int lines, cols;
 #include "../../../../lib/decompress_unlzo.c"
 #endif
 
+#ifdef CONFIG_KERNEL_LZ4
+#include "../../../../lib/decompress_unlz4.c"
+#endif
+
 static void scroll(void)
 {
 	int i;
-- 
1.8.1.1
