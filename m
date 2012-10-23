From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 15:39:02 +0800
Subject: [PATCH] ARM: imx: select HAVE_IMX_SRC when SMP is enabled
Message-ID: <1350977942-15964-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With being part of multi-platform support, SMP can be enabled by other
platform even when SOC_IMX6Q is deselected.  It leads to a situation
that arch/arm/mach-imx/platsmp.c is built without HAVE_IMX_SRC selection
which will cause build error.  For example, the following link errors
will be seen when building imx5 with other v7 platforms.

 arch/arm/mach-imx/built-in.o: In function `imx_cpu_die':
 platform-ahci-imx.c:(.text+0x219c): undefined reference to `imx_enable_cpu'
 arch/arm/mach-imx/built-in.o: In function `imx_boot_secondary':
 platform-ahci-imx.c:(.cpuinit.text+0x14): undefined reference to `imx_set_cpu_jump'
 platform-ahci-imx.c:(.cpuinit.text+0x20): undefined reference to `imx_enable_cpu'

Select HAVE_IMX_SRC as long as SMP is enabled to fix the problem.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8c75bae..4f73866 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -72,7 +72,7 @@ config HAVE_IMX_MMDC
 	bool
 
 config HAVE_IMX_SRC
-	bool
+	def_bool y if SMP
 
 config IMX_HAVE_IOMUX_V1
 	bool
@@ -839,7 +839,6 @@ config SOC_IMX6Q
 	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
-	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
 	select PINCTRL
-- 
1.7.9.5
