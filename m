From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 18 Oct 2016 20:31:32 +0100
Subject: [PATCH 1/3] ARM: remove indirection of asm/mach-types.h
Message-ID: <E1bwa6m-0004ZS-VJ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arrange for mach-types.h to be directly generated in the relevant
path, so we don't need a one-liner file in arch/arm/include/asm/.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Makefile                 |  2 +-
 arch/arm/include/asm/Kbuild       |  2 ++
 arch/arm/include/asm/mach-types.h |  1 -
 arch/arm/tools/Makefile           | 16 +++++++++++++++-
 4 files changed, 18 insertions(+), 3 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach-types.h

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6be9ee148b78..2208a73ba1d4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -312,7 +312,7 @@ all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
 boot := arch/arm/boot
 
 archprepare:
-	$(Q)$(MAKE) $(build)=arch/arm/tools include/generated/mach-types.h
+	$(Q)$(MAKE) $(build)=arch/arm/tools kapi
 
 # Convert bzImage to zImage
 bzImage: zImage
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 0745538b26d3..5b06064946ce 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -39,3 +39,5 @@ generic-y += termios.h
 generic-y += timex.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
+
+generated-y += mach-types.h
diff --git a/arch/arm/include/asm/mach-types.h b/arch/arm/include/asm/mach-types.h
deleted file mode 100644
index 948178cc6ba8..000000000000
--- a/arch/arm/include/asm/mach-types.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <generated/mach-types.h>
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 6e4cd1867a9f..bdf48e4949ad 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -4,10 +4,24 @@
 # Copyright (C) 2001 Russell King
 #
 
+gen := arch/$(ARCH)/include/generated
+kapi := $(gen)/asm
+
+kapi-hdrs-y := $(kapi)/mach-types.h
+
+targets += $(addprefix ../../../,$(kapi-hdrs-y))
+
+PHONY += kapi
+
+kapi:	$(kapi-hdrs-y)
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+
 quiet_cmd_gen_mach = GEN     $@
       cmd_gen_mach = mkdir -p $(dir $@) && \
 		     $(AWK) -f $(filter-out $(PHONY),$^) > $@ || \
 		     { rm -f $@; /bin/false; }
 
-include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
+$(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
-- 
2.1.0
