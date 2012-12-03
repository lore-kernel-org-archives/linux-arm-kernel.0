From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Dec 2012 17:56:42 +0000
Subject: [PATCH 2/3] ARM: nommu: prevent generation of kernel unaligned memory
 accesses
In-Reply-To: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
Message-ID: <1354557403-20386-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent ARMv7 toolchains assume that unaligned memory accesses will not
fault and will instead be handled by the processor.

For the nommu case (without an MPU), memory will be treated as
strongly-ordered and therefore unaligned accesses may fault regardless
of the SCTLR.A setting.

This patch passes -mno-unaligned-access to GCC when compiling for nommu
targets, preventing the generation of unaligned memory access in the
kernel.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5f914fc..03363e2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -32,6 +32,7 @@ KBUILD_DEFCONFIG := versatile_defconfig
 # defines filename extension depending memory management type.
 ifeq ($(CONFIG_MMU),)
 MMUEXT		:= -nommu
+KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-- 
1.8.0
