From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 18 Jul 2014 15:00:50 +0100
Subject: [PATCH 4/7] arm: Disable stack protection for decompressor/stub
In-Reply-To: <1405692053-7514-1-git-send-email-leif.lindholm@linaro.org>
References: <1405692053-7514-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1405692053-7514-5-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roy Franz <roy.franz@linaro.org>

The ARM decompressor/EFI stub do not implement the functions
(__stack_chk_guard_setup, etc) that are required for support of
stack protection.  The actual enablement of stack protection is
controlled by heuristics in GCC, which the code added for the EFI
stub triggers when CONFIG_STACKPROTECTOR is set.  Even with
CONFIG_STACKPROTECTOR set, the decompressor was never compiled
with stack protection actually enabled. Adding -fno-stack-protector
to the decompressor/stub build keeps it building without stack
protection as it has always been built.
The x86 decompressor/stub is also built with -fno-stack-protector.

Signed-off-by: Roy Franz <roy.franz@linaro.org>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 arch/arm/boot/compressed/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 68c9183..27536b1 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -121,7 +121,7 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
+ccflags-y := -fpic -mno-single-pic-base -fno-builtin -fno-stack-protector -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-- 
1.7.10.4
