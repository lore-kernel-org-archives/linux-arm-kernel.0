From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 16:31:16 +0900
Subject: [PATCH 5/6] ARM: decompressor: merge piggy.*.S and simplify Makefile
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1456126277-14633-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The files piggy.$(suffix).S are similar enough to be merged into a
single file.  This also allows clean up of the Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/compressed/.gitignore                |  6 +-----
 arch/arm/boot/compressed/Makefile                  | 14 ++++++--------
 arch/arm/boot/compressed/{piggy.gzip.S => piggy.S} |  2 +-
 arch/arm/boot/compressed/piggy.lz4.S               |  6 ------
 arch/arm/boot/compressed/piggy.lzma.S              |  6 ------
 arch/arm/boot/compressed/piggy.lzo.S               |  6 ------
 arch/arm/boot/compressed/piggy.xzkern.S            |  6 ------
 7 files changed, 8 insertions(+), 38 deletions(-)
 rename arch/arm/boot/compressed/{piggy.gzip.S => piggy.S} (67%)
 delete mode 100644 arch/arm/boot/compressed/piggy.lz4.S
 delete mode 100644 arch/arm/boot/compressed/piggy.lzma.S
 delete mode 100644 arch/arm/boot/compressed/piggy.lzo.S
 delete mode 100644 arch/arm/boot/compressed/piggy.xzkern.S

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index 0714e03..86b2f5d 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -3,11 +3,7 @@ bswapsdi2.S
 font.c
 lib1funcs.S
 hyp-stub.S
-piggy.gzip
-piggy.lzo
-piggy.lzma
-piggy.xzkern
-piggy.lz4
+piggy_data
 vmlinux
 vmlinux.lds
 
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 903b953..3243f09 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -89,14 +89,12 @@ ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
 OBJS	+= $(libfdt_objs) atags_to_fdt.o
 endif
 
-targets       := vmlinux vmlinux.lds \
-		 piggy.$(suffix_y) piggy.$(suffix_y).o \
+targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 lib1funcs.o ashldi3.o bswapsdi2.o \
 		 head.o $(OBJS)
 
-clean-files += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
-		 lib1funcs.S ashldi3.S bswapsdi2.S $(libfdt) $(libfdt_hdrs) \
-		 hyp-stub.S
+clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
+		$(libfdt) $(libfdt_hdrs) hyp-stub.S
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
@@ -177,17 +175,17 @@ fi
 
 efi-obj-$(CONFIG_EFI_STUB) := $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
 		$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) $(ashldi3) \
 		$(bswapsdi2) $(efi-obj-y) FORCE
 	@$(check_for_multiple_zreladdr)
 	$(call if_changed,ld)
 	@$(check_for_bad_syms)
 
-$(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
+$(obj)/piggy_data: $(obj)/../Image FORCE
 	$(call if_changed,$(suffix_y))
 
-$(obj)/piggy.$(suffix_y).o:  $(obj)/piggy.$(suffix_y)
+$(obj)/piggy.o: $(obj)/piggy_data
 
 CFLAGS_font.o := -Dstatic=
 
diff --git a/arch/arm/boot/compressed/piggy.gzip.S b/arch/arm/boot/compressed/piggy.S
similarity index 67%
rename from arch/arm/boot/compressed/piggy.gzip.S
rename to arch/arm/boot/compressed/piggy.S
index a68adf9..f720884 100644
--- a/arch/arm/boot/compressed/piggy.gzip.S
+++ b/arch/arm/boot/compressed/piggy.S
@@ -1,6 +1,6 @@
 	.section .piggydata,#alloc
 	.globl	input_data
 input_data:
-	.incbin	"arch/arm/boot/compressed/piggy.gzip"
+	.incbin	"arch/arm/boot/compressed/piggy_data"
 	.globl	input_data_end
 input_data_end:
diff --git a/arch/arm/boot/compressed/piggy.lz4.S b/arch/arm/boot/compressed/piggy.lz4.S
deleted file mode 100644
index 3d9a575..0000000
--- a/arch/arm/boot/compressed/piggy.lz4.S
+++ /dev/null
@@ -1,6 +0,0 @@
-	.section .piggydata,#alloc
-	.globl	input_data
-input_data:
-	.incbin	"arch/arm/boot/compressed/piggy.lz4"
-	.globl	input_data_end
-input_data_end:
diff --git a/arch/arm/boot/compressed/piggy.lzma.S b/arch/arm/boot/compressed/piggy.lzma.S
deleted file mode 100644
index d7e69cf..0000000
--- a/arch/arm/boot/compressed/piggy.lzma.S
+++ /dev/null
@@ -1,6 +0,0 @@
-	.section .piggydata,#alloc
-	.globl	input_data
-input_data:
-	.incbin	"arch/arm/boot/compressed/piggy.lzma"
-	.globl	input_data_end
-input_data_end:
diff --git a/arch/arm/boot/compressed/piggy.lzo.S b/arch/arm/boot/compressed/piggy.lzo.S
deleted file mode 100644
index a425ad9..0000000
--- a/arch/arm/boot/compressed/piggy.lzo.S
+++ /dev/null
@@ -1,6 +0,0 @@
-	.section .piggydata,#alloc
-	.globl	input_data
-input_data:
-	.incbin	"arch/arm/boot/compressed/piggy.lzo"
-	.globl	input_data_end
-input_data_end:
diff --git a/arch/arm/boot/compressed/piggy.xzkern.S b/arch/arm/boot/compressed/piggy.xzkern.S
deleted file mode 100644
index 5703f30..0000000
--- a/arch/arm/boot/compressed/piggy.xzkern.S
+++ /dev/null
@@ -1,6 +0,0 @@
-	.section .piggydata,#alloc
-	.globl	input_data
-input_data:
-	.incbin	"arch/arm/boot/compressed/piggy.xzkern"
-	.globl	input_data_end
-input_data_end:
-- 
1.9.1
