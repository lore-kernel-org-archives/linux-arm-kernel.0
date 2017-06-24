From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Sat, 24 Jun 2017 17:38:42 +0200
Subject: [PATCH] arm: pass endianness info to sparse
Message-ID: <20170624153842.61064-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM depends on the macros '__ARMEL__' & '__ARMEB__' being defined
or not to correctly select or define endian-specific macros,
structures or pieces of code.

These macros are predefined by the compiler but sparse knows
nothing about them and thus may pre-process files differently
from what gcc would.

Fix this by passing '-D__ARMEL__' or '-D__ARMEB__' to sparse,
depending of the endianness of the kernel, like defined by GCC.

Note: In most case it won't change anything since most ARMs use
      little-endian (but an allyesconfig would use big-endian!).

CC: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 65f4e2a4e..0fca46d7f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -44,10 +44,12 @@ endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
+CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
 LD		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
+CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
 LD		+= -EL
 endif
-- 
2.13.0
