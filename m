From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 20 Oct 2012 20:09:24 +0000
Subject: [PATCH V2] ARM: Kirkwood: new board USI Topkick
In-Reply-To: <1350679752-11931-1-git-send-email-jason@lakedaemon.net>
References: <1350679752-11931-1-git-send-email-jason@lakedaemon.net>
Message-ID: <1350763764-737-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new kirkwood box made by Universal Scientific Industrial, Inc.
The product description is here:

http://www.usish.com/english/products_topkick1281p2.php

It is very similar to the dreamplug and other plug devices, with the
exception that it has room for a 2.5" SATA HDD internally.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes since V1:
 - changes nr-ports to 1 for sata0
 - included board in defconfig
 - trimmed #includes
 - added mvsdio init call

 arch/arm/boot/dts/Makefile                 |  3 +-
 arch/arm/boot/dts/kirkwood-topkick.dts     | 85 ++++++++++++++++++++++++++++++
 arch/arm/configs/kirkwood_defconfig        |  1 +
 arch/arm/mach-kirkwood/Kconfig             |  7 +++
 arch/arm/mach-kirkwood/Makefile            |  1 +
 arch/arm/mach-kirkwood/board-dt.c          |  4 ++
 arch/arm/mach-kirkwood/board-usi_topkick.c | 83 +++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h            |  6 +++
 8 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-topkick.dts
 create mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c1ce813..04fffc7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -38,7 +38,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-lschlv2.dtb \
 	kirkwood-lsxhl.dtb \
 	kirkwood-ts219-6281.dtb \
-	kirkwood-ts219-6282.dtb
+	kirkwood-ts219-6282.dtb \
+	kirkwood-topkick.dtb
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
new file mode 100644
index 0000000..c0de5a7
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -0,0 +1,85 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
+	compatible = "usi,topkick-1281P2", "usi,topkick", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		nand at 3000000 {
+			status = "okay";
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x180000>;
+			};
+
+			partition at 180000 {
+				label = "u-boot env";
+				reg = <0x0180000 0x20000>;
+			};
+
+			partition at 200000 {
+				label = "uImage";
+				reg = <0x0200000 0x600000>;
+			};
+
+			partition at 800000 {
+				label = "uInitrd";
+				reg = <0x0800000 0x1000000>;
+			};
+
+			partition at 1800000 {
+				label = "rootfs";
+				reg = <0x1800000 0xe800000>;
+			};
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		disk {
+			label = "topkick:yellow:disk";
+			gpios = <&gpio0 21 1>;
+			linux,default-trigger = "ide-disk";
+		};
+		system2 {
+			label = "topkick:red:system";
+			gpios = <&gpio1 5 1>;
+		};
+		system {
+			label = "topkick:blue:system";
+			gpios = <&gpio1 6 1>;
+			default-state = "on";
+		};
+		wifi {
+			label = "topkick:green:wifi";
+			gpios = <&gpio1 7 1>;
+		};
+		wifi2 {
+			label = "topkick:yellow:wifi";
+			gpios = <&gpio1 16 1>;
+		};
+	};
+};
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 74eee0c..72d6c28 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -27,6 +27,7 @@ CONFIG_MACH_GOFLEXNET_DT=y
 CONFIG_MACH_LSXL_DT=y
 CONFIG_MACH_IOMEGA_IX2_200_DT=y
 CONFIG_MACH_KM_KIRKWOOD_DT=y
+CONFIG_MACH_TOPKICK_DT=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
 CONFIG_MACH_DOCKSTAR=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 50bca50..b8b5c22 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -130,6 +130,13 @@ config MACH_KM_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
 
+config MACH_TOPKICK_DT
+	bool "USI Topkick (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  USI Topkick, using Flattened Device Tree
+
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 294779f..bd463df 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
 obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
 obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
 obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
+obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 70c5a28..33e9217 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -96,6 +96,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("keymile,km_kirkwood"))
 		km_kirkwood_init();
 
+	if (of_machine_is_compatible("usi,topkick"))
+		usi_topkick_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table,
 			     kirkwood_auxdata_lookup, NULL);
 }
@@ -112,6 +115,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"buffalo,lsxl",
 	"iom,ix2-200",
 	"keymile,km_kirkwood",
+	"usi,topkick",
 	NULL
 };
 
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
new file mode 100644
index 0000000..a5e0826
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
+ *
+ * arch/arm/mach-kirkwood/board-dreamplug.c
+ *
+ * Marvell DreamPlug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/mmc-mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mv643xx_eth_platform_data topkick_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mvsdio_platform_data topkick_mvsdio_data = {
+	/* unfortunately the CD signal has not been connected */
+};
+
+/*
+ * GPIO LED layout
+ *
+ *       /-SYS_LED(2)
+ *       |
+ *       |   /-DISK_LED
+ *       |   |
+ *       |   |   /-WLAN_LED(2)
+ *       |   |   |
+ * [SW] [*] [*] [*]
+ */
+
+/*
+ * Switch positions
+ *
+ *     /-SW_LEFT
+ *     |
+ *     |   /-SW_IDLE
+ *     |   |
+ *     |   |   /-SW_RIGHT
+ *     |   |   |
+ * PS [L] [I] [R] LEDS
+ */
+
+static unsigned int topkick_mpp_config[] __initdata = {
+	MPP21_GPIO,	/* DISK_LED           (low active) - yellow */
+	MPP36_GPIO,	/* SATA0 power enable (high active) */
+	MPP37_GPIO,	/* SYS_LED2           (low active) - red */
+	MPP38_GPIO,	/* SYS_LED            (low active) - blue */
+	MPP39_GPIO,	/* WLAN_LED           (low active) - green */
+	MPP43_GPIO,	/* SW_LEFT            (low active) */
+	MPP44_GPIO,     /* SW_RIGHT           (low active) */
+	MPP45_GPIO,	/* SW_IDLE            (low active) */
+	MPP46_GPIO,     /* SW_LEFT            (low active) */
+	MPP48_GPIO,	/* WLAN_LED2          (low active) - yellow */
+	0
+};
+
+#define TOPKICK_SATA0_PWR_ENABLE 36
+
+void __init usi_topkick_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(topkick_mpp_config);
+
+	/* SATA0 power enable */
+	gpio_set_value(TOPKICK_SATA0_PWR_ENABLE, 1);
+
+	kirkwood_ehci_init();
+	kirkwood_ge00_init(&topkick_ge00_data);
+	kirkwood_sdio_init(&topkick_mvsdio_data);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index bcffd7c..46b47d1 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -112,6 +112,12 @@ void km_kirkwood_init(void);
 static inline void km_kirkwood_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_TOPKICK_DT
+void usi_topkick_init(void);
+#else
+static inline void usi_topkick_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.12.4
