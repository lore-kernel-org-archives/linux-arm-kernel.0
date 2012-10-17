From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Oct 2012 11:27:36 -0300
Subject: [PATCH v2] ARM: mach-imx: Let ARCH_MXC select HAVE_IMX_SRC
Message-ID: <1350484056-13437-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit c5a0d497(ARM: imx: enable multi-platform build), 
ARCH_MXC is selected by the following logic:

config ARCH_MXC
	def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7

As vexpress_defconfig selects ARCH_MULTI_V6_V7, this leads to the following
build error when building for vexpress_defconfig: 

arch/arm/mach-imx/hotplug.c:49: undefined reference to `imx_enable_cpu'
arch/arm/mach-imx/platsmp.c:57: undefined reference to `imx_set_cpu_jump'
arch/arm/mach-imx/platsmp.c:58: undefined reference to `imx_enable_cpu'

These missing functions are provided by arch/arm/mach-imx/src.c, which is 
selected via HAVE_IMX_SRC.

Currently only SOC_IMX6Q selects HAVE_IMX_SRC, so let ARCH_MXC select it and fix
the build error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix typo in commit message and improve it a bit
 arch/arm/mach-imx/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 892631f..856482d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -7,6 +7,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select HAVE_IMX_SRC
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
@@ -837,7 +838,6 @@ config SOC_IMX6Q
 	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
-	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
 	select PINCTRL
-- 
1.7.9.5
