From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:13:19 +0100
Subject: [PATCH 2/2] ARM: imx: select ARM_CPU_SUSPEND for CPU_IDLE as well
In-Reply-To: <20180315151345.3089601-1-arnd@arndb.de>
References: <20180315151345.3089601-1-arnd@arndb.de>
Message-ID: <20180315151345.3089601-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle support calls cpu_suspend(), which is compiled conditionally,
and fails to link unless something selects CONFIG_ARM_CPU_SUSPEND.

arch/arm/mach-imx/cpuidle-imx6sx.o: In function `imx6sx_enter_wait':
cpuidle-imx6sx.c:(.text+0x6c): undefined reference to `cpu_suspend'

This adds an explicit select statement here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f53ec31c9f5a..e47fa13f4b0c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -469,7 +469,7 @@ config	SOC_IMX53
 
 config SOC_IMX6
 	bool
-	select ARM_CPU_SUSPEND if PM
+	select ARM_CPU_SUSPEND if (PM || CPU_IDLE)
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
-- 
2.9.0
