From: Barry.Song@csr.com (Barry Song)
Date: Fri, 31 Aug 2012 18:35:12 +0800
Subject: [RFC/PATCH] ARM: PRIMA2: initial support for SiRFmarco dual-core SoC
Message-ID: <1346409312-16778-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

SiRFmarco is a dual-core cortex-A9 SoC. This patch adds initial support for it.
It is only a RFC for early review from community. I'd like to split it into
multiple patches later.
change list:
1. Marco has different OS timer hardware with Prima2, so add a new timer-marco
2. add platsmp.c, headsmp.S and hotplug.c for MPcore support
3. some hardwares have changed, like rstc, so use of_compatible to branch Prima2 and Marco
4. add initial .dtsi for Marco SoC and initial .dts for the EVB
5. some hardware support both Prima2 and Marco, add marco stuff to of_match tables
6. use GIC for Marco instead of Prima2's IRQ controller
7. add DEBUG_LL uart ports for Prima2 and Marco debug ports

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig                                 |    3 +-
 arch/arm/Kconfig.debug                           |   14 +
 arch/arm/Makefile                                |    2 +-
 arch/arm/boot/dts/marco-evb.dts                  |   20 +
 arch/arm/boot/dts/marco.dtsi                     |  497 ++++++++++++++++++++++
 arch/arm/configs/marcocb_defconfig               |   86 ++++
 arch/arm/mach-prima2/Kconfig                     |   14 +
 arch/arm/mach-prima2/Makefile                    |    5 +-
 arch/arm/mach-prima2/common.c                    |   44 ++-
 arch/arm/mach-prima2/common.h                    |    6 +-
 arch/arm/mach-prima2/headsmp.S                   |   79 ++++
 arch/arm/mach-prima2/hotplug.c                   |   57 +++
 arch/arm/mach-prima2/include/mach/uart.h         |    4 +
 arch/arm/mach-prima2/l2x0.c                      |   19 +-
 arch/arm/mach-prima2/platsmp.c                   |  154 +++++++
 arch/arm/mach-prima2/pm.c                        |    1 +
 arch/arm/mach-prima2/rstc.c                      |   47 ++-
 arch/arm/mach-prima2/rtciobrg.c                  |    1 +
 arch/arm/mach-prima2/timer-marco.c               |  295 +++++++++++++
 arch/arm/mach-prima2/{timer.c => timer-prima2.c} |    4 +-
 drivers/pinctrl/Kconfig                          |    2 +-
 21 files changed, 1326 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/boot/dts/marco-evb.dts
 create mode 100644 arch/arm/boot/dts/marco.dtsi
 create mode 100644 arch/arm/configs/marcocb_defconfig
 create mode 100644 arch/arm/mach-prima2/headsmp.S
 create mode 100644 arch/arm/mach-prima2/hotplug.c
 create mode 100644 arch/arm/mach-prima2/platsmp.c
 create mode 100644 arch/arm/mach-prima2/timer-marco.c
 rename arch/arm/mach-prima2/{timer.c => timer-prima2.c} (98%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 00ef0e0..8f2fe64 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -418,8 +418,9 @@ config ARCH_SIRF
 	select PINCTRL
 	select PINCTRL_SIRF
 	select USE_OF
+	select AUTO_ZRELADDR
 	help
-	  Support for CSR SiRFprimaII/Marco/Polo platforms
+	 Support for CSR SiRFprimaII/Marco/Polo platforms
 
 config ARCH_EBSA110
 	bool "EBSA-110"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f15f82b..2e63c78 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -310,6 +310,20 @@ choice
 		  The uncompressor code port configuration is now handled
 		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+	config DEBUG_SIRFPRIMA2_UART1
+		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
+		depends on ARCH_PRIMA2
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart1 port on SiRFprimaII devices.
+
+	config DEBUG_SIRFMARCO_UART1
+		bool "Kernel low-level debugging messages via SiRFmarco UART1"
+		depends on ARCH_MARCO
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart1 port on SiRFmarco devices.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..6fbec07 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -168,7 +168,6 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
-machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
@@ -182,6 +181,7 @@ machine-$(CONFIG_ARCH_EXYNOS5)		:= exynos
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
+machine-$(CONFIG_ARCH_SIRF)		:= prima2
 machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
diff --git a/arch/arm/boot/dts/marco-evb.dts b/arch/arm/boot/dts/marco-evb.dts
new file mode 100644
index 0000000..8b2dc61
--- /dev/null
+++ b/arch/arm/boot/dts/marco-evb.dts
@@ -0,0 +1,20 @@
+/*
+ * DTS file for CSR SiRFmarco Evaluation Board
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+
+/include/ "marco.dtsi"
+
+/ {
+	model = "CSR SiRFmarco Evaluation Board";
+	compatible = "sirf,marco", "sirf,marco-cb";
+
+	memory {
+		reg = <0x40000000 0x60000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
new file mode 100644
index 0000000..34aad72
--- /dev/null
+++ b/arch/arm/boot/dts/marco.dtsi
@@ -0,0 +1,497 @@
+/*
+ * DTS file for CSR SiRFmarco SoC
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+/ {
+	compatible = "sirf,marco";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x40000000 0x40000000 0xa0000000>;
+
+		l2-cache-controller at c0030000 {
+			compatible = "arm,pl310-cache", "sirf,marco-pl310-cache";
+			reg = <0xc0030000 0x1000>;
+			interrupts = <0 59 0>;
+			arm,tag-latency = <1 1 1>;
+			arm,data-latency = <1 1 1>;
+			arm,filter-ranges = <0x40000000 0xc0000000>;
+		};
+
+                gic: interrupt-controller at c0011000 {
+                        compatible = "arm,cortex-a9-gic";
+                        interrupt-controller;
+                        #interrupt-cells = <3>;
+                        reg = <0xc0011000 0x1000>,
+                              <0xc0010100 0x0100>;
+                };
+
+		 rstc-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc2000000 0xc2000000 0x10000>;
+
+			reset-controller at c2000000 {
+				compatible = "sirf,marco-rstc";
+				reg = <0xc2000000 0x10000>;
+			};
+		};
+
+		sys-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc3000000 0xc3000000 0x30000>;
+
+			clock-controller at c3000000 {
+				compatible = "sirf,marco-clkc";
+				reg = <0xc3000000 0x1000>;
+				interrupts = <0 3 0>;
+			};
+
+			rsc-controller at c3010000 {
+				compatible = "sirf,marco-rsc";
+				reg = <0xc3010000 0x1000>;
+			};
+		};
+
+		mem-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc4000000 0xc4000000 0x10000>;
+
+			memory-controller at c4000000 {
+				compatible = "sirf,marco-memc";
+				reg = <0xc4000000 0x10000>;
+				interrupts = <0 27 0>;
+			};
+		};
+
+		disp-iobg0 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc5000000 0xc5000000 0x20000>;
+
+			display0 at c5000000 {
+				compatible = "sirf,marco-lcd";
+				reg = <0xc5000000 0x10000>;
+				interrupts = <0 30 0>;
+			};
+
+			vpp0 at c5010000 {
+				compatible = "sirf,marco-vpp";
+				reg = <0xc5010000 0x10000>;
+				interrupts = <0 31 0>;
+			};
+		};
+
+		disp-iobg1 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc6000000 0xc6000000 0x20000>;
+
+			display1 at c6000000 {
+				compatible = "sirf,marco-lcd";
+				reg = <0xc6000000 0x10000>;
+				interrupts = <0 62 0>;
+			};
+
+			vpp1 at c6010000 {
+				compatible = "sirf,marco-vpp";
+				reg = <0xc6010000 0x10000>;
+				interrupts = <0 63 0>;
+			};
+		};
+
+		graphics-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc8000000 0xc8000000 0x1000000>;
+
+			graphics at c8000000 {
+				compatible = "powervr,sgx540";
+				reg = <0xc8000000 0x1000000>;
+				interrupts = <0 6 0>;
+			};
+		};
+
+		multimedia-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xc9000000 0xc9000000 0x1000000>;
+
+			multimedia at a0000000 {
+				compatible = "sirf,marco-video-codec";
+				reg = <0xc9000000 0x1000000>;
+				interrupts = <0 5 0>;
+			};
+		};
+
+		dsp-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xca000000 0xca000000 0x2000000>;
+
+			dspif at ca000000 {
+				compatible = "sirf,marco-dspif";
+				reg = <0xca000000 0x10000>;
+				interrupts = <0 9 0>;
+			};
+
+			gps at ca010000 {
+				compatible = "sirf,marco-gps";
+				reg = <0xca010000 0x10000>;
+				interrupts = <0 7 0>;
+			};
+
+			dsp at cb000000 {
+				compatible = "sirf,marco-dsp";
+				reg = <0xcb000000 0x1000000>;
+				interrupts = <0 8 0>;
+			};
+		};
+
+		peri-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xcc000000 0xcc000000 0x1b0000>;
+
+			timer at cc020000 {
+				compatible = "sirf,marco-tick";
+				reg = <0xcc020000 0x1000>;
+				interrupts = <0 0 0>;
+			};
+
+			nand at cc030000 {
+				compatible = "sirf,marco-nand";
+				reg = <0xcc030000 0x10000>;
+				interrupts = <0 41 0>;
+			};
+
+			audio at cc040000 {
+				compatible = "sirf,marco-audio";
+				reg = <0xcc040000 0x10000>;
+				interrupts = <0 35 0>;
+			};
+
+			uart0: uart at cc050000 {
+				cell-index = <0>;
+				compatible = "sirf,marco-uart";
+				reg = <0xcc050000 0x1000>;
+				interrupts = <0 17 0>;
+				fifosize = <128>;
+			};
+
+			uart1: uart at cc060000 {
+				cell-index = <1>;
+				compatible = "sirf,marco-uart";
+				reg = <0xcc060000 0x1000>;
+				interrupts = <0 18 0>;
+				fifosize = <32>;
+			};
+
+			uart2: uart at cc070000 {
+				cell-index = <2>;
+				compatible = "sirf,marco-uart";
+				reg = <0xcc070000 0x1000>;
+				interrupts = <0 19 0>;
+				fifosize = <128>;
+			};
+
+			uart3: uart at cc190000 {
+				cell-index = <3>;
+				compatible = "sirf,marco-uart";
+				reg = <0xcc190000 0x1000>;
+				interrupts = <0 66 0>;
+				fifosize = <128>;
+			};
+
+			uart4: uart at cc1a0000 {
+				cell-index = <4>;
+				compatible = "sirf,marco-uart";
+				reg = <0xcc1a0000 0x1000>;
+				interrupts = <0 69 0>;
+				fifosize = <128>;
+			};
+
+			usp0: usp at cc080000 {
+				cell-index = <0>;
+				compatible = "sirf,marco-usp";
+				reg = <0xcc080000 0x10000>;
+				interrupts = <0 20 0>;
+			};
+
+			usp1: usp at cc090000 {
+				cell-index = <1>;
+				compatible = "sirf,marco-usp";
+				reg = <0xcc090000 0x10000>;
+				interrupts = <0 21 0>;
+			};
+
+			usp2: usp at cc0a0000 {
+				cell-index = <2>;
+				compatible = "sirf,marco-usp";
+				reg = <0xcc0a0000 0x10000>;
+				interrupts = <0 22 0>;
+			};
+
+			dmac0: dma-controller at cc0b0000 {
+				cell-index = <0>;
+				compatible = "sirf,marco-dmac";
+				reg = <0xcc0b0000 0x10000>;
+				interrupts = <0 12 0>;
+			};
+
+			dmac1: dma-controller at cc160000 {
+				cell-index = <1>;
+				compatible = "sirf,marco-dmac";
+				reg = <0xcc160000 0x10000>;
+				interrupts = <0 13 0>;
+			};
+
+			vip at cc0c0000 {
+				compatible = "sirf,marco-vip";
+				reg = <0xcc0c0000 0x10000>;
+			};
+
+			spi0: spi at cc0D0000 {
+				cell-index = <0>;
+				compatible = "sirf,marco-spi";
+				reg = <0xcc0D0000 0x10000>;
+				interrupts = <0 15 0>;
+				sirf,spi-num-chipselects = <1>;
+				cs-gpios = <&gpio 0 0>;
+			};
+
+			spi1: spi at cc170000 {
+				cell-index = <1>;
+				compatible = "sirf,marco-spi";
+				reg = <0xcc170000 0x10000>;
+				interrupts = <0 16 0>;
+				sirf,spi-num-chipselects = <1>;
+				cs-gpios = <&gpio 0 0>;
+			};
+
+			i2c0: i2c at cc0e0000 {
+				cell-index = <0>;
+				compatible = "sirf,marco-i2c";
+				reg = <0xcc0e0000 0x10000>;
+				interrupts = <0 24 0>;
+			};
+
+			i2c1: i2c at cc0f0000 {
+				cell-index = <1>;
+				compatible = "sirf,marco-i2c";
+				reg = <0xcc0f0000 0x10000>;
+				interrupts = <0 25 0>;
+			};
+
+			tsc at cc110000 {
+				compatible = "sirf,marco-tsc";
+				reg = <0xcc110000 0x10000>;
+				interrupts = <0 33 0>;
+			};
+
+			gpio: gpio-controller at cc120000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,marco-gpio-pinmux";
+				reg = <0xcc120000 0x10000>;
+				interrupts = <0 43 0>,
+					   <0 44 0>,
+					   <0 45 0>,
+					   <0 46 0>,
+					   <0 47 0>;
+				gpio-controller;
+				interrupt-controller;
+			};
+
+			pwm at cc130000 {
+				compatible = "sirf,marco-pwm";
+				reg = <0xcc130000 0x10000>;
+			};
+
+			efusesys at cc140000 {
+				compatible = "sirf,marco-efuse";
+				reg = <0xcc140000 0x10000>;
+			};
+
+			pulsec at cc150000 {
+				compatible = "sirf,marco-pulsec";
+				reg = <0xcc150000 0x10000>;
+				interrupts = <0 48 0>;
+			};
+
+			pci-iobg {
+				compatible = "sirf,marco-pciiobg", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0xcD000000 0xcD000000 0x1000000>;
+
+				sd0: sdhci at cD000000 {
+					cell-index = <0>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD000000 0x100000>;
+					interrupts = <0 38 0>;
+				};
+
+				sd1: sdhci at cD100000 {
+					cell-index = <1>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD100000 0x100000>;
+					interrupts = <0 38 0>;
+				};
+
+				sd2: sdhci at cD200000 {
+					cell-index = <2>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD200000 0x100000>;
+					interrupts = <0 23 0>;
+				};
+
+				sd3: sdhci at cD300000 {
+					cell-index = <3>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD300000 0x100000>;
+					interrupts = <0 23 0>;
+				};
+
+				sd4: sdhci at cD400000 {
+					cell-index = <4>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD400000 0x100000>;
+					interrupts = <0 39 0>;
+				};
+
+				sd5: sdhci at cD500000 {
+					cell-index = <5>;
+					compatible = "sirf,marco-sdhc";
+					reg = <0xcD500000 0x100000>;
+					interrupts = <0 39 0>;
+				};
+
+				pci-copy at cD900000 {
+					compatible = "sirf,marco-pcicp";
+					reg = <0xcD900000 0x100000>;
+					interrupts = <0 40 0>;
+				};
+
+				rom-interface at cDa00000 {
+					compatible = "sirf,marco-romif";
+					reg = <0xcDa00000 0x100000>;
+				};
+			};
+		};
+
+		rtc-iobg {
+			compatible = "sirf,marco-rtciobg", "sirf-marco-rtciobg-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xc1000000 0x10000>;
+
+			gpsrtc at 1000 {
+				compatible = "sirf,marco-gpsrtc";
+				reg = <0x1000 0x1000>;
+				interrupts = <0 55 0>,
+					   <0 56 0>,
+					   <0 57 0>;
+			};
+
+			sysrtc at 2000 {
+				compatible = "sirf,marco-sysrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <0 52 0>,
+					   <0 53 0>,
+					   <0 54 0>;
+			};
+
+			pwrc at 3000 {
+				compatible = "sirf,marco-pwrc";
+				reg = <0x3000 0x1000>;
+				interrupts = <0 32 0>;
+			};
+		};
+
+		uus-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xce000000 0xce000000 0x40000>;
+
+			usb0: usb at ce000000 {
+				compatible = "chipidea,ci13611a-marco";
+				reg = <0xce000000 0x10000>;
+				interrupts = <0 10 0>;
+			};
+
+			usb1: usb at ce010000 {
+				compatible = "chipidea,ci13611a-marco";
+				reg = <0xce010000 0x10000>;
+				interrupts = <0 11 0>;
+			};
+
+			security at ce020000 {
+				compatible = "sirf,marco-security";
+				reg = <0xce020000 0x10000>;
+				interrupts = <0 42 0>;
+			};
+		};
+
+		can-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xD0000000 0xD0000000 0x20000>;
+
+			can0: can at D0000000 {
+				compatible = "sirf,marco-can";
+				reg = <0xD0000000 0x10000>;
+			};
+
+			can1: can at D0010000 {
+				compatible = "sirf,marco-can";
+				reg = <0xD0010000 0x10000>;
+			};
+		};
+
+		lvds-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xD1000000 0xD1000000 0x10000>;
+
+			lvds at D1000000 {
+				compatible = "sirf,marco-lvds";
+				reg = <0xD1000000 0x10000>;
+				interrupts = <0 64 0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/configs/marcocb_defconfig b/arch/arm/configs/marcocb_defconfig
new file mode 100644
index 0000000..1a9829d
--- /dev/null
+++ b/arch/arm/configs/marcocb_defconfig
@@ -0,0 +1,86 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_PERF_EVENTS=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_ARCH_SIRF=y
+# CONFIG_ARCH_PRIMA2 is not set
+# CONFIG_SWP_EMULATE is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+# CONFIG_LOCAL_TIMERS is not set
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_KEXEC=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_BINFMT_AOUT=y
+CONFIG_BINFMT_MISC=y
+CONFIG_PM_RUNTIME=y
+CONFIG_PM_DEBUG=y
+CONFIG_PM_ADVANCED_DEBUG=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_POWER_SUPPLY=y
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_DMADEVICES=y
+CONFIG_DMADEVICES_DEBUG=y
+CONFIG_DMADEVICES_VDEBUG=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CRC_CCITT=y
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 41fc853..1ad4dd3 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -11,9 +11,23 @@ config ARCH_PRIMA2
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
+config ARCH_MARCO
+	bool "CSR SiRFSoC MARCO ARM Cortex A9 Platform"
+	default y
+	select CPU_V7
+	select HAVE_SMP
+	select SMP_ON_UP
+	select ARM_GIC
+	select SIRFMARCO_FPGA
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
 endmenu
 
 config SIRF_IRQ
 	bool
 
+config SIRFMARCO_FPGA
+	bool "CSR SiRFmarco FPGA with 26Mhz io clock"
+
 endif
diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index fc9ce22..bfe360c 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -1,4 +1,3 @@
-obj-y := timer.o
 obj-y += rstc.o
 obj-y += common.o
 obj-y += rtciobrg.o
@@ -6,3 +5,7 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
 obj-$(CONFIG_CACHE_L2X0) += l2x0.o
 obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SIRF_IRQ) += irq.o
+obj-$(CONFIG_SMP) += platsmp.o headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
+obj-$(CONFIG_ARCH_PRIMA2) += timer-prima2.o
+obj-$(CONFIG_ARCH_MARCO) += timer-marco.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index f25a541..3ee1457 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -8,9 +8,11 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include "common.h"
@@ -32,15 +34,15 @@ void __init sirfsoc_init_late(void)
 
 #ifdef CONFIG_ARCH_PRIMA2
 static const char *prima2_dt_match[] __initdata = {
-       "sirf,prima2",
-       NULL
+	"sirf,prima2",
+	NULL
 };
 
 DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_lluart,
 	.init_irq	= sirfsoc_of_irq_init,
-	.timer		= &sirfsoc_timer,
+	.timer		= &sirfsoc_prima2_timer,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
@@ -48,3 +50,39 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.restart	= sirfsoc_restart,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_ARCH_MARCO
+static __init void sirfsoc_map_io(void)
+{
+	sirfsoc_map_lluart();
+	sirfsoc_map_scu();
+}
+
+static const struct of_device_id marco_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ /* sentinel */ }
+};
+
+static void __init marco_init_irq(void)
+{
+	of_irq_init(marco_irq_match);
+}
+
+static const char *marco_dt_match[] __initdata = {
+	"sirf,marco",
+	NULL
+};
+
+DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
+	/* Maintainer: Barry Song <baohua.song@csr.com> */
+	.map_io         = sirfsoc_map_io,
+	.init_irq	= marco_init_irq,
+	.handle_irq     = gic_handle_irq,
+	.timer		= &sirfsoc_marco_timer,
+	.init_machine	= sirfsoc_mach_init,
+	.init_late	= sirfsoc_init_late,
+	.dt_compat      = marco_dt_match,
+	.restart	= sirfsoc_restart,
+MACHINE_END
+#endif
+
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 60d826f..2e82e41 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -12,11 +12,13 @@
 #include <linux/init.h>
 #include <asm/mach/time.h>
 
-extern struct sys_timer sirfsoc_timer;
+extern struct sys_timer sirfsoc_prima2_timer;
+extern struct sys_timer sirfsoc_marco_timer;
 
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
 extern void sirfsoc_restart(char, const char *);
+extern void sirfsoc_secondary_startup(void);
 
 #ifndef CONFIG_DEBUG_LL
 static inline void sirfsoc_map_lluart(void)  {}
@@ -24,6 +26,8 @@ static inline void sirfsoc_map_lluart(void)  {}
 extern void __init sirfsoc_map_lluart(void);
 #endif
 
+extern void sirfsoc_map_scu(void);
+
 #ifdef CONFIG_SUSPEND
 extern int sirfsoc_pm_init(void);
 #else
diff --git a/arch/arm/mach-prima2/headsmp.S b/arch/arm/mach-prima2/headsmp.S
new file mode 100644
index 0000000..6ec19d5
--- /dev/null
+++ b/arch/arm/mach-prima2/headsmp.S
@@ -0,0 +1,79 @@
+/*
+ * Entry of the second core for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+/*
+ * Cold boot and hardware reset show different behaviour,
+ * system will be always panic if we warm-reset the board
+ * Here we invalidate L1 of CPU1 to make sure there isn't
+ * uninitialized data written into memory later
+ */
+ENTRY(v7_invalidate_l1)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
+	mcr	p15, 2, r0, c0, c0, 0
+	mrc	p15, 1, r0, c0, c0, 0
+
+	ldr	r1, =0x7fff
+	and	r2, r1, r0, lsr #13
+
+	ldr	r1, =0x3ff
+
+	and	r3, r1, r0, lsr #3	@ NumWays - 1
+	add	r2, r2, #1		@ NumSets
+
+	and	r0, r0, #0x7
+	add	r0, r0, #4	@ SetShift
+
+	clz	r1, r3		@ WayShift
+	add	r4, r3, #1	@ NumWays
+1:	sub	r2, r2, #1	@ NumSets--
+	mov	r3, r4		@ Temp = NumWays
+2:	subs	r3, r3, #1	@ Temp--
+	mov	r5, r3, lsl r1
+	mov	r6, r2, lsl r0
+	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
+	mcr	p15, 0, r5, c7, c6, 2
+	bgt	2b
+	cmp	r2, #0
+	bgt	1b
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7_invalidate_l1)
+
+/*
+ * SIRFSOC specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(sirfsoc_secondary_startup)
+	bl v7_invalidate_l1
+        mrc     p15, 0, r0, c0, c0, 5
+        and     r0, r0, #15
+        adr     r4, 1f
+        ldmia   r4, {r5, r6}
+        sub     r4, r4, r5
+        add     r6, r6, r4
+pen:    ldr     r7, [r6]
+        cmp     r7, r0
+        bne     pen
+
+        /*
+         * we've been released from the holding pen: secondary_stack
+         * should now contain the SVC stack for this core
+         */
+        b       secondary_startup
+ENDPROC(sirfsoc_secondary_startup)
+
+        .align
+1:      .long   .
+        .long   pen_release
diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
new file mode 100644
index 0000000..7d5febe
--- /dev/null
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -0,0 +1,57 @@
+/*
+ * CPU hotplug support for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+
+extern volatile int pen_release;
+
+static inline void platform_do_lowpower(unsigned int cpu)
+{
+	flush_cache_all();
+
+	/* we put the platform to just WFI */
+	for (;;) {
+		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
+			: : : "memory");
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+	}
+}
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	platform_do_lowpower(cpu);
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-prima2/include/mach/uart.h
index c98b4d5..e5953d2 100644
--- a/arch/arm/mach-prima2/include/mach/uart.h
+++ b/arch/arm/mach-prima2/include/mach/uart.h
@@ -10,7 +10,11 @@
 #define __MACH_PRIMA2_SIRFSOC_UART_H
 
 /* UART-1: used as serial debug port */
+#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
 #define SIRFSOC_UART1_PA_BASE          0xb0060000
+#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#endif
 #define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
 #define SIRFSOC_UART1_SIZE		SZ_4K
 
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index c998377..35a2973 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -11,21 +11,38 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 
+/*
+ * fixme: make aux_val and aux_mask the private data
+ * of of_device_id after we get right aux_val/mask
+ */
 static struct of_device_id prima2_l2x0_ids[]  = {
 	{ .compatible = "sirf,prima2-pl310-cache" },
 	{},
 };
 
+static struct of_device_id marco_l2x0_ids[]  = {
+	{ .compatible = "sirf,marco-pl310-cache" },
+	{},
+};
+
 static int __init sirfsoc_l2x0_init(void)
 {
 	struct device_node *np;
-
 	np = of_find_matching_node(NULL, prima2_l2x0_ids);
 	if (np) {
 		pr_info("Initializing prima2 L2 cache\n");
 		return l2x0_of_init(0x40000, 0);
 	}
 
+	np = of_find_matching_node(NULL, marco_l2x0_ids);
+	if (np) {
+		pr_info("Initializing marco L2 cache\n");
+		/*
+		 * fixme: set the right aux_val and aux_mask
+		 * return l2x0_of_init(0x10000, 0);
+		 */
+	}
+
 	return 0;
 }
 early_initcall(sirfsoc_l2x0_init);
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
new file mode 100644
index 0000000..e990a79
--- /dev/null
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -0,0 +1,154 @@
+/*
+ * plat smp support for CSR Marco dual-core SMP SoCs
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/hardware/gic.h>
+#include <mach/map.h>
+
+#include "common.h"
+
+static void __iomem *scu_base;
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen".
+ */
+volatile int pen_release = -1;
+
+static DEFINE_SPINLOCK(boot_lock);
+
+static struct map_desc scu_io_desc __initdata = {
+	.length		= SZ_4K,
+	.type		= MT_DEVICE,
+};
+
+void __init sirfsoc_map_scu(void)
+{
+	unsigned long base;
+
+	/* Get SCU base */
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+
+	scu_io_desc.virtual = SIRFSOC_VA(base);
+	scu_io_desc.pfn = __phys_to_pfn(base);
+	iotable_init(&scu_io_desc, 1);
+
+	scu_base = (void __iomem *)SIRFSOC_VA(base);
+}
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+	static void __iomem *sram_base;
+
+	/* for the moment in FPGA we use DSP SRAM */
+#define SIRFSOC_DSP_SRAM_BASE 0xCA008000UL
+	sram_base = ioremap_nocache(SIRFSOC_DSP_SRAM_BASE, SZ_4K);
+
+	/*
+	 * write the address of secondary startup into the sram register
+	 * at offset 0x34, then write the magic number 0x12345678 to the
+	 * sram register at offset 0x30, which is what boot rom code is
+	 * waiting for. This would wake up the secondary core from WFI
+	 */
+#define SIRFSOC_CPU1_JUMPADDR_OFFSET 0x34
+	__raw_writel(virt_to_phys(sirfsoc_secondary_startup),
+		sram_base + SIRFSOC_CPU1_JUMPADDR_OFFSET);
+
+#define SIRFSOC_CPU1_WAKEMAGIC_OFFSET 0x30
+	__raw_writel(0x12345678,
+		sram_base + SIRFSOC_CPU1_WAKEMAGIC_OFFSET);
+
+	/* make sure write buffer is drained */
+	mb();
+
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu_logical_map(cpu);
+	__cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
+	outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
+
+	/*
+	 * Send the secondary CPU a soft interrupt ID15, thereby causing
+	 * the boot monitor to read the JUMPADDR and WAKEMAGIC, and branch
+	 * to the address found there.
+	 */
+	gic_raise_softirq(cpumask_of(cpu), 15);
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+void __init smp_init_cpus(void)
+{
+	int i, ncores;
+
+	ncores = scu_get_core_count(scu_base);
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(scu_base);
+}
diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index fb5a791..a16dec7 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -93,6 +93,7 @@ int __init sirfsoc_pm_init(void)
 
 static const struct of_device_id pwrc_ids[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
+	{ .compatible = "sirf,marco-pwrc" },
 	{}
 };
 
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 762adb7..b8b002a 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -19,6 +19,7 @@ static DEFINE_MUTEX(rstc_lock);
 
 static struct of_device_id rstc_ids[]  = {
 	{ .compatible = "sirf,prima2-rstc" },
+	{ .compatible = "sirf,marco-rstc" },
 	{},
 };
 
@@ -42,27 +43,39 @@ early_initcall(sirfsoc_of_rstc_init);
 
 int sirfsoc_reset_device(struct device *dev)
 {
-	const unsigned int *prop = of_get_property(dev->of_node, "reset-bit", NULL);
-	unsigned int reset_bit;
+	u32 reset_bit;
 
-	if (!prop)
-		return -ENODEV;
-
-	reset_bit = be32_to_cpup(prop);
+	if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
+		return -EINVAL;
 
 	mutex_lock(&rstc_lock);
 
-	/*
-	 * Writing 1 to this bit resets corresponding block. Writing 0 to this
-	 * bit de-asserts reset signal of the corresponding block.
-	 * datasheet doesn't require explicit delay between the set and clear
-	 * of reset bit. it could be shorter if tests pass.
-	 */
-	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
-		sirfsoc_rstc_base + (reset_bit / 32) * 4);
-	msleep(10);
-	writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
-		sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	if (of_device_is_compatible(dev->of_node, "sirf,prima2-rstc")) {
+		/*
+		 * Writing 1 to this bit resets corresponding block. Writing 0 to this
+		 * bit de-asserts reset signal of the corresponding block.
+		 * datasheet doesn't require explicit delay between the set and clear
+		 * of reset bit. it could be shorter if tests pass.
+		 */
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 4);
+		msleep(10);
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	} else {
+		/*
+		 * For MARCO and POLO
+		 * Writing 1 to SET register resets corresponding block. Writing 1 to CLEAR
+		 * register de-asserts reset signal of the corresponding block.
+		 * datasheet doesn't require explicit delay between the set and clear
+		 * of reset bit. it could be shorter if tests pass.
+		 */
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 8) | reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 8);
+		msleep(10);
+		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 8) | reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
+	}
 
 	mutex_unlock(&rstc_lock);
 
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 9d80f1e..fc6c4ab 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -104,6 +104,7 @@ EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_writel);
 
 static const struct of_device_id rtciobrg_ids[] = {
 	{ .compatible = "sirf,prima2-rtciobg" },
+	{ .compatible = "sirf,marco-rtciobg" },
 	{}
 };
 
diff --git a/arch/arm/mach-prima2/timer-marco.c b/arch/arm/mach-prima2/timer-marco.c
new file mode 100644
index 0000000..eb5adad
--- /dev/null
+++ b/arch/arm/mach-prima2/timer-marco.c
@@ -0,0 +1,295 @@
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
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <mach/map.h>
+#include <asm/sched_clock.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+#define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
+#define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
+#define SIRFSOC_TIMER_32COUNTER_2_CTRL			0x0008
+#define SIRFSOC_TIMER_32COUNTER_3_CTRL			0x000c
+#define SIRFSOC_TIMER_32COUNTER_4_CTRL			0x0010
+#define SIRFSOC_TIMER_32COUNTER_5_CTRL			0x0014
+#define SIRFSOC_TIMER_MATCH_0				0x0018
+#define SIRFSOC_TIMER_MATCH_1				0x001c
+#define SIRFSOC_TIMER_MATCH_2				0x0020
+#define SIRFSOC_TIMER_MATCH_3				0x0024
+#define SIRFSOC_TIMER_MATCH_4				0x0028
+#define SIRFSOC_TIMER_MATCH_5				0x002c
+#define SIRFSOC_TIMER_32COUNTER_0_MATCH_NUM		0x0030
+#define SIRFSOC_TIMER_32COUNTER_1_MATCH_NUM		0x0034
+#define SIRFSOC_TIMER_32COUNTER_2_MATCH_NUM		0x0038
+#define SIRFSOC_TIMER_32COUNTER_3_MATCH_NUM		0x003c
+#define SIRFSOC_TIMER_32COUNTER_4_MATCH_NUM		0x0040
+#define SIRFSOC_TIMER_32COUNTER_5_MATCH_NUM		0x0044
+#define SIRFSOC_TIMER_COUNTER_0				0x0048
+#define SIRFSOC_TIMER_COUNTER_1				0x004c
+#define SIRFSOC_TIMER_COUNTER_2				0x0050
+#define SIRFSOC_TIMER_COUNTER_3				0x0054
+#define SIRFSOC_TIMER_COUNTER_4				0x0058
+#define SIRFSOC_TIMER_COUNTER_5				0x005c
+#define SIRFSOC_TIMER_INTR_STATUS			0x0060
+#define SIRFSOC_TIMER_WATCHDOG_EN			0x0064
+#define SIRFSOC_TIMER_64COUNTER_CTRL			0x0068
+#define SIRFSOC_TIMER_64COUNTER_LO			0x006c
+#define SIRFSOC_TIMER_64COUNTER_HI			0x0070
+#define SIRFSOC_TIMER_64COUNTER_LOAD_LO			0x0074
+#define SIRFSOC_TIMER_64COUNTER_LOAD_HI			0x0078
+#define SIRFSOC_TIMER_64COUNTER_RLATCHED_LO		0x007c
+#define SIRFSOC_TIMER_64COUNTER_RLATCHED_HI		0x0080
+
+#define SIRFSOC_TIMER_REG_CNT 5
+
+static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
+	SIRFSOC_TIMER_WATCHDOG_EN,
+	SIRFSOC_TIMER_32COUNTER_0_CTRL,
+	SIRFSOC_TIMER_64COUNTER_CTRL,
+	SIRFSOC_TIMER_64COUNTER_RLATCHED_LO,
+	SIRFSOC_TIMER_64COUNTER_RLATCHED_HI,
+};
+
+static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
+
+static void __iomem *sirfsoc_timer_base;
+static void __init sirfsoc_of_timer_map(void);
+
+/* timer0 interrupt handler */
+static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ce = dev_id;
+	u32 val;
+
+	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS) & BIT(0)));
+
+	/* Stop the timer tick */
+	val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+	val &= ~(BIT(0) | BIT(1) | BIT(2));
+	writel_relaxed(val, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0);
+
+	/* clear timer0 interrupt */
+	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
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
+	writel_relaxed((readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+			BIT(0)) & ~BIT(1), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+
+	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_HI);
+	cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_RLATCHED_LO);
+
+	return cycles;
+}
+
+static int sirfsoc_timer_set_next_event(unsigned long delta,
+	struct clock_event_device *ce)
+{
+	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+	val |= BIT(0) | BIT(1) | BIT(2);
+
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0);
+#if 0
+	writel_relaxed(delta, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
+#else
+	/* Fix FPGA: divider of 32counter_0 doesn't work */
+	writel_relaxed(delta * 13, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
+#endif
+
+	/* enable the tick */
+	writel_relaxed(val, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+	return 0;
+}
+
+static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *ce)
+{
+	u32 val = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+	val &= ~(BIT(0) | BIT(1) | BIT(2));
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		WARN_ON(1);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* enable in set_next_event */
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+
+	writel_relaxed(val, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+}
+
+static void sirfsoc_clocksource_suspend(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
+		sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+}
+
+static void sirfsoc_clocksource_resume(struct clocksource *cs)
+{
+	int i;
+
+	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
+		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
+		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
+		sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
+
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
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
+	.suspend = sirfsoc_clocksource_suspend,
+	.resume = sirfsoc_clocksource_resume,
+};
+
+static struct irqaction sirfsoc_timer_irq = {
+	.name = "sirfsoc_timer0",
+	.flags = IRQF_TIMER,
+	.handler = sirfsoc_timer_interrupt,
+	.dev_id = &sirfsoc_clockevent,
+};
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
+	u32 timer_div;
+	struct clk *clk;
+
+	/* initialize clocking early, we want to set the OS timer */
+	sirfsoc_of_clk_init();
+
+	/* timer's input clock is io clock */
+	clk = clk_get_sys("io", NULL);
+
+	BUG_ON(IS_ERR(clk));
+#if defined(CONFIG_SIRFMARCO_FPGA)
+	/* For FPGA, the io clk is fixed to 26Mhz */
+	rate = 26000000;
+#else
+	rate = clk_get_rate(clk);
+#endif
+
+	BUG_ON(rate < CLOCK_TICK_RATE);
+	BUG_ON(rate % CLOCK_TICK_RATE);
+
+	sirfsoc_of_timer_map();
+
+	/* Initialize the timer divider */
+	timer_div = rate / CLOCK_TICK_RATE / 2 - 1;
+	writel_relaxed((timer_div << 16) | readl_relaxed(sirfsoc_timer_base +
+				SIRFSOC_TIMER_64COUNTER_CTRL),
+			sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+
+	writel_relaxed((timer_div << 16) | readl_relaxed(sirfsoc_timer_base +
+				SIRFSOC_TIMER_32COUNTER_0_CTRL) | BIT(0),
+			sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
+
+	/* Initialize the timer counter to 0 */
+
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_LO);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_LOAD_HI);
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL) |
+		BIT(1) | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
+	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0);
+
+	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
+
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+
+	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
+
+	sirfsoc_clockevent_init();
+}
+
+static struct of_device_id timer_ids[] = {
+	{ .compatible = "sirf,marco-tick" },
+	{},
+};
+
+static void __init sirfsoc_of_timer_map(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, timer_ids);
+	if (!np)
+		return;
+	sirfsoc_timer_base = of_iomap(np, 0);
+	if (!sirfsoc_timer_base)
+		panic("unable to map timer cpu registers\n");
+
+	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
+	if (!sirfsoc_timer_irq.irq)
+		panic("No irq passed for timer via DT\n");
+
+	of_node_put(np);
+}
+
+struct sys_timer sirfsoc_marco_timer = {
+	.init = sirfsoc_timer_init,
+};
diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer-prima2.c
similarity index 98%
rename from arch/arm/mach-prima2/timer.c
rename to arch/arm/mach-prima2/timer-prima2.c
index d95bf25..305cbcc 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer-prima2.c
@@ -233,7 +233,7 @@ static void __init sirfsoc_of_timer_map(void)
 
 	np = of_find_matching_node(NULL, timer_ids);
 	if (!np)
-		panic("unable to find compatible timer node in dtb\n");
+		return;
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base)
 		panic("unable to map timer cpu registers\n");
@@ -246,6 +246,6 @@ static void __init sirfsoc_of_timer_map(void)
 	of_node_put(np);
 }
 
-struct sys_timer sirfsoc_timer = {
+struct sys_timer sirfsoc_prima2_timer = {
 	.init = sirfsoc_timer_init,
 };
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 54e3588..e5db829 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -112,7 +112,7 @@ config PINCTRL_SINGLE
 
 config PINCTRL_SIRF
 	bool "CSR SiRFprimaII pin controller driver"
-	depends on ARCH_PRIMA2
+	depends on ARCH_SIRF
 	select PINMUX
 
 config PINCTRL_TEGRA
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
