From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Sat, 24 Jun 2017 17:42:11 +0200
Subject: [PATCH] arm64: pass endianness info to sparse
Message-ID: <20170624154211.61472-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 depends on the macro __AARCH64EB__ being defined or not
to correctly select or define endian-specific macros, structures
or pieces of code.

This macro is predefined by the compiler but sparse knows nothing
about it and thus may pre-process files differently from what
gcc would.

Fix this by passing '-D__AARCH64EL__' or '-D__AARCH64EB__' to
sparse depending of the endianness of the kernel, like defined
by GCC.

Note: In most case it won't change anything since most arm64 use
      little-endian (but an allyesconfig would use big-endian!).

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 15d6c1476..8ed11b94a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -52,11 +52,13 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
+CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
+CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
 UTS_MACHINE	:= aarch64
-- 
2.13.0
