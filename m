From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 19 Apr 2016 14:05:09 +0900
Subject: [PATCH] ARM: suppress "include/generated/mach-types.h is up to date."
Message-ID: <1461042309-17898-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For incremental build, "include/generated/mach-types.h is up to date"
is every time displayed like follows:

$ make ARCH=arm
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h

This commit avoids such a clumsy log and introduces Kbuild standard
log style:

  GEN     include/generated/mach-types.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 4.6-rc4

 arch/arm/tools/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 32d05c8..6e4cd18 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -4,7 +4,10 @@
 # Copyright (C) 2001 Russell King
 #
 
-include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types
-	@$(kecho) '  Generating $@'
-	@mkdir -p $(dir $@)
-	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
+quiet_cmd_gen_mach = GEN     $@
+      cmd_gen_mach = mkdir -p $(dir $@) && \
+		     $(AWK) -f $(filter-out $(PHONY),$^) > $@ || \
+		     { rm -f $@; /bin/false; }
+
+include/generated/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
+	$(call if_changed,gen_mach)
-- 
1.9.1
