From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Aug 2013 09:49:24 +0200
Subject: [PATCH] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
Message-ID: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                               |  15 +-
 arch/arm/Kconfig.debug                         |  16 ++
 arch/arm/Makefile                              |   1 +
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armv7-m.dtsi                 |  18 ++
 arch/arm/boot/dts/efm32gg-dk3750.dts           |  63 ++++++
 arch/arm/boot/dts/efm32gg.dtsi                 | 141 +++++++++++++
 arch/arm/configs/efm32_defconfig               | 104 ++++++++++
 arch/arm/mach-efm32/Makefile                   |   1 +
 arch/arm/mach-efm32/Makefile.boot              |   2 +
 arch/arm/mach-efm32/cmu.h                      |  15 ++
 arch/arm/mach-efm32/common.h                   |   1 +
 arch/arm/mach-efm32/dtmachine.c                |  31 +++
 arch/arm/mach-efm32/include/mach/debug-macro.S |  48 +++++
 arch/arm/mach-efm32/include/mach/entry-macro.S |   5 +
 arch/arm/mach-efm32/include/mach/io.h          |   6 +
 arch/arm/mach-efm32/include/mach/irqs.h        |   6 +
 arch/arm/mach-efm32/include/mach/timex.h       |   7 +
 arch/arm/mach-efm32/time.c                     | 261 +++++++++++++++++++++++++
 19 files changed, 741 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armv7-m.dtsi
 create mode 100644 arch/arm/boot/dts/efm32gg-dk3750.dts
 create mode 100644 arch/arm/boot/dts/efm32gg.dtsi
 create mode 100644 arch/arm/configs/efm32_defconfig
 create mode 100644 arch/arm/mach-efm32/Makefile
 create mode 100644 arch/arm/mach-efm32/Makefile.boot
 create mode 100644 arch/arm/mach-efm32/cmu.h
 create mode 100644 arch/arm/mach-efm32/common.h
 create mode 100644 arch/arm/mach-efm32/dtmachine.c
 create mode 100644 arch/arm/mach-efm32/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/io.h
 create mode 100644 arch/arm/mach-efm32/include/mach/irqs.h
 create mode 100644 arch/arm/mach-efm32/include/mach/timex.h
 create mode 100644 arch/arm/mach-efm32/time.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..d45cc5d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -404,6 +404,19 @@ config ARCH_EBSA110
 	  Ethernet interface, two PCMCIA sockets, two serial ports and a
 	  parallel port.
 
+config ARCH_EFM32
+	bool "Energy Micro Cortex M3 Platform"
+	depends on !MMU
+	select ARM_NVIC
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select CPU_V7M
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select NO_DMA
+	select NO_IOPORT
+	select USE_OF
+
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -1762,7 +1775,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE
 	range 11 64 if ARCH_SHMOBILE
 	default "12" if SOC_AM33XX
-	default "9" if SA1111
+	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 583f4a0..1d99e38 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -167,6 +167,22 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port in the DC21285 (Footbridge).
 
+	config DEBUG_EFM32_UART1
+		bool "Kernel low-level debugging messages via UART1 (ttyefm4)"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second UART port on efm32 based
+		  machines.
+
+	config DEBUG_EFM32_USART1
+		bool "Kernel low-level debugging messages via USART1 (ttyefm1)"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second USART port on efm32 based
+		  machines.
+
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6fd2cea..ae48049 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -152,6 +152,7 @@ machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
+machine-$(CONFIG_ARCH_EFM32)		+= efm32
 machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..dd3b47e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 	dove-cubox.dtb \
 	dove-dove-db.dtb
+dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
new file mode 100644
index 0000000..dc2cf8d
--- /dev/null
+++ b/arch/arm/boot/dts/armv7-m.dtsi
@@ -0,0 +1,18 @@
+#include "skeleton.dtsi"
+
+/ {
+	nvic: nv-interrupt-controller at 0xe0000000  {
+		compatible = "arm,armv7m-nvic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xe000e100 0xc00>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&nvic>;
+		ranges;
+	};
+};
diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
new file mode 100644
index 0000000..4ae1ffc
--- /dev/null
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -0,0 +1,63 @@
+/dts-v1/;
+#include "efm32gg.dtsi"
+
+/ {
+	model = "Energy Micro Giant Gecko Development Kit";
+	compatible = "efm32,dk3750";
+
+	chosen {
+		bootargs = "console=ttyefm4,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk uclinux.physaddr=0x8c400000 root=/dev/mtdblock0";
+	};
+
+	memory {
+		reg = <0x88000000 0x400000>;
+	};
+
+	soc {
+		adc at 0x40002000 {
+			status = "ok";
+		};
+
+		spi0: spi at 0x4000c000 { /* USART0 */
+			cs-gpios = <&gpio 68 1>; // E4
+			location = <1>;
+			status = "ok";
+
+			microsd at 0 {
+				compatible = "mmc-spi-slot";
+				spi-max-frequency = <100000>;
+				voltage-ranges = <3200 3400>;
+				broken-cd;
+				reg = <0>;
+			};
+		};
+
+		spi1: spi at 0x4000c400 { /* USART1 */
+			cs-gpios = <&gpio 51 1>; // D3
+			location = <1>;
+			status = "ok";
+
+			ks8851 at 0 {
+				compatible = "ks8851";
+				spi-max-frequency = <6000000>;
+				reg = <0>;
+				interrupt-parent = <&boardfpga>;
+				interrupts = <4>;
+			};
+		};
+
+		uart4: uart at 0x4000e400 { /* UART1 */
+			location = <2>;
+			status = "ok";
+		};
+
+		boardfpga: boardfpga at 0x80000000 {
+			compatible = "efm32board";
+			reg = <0x80000000 0x400>;
+			irq-gpios = <&gpio 64 1>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
new file mode 100644
index 0000000..a15151ae
--- /dev/null
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -0,0 +1,141 @@
+#include "armv7-m.dtsi"
+#include "dt-bindings/clock/efm32-cmu.h"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+	};
+
+	soc {
+		adc: adc at 0x40002000 {
+			compatible = "efm32,adc";
+			reg = <0x40002000 0x400>;
+			interrupts = <7>;
+			status = "disabled";
+		};
+
+		gpio: gpio at 0x40006000 {
+			compatible = "efm32,gpio";
+			reg = <0x40006000 0x1000>;
+			interrupts = <1 11>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			clocks = <&cmu clk_HFPERCLKGPIO>;
+			status = "ok";
+		};
+
+		spi0: spi at 0x4000c000 { /* USART0 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c000 0x400>;
+			interrupts = <3 4>;
+			clocks = <&cmu clk_HFPERCLKUSART0>;
+			status = "disabled";
+		};
+
+		spi1: spi at 0x4000c400 { /* USART1 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c400 0x400>;
+			interrupts = <15 16>;
+			clocks = <&cmu clk_HFPERCLKUSART1>;
+			status = "disabled";
+		};
+
+		spi2: spi at 40x4000c800 { /* USART2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "efm32,spi";
+			reg = <0x4000c800 0x400>;
+			interrupts = <18 19>;
+			clocks = <&cmu clk_HFPERCLKUSART2>;
+			status = "disabled";
+		};
+
+		uart0: uart at 0x4000c000 { /* USART0 */
+			compatible = "efm32,uart";
+			reg = <0x4000c000 0x400>;
+			interrupts = <3 4>;
+			clocks = <&cmu clk_HFPERCLKUSART0>;
+			status = "disabled";
+		};
+
+		uart1: uart at 0x4000c400 { /* USART1 */
+			compatible = "efm32,uart";
+			reg = <0x4000c400 0x400>;
+			interrupts = <15 16>;
+			clocks = <&cmu clk_HFPERCLKUSART1>;
+			status = "disabled";
+		};
+
+		uart2: uart at 40x4000c800 { /* USART2 */
+			compatible = "efm32,uart";
+			reg = <0x4000c800 0x400>;
+			interrupts = <18 19>;
+			clocks = <&cmu clk_HFPERCLKUSART2>;
+			status = "disabled";
+		};
+
+		uart3: uart at 0x4000e000 { /* UART0 */
+			compatible = "efm32,uart";
+			reg = <0x4000e000 0x400>;
+			interrupts = <20 21>;
+			clocks = <&cmu clk_HFPERCLKUART0>;
+			status = "disabled";
+		};
+
+		uart4: uart at 0x4000e400 { /* UART1 */
+			compatible = "efm32,uart";
+			reg = <0x4000e400 0x400>;
+			interrupts = <22 23>;
+			clocks = <&cmu clk_HFPERCLKUART1>;
+			status = "disabled";
+		};
+
+		timer0: timer at 40010000 {
+			compatible = "efm32,timer";
+			reg = <0x40010000 0x400>;
+			interrupts = <2>;
+			clocks = <&cmu clk_HFPERCLKTIMER0>;
+		};
+
+		timer1: timer at 40010400 {
+			compatible = "efm32,timer";
+			reg = <0x40010400 0x400>;
+			interrupts = <12>;
+			clocks = <&cmu clk_HFPERCLKTIMER1>;
+		};
+
+		timer2: timer at 40010800 {
+			compatible = "efm32,timer";
+			reg = <0x40010800 0x400>;
+			interrupts = <13>;
+			clocks = <&cmu clk_HFPERCLKTIMER2>;
+		};
+
+		timer3: timer at 40010c00 {
+			compatible = "efm32,timer";
+			reg = <0x40010c00 0x400>;
+			interrupts = <14>;
+			clocks = <&cmu clk_HFPERCLKTIMER3>;
+		};
+
+		cmu: cmu at 400c8000 {
+			compatible = "efm32gg,cmu";
+			reg = <0x400c8000 0x400>;
+			interrupts = <32>;
+			#clock-cells = <1>;
+		};
+	};
+};
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
new file mode 100644
index 0000000..b31af07
--- /dev/null
+++ b/arch/arm/configs/efm32_defconfig
@@ -0,0 +1,104 @@
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_LOG_BUF_SHIFT=12
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_UID16 is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLUB_CPU_PARTIAL is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_MMU is not set
+CONFIG_ARCH_EFM32=y
+# CONFIG_KUSER_HELPERS is not set
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x88000000
+CONFIG_DRAM_SIZE=0x00400000
+CONFIG_FLASH_MEM_BASE=0x8c000000
+CONFIG_FLASH_SIZE=0x01000000
+CONFIG_PREEMPT=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_XIP_KERNEL=y
+CONFIG_XIP_PHYS_ADDR=0x8c000000
+CONFIG_BINFMT_FLAT=y
+CONFIG_BINFMT_SHARED_FLAT=y
+# CONFIG_COREDUMP is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FW_LOADER is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_ROM=y
+CONFIG_MTD_UCLINUX=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+CONFIG_KS8851=y
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_EFM32_UART=y
+CONFIG_SERIAL_EFM32_UART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_EFM32=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_ROMFS_FS=y
+CONFIG_ROMFS_BACKED_BY_MTD=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
new file mode 100644
index 0000000..419e900
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile
@@ -0,0 +1 @@
+obj-y += dtmachine.o time.o
diff --git a/arch/arm/mach-efm32/Makefile.boot b/arch/arm/mach-efm32/Makefile.boot
new file mode 100644
index 0000000..1d56a92
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile.boot
@@ -0,0 +1,2 @@
+# This file is still needed because we cannot select ARCH_MULTIPLATFORM (as it
+# depends on MMU) and then this file is sourced in arch/arm/boot/Makefile
diff --git a/arch/arm/mach-efm32/cmu.h b/arch/arm/mach-efm32/cmu.h
new file mode 100644
index 0000000..a7e5741
--- /dev/null
+++ b/arch/arm/mach-efm32/cmu.h
@@ -0,0 +1,15 @@
+/*
+ * Register definition for efm32's CMU component
+ */
+
+#define CMU_OSCENCMD		0x20
+#define CMU_OSCENCMD_HFXOEN		0x00000004
+
+#define CMU_CMD			0x24
+#define CMU_CMD_HFCLKSEL_HFXO		0x00000002
+
+#define CMU_STATUS		0x2c
+#define CMU_STATUS_HFRCOSEL		0x00000400
+#define CMU_STATUS_HFXOSEL		0x00000800
+
+#define CMU_HFPERCLKEN0		0x44
diff --git a/arch/arm/mach-efm32/common.h b/arch/arm/mach-efm32/common.h
new file mode 100644
index 0000000..e8ce15e
--- /dev/null
+++ b/arch/arm/mach-efm32/common.h
@@ -0,0 +1 @@
+void efm32_timer_init(void);
diff --git a/arch/arm/mach-efm32/dtmachine.c b/arch/arm/mach-efm32/dtmachine.c
new file mode 100644
index 0000000..d45f0b5
--- /dev/null
+++ b/arch/arm/mach-efm32/dtmachine.c
@@ -0,0 +1,31 @@
+#include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+
+#include <asm/v7m.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+static void __init efm32_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *const efm32gg_compat[] __initconst = {
+	"efm32,dk3750",
+	NULL
+};
+
+DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
+	.init_irq = irqchip_init,
+	.init_time = efm32_timer_init,
+	.init_machine = efm32_init,
+	.dt_compat = efm32gg_compat,
+	.restart = armv7m_restart,
+MACHINE_END
diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
new file mode 100644
index 0000000..c58915c
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/debug-macro.S
@@ -0,0 +1,48 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define UARTn_CMD		0x000c
+#define UARTn_CMD_TXEN			0x0004
+
+#define	UARTn_STATUS		0x0010
+#define	UARTn_STATUS_TXC		0x0020
+#define	UARTn_STATUS_TXBL		0x0040
+
+#define	UARTn_TXDATA		0x0034
+
+		.macro	addruart, rx, tmp
+#if defined(CONFIG_DEBUG_EFM32_USART1)
+		ldr	\rx, =(0x4000c400)		/* USART1 */
+#elif defined(CONFIG_DEBUG_EFM32_UART1)
+		ldr	\rx, =(0x4000e400)		/* UART1 */
+#else
+#error "No debug port configured"
+#endif
+		/*
+		 * enable TX. The driver might disable that to save energy. We
+		 * don't care about disabling at the end as during debug power
+		 * consumption isn't that important.
+		 */
+		ldr	\tmp, =(UARTn_CMD_TXEN)
+		str	\tmp, [\rx, #UARTn_CMD]
+		.endm
+
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #UARTn_TXDATA]
+		.endm
+
+		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #UARTn_STATUS]
+		tst	\rd, #UARTn_STATUS_TXBL
+		beq	1001b
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldr	\rd, [\rx, UARTn_STATUS]
+		tst	\rd, #UARTn_STATUS_TXC
+		bne	1001b
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
new file mode 100644
index 0000000..f0c0f7d
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/entry-macro.S
@@ -0,0 +1,5 @@
+		.macro	get_irqnr_preamble, base, tmp
+		.endm
+
+		.macro	arch_ret_to_user, tmp1, tmp2
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/io.h b/arch/arm/mach-efm32/include/mach/io.h
new file mode 100644
index 0000000..bc3519b
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/io.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IO_H__
+#define __MACH_IO_H__
+
+#define __mem_pci(a)		(a)
+
+#endif /* __MACH_IO_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/irqs.h b/arch/arm/mach-efm32/include/mach/irqs.h
new file mode 100644
index 0000000..e33ed12
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/irqs.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IRQS_H__
+#define __MACH_IRQS_H__
+
+#define NR_IRQS			82
+
+#endif /* __MACH_IRQS_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/timex.h b/arch/arm/mach-efm32/include/mach/timex.h
new file mode 100644
index 0000000..b408dce
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/timex.h
@@ -0,0 +1,7 @@
+#ifndef __MACH_TIMEX_H__
+#define __MACH_TIMEX_H__
+
+/* just a bogus value */
+#define CLOCK_TICK_RATE	12345678
+
+#endif /* __MACH_TIMEX_H__ */
diff --git a/arch/arm/mach-efm32/time.c b/arch/arm/mach-efm32/time.c
new file mode 100644
index 0000000..db96dfb
--- /dev/null
+++ b/arch/arm/mach-efm32/time.c
@@ -0,0 +1,261 @@
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+#include <linux/clk/efm32.h>
+
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+#define BASEADDR_TIMER(n)		IOMEM(0x40010000 + (n) * 0x400)
+
+#define TIMERn_CTRL			0x00
+#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
+#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
+#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
+#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
+#define TIMERn_CTRL_OSMEN			0x00000010
+#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
+#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
+#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
+
+#define TIMERn_CMD			0x04
+#define TIMERn_CMD_START			0x1
+#define TIMERn_CMD_STOP				0x2
+
+#define TIMERn_IEN			0x0c
+#define TIMERn_IF			0x10
+#define TIMERn_IFS			0x14
+#define TIMERn_IFC			0x18
+#define TIMERn_IRQ_UF				0x2
+#define TIMERn_IRQ_OF				0x1
+
+#define TIMERn_TOP			0x1c
+#define TIMERn_CNT			0x24
+
+#define TIMER_CLOCKSOURCE	0
+#define TIMER_CLOCKEVENT	1
+
+struct efm32_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	unsigned periodic_top;
+};
+
+static void efm32_clock_event_set_mode(enum clock_event_mode mode,
+				       struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+		writel_relaxed(ddata->periodic_top, ddata->base + TIMERn_TOP);
+		writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+			       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+			       TIMERn_CTRL_MODE_DOWN,
+			       ddata->base + TIMERn_CTRL);
+		writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+		writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+			       TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+			       TIMERn_CTRL_OSMEN |
+			       TIMERn_CTRL_MODE_DOWN,
+			       ddata->base + TIMERn_CTRL);
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static int efm32_clock_event_set_next_event(unsigned long evt,
+					    struct clock_event_device *evtdev)
+{
+	struct efm32_clock_event_ddata *ddata =
+		container_of(evtdev, struct efm32_clock_event_ddata, evtdev);
+
+	writel_relaxed(TIMERn_CMD_STOP, ddata->base + TIMERn_CMD);
+	writel_relaxed(evt, ddata->base + TIMERn_CNT);
+	writel_relaxed(TIMERn_CMD_START, ddata->base + TIMERn_CMD);
+
+	return 0;
+}
+
+static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
+{
+	struct efm32_clock_event_ddata *ddata = dev_id;
+
+	writel_relaxed(TIMERn_IRQ_UF, ddata->base + TIMERn_IFC);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct efm32_clock_event_ddata clock_event_ddata = {
+	.evtdev = {
+		.name = "efm32 clockevent",
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_MODE_PERIODIC,
+		.set_mode = efm32_clock_event_set_mode,
+		.set_next_event = efm32_clock_event_set_next_event,
+		.rating = 200,
+	},
+};
+
+static struct irqaction efm32_clock_event_irq = {
+	.name = "efm32 clockevent",
+	.flags = IRQF_TIMER,
+	.handler = efm32_clock_event_handler,
+	.dev_id = &clock_event_ddata,
+};
+
+static int efm32_timer_clocksource_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clocksource\n");
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clocksource\n");
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("failed to map registers for clocksource\n");
+		goto err_iomap;
+	}
+
+	writel_relaxed(TIMERn_CTRL_PRESC_1024 |
+			TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+			TIMERn_CTRL_MODE_UP, base + TIMERn_CTRL);
+	writel_relaxed(TIMERn_CMD_START, base + TIMERn_CMD);
+
+	return clocksource_mmio_init(base + TIMERn_CNT,
+			"efm32 timer", rate / 1024, 200, 16,
+			clocksource_mmio_readl_up);
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+int __init efm32_clockevent_init(struct device_node *np)
+{
+	struct clk *clk;
+	void __iomem *base;
+	unsigned long rate;
+	int irq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clockevent\n");
+		ret = PTR_ERR(clk);
+		goto err_clk_get;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable timer clock for clockevent\n");
+		goto err_clk_enable;
+	}
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("failed to map registers for clockevent\n");
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("failed to get irq\n");
+		goto err_get_irq;
+	}
+
+	writel_relaxed(TIMERn_IRQ_UF, base + TIMERn_IEN);
+
+	clock_event_ddata.base = base;
+	clock_event_ddata.periodic_top = DIV_ROUND_CLOSEST(rate, 1024 * HZ);
+
+	setup_irq(irq, &efm32_clock_event_irq);
+
+	clockevents_config_and_register(&clock_event_ddata.evtdev,
+			DIV_ROUND_CLOSEST(rate, 1024), 0xf, 0xffff);
+
+	return 0;
+
+err_get_irq:
+
+	iounmap(base);
+err_iomap:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+err_clk_get:
+
+	return ret;
+}
+
+void __init efm32_timer_init(void)
+{
+	struct device_node *np;
+
+	efm32gg_clk_init();
+
+	np = of_find_compatible_node(NULL, NULL, "efm32,timer");
+	if (!np) {
+		pr_err("failed to find timer node for clocksource\n");
+		return;
+	}
+
+	efm32_timer_clocksource_init(np);
+
+	np = of_find_compatible_node(np, NULL, "efm32,timer");
+	if (!np) {
+		pr_err("failed to find timer node for clock events\n");
+		return;
+	}
+
+	efm32_clockevent_init(np);
+
+	of_node_put(np);
+}
-- 
1.8.4.rc0
