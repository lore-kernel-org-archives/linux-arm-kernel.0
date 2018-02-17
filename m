From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Feb 2018 13:01:12 +0800
Subject: [PATCH] ARM: sunxi: Fix multi-cluster SMP support compilation in
 multi v6/v7 configs
Message-ID: <20180217050112.14619-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various parts of the assembly code used in the multi-cluster SMP support
requires ARMv7-A. If the kernel config also has multi v6 support enabled,
Kbuild defaults to building for armv6k, which does not support some of
the instructions we use.

Configure the Makefile such that the multi-cluster SMP code is always
built for ARMv7-A. This is also what mach-exynos does for their MC-SMP
code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This addresses "[sunxi:sunxi/core-for-4.17 1/4] /tmp/ccSQM2rD.s:438:
Error: selected processor does not support `isb' in ARM mode"
reported by the kbuild test robot for arm-allmodconfig.

Should we apply it, or squash it in the original patch?

---
 arch/arm/mach-sunxi/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 3e741e959c7c..3c2c4384357a 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
+CFLAGS_mc_smp.o	+= -march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
-- 
2.16.1
