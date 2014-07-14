From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Jul 2014 13:24:53 +0200
Subject: [PATCH] ARM: EXYNOS: Fix MCPM build with SUSPEND=n
Message-ID: <1405337093-15377-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building of EXYNOS5420_MCPM with disabled SUSPEND fails:
arch/arm/mach-exynos/built-in.o: In function `exynos_mcpm_init':
arch/arm/mach-exynos/mcpm-exynos.c:361: undefined reference to `mcpm_loopback'

The exynos_mcpm_init() in mcp-exynos.c calls mcpm_loopback() which
depends on cpu_suspend function (ARM_CPU_SUSPEND).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: a6a4d3152e3cbb6 ("ARM: 8083/1: exynos: activate the CCI on boot CPU/cluster using the MCPM loopback")
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 8f9b66c4ac78..5d4ff6571dcd 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -119,6 +119,7 @@ config EXYNOS5420_MCPM
 	bool "Exynos5420 Multi-Cluster PM support"
 	depends on MCPM && SOC_EXYNOS5420
 	select ARM_CCI
+	select ARM_CPU_SUSPEND
 	help
 	  This is needed to provide CPU and cluster power management
 	  on Exynos5420 implementing big.LITTLE.
-- 
1.9.1
