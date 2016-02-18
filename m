From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 18:05:07 +0100
Subject: [PATCH 1/3] [RESEND] ARM: pass -march=armv7-a when building NEON
 files with clang
In-Reply-To: <1455815113-2562966-1-git-send-email-arnd@arndb.de>
References: <1455815113-2562966-1-git-send-email-arnd@arndb.de>
Message-ID: <1455815113-2562966-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang ignores the -mfpu=neon flag when building with -march=armv6:

In file included from lib/raid6/neon1.c:27:
clang/3.8.0/include/arm_neon.h:28:2: error: "NEON support not enabled"

There is no real need to build the file with -march=armv6 in a
multi-CPU enabled kernel, as nothing in here will ever get called
on an ARMv6 CPU. Adding -march=armv7 doesn't hurt and can only
improve the code quality.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/lib/Makefile | 2 +-
 lib/raid6/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index d8a780799506..a86c6c8e0648 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -35,7 +35,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
+  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon -march=armv7-a
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 3b10a48fa040..4ef3e800fb39 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -23,7 +23,7 @@ endif
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 ifeq ($(ARCH),arm)
-NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
+NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon -march=armv7-a
 endif
 ifeq ($(ARCH),arm64)
 CFLAGS_REMOVE_neon1.o += -mgeneral-regs-only
-- 
2.7.0
