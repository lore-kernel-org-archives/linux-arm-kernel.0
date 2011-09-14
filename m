From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:46 -0400
Subject: [PATCH 6/6] ARM: zImage: prevent constant copy+rebuild of lib1funcs.S
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

The rule to copy this file doesn't have to be forced.  However
lib1funcs.[So] have to be listed amongst the targets.

This prevents zImage from being recreated needlessly.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index ce2bef536e..db1fd260ed 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -112,7 +112,7 @@ endif
 
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
-		 font.o font.c head.o misc.o $(OBJS)
+		 lib1funcs.o lib1funcs.S font.o font.c head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
 extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S $(libfdt) $(libfdt_hdrs)
@@ -147,7 +147,7 @@ LDFLAGS_vmlinux += -T
 # For __aeabi_uidivmod
 lib1funcs = $(obj)/lib1funcs.o
 
-$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
+$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
 	$(call cmd,shipped)
 
 # We need to prevent any GOTOFF relocs being used with references
-- 
1.7.7-rc0
