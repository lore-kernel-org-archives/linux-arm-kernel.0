From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:13:57 +0200
Subject: [RFC 3/7] ARM: vf610m4: add new machine and SoC for Vybrid on
 Cortex-M4
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <d1b3670556c7c7a11092834abf52eedb22c332b7.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new machine ARCH_MXCM4 which requires !MMU and
!MULTIARCH and is meant as machine for the hetregenous multi-core
Vybrid/i.MX SoC's to run Linux on the Cortex-M4.

The first SoC supported is Vybrid on Cortex-M4 (SOC_VF610M4).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Not sure whether we really need a new MACH, but since MACH_MXC needs
MULTIARCH, which in turn conflicts with !MMU, I guess there is no
easier way to do it... And then, this also needs a new SOC.

 arch/arm/Kconfig                 | 12 ++++++++++++
 arch/arm/Kconfig.debug           |  4 ++--
 arch/arm/Makefile                |  1 +
 arch/arm/mach-imx/Kconfig        | 22 ++++++++++++++++++++++
 arch/arm/mach-imx/Makefile       |  1 +
 arch/arm/mach-imx/Makefile.boot  |  0
 arch/arm/mach-imx/mach-vf610m4.c | 16 ++++++++++++++++
 drivers/mmc/host/Kconfig         |  2 +-
 drivers/pinctrl/Kconfig          |  2 +-
 9 files changed, 56 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-imx/Makefile.boot
 create mode 100644 arch/arm/mach-imx/mach-vf610m4.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..69f0bad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -455,6 +455,18 @@ config ARCH_FOOTBRIDGE
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
+menuconfig ARCH_MXCM4
+	bool "Freescale Vybrid/i.MX family on Cortex-M4" if !MMU
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_CPU_SUSPEND if PM
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
+	select PINCTRL
+	select PM_OPP if PM
+	select SOC_BUS
+	help
+	  Support for Freescale Vybrid/iMX-based family of processors on Cortex-M4
+
 config ARCH_NETX
 	bool "Hilscher NetX based"
 	select ARM_VIC
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..3ac00e7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -435,7 +435,7 @@ choice
 
 	config DEBUG_VF_UART
 		bool "Vybrid UART"
-		depends on SOC_VF610
+		depends on SOC_VF610 || SOC_VF610M4
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Vybrid based platforms.
@@ -994,7 +994,7 @@ config DEBUG_VF_UART_PORT
 	int "Vybrid Debug UART Port Selection" if DEBUG_VF_UART
 	default 1
 	range 0 3
-	depends on SOC_VF610
+	depends on SOC_VF610 || SOC_VF610M4
 	help
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0ce9d0f..55339fd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -174,6 +174,7 @@ machine-$(CONFIG_ARCH_MSM)		+= msm
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
+machine-$(CONFIG_ARCH_MXCM4)		+= imx
 machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index be9a51a..7ed3ab9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -739,3 +739,25 @@ endif
 source "arch/arm/mach-imx/devices/Kconfig"
 
 endif
+
+if !MMU && ARCH_MXCM4
+
+config SOC_VF610M4
+	bool "Vybrid Family VF610 support for Cortex-M4"
+	select ARCH_REQUIRE_GPIOLIB
+	select PINCTRL_VF610
+	select PINCTRL_IMX
+	select ARM_NVIC
+	select AUTO_ZRELADDR
+	select CPU_V7M
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select NO_DMA
+	select NO_IOPORT_MAP
+	select SPARSE_IRQ
+	select USE_OF
+	select VF_PIT_TIMER
+	help
+	  Support for Vybrid Familiy VF610's Cortex-M4
+
+endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 23c0293..d326220 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -113,5 +113,6 @@ obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
 obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
+obj-$(CONFIG_SOC_VF610M4) += clk-vf610.o mach-vf610m4.o
 
 obj-y += devices/
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-imx/mach-vf610m4.c b/arch/arm/mach-imx/mach-vf610m4.c
new file mode 100644
index 0000000..d534f01
--- /dev/null
+++ b/arch/arm/mach-imx/mach-vf610m4.c
@@ -0,0 +1,16 @@
+#include <linux/kernel.h>
+
+#include <asm/v7m.h>
+
+#include <asm/mach/arch.h>
+
+static const char *const vf610m4_compat[] __initconst = {
+	"fsl,vf610m4",
+	NULL
+};
+
+
+DT_MACHINE_START(VF610M4DT, "VF610 on Cortex-M4 (Device Tree Support)")
+	.dt_compat = vf610m4_compat,
+	.restart = armv7m_restart,
+MACHINE_END
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4511358..eef90c0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -155,7 +155,7 @@ config MMC_SDHCI_CNS3XXX
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_MXCM4
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index bfd2c2e..508dc95 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -181,7 +181,7 @@ config PINCTRL_IMX6SX
 
 config PINCTRL_VF610
 	bool "Freescale Vybrid VF610 pinctrl driver"
-	depends on SOC_VF610
+	depends on SOC_VF610 || SOC_VF610M4
 	select PINCTRL_IMX
 	help
 	  Say Y here to enable the Freescale Vybrid VF610 pinctrl driver
-- 
2.1.2
