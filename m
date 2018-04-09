From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Mon, 9 Apr 2018 00:35:57 +0000
Subject: [PATCH AUTOSEL for 3.18 047/101] arm64: pass endianness info to sparse
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
Message-ID: <20180409003505.164715-47-alexander.levin@microsoft.com>
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
index 3e2f6590666a..203d87177172 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -24,10 +24,12 @@ KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
+CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
+CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
 endif
-- 
2.15.1
