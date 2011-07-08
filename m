From: bs14@csr.com (Barry Song)
Date: Fri, 8 Jul 2011 02:40:12 -0700
Subject: [PATCH v5 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <1310118014-24509-1-git-send-email-bs14@csr.com>
References: <1310118014-24509-1-git-send-email-bs14@csr.com>
Message-ID: <1310118014-24509-2-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Binghua Duan <binghua.duan@csr.com>

SiRFprimaII is the latest generation application processor from CSR?s
Multifunction SoC product family. Designed around an ARM cortex A9 core,
high-speed memory bus, advanced 3D accelerator and full-HD multi-format
video decoder, SiRFprimaII is able to meet the needs of complicated
applications for modern multifunction devices that require heavy concurrent
applications and fluid user experience. Integrated with GPS baseband,
analog and PMU, this new platform is designed to provide a cost effective
solution for Automotive and Consumer markets.

This patch adds the basic support for this SoC and EVB board based on device
tree. It is following the ZYNQ of Xilinx in some degree.

Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Huayi Li <Huayi.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/arm/sirf.txt  |    3 +
 arch/arm/Kconfig                                |   14 +
 arch/arm/Makefile                               |    1 +
 arch/arm/boot/dts/prima2-cb.dts                 |  416 ++++++++++++++++++
 arch/arm/mach-prima2/Makefile                   |    5 +
 arch/arm/mach-prima2/Makefile.boot              |    3 +
 arch/arm/mach-prima2/clock.c                    |  509 +++++++++++++++++++++++
 arch/arm/mach-prima2/common.h                   |   20 +
 arch/arm/mach-prima2/include/mach/clkdev.h      |   15 +
 arch/arm/mach-prima2/include/mach/debug-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/entry-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/hardware.h    |   15 +
 arch/arm/mach-prima2/include/mach/io.h          |   16 +
 arch/arm/mach-prima2/include/mach/irqs.h        |   17 +
 arch/arm/mach-prima2/include/mach/map.h         |   16 +
 arch/arm/mach-prima2/include/mach/memory.h      |   21 +
 arch/arm/mach-prima2/include/mach/system.h      |   29 ++
 arch/arm/mach-prima2/include/mach/timex.h       |   14 +
 arch/arm/mach-prima2/include/mach/uart.h        |   23 +
 arch/arm/mach-prima2/include/mach/uncompress.h  |   40 ++
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   16 +
 arch/arm/mach-prima2/irq.c                      |   71 ++++
 arch/arm/mach-prima2/prima2.c                   |   40 ++
 arch/arm/mach-prima2/rstc.c                     |   69 +++
 arch/arm/mach-prima2/timer.c                    |  217 ++++++++++
 arch/arm/mm/Kconfig                             |    2 +-
 26 files changed, 1649 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/mach-prima2/Makefile
 create mode 100644 arch/arm/mach-prima2/Makefile.boot
 create mode 100644 arch/arm/mach-prima2/clock.c
 create mode 100644 arch/arm/mach-prima2/common.h
 create mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-prima2/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-prima2/include/mach/io.h
 create mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-prima2/include/mach/map.h
 create mode 100644 arch/arm/mach-prima2/include/mach/memory.h
 create mode 100644 arch/arm/mach-prima2/include/mach/system.h
 create mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uart.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-prima2/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-prima2/irq.c
 create mode 100644 arch/arm/mach-prima2/prima2.c
 create mode 100644 arch/arm/mach-prima2/rstc.c
 create mode 100644 arch/arm/mach-prima2/timer.c

diff --git a/Documentation/devicetree/bindings/arm/sirf.txt b/Documentation/devicetree/bindings/arm/sirf.txt
new file mode 100644
index 0000000..6b07f65
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sirf.txt
@@ -0,0 +1,3 @@
+prima2 "cb" evalutation board
+Required root node properties:
+    - compatible = "sirf,prima2-cb", "sirf,prima2";
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..aa6c91d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -879,6 +879,20 @@ config ARCH_VT8500
 	select HAVE_PWM
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
+
+config ARCH_PRIMA2
+	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
+	select CPU_V7
+	select GENERIC_TIME
+	select NO_IOPORT
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select GENERIC_IRQ_CHIP
+	select USE_OF
+	select ZONE_DMA
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
 endchoice
 
 #
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f5b2b39..1d693d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -169,6 +169,7 @@ machine-$(CONFIG_ARCH_OMAP3)		:= omap2
 machine-$(CONFIG_ARCH_OMAP4)		:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
+machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
new file mode 100644
index 0000000..6fecc88
--- /dev/null
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -0,0 +1,416 @@
+/dts-v1/;
+/ {
+	model = "SiRF Prima2 eVB";
+	compatible = "sirf,prima2-cb", "sirf,prima2";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS0 panel=1 bootsplash=true bpp=16 androidboot.console=ttyS1";
+		linux,stdout-path = &uart1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			/* from bootloader */
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x40000000 0x40000000 0x80000000>;
+
+		l2-cache-controller at 80040000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x80040000 0x1000>;
+			interrupts = <59>;
+		};
+
+		intc: interrupt-controller at 80020000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "sirf,prima2-intc";
+			reg = <0x80020000 0x1000>;
+		};
+
+		sys-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x88000000 0x88000000 0x40000>;
+
+			clock-controller at 88000000 {
+				compatible = "sirf,prima2-clkc";
+				reg = <0x88000000 0x1000>;
+				interrupts = <3>;
+			};
+
+			reset-controller at 88010000 {
+				compatible = "sirf,prima2-rstc";
+				reg = <0x88010000 0x1000>;
+			};
+		};
+
+		mem-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x90000000 0x90000000 0x10000>;
+
+			memory-controller at 90000000 {
+				compatible = "sirf,prima2-memc";
+				reg = <0x90000000 0x10000>;
+				interrupts = <27>;
+			};
+		};
+
+		disp-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x90010000 0x90010000 0x30000>;
+
+			display at 90010000 {
+				compatible = "sirf,prima2-lcd";
+				reg = <0x90010000 0x20000>;
+				interrupts = <30>;
+			};
+
+			vpp at 90020000 {
+				compatible = "sirf,prima2-vpp";
+				reg = <0x90020000 0x10000>;
+				interrupts = <31>;
+			};
+		};
+
+		graphics-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x98000000 0x98000000 0x8000000>;
+
+			graphics at 98000000 {
+				compatible = "powervr,sgx531";
+				reg = <0x98000000 0x8000000>;
+				interrupts = <6>;
+			};
+		};
+
+		multimedia-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xa0000000 0xa0000000 0x8000000>;
+
+			multimedia at a0000000 {
+				compatible = "sirf,prima2-video-codec";
+				reg = <0xa0000000 0x8000000>;
+				interrupts = <5>;
+			};
+		};
+
+		dsp-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xa8000000 0xa8000000 0x2000000>;
+
+			dspif at a8000000 {
+				compatible = "sirf,prima2-dspif";
+				reg = <0xa8000000 0x10000>;
+				interrupts = <9>;
+			};
+
+			gps at a8010000 {
+				compatible = "sirf,prima2-gps";
+				reg = <0xa8010000 0x10000>;
+				interrupts = <7>;
+			};
+
+			dsp at a9000000 {
+				compatible = "sirf,prima2-dsp";
+				reg = <0xa9000000 0x1000000>;
+				interrupts = <8>;
+			};
+		};
+
+		peri-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb0000000 0xb0000000 0x180000>;
+
+			timer at b0020000 {
+				compatible = "sirf,prima2-tick";
+				reg = <0xb0020000 0x1000>;
+				interrupts = <0>;
+			};
+
+			nand at b0030000 {
+				compatible = "sirf,prima2-nand";
+				reg = <0xb0030000 0x10000>;
+				interrupts = <41>;
+			};
+
+			audio at b0040000 {
+				compatible = "sirf,prima2-audio";
+				reg = <0xb0040000 0x10000>;
+				interrupts = <35>;
+			};
+
+			uart0: uart at b0050000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0050000 0x10000>;
+				interrupts = <17>;
+			};
+
+			uart1: uart at b0060000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0060000 0x10000>;
+				interrupts = <18>;
+			};
+
+			uart2: uart at b0070000 {
+				cell-index = <2>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0070000 0x10000>;
+				interrupts = <19>;
+			};
+
+			usp0: usp at b0080000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-usp";
+				reg = <0xb0080000 0x10000>;
+				interrupts = <20>;
+			};
+
+			usp1: usp at b0090000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-usp";
+				reg = <0xb0090000 0x10000>;
+				interrupts = <21>;
+			};
+
+			usp2: usp at b00a0000 {
+				cell-index = <2>;
+				compatible = "sirf,prima2-usp";
+				reg = <0xb00a0000 0x10000>;
+				interrupts = <22>;
+			};
+
+			dmac0: dma-controller at b00b0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-dmac";
+				reg = <0xb00b0000 0x10000>;
+				interrupts = <12>;
+			};
+
+			dmac1: dma-controller at b0160000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-dmac";
+				reg = <0xb0160000 0x10000>;
+				interrupts = <13>;
+			};
+
+			vip at b00C0000 {
+				compatible = "sirf,prima2-vip";
+				reg = <0xb00C0000 0x10000>;
+			};
+
+			spi0: spi at b00d0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-spi";
+				reg = <0xb00d0000 0x10000>;
+				interrupts = <15>;
+			};
+
+			spi1: spi at b0170000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-spi";
+				reg = <0xb0170000 0x10000>;
+				interrupts = <16>;
+			};
+
+			i2c0: i2c at b00e0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-i2c";
+				reg = <0xb00e0000 0x10000>;
+				interrupts = <24>;
+			};
+
+			i2c1: i2c at b00f0000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-i2c";
+				reg = <0xb00f0000 0x10000>;
+				interrupts = <25>;
+			};
+
+			tsc at b0110000 {
+				compatible = "sirf,prima2-tsc";
+				reg = <0xb0110000 0x10000>;
+				interrupts = <33>;
+			};
+
+			gpio: gpio-controller at b0120000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,prima2-gpio";
+				reg = <0xb0120000 0x10000>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pwm at b0130000 {
+				compatible = "sirf,prima2-pwm";
+				reg = <0xb0130000 0x10000>;
+			};
+
+			efusesys at b0140000 {
+				compatible = "sirf,prima2-efuse";
+				reg = <0xb0140000 0x10000>;
+			};
+
+			pulsec at b0150000 {
+				compatible = "sirf,prima2-pulsec";
+				reg = <0xb0150000 0x10000>;
+				interrupts = <48>;
+			};
+
+			pci-iobg {
+				compatible = "sirf,prima2-pciiobg", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x56000000 0x56000000 0x1b00000>;
+
+				sd0: sdhci at 56000000 {
+					cell-index = <0>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56000000 0x100000>;
+					interrupts = <38>;
+				};
+
+				sd1: sdhci at 56100000 {
+					cell-index = <1>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56100000 0x100000>;
+					interrupts = <38>;
+				};
+
+				sd2: sdhci at 56200000 {
+					cell-index = <2>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56200000 0x100000>;
+					interrupts = <23>;
+				};
+
+				sd3: sdhci at 56300000 {
+					cell-index = <3>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56300000 0x100000>;
+					interrupts = <23>;
+				};
+
+				sd4: sdhci at 56400000 {
+					cell-index = <4>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56400000 0x100000>;
+					interrupts = <39>;
+				};
+
+				sd5: sdhci at 56500000 {
+					cell-index = <5>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56500000 0x100000>;
+					interrupts = <39>;
+				};
+
+				pci-copy at 57900000 {
+					compatible = "sirf,prima2-pcicp";
+					reg = <0x57900000 0x100000>;
+					interrupts = <40>;
+				};
+
+				rom-interface at 57a00000 {
+					compatible = "sirf,prima2-romif";
+					reg = <0x57a00000 0x100000>;
+				};
+			};
+		};
+
+		rtc-iobg {
+			compatible = "sirf,prima2-rtciobg", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80030000 0x10000>;
+
+			gpsrtc at 1000 {
+				compatible = "sirf,prima2-gpsrtc";
+				reg = <0x1000 0x1000>;
+				interrupts = <55 56 57>;
+			};
+
+			sysrtc at 2000 {
+				compatible = "sirf,prima2-sysrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <52 53 54>;
+			};
+
+			pwrc at 3000 {
+				compatible = "sirf,prima2-pwrc";
+				reg = <0x3000 0x1000>;
+				interrupts = <32>;
+			};
+		};
+
+		uus-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb8000000 0xb8000000 0x40000>;
+
+			usb0: usb at b00e0000 {
+				compatible = "chipidea,ci13611a-prima2";
+				reg = <0xb8000000 0x10000>;
+				interrupts = <10>;
+			};
+
+			usb1: usb at b00f0000 {
+				compatible = "chipidea,ci13611a-prima2";
+				reg = <0xb8010000 0x10000>;
+				interrupts = <11>;
+			};
+
+			sata at b00f0000 {
+				compatible = "synopsys,dwc-ahsata";
+				reg = <0xb8020000 0x10000>;
+				interrupts = <37>;
+			};
+
+			security at b00f0000 {
+				compatible = "sirf,prima2-security";
+				reg = <0xb8030000 0x10000>;
+				interrupts = <42>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
new file mode 100644
index 0000000..d44f7ae
--- /dev/null
+++ b/arch/arm/mach-prima2/Makefile
@@ -0,0 +1,5 @@
+obj-y := timer.o
+obj-y += irq.o
+obj-y += clock.o
+obj-y += rstc.o
+obj-y += prima2.o
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
new file mode 100644
index 0000000..d023db3
--- /dev/null
+++ b/arch/arm/mach-prima2/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y		:= 0x00008000
+params_phys-y		:= 0x00000100
+initrd_phys-y		:= 0x00800000
diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
new file mode 100644
index 0000000..f9a2aaf
--- /dev/null
+++ b/arch/arm/mach-prima2/clock.c
@@ -0,0 +1,509 @@
+/*
+ * Clock tree for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/clkdev.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <asm/mach/map.h>
+#include <mach/map.h>
+
+#define SIRFSOC_CLKC_CLK_EN0    0x0000
+#define SIRFSOC_CLKC_CLK_EN1    0x0004
+#define SIRFSOC_CLKC_REF_CFG    0x0014
+#define SIRFSOC_CLKC_CPU_CFG    0x0018
+#define SIRFSOC_CLKC_MEM_CFG    0x001c
+#define SIRFSOC_CLKC_SYS_CFG    0x0020
+#define SIRFSOC_CLKC_IO_CFG     0x0024
+#define SIRFSOC_CLKC_DSP_CFG    0x0028
+#define SIRFSOC_CLKC_GFX_CFG    0x002c
+#define SIRFSOC_CLKC_MM_CFG     0x0030
+#define SIRFSOC_LKC_LCD_CFG     0x0034
+#define SIRFSOC_CLKC_MMC_CFG    0x0038
+#define SIRFSOC_CLKC_PLL1_CFG0  0x0040
+#define SIRFSOC_CLKC_PLL2_CFG0  0x0044
+#define SIRFSOC_CLKC_PLL3_CFG0  0x0048
+#define SIRFSOC_CLKC_PLL1_CFG1  0x004c
+#define SIRFSOC_CLKC_PLL2_CFG1  0x0050
+#define SIRFSOC_CLKC_PLL3_CFG1  0x0054
+#define SIRFSOC_CLKC_PLL1_CFG2  0x0058
+#define SIRFSOC_CLKC_PLL2_CFG2  0x005c
+#define SIRFSOC_CLKC_PLL3_CFG2  0x0060
+
+#define SIRFSOC_CLOCK_VA_BASE		SIRFSOC_VA(0x005000)
+
+#define KHZ     1000
+#define MHZ     (KHZ * KHZ)
+
+struct clk_ops {
+	unsigned long (*get_rate)(struct clk *clk);
+	long (*round_rate)(struct clk *clk, unsigned long rate);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+	int (*enable)(struct clk *clk);
+	int (*disable)(struct clk *clk);
+	struct clk *(*get_parent)(struct clk *clk);
+	int (*set_parent)(struct clk *clk, struct clk *parent);
+};
+
+struct clk {
+	struct clk *parent;     /* parent clk */
+	unsigned long rate;     /* clock rate in Hz */
+	signed char usage;      /* clock enable count */
+	signed char enable_bit; /* enable bit: 0 ~ 63 */
+	unsigned short regofs;  /* register offset */
+	struct clk_ops *ops;    /* clock operation */
+};
+
+static DEFINE_SPINLOCK(clocks_lock);
+
+static inline unsigned long clkc_readl(unsigned reg)
+{
+	return readl(SIRFSOC_CLOCK_VA_BASE + reg);
+}
+
+static inline void clkc_writel(u32 val, unsigned reg)
+{
+	writel(val, SIRFSOC_CLOCK_VA_BASE + reg);
+}
+
+/*
+ * osc_rtc - real time oscillator - 32.768KHz
+ * osc_sys - high speed oscillator - 26MHz
+ */
+
+static struct clk clk_rtc = {
+	.rate = 32768,
+};
+
+static struct clk clk_osc = {
+	.rate = 26 * MHZ,
+};
+
+/*
+ * std pll
+ */
+static unsigned long std_pll_get_rate(struct clk *clk)
+{
+	unsigned long fin = clk_get_rate(clk->parent);
+	u32 regcfg2 = clk->regofs + SIRFSOC_CLKC_PLL1_CFG2 -
+		SIRFSOC_CLKC_PLL1_CFG0;
+
+	if (clkc_readl(regcfg2) & BIT(2)) {
+		/* pll bypass mode */
+		clk->rate = fin;
+	} else {
+		/* fout = fin * nf / nr / od */
+		u32 cfg0 = clkc_readl(clk->regofs);
+		u32 nf = (cfg0 & (BIT(13) - 1)) + 1;
+		u32 nr = ((cfg0 >> 13) & (BIT(6) - 1)) + 1;
+		u32 od = ((cfg0 >> 19) & (BIT(4) - 1)) + 1;
+		WARN_ON(fin % MHZ);
+		clk->rate = fin / MHZ * nf / nr / od * MHZ;
+	}
+
+	return clk->rate;
+}
+
+static int std_pll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long fin, nf, nr, od, reg;
+
+	/*
+	 * fout = fin * nf / (nr * od);
+	 * set od = 1, nr = fin/MHz, so fout = nf * MHz
+	 */
+
+	nf = rate / MHZ;
+	if (unlikely((rate % MHZ) || nf > BIT(13) || nf < 1))
+		return -EINVAL;
+
+	fin = clk_get_rate(clk->parent);
+	BUG_ON(fin < MHZ);
+
+	nr = fin / MHZ;
+	BUG_ON((fin % MHZ) || nr > BIT(6));
+
+	od = 1;
+
+	reg = (nf - 1) | ((nr - 1) << 13) | ((od - 1) << 19);
+	clkc_writel(reg, clk->regofs);
+
+	reg = clk->regofs + SIRFSOC_CLKC_PLL1_CFG1 - SIRFSOC_CLKC_PLL1_CFG0;
+	clkc_writel((nf >> 1) - 1, reg);
+
+	reg = clk->regofs + SIRFSOC_CLKC_PLL1_CFG2 - SIRFSOC_CLKC_PLL1_CFG0;
+	while (!(clkc_readl(reg) & BIT(6)))
+		cpu_relax();
+
+	clk->rate = 0; /* set to zero will force recalculation */
+	return 0;
+}
+
+static struct clk_ops std_pll_ops = {
+	.get_rate = std_pll_get_rate,
+	.set_rate = std_pll_set_rate,
+};
+
+static struct clk clk_pll1 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL1_CFG0,
+	.ops = &std_pll_ops,
+};
+
+static struct clk clk_pll2 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL2_CFG0,
+	.ops = &std_pll_ops,
+};
+
+static struct clk clk_pll3 = {
+	.parent = &clk_osc,
+	.regofs = SIRFSOC_CLKC_PLL3_CFG0,
+	.ops = &std_pll_ops,
+};
+
+/*
+ * clock domains - cpu, mem, sys/io
+ */
+
+static struct clk clk_mem;
+
+static struct clk *dmn_get_parent(struct clk *clk)
+{
+	struct clk *clks[] = {
+		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
+	};
+	u32 cfg = clkc_readl(clk->regofs);
+	WARN_ON((cfg & (BIT(3) - 1)) > 4);
+	return clks[cfg & (BIT(3) - 1)];
+}
+
+static int dmn_set_parent(struct clk *clk, struct clk *parent)
+{
+	const struct clk *clks[] = {
+		&clk_osc, &clk_rtc, &clk_pll1, &clk_pll2, &clk_pll3
+	};
+	u32 cfg = clkc_readl(clk->regofs);
+	int i;
+	for (i = 0; i < ARRAY_SIZE(clks); i++) {
+		if (clks[i] == parent) {
+			cfg &= ~(BIT(3) - 1);
+			clkc_writel(cfg | i, clk->regofs);
+			/* BIT(3) - switching status: 1 - busy, 0 - done */
+			while (clkc_readl(clk->regofs) & BIT(3))
+				cpu_relax();
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static unsigned long dmn_get_rate(struct clk *clk)
+{
+	unsigned long fin = clk_get_rate(clk->parent);
+	u32 cfg = clkc_readl(clk->regofs);
+	if (cfg & BIT(24)) {
+		/* fcd bypass mode */
+		clk->rate = fin;
+	} else {
+		/*
+		 * wait count: bit[19:16], hold count: bit[23:20]
+		 */
+		u32 wait = (cfg >> 16) & (BIT(4) - 1);
+		u32 hold = (cfg >> 20) & (BIT(4) - 1);
+
+		clk->rate = fin / (wait + hold + 2);
+	}
+
+	return clk->rate;
+}
+
+static int dmn_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long fin;
+	unsigned ratio, wait, hold, reg;
+	unsigned bits = (clk == &clk_mem) ? 3 : 4;
+
+	fin = clk_get_rate(clk->parent);
+	ratio = fin / rate;
+
+	if (unlikely(ratio < 2 || ratio > BIT(bits + 1)))
+		return -EINVAL;
+
+	WARN_ON(fin % rate);
+
+	wait = (ratio >> 1) - 1;
+	hold = ratio - wait - 2;
+
+	reg = clkc_readl(clk->regofs);
+	reg &= ~(((BIT(bits) - 1) << 16) | ((BIT(bits) - 1) << 20));
+	reg |= (wait << 16) | (hold << 20) | BIT(25);
+	clkc_writel(reg, clk->regofs);
+
+	/* waiting FCD been effective */
+	while (clkc_readl(clk->regofs) & BIT(25))
+		cpu_relax();
+
+	clk->rate = 0; /* set to zero will force recalculation */
+
+	return 0;
+}
+
+/*
+ * cpu clock has no FCD register in Prima2, can only change pll
+ */
+static int cpu_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret1, ret2;
+	struct clk *cur_parent, *tmp_parent;
+
+	cur_parent = dmn_get_parent(clk);
+	BUG_ON(cur_parent == NULL || cur_parent->usage > 1);
+
+	/* switch to tmp pll before setting parent clock's rate */
+	tmp_parent = cur_parent == &clk_pll1 ? &clk_pll2 : &clk_pll1;
+	ret1 = dmn_set_parent(clk, tmp_parent);
+	BUG_ON(ret1);
+
+	ret2 = clk_set_rate(cur_parent, rate);
+
+	ret1 = dmn_set_parent(clk, cur_parent);
+
+	clk->rate = 0; /* set to zero will force recalculation */
+
+	return ret2 ? ret2 : ret1;
+}
+
+static struct clk_ops cpu_ops = {
+	.get_parent = dmn_get_parent,
+	.set_parent = dmn_set_parent,
+	.set_rate = cpu_set_rate,
+};
+
+static struct clk clk_cpu = {
+	.parent = &clk_pll1,
+	.regofs = SIRFSOC_CLKC_CPU_CFG,
+	.ops = &cpu_ops,
+};
+
+
+static struct clk_ops msi_ops = {
+	.set_rate = dmn_set_rate,
+	.get_rate = dmn_get_rate,
+	.set_parent = dmn_set_parent,
+	.get_parent = dmn_get_parent,
+};
+
+static struct clk clk_mem = {
+	.parent = &clk_pll2,
+	.regofs = SIRFSOC_CLKC_MEM_CFG,
+	.ops = &msi_ops,
+};
+
+static struct clk clk_sys = {
+	.parent = &clk_pll3,
+	.regofs = SIRFSOC_CLKC_SYS_CFG,
+	.ops = &msi_ops,
+};
+
+static struct clk clk_io = {
+	.parent = &clk_pll3,
+	.regofs = SIRFSOC_CLKC_IO_CFG,
+	.ops = &msi_ops,
+};
+
+/*
+ * on-chip clock sets
+ */
+static struct clk_lookup onchip_clks[] = {
+	{
+		.dev_id = "rtc",
+		.clk = &clk_rtc,
+	}, {
+		.dev_id = "osc",
+		.clk = &clk_osc,
+	}, {
+		.dev_id = "pll1",
+		.clk = &clk_pll1,
+	}, {
+		.dev_id = "pll2",
+		.clk = &clk_pll2,
+	}, {
+		.dev_id = "pll3",
+		.clk = &clk_pll3,
+	}, {
+		.dev_id = "cpu",
+		.clk = &clk_cpu,
+	}, {
+		.dev_id = "mem",
+		.clk = &clk_mem,
+	}, {
+		.dev_id = "sys",
+			.clk = &clk_sys,
+	}, {
+		.dev_id = "io",
+			.clk = &clk_io,
+	},
+};
+
+int clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (clk->parent)
+		clk_enable(clk->parent);
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (!clk->usage++ && clk->ops && clk->ops->enable)
+		clk->ops->enable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return;
+
+	WARN_ON(!clk->usage);
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	if (--clk->usage == 0 && clk->ops && clk->ops->disable)
+		clk->ops->disable(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+
+	if (clk->parent)
+		clk_disable(clk->parent);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0;
+
+	if (clk->rate)
+		return clk->rate;
+
+	if (clk->ops && clk->ops->get_rate)
+		return clk->ops->get_rate(clk);
+
+	return clk_get_rate(clk->parent);
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0;
+
+	if (clk->ops && clk->ops->round_rate)
+		return clk->ops->round_rate(clk, rate);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (!clk->ops || !clk->ops->set_rate)
+		return -EINVAL;
+
+	return clk->ops->set_rate(clk, rate);
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret;
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	if (!clk->ops || !clk->ops->set_parent)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	ret = clk->ops->set_parent(clk, parent);
+	if (!ret) {
+		parent->usage += clk->usage;
+		clk->parent->usage -= clk->usage;
+		BUG_ON(clk->parent->usage < 0);
+		clk->parent = parent;
+	}
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	unsigned long flags;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return NULL;
+
+	if (!clk->ops || !clk->ops->get_parent)
+		return clk->parent;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	clk->parent = clk->ops->get_parent(clk);
+	spin_unlock_irqrestore(&clocks_lock, flags);
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+static void __init sirfsoc_clk_init(void)
+{
+	clkdev_add_table(onchip_clks, ARRAY_SIZE(onchip_clks));
+}
+
+static struct of_device_id clkc_ids[] = {
+	{ .compatible = "sirf,prima2-clkc" },
+};
+
+void __init sirfsoc_of_clk_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	struct map_desc sirfsoc_clkc_iodesc = {
+		.virtual = SIRFSOC_CLOCK_VA_BASE,
+		.type    = MT_DEVICE,
+	};
+
+	np = of_find_matching_node(NULL, clkc_ids);
+	if (!np)
+		panic("unable to find compatible clkc node in dtb\n");
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("unable to find clkc range in dtb");
+	of_node_put(np);
+
+	sirfsoc_clkc_iodesc.pfn = __phys_to_pfn(res.start);
+	sirfsoc_clkc_iodesc.length = 1 + res.end - res.start;
+
+	iotable_init(&sirfsoc_clkc_iodesc, 1);
+
+	sirfsoc_clk_init();
+}
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
new file mode 100644
index 0000000..fa4a3b5
--- /dev/null
+++ b/arch/arm/mach-prima2/common.h
@@ -0,0 +1,20 @@
+/*
+ * This file contains common function prototypes to avoid externs in the c files.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_COMMON_H__
+#define __MACH_PRIMA2_COMMON_H__
+
+#include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern struct sys_timer sirfsoc_timer;
+
+extern void __init sirfsoc_of_irq_init(void);
+extern void __init sirfsoc_of_clk_init(void);
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/clkdev.h b/arch/arm/mach-prima2/include/mach/clkdev.h
new file mode 100644
index 0000000..6693251
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/clkdev.h
@@ -0,0 +1,15 @@
+/*
+ * arch/arm/mach-prima2/include/mach/clkdev.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/debug-macro.S b/arch/arm/mach-prima2/include/mach/debug-macro.S
new file mode 100644
index 0000000..bf75106
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/debug-macro.S
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-prima2/include/mach/debug-macro.S
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <mach/hardware.h>
+#include <mach/uart.h>
+
+	.macro	addruart, rp, rv
+	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
+	ldr	\rv, =SIRFSOC_UART1_VA_BASE		@ virtual
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #SIRFSOC_UART_TXFIFO_DATA]
+	.endm
+
+	.macro	busyuart,rd,rx
+	.endm
+
+	.macro	waituart,rd,rx
+1001:	ldr	\rd, [\rx, #SIRFSOC_UART_TXFIFO_STATUS]
+	tst	\rd, #SIRFSOC_UART1_TXFIFO_EMPTY
+	beq	1001b
+	.endm
+
diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-prima2/include/mach/entry-macro.S
new file mode 100644
index 0000000..1c8a50f
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/entry-macro.S
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-prima2/include/mach/entry-macro.S
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <mach/hardware.h>
+
+#define SIRFSOC_INT_ID 0x38
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr     \base, =sirfsoc_intc_base
+	ldr     \base, [\base]
+	.endm
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr \irqnr, [\base, #SIRFSOC_INT_ID]	@ Get the highest priority irq
+	cmp \irqnr, #0x40			@ the irq num can't be larger than 0x3f
+	movges \irqnr, #0
+	.endm
+
+	.macro  disable_fiq
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
diff --git a/arch/arm/mach-prima2/include/mach/hardware.h b/arch/arm/mach-prima2/include/mach/hardware.h
new file mode 100644
index 0000000..105b969
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/hardware.h
@@ -0,0 +1,15 @@
+/*
+ * arch/arm/mach-prima2/include/mach/hardware.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_HARDWARE_H__
+#define __MACH_HARDWARE_H__
+
+#include <asm/sizes.h>
+#include <mach/map.h>
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/io.h b/arch/arm/mach-prima2/include/mach/io.h
new file mode 100644
index 0000000..6c31e9e
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/io.h
@@ -0,0 +1,16 @@
+/*
+ * arch/arm/mach-prima2/include/mach/io.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_IO_H
+#define __MACH_PRIMA2_IO_H
+
+#define IO_SPACE_LIMIT ((resource_size_t)0)
+
+#define __mem_pci(a)            (a)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/irqs.h b/arch/arm/mach-prima2/include/mach/irqs.h
new file mode 100644
index 0000000..bb354f9
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/irqs.h
@@ -0,0 +1,17 @@
+/*
+ * arch/arm/mach-prima2/include/mach/irqs.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H
+
+#define SIRFSOC_INTENAL_IRQ_START  0
+#define SIRFSOC_INTENAL_IRQ_END    59
+
+#define NR_IRQS	220
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-prima2/include/mach/map.h
new file mode 100644
index 0000000..66b1ae2
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/map.h
@@ -0,0 +1,16 @@
+/*
+ * memory & I/O static mapping definitions for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_MAP_H__
+#define __MACH_PRIMA2_MAP_H__
+
+#include <mach/vmalloc.h>
+
+#define SIRFSOC_VA(x)			(VMALLOC_END + ((x) & 0x00FFF000))
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/memory.h b/arch/arm/mach-prima2/include/mach/memory.h
new file mode 100644
index 0000000..368cd5a
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/memory.h
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/mach-prima2/include/mach/memory.h
+ *
+ * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PLAT_PHYS_OFFSET        UL(0x00000000)
+
+/*
+ * Restrict DMA-able region to workaround silicon limitation.
+ * The limitation restricts buffers available for DMA to SD/MMC
+ * hardware to be below 256MB
+ */
+#define ARM_DMA_ZONE_SIZE	(SZ_256M)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
new file mode 100644
index 0000000..0dbd257
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/system.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-prima2/include/mach/system.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_SYSTEM_H__
+#define __MACH_SYSTEM_H__
+
+#include <linux/bitops.h>
+#include <mach/hardware.h>
+
+#define SIRFSOC_SYS_RST_BIT  BIT(31)
+
+extern void __iomem *sirfsoc_rstc_base;
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
+}
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/timex.h b/arch/arm/mach-prima2/include/mach/timex.h
new file mode 100644
index 0000000..d6f98a7
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/timex.h
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-prima2/include/mach/timex.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_TIMEX_H__
+#define __MACH_TIMEX_H__
+
+#define CLOCK_TICK_RATE  1000000
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-prima2/include/mach/uart.h
new file mode 100644
index 0000000..c98b4d5
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/uart.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-prima2/include/mach/uart.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_SIRFSOC_UART_H
+#define __MACH_PRIMA2_SIRFSOC_UART_H
+
+/* UART-1: used as serial debug port */
+#define SIRFSOC_UART1_PA_BASE          0xb0060000
+#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
+#define SIRFSOC_UART1_SIZE		SZ_4K
+
+#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
+#define SIRFSOC_UART_TXFIFO_DATA	0x0118
+
+#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
+#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
new file mode 100644
index 0000000..83125c6
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -0,0 +1,40 @@
+/*
+ * arch/arm/mach-prima2/include/mach/uncompress.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/uart.h>
+
+void arch_decomp_setup(void)
+{
+}
+
+#define arch_decomp_wdog()
+
+static __inline__ void putc(char c)
+{
+	/*
+	 * during kernel decompression, all mappings are flat:
+	 *  virt_addr == phys_addr
+	 */
+	while (__raw_readl(SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
+		& SIRFSOC_UART1_TXFIFO_FULL)
+		barrier();
+
+	__raw_writel(c, SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_DATA);
+}
+
+static inline void flush(void)
+{
+}
+
+#endif
+
diff --git a/arch/arm/mach-prima2/include/mach/vmalloc.h b/arch/arm/mach-prima2/include/mach/vmalloc.h
new file mode 100644
index 0000000..c9f90fe
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/vmalloc.h
@@ -0,0 +1,16 @@
+/*
+ * arch/arm/ach-prima2/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_VMALLOC_H
+#define __MACH_VMALLOC_H
+
+#include <linux/const.h>
+
+#define VMALLOC_END    _AC(0xFEC00000, UL)
+
+#endif
diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
new file mode 100644
index 0000000..c3404cb
--- /dev/null
+++ b/arch/arm/mach-prima2/irq.c
@@ -0,0 +1,71 @@
+/*
+ * interrupt controller support for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <mach/hardware.h>
+#include <asm/mach/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define SIRFSOC_INT_RISC_MASK0          0x0018
+#define SIRFSOC_INT_RISC_MASK1          0x001C
+#define SIRFSOC_INT_RISC_LEVEL0         0x0020
+#define SIRFSOC_INT_RISC_LEVEL1         0x0024
+
+void __iomem *sirfsoc_intc_base;
+
+static __init void
+sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("SIRFINTC", 1, irq_start, base, handle_level_irq);
+	ct = gc->chip_types;
+
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST, 0);
+}
+
+static __init void sirfsoc_irq_init(void)
+{
+	sirfsoc_alloc_gc(sirfsoc_intc_base, 0, 32);
+	sirfsoc_alloc_gc(sirfsoc_intc_base + 4, 32, SIRFSOC_INTENAL_IRQ_END - 32);
+
+	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL0);
+	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL1);
+
+	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK0);
+	writel_relaxed(0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK1);
+}
+
+static struct of_device_id intc_ids[]  = {
+	{ .compatible = "sirf,prima2-intc" },
+};
+
+void __init sirfsoc_of_irq_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, intc_ids);
+	if (!np)
+		panic("unable to find compatible intc node in dtb\n");
+
+	sirfsoc_intc_base = of_iomap(np, 0);
+	if (!sirfsoc_intc_base)
+		panic("unable to map intc cpu registers\n");
+
+	of_node_put(np);
+
+	sirfsoc_irq_init();
+}
diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
new file mode 100644
index 0000000..c26947d
--- /dev/null
+++ b/arch/arm/mach-prima2/prima2.c
@@ -0,0 +1,40 @@
+/*
+ * Defines machines for CSR SiRFprimaII 
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include "common.h"
+
+static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+void __init sirfsoc_mach_init(void)
+{
+	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
+}
+
+static const char *prima2cb_dt_match[] __initdata = {
+       "sirf,prima2-cb",
+       NULL
+};
+
+MACHINE_START(PRIMA2_EVB, "prima2cb")
+	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.boot_params	= 0x00000100,
+	.init_early     = sirfsoc_of_clk_init,
+	.init_irq	= sirfsoc_of_irq_init,
+	.timer		= &sirfsoc_timer,
+	.init_machine	= sirfsoc_mach_init,
+	.dt_compat      = prima2cb_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
new file mode 100644
index 0000000..d074786
--- /dev/null
+++ b/arch/arm/mach-prima2/rstc.c
@@ -0,0 +1,69 @@
+/*
+ * reset controller for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __iomem *sirfsoc_rstc_base;
+static DEFINE_MUTEX(rstc_lock);
+
+static struct of_device_id rstc_ids[]  = {
+	{ .compatible = "sirf,prima2-rstc" },
+};
+
+static int __init sirfsoc_of_rstc_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rstc_ids);
+	if (!np)
+		panic("unable to find compatible rstc node in dtb\n");
+
+	sirfsoc_rstc_base = of_iomap(np, 0);
+	if (!sirfsoc_rstc_base)
+		panic("unable to map rstc cpu registers\n");
+
+	of_node_put(np);
+
+	return 0;
+}
+early_initcall(sirfsoc_of_rstc_init);
+
+int sirfsoc_reset_device(struct device *dev)
+{
+	const unsigned int *prop = of_get_property(dev->of_node, "reset-bit", NULL);
+	unsigned int reset_bit;
+
+	if (!prop)
+		return -ENODEV;
+
+	reset_bit = be32_to_cpup(prop);
+
+	mutex_lock(&rstc_lock);
+
+	/*
+	 * Writing 1 to this bit resets corresponding block. Writing 0 to this
+	 * bit de-asserts reset signal of the corresponding block.
+	 * datasheet doesn't require explicit delay between the set and clear
+	 * of reset bit. it could be shorter if tests pass.
+	 */
+	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
+		sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	msleep(10);
+	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
+		sirfsoc_rstc_base + (reset_bit / 32) * 4);
+
+	mutex_unlock(&rstc_lock);
+
+	return 0;
+}
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
new file mode 100644
index 0000000..44027f3
--- /dev/null
+++ b/arch/arm/mach-prima2/timer.c
@@ -0,0 +1,217 @@
+/*
+ * System timer for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <mach/map.h>
+#include <asm/mach/time.h>
+
+#define SIRFSOC_TIMER_COUNTER_LO	0x0000
+#define SIRFSOC_TIMER_COUNTER_HI	0x0004
+#define SIRFSOC_TIMER_MATCH_0		0x0008
+#define SIRFSOC_TIMER_MATCH_1		0x000C
+#define SIRFSOC_TIMER_MATCH_2		0x0010
+#define SIRFSOC_TIMER_MATCH_3		0x0014
+#define SIRFSOC_TIMER_MATCH_4		0x0018
+#define SIRFSOC_TIMER_MATCH_5		0x001C
+#define SIRFSOC_TIMER_STATUS		0x0020
+#define SIRFSOC_TIMER_INT_EN		0x0024
+#define SIRFSOC_TIMER_WATCHDOG_EN	0x0028
+#define SIRFSOC_TIMER_DIV		0x002C
+#define SIRFSOC_TIMER_LATCH		0x0030
+#define SIRFSOC_TIMER_LATCHED_LO	0x0034
+#define SIRFSOC_TIMER_LATCHED_HI	0x0038
+
+#define SIRFSOC_TIMER_WDT_INDEX		5
+
+#define SIRFSOC_TIMER_LATCH_BIT	 BIT(0)
+
+static void __iomem *sirfsoc_timer_base;
+static void __init sirfsoc_of_timer_map(void);
+
+/* timer0 interrupt handler */
+static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ce = dev_id;
+
+	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) & BIT(0)));
+
+	/* clear timer0 interrupt */
+	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+/* read 64-bit timer counter */
+static cycle_t sirfsoc_timer_read(struct clocksource *cs)
+{
+	u64 cycles;
+
+	/* latch the 64-bit timer counter */
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_HI);
+	cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
+
+	return cycles;
+}
+
+static int sirfsoc_timer_set_next_event(unsigned long delta,
+	struct clock_event_device *ce)
+{
+	unsigned long now, next;
+
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
+	next = now + delta;
+	writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
+
+	return next - now > delta ? -ETIME : 0;
+}
+
+static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *ce)
+{
+	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		WARN_ON(1);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		writel_relaxed(val & ~BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device sirfsoc_clockevent = {
+	.name = "sirfsoc_clockevent",
+	.rating = 200,
+	.features = CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode = sirfsoc_timer_set_mode,
+	.set_next_event = sirfsoc_timer_set_next_event,
+};
+
+static struct clocksource sirfsoc_clocksource = {
+	.name = "sirfsoc_clocksource",
+	.rating = 200,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.read = sirfsoc_timer_read,
+};
+
+static struct irqaction sirfsoc_timer_irq = {
+	.name = "sirfsoc_timer0",
+	.flags = IRQF_TIMER,
+	.irq = 0,
+	.handler = sirfsoc_timer_interrupt,
+	.dev_id = &sirfsoc_clockevent,
+};
+
+/* Overwrite weak default sched_clock with more precise one */
+unsigned long long notrace sched_clock(void)
+{
+	static int is_mapped = 0;
+
+	/*
+	 * sched_clock is called earlier than .init of sys_timer
+	 * if we map timer memory in .init of sys_timer, system
+	 * will panic due to illegal memory access
+	 */
+	if(!is_mapped) {
+		sirfsoc_of_timer_map();
+		is_mapped = 1;
+	}
+
+	return sirfsoc_timer_read(NULL) * (NSEC_PER_SEC / CLOCK_TICK_RATE);
+}
+
+static void __init sirfsoc_clockevent_init(void)
+{
+	clockevents_calc_mult_shift(&sirfsoc_clockevent, CLOCK_TICK_RATE, 60);
+
+	sirfsoc_clockevent.max_delta_ns =
+		clockevent_delta2ns(-2, &sirfsoc_clockevent);
+	sirfsoc_clockevent.min_delta_ns =
+		clockevent_delta2ns(2, &sirfsoc_clockevent);
+
+	sirfsoc_clockevent.cpumask = cpumask_of(0);
+	clockevents_register_device(&sirfsoc_clockevent);
+}
+
+/* initialize the kernel jiffy timer source */
+static void __init sirfsoc_timer_init(void)
+{
+	unsigned long rate;
+
+	/* timer's input clock is io clock */
+	struct clk *clk = clk_get_sys("io", NULL);
+
+	BUG_ON(IS_ERR(clk));
+
+	rate = clk_get_rate(clk);
+
+	BUG_ON(rate < CLOCK_TICK_RATE);
+	BUG_ON(rate % CLOCK_TICK_RATE);
+
+	writel_relaxed(rate / CLOCK_TICK_RATE / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
+	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
+
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+
+	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
+
+	sirfsoc_clockevent_init();
+}
+
+static struct of_device_id timer_ids[] = {
+	{ .compatible = "sirf,prima2-tick" },
+};
+
+static void __init sirfsoc_of_timer_map(void)
+{
+	struct device_node *np;
+	const unsigned int *intspec;
+
+	np = of_find_matching_node(NULL, timer_ids);
+	if (!np)
+		panic("unable to find compatible timer node in dtb\n");
+	sirfsoc_timer_base = of_iomap(np, 0);
+	if (!sirfsoc_timer_base)
+		panic("unable to map timer cpu registers\n");
+
+	/* Get the interrupts property */
+	intspec = of_get_property(np, "interrupts", NULL);
+	BUG_ON(!intspec);
+	sirfsoc_timer_irq.irq = be32_to_cpup(intspec);
+
+	of_node_put(np);
+}
+
+struct sys_timer sirfsoc_timer = {
+	.init = sirfsoc_timer_init,
+};
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 0074b8d..edf0681 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -821,7 +821,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || ARCH_PRIMA2
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
