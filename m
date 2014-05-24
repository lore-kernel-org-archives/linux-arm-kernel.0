From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:01:22 -0700
Subject: [PATCH 01/24] ARM64: Force LP64 to compile the kernel.
In-Reply-To: <1400914905-9594-1-git-send-email-apinski@cavium.com>
References: <1400914905-9594-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914905-9594-2-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the compiler is set to default to ILP32 ABI so we want to make sure the kernel can compile in that case.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..e9dbd20 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -20,14 +20,18 @@ LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
+KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
+KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
+LDFLAGS		+= -maarch64linuxb
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+LDFLAGS		+= -maarch64linux
 endif
 
 comma = ,
-- 
1.7.2.5
