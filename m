From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Nov 2011 08:41:03 +0100
Subject: [PATCH 2/3] ARM i.MX: Merge i.MX5 support into mach-imx
In-Reply-To: <1321429264-25834-1-git-send-email-s.hauer@pengutronix.de>
References: <1321429264-25834-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1321429264-25834-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the contents of arch/arm/mach-mx5 to arch/arm/mach-imx
and adjusts the Makefile/Kconfig entries in a way that it's possible
to compile i.MX5 together with i.MX3/6.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/Makefile                                  |    1 -
 arch/arm/mach-imx/Kconfig                          |  239 +++++++++++++++++++
 arch/arm/mach-imx/Makefile                         |   21 ++
 arch/arm/mach-imx/Makefile.boot                    |   12 +
 arch/arm/{mach-mx5 => mach-imx}/clock-mx51-mx53.c  |    2 +-
 arch/arm/{mach-mx5/cpu.c => mach-imx/cpu-imx5.c}   |    0
 arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.c      |    0
 arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.h      |    0
 .../crm_regs.h => mach-imx/crm-regs-imx5.h}        |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx50.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx51.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/devices-imx53.h    |    0
 arch/arm/{mach-mx5 => mach-imx}/efika.h            |    0
 arch/arm/{mach-mx5/ehci.c => mach-imx/ehci-imx5.c} |    0
 .../eukrea_mbimx51-baseboard.c                     |    0
 .../eukrea_mbimxsd-baseboard.c                     |    0
 arch/arm/{mach-mx5 => mach-imx}/imx51-dt.c         |    0
 arch/arm/{mach-mx5 => mach-imx}/imx53-dt.c         |    0
 .../board-cpuimx51.c => mach-imx/mach-cpuimx51.c}  |    0
 .../mach-cpuimx51sd.c}                             |    0
 .../board-mx50_rdp.c => mach-imx/mach-mx50_rdp.c}  |    0
 .../board-mx51_3ds.c => mach-imx/mach-mx51_3ds.c}  |    0
 .../mach-mx51_babbage.c}                           |    0
 .../mach-mx51_efikamx.c}                           |    0
 .../mach-mx51_efikasb.c}                           |    0
 .../board-mx53_ard.c => mach-imx/mach-mx53_ard.c}  |    0
 .../board-mx53_evk.c => mach-imx/mach-mx53_evk.c}  |    0
 .../mach-mx53_loco.c}                              |    0
 .../board-mx53_smd.c => mach-imx/mach-mx53_smd.c}  |    0
 arch/arm/{mach-mx5/mm.c => mach-imx/mm-imx5.c}     |    0
 arch/arm/{mach-mx5 => mach-imx}/mx51_efika.c       |    0
 arch/arm/{mach-mx5/system.c => mach-imx/pm-imx5.c} |   89 +++++++-
 arch/arm/mach-mx5/Kconfig                          |  244 --------------------
 arch/arm/mach-mx5/Makefile                         |   26 --
 arch/arm/mach-mx5/Makefile.boot                    |    9 -
 arch/arm/mach-mx5/pm-imx5.c                        |   83 -------
 arch/arm/plat-mxc/Kconfig                          |   15 +-
 37 files changed, 356 insertions(+), 385 deletions(-)
 rename arch/arm/{mach-mx5 => mach-imx}/clock-mx51-mx53.c (99%)
 rename arch/arm/{mach-mx5/cpu.c => mach-imx/cpu-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.h (100%)
 rename arch/arm/{mach-mx5/crm_regs.h => mach-imx/crm-regs-imx5.h} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx50.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx51.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/devices-imx53.h (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/efika.h (100%)
 rename arch/arm/{mach-mx5/ehci.c => mach-imx/ehci-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/eukrea_mbimx51-baseboard.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/eukrea_mbimxsd-baseboard.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/imx51-dt.c (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/imx53-dt.c (100%)
 rename arch/arm/{mach-mx5/board-cpuimx51.c => mach-imx/mach-cpuimx51.c} (100%)
 rename arch/arm/{mach-mx5/board-cpuimx51sd.c => mach-imx/mach-cpuimx51sd.c} (100%)
 rename arch/arm/{mach-mx5/board-mx50_rdp.c => mach-imx/mach-mx50_rdp.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_3ds.c => mach-imx/mach-mx51_3ds.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_babbage.c => mach-imx/mach-mx51_babbage.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_efikamx.c => mach-imx/mach-mx51_efikamx.c} (100%)
 rename arch/arm/{mach-mx5/board-mx51_efikasb.c => mach-imx/mach-mx51_efikasb.c} (100%)
 rename arch/arm/{mach-mx5/board-mx53_ard.c => mach-imx/mach-mx53_ard.c} (100%)
 rename arch/arm/{mach-mx5/board-mx53_evk.c => mach-imx/mach-mx53_evk.c} (100%)
 rename arch/arm/{mach-mx5/board-mx53_loco.c => mach-imx/mach-mx53_loco.c} (100%)
 rename arch/arm/{mach-mx5/board-mx53_smd.c => mach-imx/mach-mx53_smd.c} (100%)
 rename arch/arm/{mach-mx5/mm.c => mach-imx/mm-imx5.c} (100%)
 rename arch/arm/{mach-mx5 => mach-imx}/mx51_efika.c (100%)
 rename arch/arm/{mach-mx5/system.c => mach-imx/pm-imx5.c} (58%)
 delete mode 100644 arch/arm/mach-mx5/Kconfig
 delete mode 100644 arch/arm/mach-mx5/Makefile
 delete mode 100644 arch/arm/mach-mx5/Makefile.boot
 delete mode 100644 arch/arm/mach-mx5/pm-imx5.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dfcf3b0..cf7d467 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,7 +160,6 @@ machine-$(CONFIG_ARCH_MSM)		:= msm
 machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
 machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
-machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5f7f9c2..ef6a6b8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -33,6 +33,18 @@ config ARCH_MX31
 config ARCH_MX35
 	bool
 
+config ARCH_MX5
+	bool
+
+config ARCH_MX50
+	bool
+
+config ARCH_MX51
+	bool
+
+config ARCH_MX53
+	bool
+
 config SOC_IMX1
 	bool
 	select ARCH_MX1
@@ -86,6 +98,32 @@ config SOC_IMX35
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
 
+config SOC_IMX5
+	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
+	select MXC_TZIC
+	select ARCH_MXC_IOMUX_V3
+	select ARCH_MXC_AUDMUX_V2
+	select ARCH_HAS_CPUFREQ
+	select ARCH_MX5
+	bool
+
+config SOC_IMX50
+	bool
+	select SOC_IMX5
+	select ARCH_MX50
+
+config	SOC_IMX51
+	bool
+	select SOC_IMX5
+	select ARCH_MX5
+	select ARCH_MX51
+
+config	SOC_IMX53
+	bool
+	select SOC_IMX5
+	select ARCH_MX5
+	select ARCH_MX53
 
 if ARCH_IMX_V4_V5
 
@@ -604,6 +642,207 @@ config MACH_VPR200
 	  Include support for VPR200 platform. This includes specific
 	  configurations for the board and its peripherals.
 
+comment "i.MX5 platforms:"
+
+config MACH_MX50_RDP
+	bool "Support MX50 reference design platform"
+	depends on BROKEN
+	select SOC_IMX50
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Include support for MX50 reference design platform (RDP) board. This
+	  includes specific configurations for the board and its peripherals.
+
+comment "i.MX51 machines:"
+
+config MACH_IMX51_DT
+	bool "Support i.MX51 platforms from device tree"
+	select SOC_IMX51
+	select USE_OF
+	select MACH_MX51_BABBAGE
+	help
+	  Include support for Freescale i.MX51 based platforms
+	  using the device tree for discovery
+
+config MACH_MX51_BABBAGE
+	bool "Support MX51 BABBAGE platforms"
+	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Include support for MX51 Babbage platform, also known as MX51EVK in
+	  u-boot. This includes specific configurations for the board and its
+	  peripherals.
+
+config MACH_MX51_3DS
+	bool "Support MX51PDK (3DS)"
+	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_DEBUG_BOARD
+	help
+	  Include support for MX51PDK (3DS) platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_EUKREA_CPUIMX51
+	bool "Support Eukrea CPUIMX51 module"
+	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Include support for Eukrea CPUIMX51 platform. This includes
+	  specific configurations for the module and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX51
+	default MACH_EUKREA_MBIMX51_BASEBOARD
+
+config MACH_EUKREA_MBIMX51_BASEBOARD
+	prompt "Eukrea MBIMX51 development board"
+	bool
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select LEDS_GPIO_REGISTER
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMX51 evaluation board.
+
+endchoice
+
+config MACH_EUKREA_CPUIMX51SD
+	bool "Support Eukrea CPUIMX51SD module"
+	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Include support for Eukrea CPUIMX51SD platform. This includes
+	  specific configurations for the module and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX51SD
+	default MACH_EUKREA_MBIMXSD51_BASEBOARD
+
+config MACH_EUKREA_MBIMXSD51_BASEBOARD
+	prompt "Eukrea MBIMXSD development board"
+	bool
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select LEDS_GPIO_REGISTER
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
+endchoice
+
+config MX51_EFIKA_COMMON
+	bool
+	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_PATA_IMX
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_ULPI if USB_ULPI
+
+config MACH_MX51_EFIKAMX
+	bool "Support MX51 Genesi Efika MX nettop"
+	select LEDS_GPIO_REGISTER
+	select MX51_EFIKA_COMMON
+	help
+	  Include support for Genesi Efika MX nettop. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX51_EFIKASB
+	bool "Support MX51 Genesi Efika Smartbook"
+	select LEDS_GPIO_REGISTER
+	select MX51_EFIKA_COMMON
+	help
+	  Include support for Genesi Efika Smartbook. This includes specific
+	  configurations for the board and its peripherals.
+
+comment "i.MX53 machines:"
+
+config MACH_IMX53_DT
+	bool "Support i.MX53 platforms from device tree"
+	select SOC_IMX53
+	select USE_OF
+	select MACH_MX53_ARD
+	select MACH_MX53_EVK
+	select MACH_MX53_LOCO
+	select MACH_MX53_SMD
+	help
+	  Include support for Freescale i.MX53 based platforms
+	  using the device tree for discovery
+
+config MACH_MX53_EVK
+	bool "Support MX53 EVK platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select LEDS_GPIO_REGISTER
+	help
+	  Include support for MX53 EVK platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX53_SMD
+	bool "Support MX53 SMD platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	help
+	  Include support for MX53 SMD platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX53_LOCO
+	bool "Support MX53 LOCO platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
+	select LEDS_GPIO_REGISTER
+	help
+	  Include support for MX53 LOCO platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX53_ARD
+	bool "Support MX53 ARD platforms"
+	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_GPIO_KEYS
+	help
+	  Include support for MX53 ARD platform. This includes specific
+	  configurations for the board and its peripherals.
+
 comment "i.MX6 family:"
 
 config SOC_IMX6Q
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index aba7321..9cf630a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
 obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o
 
+obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
+
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
@@ -71,3 +73,22 @@ obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
 obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
+
+# i.MX5 based machines
+obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
+obj-$(CONFIG_MACH_MX51_3DS) += mach-mx51_3ds.o
+obj-$(CONFIG_MACH_MX53_EVK) += mach-mx53_evk.o
+obj-$(CONFIG_MACH_MX53_SMD) += mach-mx53_smd.o
+obj-$(CONFIG_MACH_MX53_LOCO) += mach-mx53_loco.o
+obj-$(CONFIG_MACH_MX53_ARD) += mach-mx53_ard.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += mach-cpuimx51.o
+obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd-baseboard.o
+obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
+obj-$(CONFIG_MACH_MX51_EFIKAMX) += mach-mx51_efikamx.o
+obj-$(CONFIG_MACH_MX51_EFIKASB) += mach-mx51_efikasb.o
+obj-$(CONFIG_MACH_MX50_RDP) += mach-mx50_rdp.o
+
+obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
+obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 22d8588..2c12b78 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -18,6 +18,18 @@ zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
 
+zreladdr-$(CONFIG_SOC_IMX50)	+= 0x70008000
+params_phys-$(CONFIG_SOC_IMX50)	:= 0x70000100
+initrd_phys-$(CONFIG_SOC_IMX50)	:= 0x70800000
+
+zreladdr-$(CONFIG_SOC_IMX51)	+= 0x90008000
+params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
+initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
+
+zreladdr-$(CONFIG_SOC_IMX53)	+= 0x70008000
+params_phys-$(CONFIG_SOC_IMX53)	:= 0x70000100
+initrd_phys-$(CONFIG_SOC_IMX53)	:= 0x70800000
+
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
 initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-imx/clock-mx51-mx53.c
similarity index 99%
rename from arch/arm/mach-mx5/clock-mx51-mx53.c
rename to arch/arm/mach-imx/clock-mx51-mx53.c
index 2aacf41..a2c654d 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-imx/clock-mx51-mx53.c
@@ -23,7 +23,7 @@
 #include <mach/common.h>
 #include <mach/clock.h>
 
-#include "crm_regs.h"
+#include "crm-regs-imx5.h"
 
 /* External clock values passed-in by the board code */
 static unsigned long external_high_reference, external_low_reference;
diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-imx/cpu-imx5.c
similarity index 100%
rename from arch/arm/mach-mx5/cpu.c
rename to arch/arm/mach-imx/cpu-imx5.c
diff --git a/arch/arm/mach-mx5/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
similarity index 100%
rename from arch/arm/mach-mx5/cpu_op-mx51.c
rename to arch/arm/mach-imx/cpu_op-mx51.c
diff --git a/arch/arm/mach-mx5/cpu_op-mx51.h b/arch/arm/mach-imx/cpu_op-mx51.h
similarity index 100%
rename from arch/arm/mach-mx5/cpu_op-mx51.h
rename to arch/arm/mach-imx/cpu_op-mx51.h
diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-imx/crm-regs-imx5.h
similarity index 100%
rename from arch/arm/mach-mx5/crm_regs.h
rename to arch/arm/mach-imx/crm-regs-imx5.h
diff --git a/arch/arm/mach-mx5/devices-imx50.h b/arch/arm/mach-imx/devices-imx50.h
similarity index 100%
rename from arch/arm/mach-mx5/devices-imx50.h
rename to arch/arm/mach-imx/devices-imx50.h
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-imx/devices-imx51.h
similarity index 100%
rename from arch/arm/mach-mx5/devices-imx51.h
rename to arch/arm/mach-imx/devices-imx51.h
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-imx/devices-imx53.h
similarity index 100%
rename from arch/arm/mach-mx5/devices-imx53.h
rename to arch/arm/mach-imx/devices-imx53.h
diff --git a/arch/arm/mach-mx5/efika.h b/arch/arm/mach-imx/efika.h
similarity index 100%
rename from arch/arm/mach-mx5/efika.h
rename to arch/arm/mach-imx/efika.h
diff --git a/arch/arm/mach-mx5/ehci.c b/arch/arm/mach-imx/ehci-imx5.c
similarity index 100%
rename from arch/arm/mach-mx5/ehci.c
rename to arch/arm/mach-imx/ehci-imx5.c
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx51-baseboard.c
similarity index 100%
rename from arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
rename to arch/arm/mach-imx/eukrea_mbimx51-baseboard.c
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
similarity index 100%
rename from arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
rename to arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
similarity index 100%
rename from arch/arm/mach-mx5/imx51-dt.c
rename to arch/arm/mach-imx/imx51-dt.c
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
similarity index 100%
rename from arch/arm/mach-mx5/imx53-dt.c
rename to arch/arm/mach-imx/imx53-dt.c
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-imx/mach-cpuimx51.c
similarity index 100%
rename from arch/arm/mach-mx5/board-cpuimx51.c
rename to arch/arm/mach-imx/mach-cpuimx51.c
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
similarity index 100%
rename from arch/arm/mach-mx5/board-cpuimx51sd.c
rename to arch/arm/mach-imx/mach-cpuimx51sd.c
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-imx/mach-mx50_rdp.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx50_rdp.c
rename to arch/arm/mach-imx/mach-mx50_rdp.c
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx51_3ds.c
rename to arch/arm/mach-imx/mach-mx51_3ds.c
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx51_babbage.c
rename to arch/arm/mach-imx/mach-mx51_babbage.c
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-imx/mach-mx51_efikamx.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx51_efikamx.c
rename to arch/arm/mach-imx/mach-mx51_efikamx.c
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-imx/mach-mx51_efikasb.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx51_efikasb.c
rename to arch/arm/mach-imx/mach-mx51_efikasb.c
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx53_ard.c
rename to arch/arm/mach-imx/mach-mx53_ard.c
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-imx/mach-mx53_evk.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx53_evk.c
rename to arch/arm/mach-imx/mach-mx53_evk.c
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-imx/mach-mx53_loco.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx53_loco.c
rename to arch/arm/mach-imx/mach-mx53_loco.c
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-imx/mach-mx53_smd.c
similarity index 100%
rename from arch/arm/mach-mx5/board-mx53_smd.c
rename to arch/arm/mach-imx/mach-mx53_smd.c
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-imx/mm-imx5.c
similarity index 100%
rename from arch/arm/mach-mx5/mm.c
rename to arch/arm/mach-imx/mm-imx5.c
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-imx/mx51_efika.c
similarity index 100%
rename from arch/arm/mach-mx5/mx51_efika.c
rename to arch/arm/mach-imx/mx51_efika.c
diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-imx/pm-imx5.c
similarity index 58%
rename from arch/arm/mach-mx5/system.c
rename to arch/arm/mach-imx/pm-imx5.c
index 144ebeb..3d57b5d 100644
--- a/arch/arm/mach-mx5/system.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -1,8 +1,6 @@
 /*
- * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
+ *  Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
  * Version 2 or later at the following locations:
@@ -10,14 +8,22 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
-#include <linux/platform_device.h>
+#include <linux/suspend.h>
+#include <linux/clk.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+#include <linux/err.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 #include <mach/common.h>
-#include "crm_regs.h"
+#include <mach/hardware.h>
+#include "crm-regs-imx5.h"
+
+static struct clk *gpc_dvfs_clk;
 
-/* set cpu low power mode before WFI instruction. This function is called
-  * mx5 because it can be used for mx50, mx51, and mx53.*/
+/*
+ * set cpu low power mode before WFI instruction. This function is called
+ * mx5 because it can be used for mx50, mx51, and mx53.
+ */
 void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 {
 	u32 plat_lpc, arm_srpgcr, ccm_clpcr;
@@ -83,3 +89,68 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 		__raw_writel(empgc1, MXC_SRPG_EMPGC1_SRPGCR);
 	}
 }
+
+static int mx5_suspend_prepare(void)
+{
+	return clk_enable(gpc_dvfs_clk);
+}
+
+static int mx5_suspend_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		mx5_cpu_lp_set(STOP_POWER_OFF);
+		break;
+	case PM_SUSPEND_STANDBY:
+		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (state == PM_SUSPEND_MEM) {
+		local_flush_tlb_all();
+		flush_cache_all();
+
+		/*clear the EMPGC0/1 bits */
+		__raw_writel(0, MXC_SRPG_EMPGC0_SRPGCR);
+		__raw_writel(0, MXC_SRPG_EMPGC1_SRPGCR);
+	}
+	cpu_do_idle();
+	return 0;
+}
+
+static void mx5_suspend_finish(void)
+{
+	clk_disable(gpc_dvfs_clk);
+}
+
+static int mx5_pm_valid(suspend_state_t state)
+{
+	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
+}
+
+static const struct platform_suspend_ops mx5_suspend_ops = {
+	.valid = mx5_pm_valid,
+	.prepare = mx5_suspend_prepare,
+	.enter = mx5_suspend_enter,
+	.finish = mx5_suspend_finish,
+};
+
+static int __init mx5_pm_init(void)
+{
+	if (!cpu_is_mx51() && !cpu_is_mx53())
+		return 0;
+
+	if (gpc_dvfs_clk == NULL)
+		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
+
+	if (!IS_ERR(gpc_dvfs_clk)) {
+		if (cpu_is_mx51())
+			suspend_set_ops(&mx5_suspend_ops);
+	} else
+		return -EPERM;
+
+	return 0;
+}
+device_initcall(mx5_pm_init);
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
deleted file mode 100644
index af0c212..0000000
--- a/arch/arm/mach-mx5/Kconfig
+++ /dev/null
@@ -1,244 +0,0 @@
-if ARCH_MX5
-
-# ARCH_MX5/50/53 are left to mark places where prevent multi-soc in single
-# image. So for most time, SOC_IMX50/51/53 should be used.
-
-config ARCH_MX51
-	bool
-
-config ARCH_MX50
-	bool
-
-config ARCH_MX53
-	bool
-
-config SOC_IMX50
-	bool
-	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
-	select MXC_TZIC
-	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX_V2
-	select ARCH_HAS_CPUFREQ
-	select ARCH_MX50
-
-config	SOC_IMX51
-	bool
-	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
-	select MXC_TZIC
-	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX_V2
-	select ARCH_HAS_CPUFREQ
-	select ARCH_MX51
-
-config	SOC_IMX53
-	bool
-	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
-	select MXC_TZIC
-	select ARCH_MXC_IOMUX_V3
-	select ARCH_MX53
-
-#comment "i.MX50 machines:"
-
-config MACH_MX50_RDP
-	bool "Support MX50 reference design platform"
-	depends on BROKEN
-	select SOC_IMX50
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Include support for MX50 reference design platform (RDP) board. This
-	  includes specific configurations for the board and its peripherals.
-
-comment "i.MX51 machines:"
-
-config MACH_IMX51_DT
-	bool "Support i.MX51 platforms from device tree"
-	select SOC_IMX51
-	select USE_OF
-	select MACH_MX51_BABBAGE
-	help
-	  Include support for Freescale i.MX51 based platforms
-	  using the device tree for discovery
-
-config MACH_MX51_BABBAGE
-	bool "Support MX51 BABBAGE platforms"
-	select SOC_IMX51
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Include support for MX51 Babbage platform, also known as MX51EVK in
-	  u-boot. This includes specific configurations for the board and its
-	  peripherals.
-
-config MACH_MX51_3DS
-	bool "Support MX51PDK (3DS)"
-	select SOC_IMX51
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_KEYPAD
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_DEBUG_BOARD
-	help
-	  Include support for MX51PDK (3DS) platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_EUKREA_CPUIMX51
-	bool "Support Eukrea CPUIMX51 module"
-	select SOC_IMX51
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Include support for Eukrea CPUIMX51 platform. This includes
-	  specific configurations for the module and its peripherals.
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX51
-	default MACH_EUKREA_MBIMX51_BASEBOARD
-
-config MACH_EUKREA_MBIMX51_BASEBOARD
-	prompt "Eukrea MBIMX51 development board"
-	bool
-	select IMX_HAVE_PLATFORM_IMX_KEYPAD
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMX51 evaluation board.
-
-endchoice
-
-config MACH_EUKREA_CPUIMX51SD
-	bool "Support Eukrea CPUIMX51SD module"
-	select SOC_IMX51
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Include support for Eukrea CPUIMX51SD platform. This includes
-	  specific configurations for the module and its peripherals.
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX51SD
-	default MACH_EUKREA_MBIMXSD51_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD51_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
-config MX51_EFIKA_COMMON
-	bool
-	select SOC_IMX51
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_PATA_IMX
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
-
-config MACH_MX51_EFIKAMX
-	bool "Support MX51 Genesi Efika MX nettop"
-	select LEDS_GPIO_REGISTER
-	select MX51_EFIKA_COMMON
-	help
-	  Include support for Genesi Efika MX nettop. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX51_EFIKASB
-	bool "Support MX51 Genesi Efika Smartbook"
-	select LEDS_GPIO_REGISTER
-	select MX51_EFIKA_COMMON
-	help
-	  Include support for Genesi Efika Smartbook. This includes specific
-	  configurations for the board and its peripherals.
-
-comment "i.MX53 machines:"
-
-config MACH_IMX53_DT
-	bool "Support i.MX53 platforms from device tree"
-	select SOC_IMX53
-	select USE_OF
-	select MACH_MX53_ARD
-	select MACH_MX53_EVK
-	select MACH_MX53_LOCO
-	select MACH_MX53_SMD
-	help
-	  Include support for Freescale i.MX53 based platforms
-	  using the device tree for discovery
-
-config MACH_MX53_EVK
-	bool "Support MX53 EVK platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  Include support for MX53 EVK platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX53_SMD
-	bool "Support MX53 SMD platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	help
-	  Include support for MX53 SMD platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX53_LOCO
-	bool "Support MX53 LOCO platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_GPIO_KEYS
-	select LEDS_GPIO_REGISTER
-	help
-	  Include support for MX53 LOCO platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX53_ARD
-	bool "Support MX53 ARD platforms"
-	select SOC_IMX53
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select IMX_HAVE_PLATFORM_GPIO_KEYS
-	help
-	  Include support for MX53 ARD platform. This includes specific
-	  configurations for the board and its peripherals.
-
-endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
deleted file mode 100644
index 0fc6080..0000000
--- a/arch/arm/mach-mx5/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
-
-obj-$(CONFIG_PM) += pm-imx5.o
-obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
-obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
-obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
-obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
-obj-$(CONFIG_MACH_MX53_SMD) += board-mx53_smd.o
-obj-$(CONFIG_MACH_MX53_LOCO) += board-mx53_loco.o
-obj-$(CONFIG_MACH_MX53_ARD) += board-mx53_ard.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
-obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd-baseboard.o
-obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
-obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
-obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
-obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
-
-obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
-obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
deleted file mode 100644
index ca207ca..0000000
--- a/arch/arm/mach-mx5/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-   zreladdr-$(CONFIG_ARCH_MX50)	+= 0x70008000
-params_phys-$(CONFIG_ARCH_MX50)	:= 0x70000100
-initrd_phys-$(CONFIG_ARCH_MX50)	:= 0x70800000
-   zreladdr-$(CONFIG_ARCH_MX51)	+= 0x90008000
-params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
-initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
-   zreladdr-$(CONFIG_ARCH_MX53)	+= 0x70008000
-params_phys-$(CONFIG_ARCH_MX53)	:= 0x70000100
-initrd_phys-$(CONFIG_ARCH_MX53)	:= 0x70800000
diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
deleted file mode 100644
index 98052fc..0000000
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- *  Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later@the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-#include <linux/suspend.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include "crm_regs.h"
-
-static struct clk *gpc_dvfs_clk;
-
-static int mx5_suspend_prepare(void)
-{
-	return clk_enable(gpc_dvfs_clk);
-}
-
-static int mx5_suspend_enter(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_MEM:
-		mx5_cpu_lp_set(STOP_POWER_OFF);
-		break;
-	case PM_SUSPEND_STANDBY:
-		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (state == PM_SUSPEND_MEM) {
-		local_flush_tlb_all();
-		flush_cache_all();
-
-		/*clear the EMPGC0/1 bits */
-		__raw_writel(0, MXC_SRPG_EMPGC0_SRPGCR);
-		__raw_writel(0, MXC_SRPG_EMPGC1_SRPGCR);
-	}
-	cpu_do_idle();
-	return 0;
-}
-
-static void mx5_suspend_finish(void)
-{
-	clk_disable(gpc_dvfs_clk);
-}
-
-static int mx5_pm_valid(suspend_state_t state)
-{
-	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
-}
-
-static const struct platform_suspend_ops mx5_suspend_ops = {
-	.valid = mx5_pm_valid,
-	.prepare = mx5_suspend_prepare,
-	.enter = mx5_suspend_enter,
-	.finish = mx5_suspend_finish,
-};
-
-static int __init mx5_pm_init(void)
-{
-	if (gpc_dvfs_clk == NULL)
-		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
-
-	if (!IS_ERR(gpc_dvfs_clk)) {
-		if (cpu_is_mx51())
-			suspend_set_ops(&mx5_suspend_ops);
-	} else
-		return -EPERM;
-
-	return 0;
-}
-device_initcall(mx5_pm_init);
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index a08a951..fdde4d1 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -17,25 +17,16 @@ config ARCH_IMX_V4_V5
 	  and ARMv5 SoCs
 
 config ARCH_IMX_V6_V7
-	bool "i.MX3, i.MX6"
+	bool "i.MX3, i.MX5, i.MX6"
 	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
 	help
-	  This enables support for systems based on the Freescale i.MX3 and i.MX6
-	  family.
-
-config ARCH_MX5
-	bool "i.MX50, i.MX51, i.MX53"
-	select AUTO_ZRELADDR
-	select ARM_PATCH_PHYS_VIRT
-	help
-	  This enables support for machines using Freescale's i.MX50 and i.MX53
-	  processors.
+	  This enables support for systems based on the Freescale i.MX3, i.MX5
+	  and i.MX6 family.
 
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
-source "arch/arm/mach-mx5/Kconfig"
 
 endmenu
 
-- 
1.7.7.1
