From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Apr 2011 18:50:24 -0400
Subject: [PATCH 9/9] ARM: zImage: make sure no GOTOFF relocs are used with .bss
	symbols
In-Reply-To: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
Message-ID: <1304031024-5121-10-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

To be able to relocate the .bss section at run time independently from
the rest of the code, we must make sure that no GOTOFF relocations are
used with .bss symbols.  This usually means that no global variables can
be marked static unless they're also const.

To enforce this, suffice to fail the build whenever a private symbol
is allocated to .bss and list those symbols for convenience.

The user_stack and user_stack_end labels in head.S were converted into
non exported symbols to remove false positives.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/Makefile |   15 ++++++++++++++-
 arch/arm/boot/compressed/head.S   |    6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 79b5c62..23aad07 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -120,10 +120,23 @@ lib1funcs = $(obj)/lib1funcs.o
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
 	$(call cmd,shipped)
 
+# We need to prevent any GOTOFF relocs being used with references
+# to symbols in the .bss section since we cannot relocate them
+# independently from the rest at run time.  This can be achieved by
+# ensuring that no private .bss symbols exist, as global symbols
+# always have a GOT entry which is what we need.
+# The .data section is already discarded by the linker script so no need
+# to bother about it here.
+check_for_bad_syms = \
+bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
+[ -z "$$bad_syms" ] || \
+  ( echo "following symbols must have non local/private scope:" >&2; \
+    echo "$$bad_syms" >&2; rm -f $@; false )
+
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
 	$(call if_changed,ld)
-	@:
+	@$(check_for_bad_syms)
 
 $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 	$(call if_changed,$(suffix_y))
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index b6eb643..dfaaae0 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -370,7 +370,7 @@ LC0:		.word	LC0			@ r1
 		.word	input_data_end - 4	@ r10 (inflated size location)
 		.word	_got_start		@ r11
 		.word	_got_end		@ ip
-		.word	user_stack_end		@ sp
+		.word	.L_user_stack_end	@ sp
 		.size	LC0, . - LC0
 
 #ifdef CONFIG_ARCH_RPC
@@ -1098,5 +1098,5 @@ reloc_code_end:
 
 		.align
 		.section ".stack", "aw", %nobits
-user_stack:	.space	4096
-user_stack_end:
+.L_user_stack:	.space	4096
+.L_user_stack_end:
-- 
1.7.4
