From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:05 +0100
Subject: [PATCH 08/62] ARM: davinci: use explicit 'select' for DA850_EVM
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DAVINCI_DA850_EVM board uses an unusual method to
enable the GPIO_PCA953X and KEYBOARD_GPIO_POLLED symbols,
which leads to the dependencies on these symbols being
ignored. As GPIO_PCA953X actually requires I2C, that
can lead to build failures when I2C is disabled.

This patch removes the duplicate symbol definitions
and instead adds equivalent 'select' statements that
are conditional on the underlying dependencies.

A different question whether we actually want to automatically
enable them at all or rather put them into defconfig,
but that should be a separate patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source at linux.davincidsp.com
---
 arch/arm/mach-davinci/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 3b98e34..df794e9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -163,6 +163,8 @@ config MACH_DAVINCI_DA850_EVM
 	bool "TI DA850/OMAP-L138/AM18x Reference Platform"
 	default ARCH_DAVINCI_DA850
 	depends on ARCH_DAVINCI_DA850
+	select GPIO_PCA953X if I2C
+	select KEYBOARD_GPIO_POLLED if GPIOLIB
 	help
 	  Say Y here to select the TI DA850/OMAP-L138/AM18x Evaluation Module.
 
@@ -209,11 +211,6 @@ config DA850_WL12XX
 	  Say Y if you want to use a wl1271 expansion card connected to the
 	  AM18x EVM.
 
-config GPIO_PCA953X
-	default MACH_DAVINCI_DA850_EVM
-
-config KEYBOARD_GPIO_POLLED
-	default MACH_DAVINCI_DA850_EVM
 
 config MACH_MITYOMAPL138
 	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
-- 
1.8.3.2
