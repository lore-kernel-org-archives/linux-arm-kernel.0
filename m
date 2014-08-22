From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Aug 2014 21:06:34 -0500
Subject: [PATCH] ARM: bcm: Don't build brcmstb SMP code when building for V6
Message-ID: <1408673194-16228-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The brcmstb SMP code contains isb() and dsb() which are not supported when
building for -march=armv6 as happens when building allmodconfig. Since I
have not been able to identify a way to override the compiler architecture
selection per file add a Kconfig dependency to ensure this code is not
built if V6 support is enabled.

There is doubtless a better solution.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc93800..372132d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -102,6 +102,7 @@ config ARCH_BCM_5301X
 config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards" if ARCH_MULTI_V7
 	depends on MMU
+	depends on !CPU_V6
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select HAVE_SMP
-- 
2.1.0.rc1
