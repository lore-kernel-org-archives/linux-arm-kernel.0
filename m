From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:08 +0200
Subject: [PATCH 2/8] ARM: MCS814x: add Device Tree based MCS8140 board support
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-3-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a generic MCS8140-based device tree registration
board along with the corresponding mcs8140.dtsi file.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/boot/dts/mcs8140.dtsi           |  207 ++++++++++++++++++++++++++++++
 arch/arm/mach-mcs814x/board-mcs8140-dt.c |   44 +++++++
 2 files changed, 251 insertions(+)
 create mode 100644 arch/arm/boot/dts/mcs8140.dtsi
 create mode 100644 arch/arm/mach-mcs814x/board-mcs8140-dt.c

diff --git a/arch/arm/boot/dts/mcs8140.dtsi b/arch/arm/boot/dts/mcs8140.dtsi
new file mode 100644
index 0000000..7888026
--- /dev/null
+++ b/arch/arm/boot/dts/mcs8140.dtsi
@@ -0,0 +1,207 @@
+/*
+ * mcs8140.dtsi - Device Tree Include file for Moschip MCS8140 family SoC
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under GPLv2.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Moschip MCS8140 family SoC";
+	compatible = "moschip,mcs8140";
+	interrupt-parent = <&intc>;
+
+	aliases {
+		serial0 = &uart0;
+		eth0 = &eth0;
+	};
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vci {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			eth0: ethernet at 40084000 {
+				compatible = "moschip,nuport-mac";
+				reg = <0x40084000 0xd8		// mac
+					0x40080000 0x58>;	// dma channels
+				interrupts = <4 5 29>;	/* tx, rx, link */
+				nuport-mac,buffer-shifting;
+				nuport-mac,link-activity = <0>;
+			};
+
+			tso at 40088000 {
+				reg = <0x40088000 0x1c>;
+				interrupts = <7>;
+			};
+
+			i2s at 4008c000 {
+				compatible = "moschip,mcs814x-i2s";
+				reg = <0x4008c000 0x18>;
+				interrupts = <8>;
+			};
+
+			ipsec at 40094000 {
+				compatible = "moschip,mcs814x-ipsec";
+				reg = <0x40094000 0x1d8>;
+				interrupts = <16>;
+			};
+
+			rng at 4009c000 {
+				compatible = "moschip,mcs814x-rng";
+				reg = <0x4009c000 0x8>;
+			};
+
+			memc at 400a8000 {
+				reg = <0x400a8000 0x58>;
+			};
+
+			list-proc at 400ac0c0 {
+				reg = <0x400ac0c0 0x38>;
+				interrupts = <19 27>;		// done, error
+			};
+
+			pci at 400b0000 {
+				compatible = "moschip,mcs814x-pci";
+				reg = <0x400b0000 0x44		// PCI master
+					0x400d8000 0xe4>;	// EEPROM emulator
+				interrupts = <25>;		// abort interrupt
+				status = "disabled";
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				ranges = <0x01000000 0 0x80000000 0x80000000 0 0x04000000   // IO
+					  0x42000000 0 0x90000000 0x90000000 0 0x20000000   // non-prefetch
+					  0x02000000 0 0xb0000000 0xb0000000 0 0x10000000>; // prefecth
+
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <>;
+				interrupt-map = <0 0 0 1 &intc 22 0
+						 0 0 0 2 &intc 23 0
+						 0 0 0 3 &intc 24 0
+						 0 0 0 4 &intc 26 0>;
+			};
+
+			gpio: gpio at 400d0000 {
+				compatible = "moschip,mcs814x-gpio";
+				reg = <0x400d0000 0x670>;
+				interrupts = <10>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				num-gpios = <20>;
+			};
+
+			eepio: gpio at 400d4000 {
+				compatible = "moschip,mcs814x-gpio";
+				reg = <0x400d4000 0x470>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				num-gpios = <4>;
+			};
+
+			uart0: serial at 400dc000 {
+				compatible = "ns16550";
+				reg = <0x400dc000 0x20>;
+				clock-frequency = <50000000>;
+				reg-shift = <2>;
+				interrupts = <21>;
+				status = "okay";
+			};
+
+			intc: interrupt-controller at 400e4000 {
+				#interrupt-cells = <1>;
+				compatible = "moschip,mcs814x-intc";
+				interrupt-controller;
+				interrupt-parent;
+				reg = <0x400e4000 0x48>;
+			};
+
+			m2m at 400e8000 {
+				reg = <0x400e8000 0x24>;
+				interrupts = <17>;
+			};
+
+			eth-filters at 400ec000 {
+				reg = <0x400ec000 0x80>;
+			};
+
+			timer: timer at 400f800c {
+				compatible = "moschip,mcs814x-timer";
+				interrupts = <0>;
+				reg = <0x400f800c 0x8>;
+			};
+
+			watchdog at 400f8014 {
+				compatible = "moschip,mcs814x-wdt";
+				reg = <0x400f8014 0x8>;
+			};
+
+			adc {
+				compatible = "simple-bus";
+				#address-cells = <2>;
+				#size-cells = <1>;
+				// 8 64MB chip-selects
+				ranges = <0 0 0x00000000 0x4000000	// sdram
+					  1 0 0x04000000 0x4000000	// sdram
+					  2 0 0x08000000 0x4000000	// reserved
+					  3 0 0x0c000000 0x4000000	// flash/localbus
+					  4 0 0x10000000 0x4000000	// flash/localbus
+					  5 0 0x14000000 0x4000000	// flash/localbus
+					  6 0 0x18000000 0x4000000	// flash/localbus
+					  7 0 0x1c000000 0x4000000>;	// flash/localbus
+
+				sdram: memory at 0,0 {
+					reg = <0 0 0>;
+				};
+
+				nor: flash at 7,0 {
+					reg = <7 0 0x4000000>;
+					compatible = "cfi-flash";
+					bank-width = <1>;		// 8-bit external flash
+					#address-cells = <1>;
+					#size-cells = <1>;
+                                };
+                        };
+
+			usb0: ehci at 400fc000 {
+				compatible = "moschip,mcs814x-ehci", "usb-ehci";
+				reg = <0x400fc000 0x74>;
+				interrupts = <2>;
+			};
+
+			usb1: ohci at 400fd000 {
+				compatible = "moschip,mcs814x-ohci", "ohci-le";
+				reg = <0x400fd000 0x74>;
+				interrupts = <11>;
+			};
+
+			usb2: ohci at 400fe000 {
+				compatible = "moschip,mcs814x-ohci", "ohci-le";
+				reg = <0x400fe000 0x74>;
+				interrupts = <12>;
+			};
+
+			usb3: otg at 400ff000 {
+				compatible = "moschip,msc814x-otg", "usb-otg";
+				reg = <0x400ff000 0x1000>;
+				interrupts = <13>;
+			};
+		};
+
+	};
+};
diff --git a/arch/arm/mach-mcs814x/board-mcs8140-dt.c b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
new file mode 100644
index 0000000..5d13283
--- /dev/null
+++ b/arch/arm/mach-mcs814x/board-mcs8140-dt.c
@@ -0,0 +1,44 @@
+/*
+ * Setup code for Moschip MCS8140-based board using Device Tree
+ *
+ * Copyright (C) 2012, Florian Fainelli <florian@openwrt.org>
+ *
+ * Licensed under GPLv2.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+
+#include "common.h"
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+static void __init mcs814x_dt_device_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	mcs814x_init_machine();
+}
+
+static const char *mcs8140_dt_board_compat[] __initdata = {
+	"moschip,mcs8140",
+	NULL,	/* sentinel */
+};
+
+DT_MACHINE_START(mcs8140_dt, "Moschip MCS8140 board")
+	/* Maintainer: Florian Fainelli <florian@openwrt.org> */
+	.timer		= &mcs814x_timer,
+	.map_io		= mcs814x_map_io,
+	.init_early	= mcs814x_clk_init,
+	.init_irq	= mcs814x_of_irq_init,
+	.init_machine	= mcs814x_dt_device_init,
+	.restart	= mcs814x_restart,
+	.dt_compat	= mcs8140_dt_board_compat,
+MACHINE_END
+
-- 
1.7.10.4
