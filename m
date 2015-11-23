From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 14:51:29 +0100
Subject: [PATCH] ARM: tegra: select USB_ULPI from EHCI rather than platform
Message-ID: <8693901.Fc4bDK8zzK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historic reasons, the tegra platform selects USB_ULPI from architecture
code, but that hasn't really made sense for a long time, as the only
user of that code is the Tegra EHCI driver that has its own Kconfig
symbol.

This removes the 'select' statements from mach-tegra and drivers/soc/tegra
and adds them with the device driver that actually needs them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Tegra maintainers, can you pick this up for 4.5? There is no real bug here,
but I found this when looking at something else in drivers/usb/phy.

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 11963667c6a9..32239aff1051 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -12,7 +12,5 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  This enables support for NVIDIA Tegra based systems.
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 7e35dfe52af5..d0c3c3e085e3 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -57,8 +57,6 @@ if ARM64
 config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	select PINCTRL_TEGRA124
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
 	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
@@ -68,8 +66,6 @@ config ARCH_TEGRA_132_SOC
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
 	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3bb08870148f..95e72d75e0a0 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -220,6 +220,8 @@ config USB_EHCI_TEGRA
        depends on ARCH_TEGRA
        select USB_EHCI_ROOT_HUB_TT
        select USB_PHY
+	select USB_ULPI
+	select USB_ULPI_VIEWPORT
        help
          This driver enables support for the internal USB Host Controllers
          found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
