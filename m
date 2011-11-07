From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon,  7 Nov 2011 21:03:36 +0100
Subject: [PATCH v3] ARM: support XZ compressed kernels
Message-ID: <1320696216-5570-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire up support for the XZ decompressor

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
New in v3: refreshed against current git

New in v2: added missing .gitignore modification

 arch/arm/Kconfig                        |    1 +
 arch/arm/boot/compressed/.gitignore     |    2 ++
 arch/arm/boot/compressed/Makefile       |   15 ++++++++++++---
 arch/arm/boot/compressed/decompress.c   |    4 ++++
 arch/arm/boot/compressed/piggy.xzkern.S |    6 ++++++
 5 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/compressed/piggy.xzkern.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2bda424..866e652 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_XZ
 	select HAVE_IRQ_WORK
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index e0936a1..d0d441c 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,8 +1,10 @@
+ashldi3.S
 font.c
 lib1funcs.S
 piggy.gzip
 piggy.lzo
 piggy.lzma
+piggy.xzkern
 vmlinux
 vmlinux.lds
 
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 21f56ff..0b9a6d1 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -92,6 +92,7 @@ SEDFLAGS	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
 suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 suffix_$(CONFIG_KERNEL_LZMA) = lzma
+suffix_$(CONFIG_KERNEL_XZ)   = xzkern
 
 # Borrowed libfdt files for the ATAG compatibility mode
 
@@ -112,10 +113,12 @@ endif
 
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
-		 lib1funcs.o lib1funcs.S font.o font.c head.o misc.o $(OBJS)
+		 lib1funcs.o lib1funcs.S ashldi3.o ashldi3.S \
+		 font.o font.c head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
-extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S $(libfdt) $(libfdt_hdrs)
+extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern \
+		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
@@ -150,6 +153,12 @@ lib1funcs = $(obj)/lib1funcs.o
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
 	$(call cmd,shipped)
 
+# For __aeabi_llsl
+ashldi3 = $(obj)/ashldi3.o
+
+$(obj)/ashldi3.S: $(srctree)/arch/$(SRCARCH)/lib/ashldi3.S
+	$(call cmd,shipped)
+
 # We need to prevent any GOTOFF relocs being used with references
 # to symbols in the .bss section since we cannot relocate them
 # independently from the rest at run time.  This can be achieved by
@@ -171,7 +180,7 @@ if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" = "" ]; then \
 fi
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
-	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
+	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) $(ashldi3) FORCE
 	@$(check_for_multiple_zreladdr)
 	$(call if_changed,ld)
 	@$(check_for_bad_syms)
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 07be5a2..0ecd8b4 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -44,6 +44,10 @@ extern void error(char *);
 #include "../../../../lib/decompress_unlzma.c"
 #endif
 
+#ifdef CONFIG_KERNEL_XZ
+#include "../../../../lib/decompress_unxz.c"
+#endif
+
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return decompress(input, len, NULL, NULL, output, NULL, error);
diff --git a/arch/arm/boot/compressed/piggy.xzkern.S b/arch/arm/boot/compressed/piggy.xzkern.S
new file mode 100644
index 0000000..5703f30
--- /dev/null
+++ b/arch/arm/boot/compressed/piggy.xzkern.S
@@ -0,0 +1,6 @@
+	.section .piggydata,#alloc
+	.globl	input_data
+input_data:
+	.incbin	"arch/arm/boot/compressed/piggy.xzkern"
+	.globl	input_data_end
+input_data_end:
-- 
1.7.1
