From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 02:11:16 +0100
Subject: RFC [PATCH 2/9] Initial makefiles and Kconfigs for the lcp32xx mach
Message-ID: <083DF309106F364B939360100EC290F804F54D560B@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial makefiles and Kconfigs for the lcp32xx mach

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-lpc32xx/Kconfig       |  217 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/Kconfig.plat  |   78 +++++++++++++
 arch/arm/mach-lpc32xx/Makefile      |    9 ++
 arch/arm/mach-lpc32xx/Makefile.boot |    4 +
 4 files changed, 308 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig.plat
 create mode 100644 arch/arm/mach-lpc32xx/Makefile
 create mode 100644 arch/arm/mach-lpc32xx/Makefile.boot

diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
new file mode 100644
index 0000000..d55431c
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -0,0 +1,217 @@
+if ARCH_LPC32XX
+
+menu "LPC32XX chip options"
+
+config MACH_LPC32XX_IRAM_SIZE
+	int
+	default 128 if ARCH_LPC32XX_20
+	default 256 if ARCH_LPC32XX_30 || ARCH_LPC32XX_40 || ARCH_LPC32XX_50
+
+choice
+    prompt "Select 32x0 device variation"
+    default MACH_LPC32XX_50
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
+choice
+	prompt "Internal IRAM use"
+	default MACH_LPC32XX_IRAM_RESERVED
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
+config MACH_LPC32XX_IRAM_FOR_NET
+	bool "Use IRAM for network buffers"
+	help
+	  IRAM will be used for the nwetwork buffers. If the total combined
+	  size of the network buffers is larger than the size of IRAM, then
+	  SDRAM will be used instead.
+
+endchoice
+
+menu "Serial port configuration"
+
+menu "Individual UART enable selections"
+
+config MACH_LPC32XX_HSUART1_ENABLE
+	bool "Enable high speed UART1"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+config MACH_LPC32XX_HSUART2_ENABLE
+	bool "Enable high speed UART2"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+config MACH_LPC32XX_UART3_ENABLE
+	bool "Enable standard UART3"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config MACH_LPC32XX_UART4_ENABLE
+	bool "Enable standard UART4"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config MACH_LPC32XX_UART5_ENABLE
+	bool "Enable standard UART5"
+	default y
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config MACH_LPC32XX_UART6_ENABLE
+	bool "Enable standard UART6"
+	help
+	 Also enable 8250 serial support in drivers/serial
+
+config MACH_LPC32XX_HSUART7_ENABLE
+	bool "Enable high speed UART7"
+	help
+	 Also enable LPC32xx high speed serial support in drivers/serial
+
+endmenu
+
+config MACH_LPC32XX_UART6_IRDAMODE
+	bool "Use IRDA mode on UART6"
+	depends on MACH_LPC32XX_UART6_ENABLE
+	help
+		Enables the IrDA modulator for UART6
+
+choice
+	prompt "Kernel uncompress status output UART selection"
+	default UNCOMP_U5
+
+	config UNCOMP_HSU1
+		bool "High speed UART 1"
+		help
+		 Kernel uncompress output is on high speed UART 1
+
+	config UNCOMP_HSU2
+		bool "High speed UART 2"
+		help
+		 Kernel uncompress output is on high speed UART 2
+
+	config UNCOMP_U3
+		bool "Standard UART 3"
+		help
+		 Kernel uncompress output is on standard UART 3
+
+	config UNCOMP_U4
+		bool "Standard UART 4"
+		help
+		 Kernel uncompress output is on standard UART 4
+
+	config UNCOMP_U5
+		bool "Standard UART 5"
+		help
+		 Kernel uncompress output is on standard UART 5
+
+	config UNCOMP_U6
+		bool "Standard UART 6"
+		help
+		 Kernel uncompress output is on standard UART 6
+
+	config UNCOMP_HSU7
+		bool "High speed UART 7"
+		help
+		 Kernel uncompress output is on high speed UART 7
+
+endchoice
+
+choice
+	prompt "debug output (printascii) UART selection"
+	default DEBUGO_U5
+
+	config DEBUGO_U3
+		bool "Standard UART 3"
+		help
+		 printascii messages are output on standard UART 3
+
+	config DEBUGO_U4
+		bool "Standard UART 4"
+		help
+		 printascii messages are output on standard UART 4
+
+	config DEBUGO_U5
+		bool "Standard UART 5"
+		help
+		 printascii messages are output on standard UART 5
+
+	config DEBUGO_U6
+		bool "Standard UART 6"
+		help
+		 printascii messages are output on standard UART 6
+
+endchoice
+
+endmenu
+
+config NODES_SHIFT
+	default 0 if !ARCH_DISCONTIGMEM_ENABLE
+	default 2 if ARCH_DISCONTIGMEM_ENABLE
+
+config ARCH_DISCONTIGMEM_ENABLE
+ 	bool "Enable support for non-contiguous memory on 64Mx2 systems"
+ 	default n
+ 	help
+	    Enable this option for designs with DRAM devices on both DRAM
+            chip selects DYCS0 and DYCS1. Do not enable this option if you
+            only have 1 DRAM device on DYCS0
+
+choice
+    prompt "Select size of DRAMs"
+    default MACH_LPC32XX_DRAM_SIZE_64
+    depends on ARCH_DISCONTIGMEM_ENABLE
+    help
+	 Select the size of DRAM devices on DYCS0/1. Depending on the
+         selected device size, different mapping configurations are used.
+
+    config MACH_LPC32XX_DRAM_SIZE_32
+        bool "2 chips, 32MB/device (64MB total)"
+
+    config MACH_LPC32XX_DRAM_SIZE_64
+        bool "2 chips, 64MB/device (128MB total)"
+
+    config MACH_LPC32XX_DRAM_SIZE_128
+        bool "2 chips, 128MB/device (256MB total)"
+
+endchoice
+
+source "kernel/Kconfig.hz"
+
+endmenu
+
+source "arch/arm/mach-lpc32xx/Kconfig.plat"
+
+endif
+
diff --git a/arch/arm/mach-lpc32xx/Kconfig.plat b/arch/arm/mach-lpc32xx/Kconfig.plat
new file mode 100644
index 0000000..2098308
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig.plat
@@ -0,0 +1,78 @@
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
+	bool "1307.0 QVGA panel (RGB565)"
+	help
+	  Use LCD module version 1307.0
+
+config PHY3250_QVGA_PANEL_1307_1
+	bool "1307.1 QVGA panel (RGB565)"
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
+endmenu
diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
new file mode 100644
index 0000000..5acbf9f
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y				:= timer.o irq.o common.o serial.o clock.o
+obj-y				+= gpiolib.o
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
1.6.0.6
