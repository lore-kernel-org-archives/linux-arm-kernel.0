From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sun, 30 Sep 2018 04:49:04 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
Message-ID: <20180930024904.14240-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per the discussion about half-way down in [1], the kernel doesn't
actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
hardware that benefits from ARMv3 code generation. Such a consideration,
then, only applies to the compiler but not to the assembler. This commit
passes -march=armv4 to the assembler in those cases, so that code
written for ARMv4 will continue to compile and run fine, without needing
module-specific asflags-y overrides.

[1] https://lore.kernel.org/lkml/CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg at mail.gmail.com/

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
I don't have too much familiarity with hardware this old, nor access to
testing systems, so please do carefully evaluate the assertions above
before merging this, since I'm not sure I have a full understanding of
the Linux ARMv3 situation.

 arch/arm/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f85f25d..7a264cacb482 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -76,8 +76,14 @@ arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
 arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3
 
+# We do not actually support the ARMv3 ISA and prefer it above only for
+# code generation purposes, which does not apply to assembly. So we pass
+# v4 to the assembler, so that we can still assemble all instructions.
+arch-asflags-$(CONFIG_CPU_32v3)	=-march=armv4
+
 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
+arch-asflags-y := $(arch-asflags-y)
 
 # This selects how we optimise for the processor.
 tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
@@ -130,7 +136,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) $(arch-asflags-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.19.0
