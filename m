From: stigge@antcom.de (Roland Stigge)
Date: Wed,  4 Apr 2012 18:07:25 +0200
Subject: [PATCH RFC 2/2] ARM: LPC32xx: Device tree support
In-Reply-To: <1333555645-2154-1-git-send-email-stigge@antcom.de>
References: <1333555645-2154-1-git-send-email-stigge@antcom.de>
Message-ID: <1333555645-2154-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support for the LPC32xx SoC

arch/arm/boot/dts/lpc32xx.dtsi: Include for devices based on LPC32xx
arch/arm/boot/dts/phy3250.dts: Board support for PHYTEC phyCORE-LPC3250
arch/arm/boot/mach-lpc32xx/irq.c: irq domain conversion

---

This is just work in progress to give some context of what I'm doing to
mach-lpc32xx, especially wrt. OHCI (see PATCH 1/2).

Applies to v3.4-rc1 and uses the various other driver DT conversion patches
(patches posted previously, but they shouldn't be essential).

Please ignore the yet unconnected devices in the dtsi file. Also, SPI and LCD
conversion is still missing.

I'm planning to do the serial port DT connections in separate, later patches.

The remaining lines of phy3250.c will finally also be merged into common.c.

Is it necessary or reasonable to split off the irq domain conversion in irq.c?

Thanks,

Roland


 Documentation/devicetree/bindings/arm/lpc32xx-mic.txt |   39 ++
 Documentation/devicetree/bindings/arm/lpc32xx.txt     |    8 
 arch/arm/Kconfig                                      |    1 
 arch/arm/boot/dts/lpc32xx.dtsi                        |  262 ++++++++++++++++++
 arch/arm/boot/dts/phy3250.dts                         |   74 +++++
 arch/arm/mach-lpc32xx/Kconfig                         |   26 -
 arch/arm/mach-lpc32xx/common.c                        |  171 -----------
 arch/arm/mach-lpc32xx/irq.c                           |   77 +++--
 arch/arm/mach-lpc32xx/phy3250.c                       |   85 ++---
 9 files changed, 471 insertions(+), 272 deletions(-)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/arm/lpc32xx-mic.txt
@@ -0,0 +1,39 @@
+* NXP LPC32xx Main Interrupt Controller
+  (MIC, including SIC1 and SIC2 secondary controllers)
+
+Required properties:
+- compatible: Should be "nxp,lpc32xx-mic"
+- interrupt-controller: Identifies the node as an interrupt controller.
+- interrupt-parent: Empty for the interrupt controller itself
+- #interrupt-cells: The number of cells to define the interrupts. Should be 2.
+  The first cell is the IRQ number
+  The second cell is used to specify mode:
+      1 = low-to-high edge triggered
+      2 = high-to-low edge triggered
+      4 = active high level-sensitive
+      8 = active low level-sensitive
+      Default for internal sources should be set to 4 (active high).
+- reg: Should contain MIC registers location and length
+
+Examples:
+	/*
+	 * MIC
+	 */
+	mic: interrupt-controller at 40008000 {
+		compatible = "nxp,lpc32xx-mic";
+		interrupt-controller;
+		interrupt-parent;
+		#interrupt-cells = <2>;
+		reg = <0x40008000 0xC000>;
+	};
+
+	/*
+	 * ADC
+	 */
+	adc at 40048000 {
+		compatible = "nxp,lpc32xx-adc";
+		reg = <0x40048000 0x1000>;
+		interrupt-parent = <&mic>;
+		interrupts = <39 4>;
+	};
+
--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/arm/lpc32xx.txt
@@ -0,0 +1,8 @@
+NXP LPC32xx Platforms Device Tree Bindings
+------------------------------------------
+
+Boards with the NXP LPC32xx SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "nxp,lpc32xx";
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -596,6 +596,7 @@ config ARCH_LPC32XX
 	select USB_ARCH_HAS_OHCI
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select USE_OF
 	help
 	  Support for the NXP LPC32XX family of processors
 
--- /dev/null
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -0,0 +1,262 @@
+/*
+ * NXP LPC32xx SoC
+ *
+ * Copyright 2012 Roland Stigge <stigge@antcom.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "nxp,lpc32xx";
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x20000000 0x20000000 0x30000000>;
+
+		slc: flash at 20020000 {
+			compatible = "nxp,nand-slc";
+			reg = <0x20020000 0x1000>;
+		};
+
+		mlc: flash at 200B0000 {
+			compatible = "nxp,nand-mlc";
+			reg = <0x200B0000 0x1000>;
+		};
+
+		dmac at 31000000 {
+			compatible = "nxp,dmac";
+			reg = <0x31000000 0x1000>;
+		};
+
+		ohci at 31020000 {
+			compatible = "nxp,ohci-nxp", "usb-ohci";
+			reg = <0x31020000 0x300>;
+			interrupt-parent = <&mic>;
+			interrupts = <0x3b 0>;
+		};
+
+		lcd at 31040000 {
+			compatible = "nxp,lcd";
+			reg = <0x31040000 0x1000>;
+		};
+
+		mac: ethernet at 31060000 {
+			compatible = "nxp,lpc-eth";
+			reg = <0x31060000 0x1000>;
+			interrupt-parent = <&mic>;
+			interrupts = <0x1d 0>;
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0x20000000 0x20000000 0x30000000>;
+
+			ssp0: ssp at 20084000 {
+				compatible = "nxp,ssp";
+				reg = <0x20084000 0x1000>;
+			};
+
+			spi1: spi at 20088000 {
+				compatible = "nxp,spi";
+				reg = <0x20088000 0x1000>;
+			};
+
+			ssp1: ssp at 2008C000 {
+				compatible = "nxp,ssp";
+				reg = <0x2008C000 0x1000>;
+			};
+
+			spi2: spi at 20090000 {
+				compatible = "nxp,spi";
+				reg = <0x20090000 0x1000>;
+			};
+
+			i2s0: i2s at 20094000 {
+				compatible = "nxp,i2s";
+				reg = <0x20094000 0x1000>;
+			};
+
+			sd at 20098000 {
+				compatible = "nxp,sd";
+				reg = <0x20098000 0x1000>;
+			};
+
+			i2s1: i2s at 2009C000 {
+				compatible = "nxp,i2s";
+				reg = <0x2009C000 0x1000>;
+			};
+
+			uart3: serial at 40080000 {
+				compatible = "nxp,serial";
+				reg = <0x40080000 0x1000>;
+			};
+
+			uart4: serial at 40088000 {
+				compatible = "nxp,serial";
+				reg = <0x40088000 0x1000>;
+			};
+
+			uart5: serial at 40090000 {
+				compatible = "nxp,serial";
+				reg = <0x40090000 0x1000>;
+			};
+
+			uart6: serial at 40098000 {
+				compatible = "nxp,serial";
+				reg = <0x40098000 0x1000>;
+			};
+
+			i2c1: i2c at 400A0000 {
+				compatible = "nxp,pnx-i2c";
+				reg = <0x400A0000 0x100>;
+				interrupt-parent = <&mic>;
+				interrupts = <0x33 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pnx,timeout = <0x64>;
+			};
+
+			i2c2: i2c at 400A8000 {
+				compatible = "nxp,pnx-i2c";
+				reg = <0x400A8000 0x100>;
+				interrupt-parent = <&mic>;
+				interrupts = <0x32 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pnx,timeout = <0x64>;
+			};
+
+			i2cusb: i2c at 31020300 {
+				compatible = "nxp,pnx-i2c";
+				reg = <0x31020300 0x100>;
+				interrupt-parent = <&mic>;
+				interrupts = <0x3f 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pnx,timeout = <0x64>;
+			};
+		};
+
+		fab {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0x20000000 0x20000000 0x30000000>;
+
+			/*
+			 * MIC Interrupt controller includes:
+			 *   MIC @40008000
+			 *   SIC1 @4000C000
+			 *   SIC2 @40010000
+			 */
+			mic: interrupt-controller at 40008000 {
+				compatible = "nxp,lpc32xx-mic";
+				interrupt-controller;
+				interrupt-parent;
+				reg = <0x40008000 0xC000>;
+				#interrupt-cells = <2>;
+			};
+
+			uart1: serial at 40014000 {
+				compatible = "nxp,serial";
+				reg = <0x40014000 0x1000>;
+			};
+
+			uart2: serial at 40018000 {
+				compatible = "nxp,serial";
+				reg = <0x40018000 0x1000>;
+			};
+
+			uart7: serial at 4001C000 {
+				compatible = "nxp,serial";
+				reg = <0x4001C000 0x1000>;
+			};
+
+			rtc at 40024000 {
+				compatible = "nxp,lpc32xx-rtc";
+				reg = <0x40024000 0x1000>;
+				interrupt-parent = <&mic>;
+				interrupts = <0x34 0>;
+			};
+
+			gpio: gpio at 40028000 {
+				compatible = "nxp,lpc32xx-gpio";
+				reg = <0x40028000 0x1000>;
+				/* create a private address space for enumeration */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio_p0: gpio-bank at 0 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <0>;
+				};
+
+				gpio_p1: gpio-bank at 1 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <1>;
+				};
+
+				gpio_p2: gpio-bank at 2 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <2>;
+				};
+
+				gpio_p3: gpio-bank at 3 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <3>;
+				};
+
+				gpi_p3: gpio-bank at 4 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <4>;
+				};
+
+				gpo_p3: gpio-bank at 5 {
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <5>;
+				};
+			};
+
+			watchdog at 4003C000 {
+				compatible = "nxp,pnx4008-wdt";
+				reg = <0x4003C000 0x1000>;
+			};
+
+			adc at 40048000 {
+				compatible = "nxp,lpc32xx-adc";
+				reg = <0x40048000 0x1000>;
+				interrupt-parent = <&mic>;
+				interrupts = <0x27 0>;
+			};
+
+			key at 40050000 {
+				compatible = "nxp,key";
+				reg = <0x40050000 0x1000>;
+			};
+
+		};
+	};
+};
--- /dev/null
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -0,0 +1,74 @@
+/*
+ * PHYTEC phyCORE-LPC3250 board
+ *
+ * Copyright 2012 Roland Stigge <stigge@antcom.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "lpc32xx.dtsi"
+
+/ {
+	model = "PHYTEC phyCORE-LPC3250 board based on NXP LPC3250";
+	compatible = "phytec,phy3250", "nxp,lpc32xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x4000000>;
+	};
+
+	ahb {
+		mac: ethernet at 31060000 {
+			phy-mode = "rmii";
+			use-iram;
+		};
+
+		apb {
+			i2c1: i2c at 400A0000 {
+				clock-frequency = <0x186a0>;
+
+				pcf8563: rtc at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+				};
+
+				uda1380: uda1380 at 18 {
+					compatible = "nxp,uda1380";
+					reg = <0x18>;
+					power-gpio = <&gpio 0x59 0>;
+					reset-gpio = <&gpio 0x51 0>;
+					dac-clk = "wspll";
+				};
+			};
+
+			i2c2: i2c at 400A8000 {
+				clock-frequency = <0x186a0>;
+			};
+
+			i2cusb: i2c at 31020300 {
+				clock-frequency = <0x186a0>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led0 {
+			gpios = <&gpo_p3 1 1>; /* GPO_P3 1, GPIO 80, active low */
+			linux,default-trigger = "heartbeat";
+			default-state = "keep";
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n81 root=/dev/ram0";
+	};
+};
--- linux-2.6.orig/arch/arm/mach-lpc32xx/Kconfig
+++ linux-2.6/arch/arm/mach-lpc32xx/Kconfig
@@ -29,30 +29,4 @@ config ARCH_LPC32XX_UART6_SELECT
 
 endmenu
 
-menu "LPC32XX chip components"
-
-config ARCH_LPC32XX_IRAM_FOR_NET
-	bool "Use IRAM for network buffers"
-	default y
-	help
-	  Say Y here to use the LPC internal fast IRAM (i.e. 256KB SRAM) as
-	  network buffer.  If the total combined required buffer sizes is
-	  larger than the size of IRAM, then SDRAM will be used instead.
-
-	  This can be enabled safely if the IRAM is not intended for other
-	  uses.
-
-config ARCH_LPC32XX_MII_SUPPORT
-	bool "Check to enable MII support or leave disabled for RMII support"
-	help
-	  Say Y here to enable MII support, or N for RMII support. Regardless of
-	  which support is selected, the ethernet interface driver needs to be
-	  selected in the device driver networking section.
-
-	  The PHY3250 reference board uses RMII, so users of this board should
-	  say N.
-
-endmenu
-
 endif
-
--- linux-2.6.orig/arch/arm/mach-lpc32xx/common.c
+++ linux-2.6/arch/arm/mach-lpc32xx/common.c
@@ -31,87 +31,6 @@
 #include <mach/platform.h>
 #include "common.h"
 
-/*
- * Watchdog timer
- */
-static struct resource watchdog_resources[] = {
-	[0] = {
-		.start = LPC32XX_WDTIM_BASE,
-		.end = LPC32XX_WDTIM_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device lpc32xx_watchdog_device = {
-	.name = "pnx4008-watchdog",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(watchdog_resources),
-	.resource = watchdog_resources,
-};
-
-/*
- * I2C busses
- */
-static struct resource i2c0_resources[] = {
-	[0] = {
-		.start = LPC32XX_I2C1_BASE,
-		.end = LPC32XX_I2C1_BASE + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_LPC32XX_I2C_1,
-		.end = IRQ_LPC32XX_I2C_1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource i2c1_resources[] = {
-	[0] = {
-		.start = LPC32XX_I2C2_BASE,
-		.end = LPC32XX_I2C2_BASE + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_LPC32XX_I2C_2,
-		.end = IRQ_LPC32XX_I2C_2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource i2c2_resources[] = {
-	[0] = {
-		.start = LPC32XX_OTG_I2C_BASE,
-		.end = LPC32XX_OTG_I2C_BASE + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_LPC32XX_USB_I2C,
-		.end = IRQ_LPC32XX_USB_I2C,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device lpc32xx_i2c0_device = {
-	.name = "pnx-i2c.0",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(i2c0_resources),
-	.resource = i2c0_resources,
-};
-
-struct platform_device lpc32xx_i2c1_device = {
-	.name = "pnx-i2c.1",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(i2c1_resources),
-	.resource = i2c1_resources,
-};
-
-struct platform_device lpc32xx_i2c2_device = {
-	.name = "pnx-i2c.2",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(i2c2_resources),
-	.resource = i2c2_resources,
-};
-
 /* TSC (Touch Screen Controller) */
 
 static struct resource lpc32xx_tsc_resources[] = {
@@ -133,96 +52,6 @@ struct platform_device lpc32xx_tsc_devic
 	.resource = lpc32xx_tsc_resources,
 };
 
-/* RTC */
-
-static struct resource lpc32xx_rtc_resources[] = {
-	{
-		.start = LPC32XX_RTC_BASE,
-		.end = LPC32XX_RTC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},{
-		.start = IRQ_LPC32XX_RTC,
-		.end = IRQ_LPC32XX_RTC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device lpc32xx_rtc_device = {
-	.name =  "rtc-lpc32xx",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(lpc32xx_rtc_resources),
-	.resource = lpc32xx_rtc_resources,
-};
-
-/*
- * ADC support
- */
-static struct resource adc_resources[] = {
-	{
-		.start = LPC32XX_ADC_BASE,
-		.end = LPC32XX_ADC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = IRQ_LPC32XX_TS_IRQ,
-		.end = IRQ_LPC32XX_TS_IRQ,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device lpc32xx_adc_device = {
-	.name =  "lpc32xx-adc",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(adc_resources),
-	.resource = adc_resources,
-};
-
-/*
- * USB support
- */
-/* The dmamask must be set for OHCI to work */
-static u64 ohci_dmamask = ~(u32) 0;
-static struct resource ohci_resources[] = {
-	{
-		.start = IO_ADDRESS(LPC32XX_USB_BASE),
-		.end = IO_ADDRESS(LPC32XX_USB_BASE + 0x100 - 1),
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = IRQ_LPC32XX_USB_HOST,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-struct platform_device lpc32xx_ohci_device = {
-	.name = "usb-ohci",
-	.id = -1,
-	.dev = {
-		.dma_mask = &ohci_dmamask,
-		.coherent_dma_mask = 0xFFFFFFFF,
-	},
-	.num_resources = ARRAY_SIZE(ohci_resources),
-	.resource = ohci_resources,
-};
-
-/*
- * Network Support
- */
-static struct resource net_resources[] = {
-	[0] = DEFINE_RES_MEM(LPC32XX_ETHERNET_BASE, SZ_4K),
-	[1] = DEFINE_RES_MEM(LPC32XX_IRAM_BASE, SZ_128K),
-	[2] = DEFINE_RES_IRQ(IRQ_LPC32XX_ETHERNET),
-};
-
-static u64 lpc32xx_mac_dma_mask = 0xffffffffUL;
-struct platform_device lpc32xx_net_device = {
-	.name = "lpc-eth",
-	.id = 0,
-	.dev = {
-		.dma_mask = &lpc32xx_mac_dma_mask,
-		.coherent_dma_mask = 0xffffffffUL,
-	},
-	.num_resources = ARRAY_SIZE(net_resources),
-	.resource = net_resources,
-};
-
 /*
  * Returns the unique ID for the device
  */
--- linux-2.6.orig/arch/arm/mach-lpc32xx/irq.c
+++ linux-2.6/arch/arm/mach-lpc32xx/irq.c
@@ -22,6 +22,11 @@
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
@@ -44,6 +49,9 @@
 #define SIC1_ATR_DEFAULT	0x00026000
 #define SIC2_ATR_DEFAULT	0x00000000
 
+static struct irq_domain *lpc32xx_mic_domain;
+static struct device_node *lpc32xx_mic_np;
+
 struct lpc32xx_event_group_regs {
 	void __iomem *enab_reg;
 	void __iomem *edge_reg;
@@ -203,7 +211,7 @@ static void lpc32xx_mask_irq(struct irq_
 {
 	unsigned int reg, ctrl, mask;
 
-	get_controller(d->irq, &ctrl, &mask);
+	get_controller(d->hwirq, &ctrl, &mask);
 
 	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) & ~mask;
 	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
@@ -213,7 +221,7 @@ static void lpc32xx_unmask_irq(struct ir
 {
 	unsigned int reg, ctrl, mask;
 
-	get_controller(d->irq, &ctrl, &mask);
+	get_controller(d->hwirq, &ctrl, &mask);
 
 	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) | mask;
 	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
@@ -223,14 +231,14 @@ static void lpc32xx_ack_irq(struct irq_d
 {
 	unsigned int ctrl, mask;
 
-	get_controller(d->irq, &ctrl, &mask);
+	get_controller(d->hwirq, &ctrl, &mask);
 
 	__raw_writel(mask, LPC32XX_INTC_RAW_STAT(ctrl));
 
 	/* Also need to clear pending wake event */
-	if (lpc32xx_events[d->irq].mask != 0)
-		__raw_writel(lpc32xx_events[d->irq].mask,
-			lpc32xx_events[d->irq].event_group->rawstat_reg);
+	if (lpc32xx_events[d->hwirq].mask != 0)
+		__raw_writel(lpc32xx_events[d->hwirq].mask,
+			lpc32xx_events[d->hwirq].event_group->rawstat_reg);
 }
 
 static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
@@ -274,22 +282,22 @@ static int lpc32xx_set_irq_type(struct i
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		/* Rising edge sensitive */
-		__lpc32xx_set_irq_type(d->irq, 1, 1);
+		__lpc32xx_set_irq_type(d->hwirq, 1, 1);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 		/* Falling edge sensitive */
-		__lpc32xx_set_irq_type(d->irq, 0, 1);
+		__lpc32xx_set_irq_type(d->hwirq, 0, 1);
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
 		/* Low level sensitive */
-		__lpc32xx_set_irq_type(d->irq, 0, 0);
+		__lpc32xx_set_irq_type(d->hwirq, 0, 0);
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
 		/* High level sensitive */
-		__lpc32xx_set_irq_type(d->irq, 1, 0);
+		__lpc32xx_set_irq_type(d->hwirq, 1, 0);
 		break;
 
 	/* Other modes are not supported */
@@ -298,7 +306,7 @@ static int lpc32xx_set_irq_type(struct i
 	}
 
 	/* Ok to use the level handler for all types */
-	irq_set_handler(d->irq, handle_level_irq);
+	irq_set_handler(d->hwirq, handle_level_irq);
 
 	return 0;
 }
@@ -307,33 +315,33 @@ static int lpc32xx_irq_wake(struct irq_d
 {
 	unsigned long eventreg;
 
-	if (lpc32xx_events[d->irq].mask != 0) {
-		eventreg = __raw_readl(lpc32xx_events[d->irq].
+	if (lpc32xx_events[d->hwirq].mask != 0) {
+		eventreg = __raw_readl(lpc32xx_events[d->hwirq].
 			event_group->enab_reg);
 
 		if (state)
-			eventreg |= lpc32xx_events[d->irq].mask;
+			eventreg |= lpc32xx_events[d->hwirq].mask;
 		else {
-			eventreg &= ~lpc32xx_events[d->irq].mask;
+			eventreg &= ~lpc32xx_events[d->hwirq].mask;
 
 			/*
 			 * When disabling the wakeup, clear the latched
 			 * event
 			 */
-			__raw_writel(lpc32xx_events[d->irq].mask,
-				lpc32xx_events[d->irq].
+			__raw_writel(lpc32xx_events[d->hwirq].mask,
+				lpc32xx_events[d->hwirq].
 				event_group->rawstat_reg);
 		}
 
 		__raw_writel(eventreg,
-			lpc32xx_events[d->irq].event_group->enab_reg);
+			lpc32xx_events[d->hwirq].event_group->enab_reg);
 
 		return 0;
 	}
 
 	/* Clear event */
-	__raw_writel(lpc32xx_events[d->irq].mask,
-		lpc32xx_events[d->irq].event_group->rawstat_reg);
+	__raw_writel(lpc32xx_events[d->hwirq].mask,
+		lpc32xx_events[d->hwirq].event_group->rawstat_reg);
 
 	return -ENODEV;
 }
@@ -386,9 +394,23 @@ static void lpc32xx_sic2_handler(unsigne
 	}
 }
 
+static int __init __lpc32xx_mic_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	lpc32xx_mic_np = node;
+
+	return 0;
+}
+
+static const struct of_device_id mic_of_match[] __initconst = {
+	{ .compatible = "nxp,lpc32xx-mic", .data = __lpc32xx_mic_of_init },
+	{ }
+};
+
 void __init lpc32xx_init_irq(void)
 {
 	unsigned int i;
+	int irq_base;
 
 	/* Setup MIC */
 	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_MIC_BASE));
@@ -448,4 +470,19 @@ void __init lpc32xx_init_irq(void)
 		LPC32XX_CLKPWR_PIN_RS);
 	__raw_writel(__raw_readl(LPC32XX_CLKPWR_INT_RS),
 		LPC32XX_CLKPWR_INT_RS);
+
+	of_irq_init(mic_of_match);
+
+	irq_base = irq_alloc_descs(-1, 0, NR_IRQS, 0);
+	if (irq_base < 0) {
+		pr_warn("Cannot allocate irq_descs, assuming pre-allocated\n");
+		irq_base = 0;
+	}
+
+	lpc32xx_mic_domain = irq_domain_add_legacy(lpc32xx_mic_np, NR_IRQS,
+						   irq_base, 0,
+						   &irq_domain_simple_ops,
+						   NULL);
+	if (!lpc32xx_mic_domain)
+		panic("Unable to add MIC irq domain\n");
 }
--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -1,8 +1,9 @@
 /*
- * arch/arm/mach-lpc32xx/phy3250.c
+ * Platform support for LPC32xx SoC
  *
  * Author: Kevin Wells <kevin.wells@nxp.com>
  *
+ * Copyright (C) 2012 Roland Stigge <stigge@antcom.de>
  * Copyright (C) 2010 NXP Semiconductors
  *
  * This program is free software; you can redistribute it and/or modify
@@ -25,11 +26,14 @@
 #include <linux/device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
-#include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl022.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -47,7 +51,6 @@
 #define SPI0_CS_GPIO	LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
 #define LCD_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
 #define BKL_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
-#define LED_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 1)
 
 /*
  * AMBA LCD controller
@@ -221,43 +224,8 @@ static int __init phy3250_spi_board_regi
 }
 arch_initcall(phy3250_spi_board_register);
 
-static struct i2c_board_info __initdata phy3250_i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("pcf8563", 0x51),
-	},
-};
-
-static struct gpio_led phy_leds[] = {
-	{
-		.name			= "led0",
-		.gpio			= LED_GPIO,
-		.active_low		= 1,
-		.default_trigger	= "heartbeat",
-	},
-};
-
-static struct gpio_led_platform_data led_data = {
-	.leds = phy_leds,
-	.num_leds = ARRAY_SIZE(phy_leds),
-};
-
-static struct platform_device lpc32xx_gpio_led_device = {
-	.name			= "leds-gpio",
-	.id			= -1,
-	.dev.platform_data	= &led_data,
-};
-
 static struct platform_device *phy3250_devs[] __initdata = {
-	&lpc32xx_rtc_device,
 	&lpc32xx_tsc_device,
-	&lpc32xx_i2c0_device,
-	&lpc32xx_i2c1_device,
-	&lpc32xx_i2c2_device,
-	&lpc32xx_watchdog_device,
-	&lpc32xx_gpio_led_device,
-	&lpc32xx_adc_device,
-	&lpc32xx_ohci_device,
-	&lpc32xx_net_device,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -265,15 +233,26 @@ static struct amba_device *amba_devs[] _
 	&lpc32xx_ssp0_device,
 };
 
-/*
- * Board specific functions
- */
-static void __init phy3250_board_init(void)
+static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("nxp,lpc32xx-adc", 0x40048000, "lpc32xx-adc", NULL),
+	OF_DEV_AUXDATA("nxp,pnx-i2c", 0x400A0000, "pnx-i2c.0", NULL),
+	OF_DEV_AUXDATA("nxp,pnx-i2c", 0x400A8000, "pnx-i2c.1", NULL),
+	OF_DEV_AUXDATA("nxp,pnx-i2c", 0x31020300, "pnx-i2c.2", NULL),
+	OF_DEV_AUXDATA("nxp,lpc32xx-rtc", 0x40024000, "lpc32xx_rtc", NULL),
+	OF_DEV_AUXDATA("nxp,lpc-eth", 0x31060000, "lpc-eth.0", NULL),
+	OF_DEV_AUXDATA("nxp,pnx4008-wdt", 0x4003C000, "pnx4008-watchdog", NULL),
+	OF_DEV_AUXDATA("nxp,lpc32xx-gpio", 0x40028000, "lpc32xx-gpio", NULL),
+	OF_DEV_AUXDATA("nxp,ohci-nxp", 0x31020000, "usb-ohci", NULL),
+	{ }
+};
+
+static void __init lpc3250_machine_init(void)
 {
 	u32 tmp;
 	int i;
 
-	lpc32xx_gpio_init();
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     lpc32xx_auxdata_lookup, NULL);
 
 	/* Register GPIOs used on this board */
 	if (gpio_request(SPI0_CS_GPIO, "spi0 cs"))
@@ -283,12 +262,6 @@ static void __init phy3250_board_init(vo
 		printk(KERN_ERR "Error setting gpio %u to output",
 			SPI0_CS_GPIO);
 
-	/* Setup network interface for RMII mode */
-	tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
-	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
-	tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
-	__raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
-
 	/* Setup SLC NAND controller muxing */
 	__raw_writel(LPC32XX_CLKPWR_NANDCLK_SEL_SLC,
 		LPC32XX_CLKPWR_NAND_CLK_CTRL);
@@ -345,9 +318,6 @@ static void __init phy3250_board_init(vo
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
 		LPC32XX_CLKPWR_TEST_CLK_SEL);
-
-	i2c_register_board_info(0, phy3250_i2c_board_info,
-		ARRAY_SIZE(phy3250_i2c_board_info));
 }
 
 static int __init lpc32xx_display_uid(void)
@@ -363,12 +333,17 @@ static int __init lpc32xx_display_uid(vo
 }
 arch_initcall(lpc32xx_display_uid);
 
-MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
-	/* Maintainer: Kevin Wells, NXP Semiconductors */
+static char const *lpc32xx_dt_compat[] __initdata = {
+	"nxp,lpc32xx",
+	NULL
+};
+
+DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
 	.atag_offset	= 0x100,
 	.map_io		= lpc32xx_map_io,
 	.init_irq	= lpc32xx_init_irq,
 	.timer		= &lpc32xx_timer,
-	.init_machine	= phy3250_board_init,
+	.init_machine	= lpc3250_machine_init,
+	.dt_compat	= lpc32xx_dt_compat,
 	.restart	= lpc23xx_restart,
 MACHINE_END
