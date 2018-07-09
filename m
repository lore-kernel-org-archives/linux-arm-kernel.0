From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  9 Jul 2018 11:09:42 +0900
Subject: [PATCH] ARM: add endianness option to LDFLAGS instead of LD
Message-ID: <1531102182-13699-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent syntax extension, Kconfig is now able to evaluate the
compiler / toolchain capability.

However, accumulating flags to 'LD' is not compatible with the way
it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
between Makefile and Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v4.18-rc4


 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fc26c3d..62ebeae 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -46,12 +46,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
-LD		+= -EB
+LDFLAGS		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
-LD		+= -EL
+LDFLAGS		+= -EL
 endif
 
 #
-- 
2.7.4
