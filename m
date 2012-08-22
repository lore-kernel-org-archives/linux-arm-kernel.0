From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:10 +0200
Subject: [PATCH 6/6] ARM: imx: select ARM_CPU_SUSPEND when necessary
In-Reply-To: <1345648390-4234-1-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
Message-ID: <1345648390-4234-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6, we select ARM_CPU_SUSPEND when building with power management
support, but for some reason this was omitted on i.MX5. Normally we
build kernels for both together so the error only showed up in
randconfig tests.

Without this patch, building imx5 standalone results in:

arch/arm/mach-imx/built-in.o: In function `v7_cpu_resume':
arch/arm/mach-imx/head-v7.S:104: undefined reference to `cpu_resume'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.miao@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index afd542a..8e96573 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -89,6 +89,7 @@ config SOC_IMX5
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX5
+	select ARM_CPU_SUSPEND if PM
 	bool
 
 config SOC_IMX50
-- 
1.7.10
