From: rob@landley.net (Rob Landley)
Date: Wed, 11 Apr 2018 20:38:37 -0500
Subject: [PATCH] Replace unnecessary perl with sed, printf, and the shell $((
 )) operator.
Message-ID: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You can build a kernel in a cross compiling environment that doesn't have perl
in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/arm/boot/compressed/Makefile |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b..33ebeb2 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -117,11 +117,10 @@ ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
-		perl -e 'while (<>) { \
-			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
-			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
-		}; printf "%d\n", $$bss_end - $$bss_start;')
+KBSS_SZ := $(shell echo $$(($$(printf '%d+%d' $$( \
+		$(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
+		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
+		       -e 's/^\([^ ]*\) B __bss_stop$$/0x\1/p') ) )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
