From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  3 Jul 2018 10:22:01 +0900
Subject: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead of
 LD
In-Reply-To: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
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

 arch/microblaze/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index d269dd4b..7333036 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
 ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS += -mbig-endian
 KBUILD_AFLAGS += -mbig-endian
-LD += -EB
+LDFLAGS += -EB
 else
 KBUILD_CFLAGS += -mlittle-endian
 KBUILD_AFLAGS += -mlittle-endian
-LD += -EL
+LDFLAGS += -EL
 endif
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
-- 
2.7.4
