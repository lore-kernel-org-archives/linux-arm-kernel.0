From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 31 Mar 2016 20:14:16 +0900
Subject: [PATCH] kbuild: delete unnecessary "@:"
Message-ID: <1459422856-31754-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 2aedcd098a94 ('kbuild: suppress annoying "... is up to
date." message'), $(call if_changed,...) is evaluated to "@:"
when there is nothing to do.

We no longer need to add "@:" after $(call if_changed,...) to
suppress "... is up to date." message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/Makefile                  | 1 -
 arch/arm/boot/bootp/Makefile            | 1 -
 arch/h8300/boot/compressed/Makefile     | 1 -
 arch/m32r/boot/compressed/Makefile      | 1 -
 arch/mn10300/boot/compressed/Makefile   | 1 -
 arch/nios2/boot/compressed/Makefile     | 1 -
 arch/s390/boot/compressed/Makefile      | 1 -
 arch/sh/boot/compressed/Makefile        | 1 -
 arch/sh/boot/romimage/Makefile          | 1 -
 arch/unicore32/boot/compressed/Makefile | 1 -
 arch/x86/boot/compressed/Makefile       | 1 -
 arch/x86/purgatory/Makefile             | 2 --
 arch/x86/realmode/rm/Makefile           | 1 -
 13 files changed, 14 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 966104e..30a7b28 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -78,7 +78,6 @@ $(obj)/uImage:	$(obj)/zImage FORCE
 
 $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/bootp $@
-	@:
 
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 3d51a13..5e4acd2 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -17,7 +17,6 @@ targets	:= bootp init.o kernel.o initrd.o
 # Note that bootp.lds picks up kernel.o and initrd.o
 $(obj)/bootp:	$(src)/bootp.lds $(addprefix $(obj)/,init.o kernel.o initrd.o) FORCE
 	$(call if_changed,ld)
-	@:
 
 # kernel.o and initrd.o includes a binary image using
 # .incbin, a dependency which is not tracked automatically
diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
index 7643633..613bfe6 100644
--- a/arch/h8300/boot/compressed/Makefile
+++ b/arch/h8300/boot/compressed/Makefile
@@ -23,7 +23,6 @@ LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -estartup -T $(obj)/vmlinux.lds \
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(LIBGCC) FORCE
 	$(call if_changed,ld)
-	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/m32r/boot/compressed/Makefile b/arch/m32r/boot/compressed/Makefile
index 01729c2..0606a72 100644
--- a/arch/m32r/boot/compressed/Makefile
+++ b/arch/m32r/boot/compressed/Makefile
@@ -19,7 +19,6 @@ LDFLAGS_vmlinux := -T
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
-	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/mn10300/boot/compressed/Makefile b/arch/mn10300/boot/compressed/Makefile
index 08a95e1..5f56f9d 100644
--- a/arch/mn10300/boot/compressed/Makefile
+++ b/arch/mn10300/boot/compressed/Makefile
@@ -8,7 +8,6 @@ LDFLAGS_vmlinux := -Ttext $(CONFIG_KERNEL_ZIMAGE_BASE_ADDRESS) -e startup_32
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
-	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/nios2/boot/compressed/Makefile b/arch/nios2/boot/compressed/Makefile
index 5b0fb34..d5921c9 100644
--- a/arch/nios2/boot/compressed/Makefile
+++ b/arch/nios2/boot/compressed/Makefile
@@ -11,7 +11,6 @@ LDFLAGS_vmlinux := -T
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
-	@:
 
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-littlenios2 -T
 
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index fac6ac9..1dd2103 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -22,7 +22,6 @@ OBJECTS += $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o
 LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(OBJECTS)
 	$(call if_changed,ld)
-	@:
 
 sed-sizes := -e 's/^\([0-9a-fA-F]*\) . \(__bss_start\|_end\)$$/\#define SZ\2 0x\1/p'
 
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 6df826e..c4c47ea 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -55,7 +55,6 @@ $(addprefix $(obj)/,$(lib1funcs-y)): $(obj)/%: $(lib1funcs-dir)/% FORCE
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(lib1funcs-obj) FORCE
 	$(call if_changed,ld)
-	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/sh/boot/romimage/Makefile b/arch/sh/boot/romimage/Makefile
index 2216ee5..43c4119 100644
--- a/arch/sh/boot/romimage/Makefile
+++ b/arch/sh/boot/romimage/Makefile
@@ -17,7 +17,6 @@ LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
 
 $(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
-	@:
 
 OBJCOPYFLAGS += -j .empty_zero_page
 
diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
index 96494fb..9aecdd3 100644
--- a/arch/unicore32/boot/compressed/Makefile
+++ b/arch/unicore32/boot/compressed/Makefile
@@ -54,7 +54,6 @@ LDFLAGS_vmlinux += -T
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/head.o $(obj)/piggy.o \
 		$(obj)/misc.o FORCE
 	$(call if_changed,ld)
-	@:
 
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6915ff2..0fb857e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -60,7 +60,6 @@ vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
-	@:
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 92e3e1d..12734a9 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -26,7 +26,5 @@ quiet_cmd_bin2c = BIN2C   $@
 
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
 	$(call if_changed,bin2c)
-	@:
-
 
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index b959646..c556c5a 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -59,7 +59,6 @@ OBJCOPYFLAGS_realmode.bin := -O binary
 targets += realmode.bin
 $(obj)/realmode.bin: $(obj)/realmode.elf $(obj)/realmode.relocs FORCE
 	$(call if_changed,objcopy)
-	@:
 
 quiet_cmd_relocs = RELOCS  $@
       cmd_relocs = arch/x86/tools/relocs --realmode $< > $@
-- 
1.9.1
