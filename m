From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:23 -0800
Subject: [PATCH 05/13] ARM: LPC32XX: arch Kconfig, plat Kconfig, and makefiles
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added Kconfig for the LPC32XX arch, Kconfig.plat for platforms based
on the LPC32XX, and the initial makefiles. Kconfig.plat currently
supports the Phytec PHY3250 platform.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/Kconfig       |  158 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/Kconfig.plat  |   98 ++++++++++++++++++++++
 arch/arm/mach-lpc32xx/Makefile      |    9 ++
 arch/arm/mach-lpc32xx/Makefile.boot |    4 +
 4 files changed, 269 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
new file mode 100644
index 0000000..a277885
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -0,0 +1,158 @@
+if ARCH_LPC32XX
+
+menu "LPC32XX chip options"
+
+config ARCH_LPC32XX_IRAM_SIZE
+	int
+	default 131072 if ARCH_LPC32XX_20
+	default 262144 if ARCH_LPC32XX_30 || ARCH_LPC32XX_40 || ARCH_LPC32XX_50
+
+choice
+    prompt "Select 32x0 device variation"
+    default ARCH_LPC32XX_50
+
+	config ARCH_LPC32XX_20
+		bool "LPC3220"
+		help
+		 128K IRAM, no ethernet or LCD
+
+	config ARCH_LPC32XX_30
+		bool "LPC3230"
+		help
+		 256K IRAM and LCD, no ethernet
+
+	config ARCH_LPC32XX_40
+		bool "LPC3240"
+		help
+		 256K IRAM and ethernet, no LCD
+
+	config ARCH_LPC32XX_50
+		bool "LPC3250"
+		help
+		 256K IRAM and ethernet and LCD
+
+endchoice
+
+menu "Serial port configuration"
+
+menu "Individual UART enable selections"
+
+config ARCH_LPC32XX_HSUART1_ENABLE
+	bool "Enable high speed UART1"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+config ARCH_LPC32XX_HSUART2_ENABLE
+	bool "Enable high speed UART2"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+config ARCH_LPC32XX_UART3_ENABLE
+	bool "Enable standard UART3"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config ARCH_LPC32XX_UART4_ENABLE
+	bool "Enable standard UART4"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config ARCH_LPC32XX_UART5_ENABLE
+	bool "Enable standard UART5"
+	default y
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config ARCH_LPC32XX_UART6_ENABLE
+	bool "Enable standard UART6"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config ARCH_LPC32XX_HSUART7_ENABLE
+	bool "Enable high speed UART7"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+endmenu
+
+config ARCH_LPC32XX_UART6_IRDAMODE
+	bool "Use IRDA mode on UART6"
+	depends on ARCH_LPC32XX_UART6_ENABLE
+	help
+		Enables the IrDA modulator for UART6
+
+choice
+	prompt "Kernel uncompress status output UART selection"
+	default ARCH_LPC32XX_UNCOMP_U5
+
+	config ARCH_LPC32XX_UNCOMP_HSU1
+		bool "High speed UART 1"
+		help
+		 Kernel uncompress output is on high speed UART 1
+
+	config ARCH_LPC32XX_UNCOMP_HSU2
+		bool "High speed UART 2"
+		help
+		 Kernel uncompress output is on high speed UART 2
+
+	config ARCH_LPC32XX_UNCOMP_U3
+		bool "Standard UART 3"
+		help
+		 Kernel uncompress output is on standard UART 3
+
+	config ARCH_LPC32XX_UNCOMP_U4
+		bool "Standard UART 4"
+		help
+		 Kernel uncompress output is on standard UART 4
+
+	config ARCH_LPC32XX_UNCOMP_U5
+		bool "Standard UART 5"
+		help
+		 Kernel uncompress output is on standard UART 5
+
+	config ARCH_LPC32XX_UNCOMP_U6
+		bool "Standard UART 6"
+		help
+		 Kernel uncompress output is on standard UART 6
+
+	config ARCH_LPC32XX_UNCOMP_HSU7
+		bool "High speed UART 7"
+		help
+		 Kernel uncompress output is on high speed UART 7
+
+endchoice
+
+choice
+	prompt "debug output (printascii) UART selection"
+	default ARCH_LPC32XX_DEBUGO_U5
+
+	config ARCH_LPC32XX_DEBUGO_U3
+		bool "Standard UART 3"
+		help
+		 printascii messages are output on standard UART 3
+
+	config ARCH_LPC32XX_DEBUGO_U4
+		bool "Standard UART 4"
+		help
+		 printascii messages are output on standard UART 4
+
+	config ARCH_LPC32XX_DEBUGO_U5
+		bool "Standard UART 5"
+		help
+		 printascii messages are output on standard UART 5
+
+	config ARCH_LPC32XX_DEBUGO_U6
+		bool "Standard UART 6"
+		help
+		 printascii messages are output on standard UART 6
+
+endchoice
+
+endmenu
+
+endmenu
+
+source "arch/arm/mach-lpc32xx/Kconfig.plat"
+
+endif
+
diff --git a/arch/arm/mach-lpc32xx/Kconfig.plat b/arch/arm/mach-lpc32xx/Kconfig.plat
new file mode 100644
index 0000000..a67d1ad
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig.plat
@@ -0,0 +1,98 @@
+menu "LPC32XX platform choices"
+
+choice
+    prompt "Choose your board"
+    default MACH_PHY3250
+    help
+        This menu selects the LPC3250 board to support for this build
+
+    config MACH_PHY3250
+        bool "Phytec 3250 development board"
+	help
+	    Support for the Phytec 3250 development board
+
+endchoice
+
+choice
+	prompt "Phytec LCD module revisions"
+	depends on MACH_PHY3250
+	default PHY3250_QVGA_PANEL_1307_1
+	help
+	  Select one of the supported LCD panel revisions
+
+config PHY3250_QVGA_PANEL_1307_0
+	bool "1307.0 QVGA panel (portrait mode RGB565)"
+	help
+	  Use LCD module version 1307.0
+
+config PHY3250_QVGA_PANEL_1307_1
+	bool "1307.1 QVGA panel (portrait mode RGB565)"
+	help
+	  Use LCD module version 1307.1
+
+endchoice
+
+choice
+	prompt "Phytec CPU module revisions"
+	depends on MACH_PHY3250
+	default PHY3250_CPU_MODULE_1304_1
+	help
+	  Select one of the supported CPU module revisions
+
+config PHY3250_CPU_MODULE_1304_0
+	bool "1304.0 CPU module"
+	help
+	  Use CPU module version 1304.0
+
+config PHY3250_CPU_MODULE_1304_1
+	bool "1304.1 CPU module"
+	help
+	  Use CPU module version 1304.1
+
+endchoice
+
+choice
+	prompt "Phytec Carrier board revisions"
+	depends on MACH_PHY3250
+	default PHY3250_CARRIER_1305_3
+	help
+	  Select one of the supported carrier board revisions
+
+config PHY3250_CARRIER_1305_01
+	bool "1305.0 or 1305.1 carrier board"
+	help
+	  Use carrier board version 1305.0 or 1305.1
+
+config PHY3250_CARRIER_1305_2
+	bool "1305.2 carrier board"
+	help
+	  Use carrier board version 1305.2
+
+config PHY3250_CARRIER_1305_3
+	bool "1305.3 carrier board"
+	help
+	  Use carrier board version 1305.3
+
+endchoice
+
+choice
+	prompt "Internal IRAM use"
+	default MACH_LPC32XX_IRAM_RESERVED
+	depends on MACH_PHY3250
+
+config MACH_LPC32XX_IRAM_RESERVED
+	bool "IRAM is not used (reserved)"
+	help
+	  IRAM is not used for video or networking and can be used for
+	  other purposes or drivers
+
+config MACH_LPC32XX_IRAM_FOR_CLCD
+	bool "Use IRAM as a video frame buffer"
+	help
+	  IRAM will be used for the LCD frame buffer. If the required buffer
+	  size is larger than the size of IRAM, then SDRAM will be used
+	  instead.
+
+endchoice
+
+endmenu
diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
new file mode 100644
index 0000000..9c76c70
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= timer.o irq.o common.o serial.o clock.o
+obj-y				+= gpiolib.o pm.o pm_events.o suspend.o
+
+obj-$(CONFIG_MACH_PHY3250)	+= phy3250.o
+
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
new file mode 100644
index 0000000..b796b41
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Makefile.boot
@@ -0,0 +1,4 @@
+   zreladdr-y	:= 0x80008000
+params_phys-y	:= 0x80000100
+initrd_phys-y	:= 0x82000000
+
-- 
1.6.6
