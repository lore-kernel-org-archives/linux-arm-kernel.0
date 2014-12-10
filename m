From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Dec 2014 15:39:46 +1300
Subject: [RFC/PATCH 3/4] ARM: mvebu: Initial support for rd-dxbc2
In-Reply-To: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1418179187-18486-4-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX4251 Control and Management subsystem is a feature reduction
derivative of the ARMADA XP with some functional changes.

The following table highlights differences between the
ARMADA XP MV78230 and the Control and Management subsystem. There is a
complete table in the "Control and Management Subsystem Functional
Specification" .

Feature                     Bobcat2             MV78230
-------                     -------             -------
CPU Core (ARMv7 compliant   Dual CPU @ up       Dual CPU @ up
with FPU)                   to 800 MHz          to 1.6 GHz

L2 Cache                    2MB                 1MB

PCIe                        1 x1                1 x4 or 4 x1
                                                1 x1

XOR DMA                     2 Channels          4 Channels

SPI interface               1 Port              2 Ports

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

I'm not sure how much of a blurb people want about the new platform. I'd
just be repeating what's in Marvell's datasheets anyway.

I deliberately left the copyright notice in rd-dxbc2.dts since it was
created by copying armada-xp-db.dts. And I don't think anything I did is
worth asserting a different copyright. At the moment the mvebu-soc-id.h
definition is not strictly needed for anything but hopefully Marvell
will come to the party and add the other SoCs.

 arch/arm/boot/dts/rd-dxbc2.dts     | 109 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h |   3 +
 2 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/rd-dxbc2.dts

diff --git a/arch/arm/boot/dts/rd-dxbc2.dts b/arch/arm/boot/dts/rd-dxbc2.dts
new file mode 100644
index 0000000..97a72d4
--- /dev/null
+++ b/arch/arm/boot/dts/rd-dxbc2.dts
@@ -0,0 +1,109 @@
+/*
+ * Device Tree file for RD-DXBC2 board
+ *
+ * Copyright (C) 2012-2014 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+  *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
+ */
+
+/dts-v1/;
+#include "armada-xp-mv78260.dtsi"
+
+/ {
+	model = "Marvell Bobcat2 Evaluation Board";
+	compatible = "marvell,axp-db", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
+
+		devbus-bootcs {
+			status = "okay";
+
+			/* Device Bus parameters are required */
+
+			/* Read parameters */
+			devbus,bus-width    = <16>;
+			devbus,turn-off-ps  = <60000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <124000>;
+			devbus,acc-next-ps  = <248000>;
+			devbus,rd-setup-ps  = <0>;
+			devbus,rd-hold-ps   = <0>;
+
+			/* Write parameters */
+			devbus,sync-enable = <0>;
+			devbus,wr-high-ps  = <60000>;
+			devbus,wr-low-ps   = <60000>;
+			devbus,ale-wr-ps   = <60000>;
+		};
+
+		internal-regs {
+			serial at 12000 {
+				status = "okay";
+			};
+			serial at 12100 {
+				status = "okay";
+			};
+
+			coreclk: mvebu-sar at 18230 {
+				compatible = "marvell,mv98dx4251-core-clock";
+			};
+
+			i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				clock-frequency = <400000>;
+				status = "okay";
+			};
+
+			mvsdio at d4000 {
+				pinctrl-0 = <&sdio_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+				/* No CD or WP GPIOs */
+				broken-cd;
+			};
+
+			spi0: spi at 10600 {
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "m25p64";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <20000000>;
+				};
+			};
+
+			xor at f0900 {
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index c16bb68..98a9dca 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -24,6 +24,9 @@
 #define ARMADA_375_Z1_REV   0x0
 #define ARMADA_375_A0_REV   0x3
 
+/* Packet Processors with integrated CPU */
+#define MV98DX4251	    0xFC00
+
 #ifdef CONFIG_ARCH_MVEBU
 int mvebu_get_soc_id(u32 *dev, u32 *rev);
 #else
-- 
2.2.0.rc0
