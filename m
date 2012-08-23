From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 13:41:58 +0800
Subject: [PATCH v2 2/3] ARM: PRIMA2: adjust Kconfig to support select SoC
 features
In-Reply-To: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
References: <1345700519-667-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345700519-667-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Now we have primaII, but will include Marco and Polo in mach-prima2
as well. We add Kconfig menu so that we can select necessary SoC
features.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 fix typo;
 don't rename mach-prima2 to mach-sirf;
 make ARCH_PRIMA2 become an enable feature but not a choice of SoC types;

 arch/arm/Kconfig                  |   10 +++++-----
 arch/arm/configs/prima2_defconfig |    7 +++----
 arch/arm/mach-prima2/Kconfig      |   15 +++++++++++++++
 3 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-prima2/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb60148..2c1ca9f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -407,9 +407,8 @@ config ARCH_GEMINI
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
-config ARCH_PRIMA2
-	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
-	select CPU_V7
+config ARCH_SIRF
+	bool "CSR SiRF"
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
@@ -419,9 +418,8 @@ config ARCH_PRIMA2
 	select PINCTRL
 	select PINCTRL_SIRF
 	select USE_OF
-	select ZONE_DMA
 	help
-          Support for CSR SiRFSoC ARM Cortex A9 Platform
+	  Support for CSR SiRFprimaII/Marco/Polo platforms
 
 config ARCH_EBSA110
 	bool "EBSA-110"
@@ -1118,6 +1116,8 @@ source "arch/arm/mach-exynos/Kconfig"
 
 source "arch/arm/mach-shmobile/Kconfig"
 
+source "arch/arm/mach-prima2/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index c328ac6..807d4e2 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -1,4 +1,6 @@
 CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
@@ -8,9 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_ARCH_PRIMA2=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
+CONFIG_ARCH_SIRF=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
@@ -36,7 +36,6 @@ CONFIG_SPI=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_FILE_STORAGE=m
 CONFIG_USB_MASS_STORAGE=m
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
new file mode 100644
index 0000000..65438e1
--- /dev/null
+++ b/arch/arm/mach-prima2/Kconfig
@@ -0,0 +1,15 @@
+if ARCH_SIRF
+
+menu "CSR SiRF primaII/Marco/Polo Specific Features"
+
+config ARCH_PRIMA2
+	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
+	default y
+	select CPU_V7
+	select ZONE_DMA
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
+endmenu
+
+endif
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
