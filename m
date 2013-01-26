From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Sat, 26 Jan 2013 14:50:46 +0900
Subject: [RFC PATCH 3/4] arm: add support for LZ4-compressed kernels
In-Reply-To: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
Message-ID: <1359179447-31118-4-git-send-email-kyungsik.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the LZ4 decompression code to the arm pre-boot code.
And it depends on two patchs below

lib: add support for LZ4-compressed kernels
decompressors: add lz4 decompressor module

Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
---
 arch/arm/Kconfig                      | 1 +
 arch/arm/boot/compressed/.gitignore   | 1 +
 arch/arm/boot/compressed/Makefile     | 3 ++-
 arch/arm/boot/compressed/decompress.c | 4 ++++
 arch/arm/boot/compressed/piggy.lz4.S  | 6 ++++++
 5 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/compressed/piggy.lz4.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91f8d78..1b3621d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -37,6 +37,7 @@ config ARM
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZ4
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index f79a08e..47279aa 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -6,6 +6,7 @@ piggy.gzip
 piggy.lzo
 piggy.lzma
 piggy.xzkern
+piggy.lz4
 vmlinux
 vmlinux.lds
 
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..8b5c79a 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -88,6 +88,7 @@ suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 suffix_$(CONFIG_KERNEL_LZMA) = lzma
 suffix_$(CONFIG_KERNEL_XZ)   = xzkern
+suffix_$(CONFIG_KERNEL_LZ4)  = lz4
 
 # Borrowed libfdt files for the ATAG compatibility mode
 
@@ -112,7 +113,7 @@ targets       := vmlinux vmlinux.lds \
 		 font.o font.c head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
-extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern \
+extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
 		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 9deb56a..a95f071 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -53,6 +53,10 @@ extern char * strstr(const char * s1, const char *s2);
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
+#ifdef CONFIG_KERNEL_LZ4
+#include "../../../../lib/decompress_unlz4.c"
+#endif
+
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return decompress(input, len, NULL, NULL, output, NULL, error);
diff --git a/arch/arm/boot/compressed/piggy.lz4.S b/arch/arm/boot/compressed/piggy.lz4.S
new file mode 100644
index 0000000..3d9a575
--- /dev/null
+++ b/arch/arm/boot/compressed/piggy.lz4.S
@@ -0,0 +1,6 @@
+	.section .piggydata,#alloc
+	.globl	input_data
+input_data:
+	.incbin	"arch/arm/boot/compressed/piggy.lz4"
+	.globl	input_data_end
+input_data_end:
-- 
1.8.0.3
