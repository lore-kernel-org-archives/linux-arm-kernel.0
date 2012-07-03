From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:41 +0200
Subject: [PATCH v2 08/12] Kirkwood: Add basic device tree support for QNAP
 TS219.
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two different variants of QNAP TS devices, varying by SoC, put the
GPIO keys on different GPIO lines. Hence we need two different DT
board descriptions, which share the same board-ts219.c file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts |   21 +++++++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts |   21 +++++++
 arch/arm/boot/dts/kirkwood-ts219.dtsi     |   73 ++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig            |   14 +++++
 arch/arm/mach-kirkwood/Makefile           |    1 +
 arch/arm/mach-kirkwood/Makefile.boot      |    1 +
 arch/arm/mach-kirkwood/board-dt.c         |    4 ++
 arch/arm/mach-kirkwood/board-ts219.c      |   87 +++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h           |    5 ++
 9 files changed, 227 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-ts219.c

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
new file mode 100644
index 0000000..ccbf327
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+/include/ "kirkwood-ts219.dtsi"
+
+/ {
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "USB Copy";
+			linux,code = <133>;
+			gpios = <&gpio0 15 1>;
+		};
+		button at 2 {
+			label = "Reset";
+			linux,code = <0x198>;
+			gpios = <&gpio0 16 1>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
new file mode 100644
index 0000000..fbe9932
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+/include/ "kirkwood-ts219.dtsi"
+
+/ {
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "USB Copy";
+			linux,code = <133>;
+			gpios = <&gpio1 11 1>;
+		};
+		button at 2 {
+			label = "Reset";
+			linux,code = <0x198>;
+			gpios = <&gpio1 5 1>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
new file mode 100644
index 0000000..e0520c3
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -0,0 +1,73 @@
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "QNAP TS219 family";
+	compatible = "qnap,ts219", "mrvl,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
+	ocp at f1000000 {
+		i2c at 11000 {
+			status = "okay";
+
+			s35390a: s35390a at 30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			};
+		};
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+		serial at 12100 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+		spi at 10600 {
+			status = "okay";
+
+			m25p128 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p128";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 0000000 {
+					reg = <0x00000000 0x00080000>;
+					label = "U-Boot";
+				};
+
+				partition at 00200000 {
+					reg = <0x00200000 0x00200000>;
+					label = "Kernel";
+				};
+
+				partition at 00400000 {
+					reg = <0x00400000 0x00900000>;
+					label = "RootFS1";
+				};
+				partition at 00d00000 {
+					reg = <0x00d00000 0x00300000>;
+					label = "RootFS2";
+				};
+				partition at 00040000 {
+					reg = <0x00080000 0x00040000>;
+					label = "U-Boot Config";
+				};
+				partition at 000c0000 {
+					reg = <0x000c0000 0x00140000>;
+					label = "NAS Config";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 199764f..089d094 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -80,6 +80,20 @@ config MACH_IB62X0_DT
 	  RaidSonic IB-NAS6210 & IB-NAS6220 devices, using
 	  Flattened Device Tree.
 
+config MACH_TS219_DT
+	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
+	select ARCH_KIRKWOOD_DT
+	select ARM_APPENDED_DTB
+	select ARM_ATAG_DTB_COMPAT
+	help
+	  Say 'Y' here if you want your kernel to support the QNAP
+	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
+	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
+	  There are two different Device Tree descriptions, depending
+	  on if the device is based on an if the board uses the MV6281
+	  or MV6282. If you have the wrong one, the buttons will not
+	  work.
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index d2b0590..0468b23 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
+obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 02edbdf..4a1f66a 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -7,3 +7,4 @@ dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns320.dtb
 dtb-$(CONFIG_MACH_DLINK_KIRKWOOD_DT) += kirkwood-dns325.dtb
 dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
 dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
+dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 24c8fdd..b7cd6d2 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -76,6 +76,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("raidsonic,ib-nas62x0"))
 		ib62x0_init();
 
+	if (of_machine_is_compatible("qnap,ts219"))
+		qnap_dt_ts219_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table,
 			     kirkwood_auxdata_lookup, NULL);
 }
@@ -86,6 +89,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"dlink,dns-325",
 	"iom,iconnect",
 	"raidsonic,ib-nas62x0",
+	"qnap,ts219",
 	NULL
 };
 
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
new file mode 100644
index 0000000..00b79ea
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-ts219.c
@@ -0,0 +1,87 @@
+/*
+ *
+ * QNAP TS-11x/TS-21x Turbo NAS Board Setup via DT
+ *
+ * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
+ *
+ * Based on the board file ts219-setup.c:
+ *
+ * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
+ * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ata_platform.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+#include "tsx1x-common.h"
+
+static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static struct mv_sata_platform_data qnap_ts219_sata_data = {
+	.n_ports	= 2,
+};
+
+static unsigned int qnap_ts219_mpp_config[] __initdata = {
+	MPP0_SPI_SCn,
+	MPP1_SPI_MOSI,
+	MPP2_SPI_SCK,
+	MPP3_SPI_MISO,
+	MPP4_SATA1_ACTn,
+	MPP5_SATA0_ACTn,
+	MPP8_TW0_SDA,
+	MPP9_TW0_SCK,
+	MPP10_UART0_TXD,
+	MPP11_UART0_RXD,
+	MPP13_UART1_TXD,	/* PIC controller */
+	MPP14_UART1_RXD,	/* PIC controller */
+	MPP15_GPIO,		/* USB Copy button (on devices with 88F6281) */
+	MPP16_GPIO,		/* Reset button (on devices with 88F6281) */
+	MPP36_GPIO,		/* RAM: 0: 256 MB, 1: 512 MB */
+	MPP37_GPIO,		/* Reset button (on devices with 88F6282) */
+	MPP43_GPIO,		/* USB Copy button (on devices with 88F6282) */
+	MPP44_GPIO,		/* Board ID: 0: TS-11x, 1: TS-21x */
+	0
+};
+
+void __init qnap_dt_ts219_init(void)
+{
+	u32 dev, rev;
+
+	kirkwood_mpp_conf(qnap_ts219_mpp_config);
+
+	kirkwood_pcie_id(&dev, &rev);
+	if (dev == MV88F6282_DEV_ID)
+		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
+
+	kirkwood_ge00_init(&qnap_ts219_ge00_data);
+	kirkwood_sata_init(&qnap_ts219_sata_data);
+	kirkwood_ehci_init();
+
+	pm_power_off = qnap_tsx1x_power_off;
+}
+
+/* FIXME: Will not work with DT. Maybe use MPP40_GPIO? */
+static int __init ts219_pci_init(void)
+{
+	if (machine_is_ts219())
+		kirkwood_pcie_init(KW_PCIE0);
+
+	return 0;
+}
+subsys_initcall(ts219_pci_init);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 9248fa2..e0c2324 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -58,6 +58,11 @@ void dreamplug_init(void);
 #else
 static inline void dreamplug_init(void) {};
 #endif
+#ifdef CONFIG_MACH_TS219_DT
+void qnap_dt_ts219_init(void);
+#else
+static inline void qnap_dt_ts219_init(void) {};
+#endif
 
 #ifdef CONFIG_MACH_DLINK_KIRKWOOD_DT
 void dnskw_init(void);
-- 
1.7.10
