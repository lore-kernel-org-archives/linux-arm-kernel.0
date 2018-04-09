From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Mon, 9 Apr 2018 00:24:47 +0000
Subject: [PATCH AUTOSEL for 4.9 146/293] arm64: pass endianness info to sparse
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
Message-ID: <20180409002239.163177-146-alexander.levin@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit bcde519e8c325f3cc1fcf443eb6466e6bb3a3aca ]

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
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index bc66f4b6a1cb..b0babc09577d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,11 +48,13 @@ KBUILD_AFLAGS	+= $(lseinstr)
 
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
2.15.1
