From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Jul 2018 08:30:33 -0700
Subject: [PATCH] arm64: build with baremetal linker target instead of Linux
 when available
In-Reply-To: <20180713150701.GA3049@arm.com>
References: <20180713150701.GA3049@arm.com>
Message-ID: <20180713153033.20540-1-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
in particular. So, probe for whether it's available and use the previous
(linux) targets if it isn't.

Reported-by: Laura Abbott <labbott@redhat.com>
Cc: Paul Kocialkowski <contact@paulk.fr>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/Makefile    | 9 +++++----
 scripts/Kbuild.include | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e7101b19d590..efe61a2e4b5e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,15 +60,16 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-# We must use the linux target here, since distributions don't tend to package
-# the ELF linker scripts with binutils, and this results in a build failure.
-LDFLAGS		+= -EB -maarch64linuxb
+# Prefer the baremetal ELF build target, but not all toolchains include
+# it so fall back to the standard linux version if needed.
+LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64linux # See comment above
+# Same as above, prefer ELF but fall back to linux target if needed.
+LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
 UTS_MACHINE	:= aarch64
 endif
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d61678c..1e13f502b42f 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
 	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
-# Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
+# Usage: LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.11.0
