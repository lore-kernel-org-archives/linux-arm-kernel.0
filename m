From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Tue, 31 Oct 2017 18:21:57 +0100
Subject: [PATCH] arm: pass endianness info to sparse
Message-ID: <20171031172157.9744-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM depends on the macros '__ARMEL__' & '__ARMEB__' being defined
or not to correctly select or define endian-specific macros,
structures or pieces of code.

These macros are predefined by the compiler but sparse knows
nothing about them and thus may pre-process files differently
from what gcc would.

Fix this by passing '-D__ARMEL__' or '-D__ARMEB__' to sparse,
depending on the endianness of the kernel, like defined by GCC.

Note: In most case it won't change anything since most ARMs use
      little-endian (but an allyesconfig would use big-endian!).

To: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 817e5cfef..36ae44545 100644
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
2.14.0
