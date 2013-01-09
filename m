From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 09 Jan 2013 11:48:00 -0800 (PST)
Subject: [PATCH] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
Message-ID: <1588881.pi23bvqp7D@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DTS file to support the Marvell RD-A370-A1
(Reference Design) board also known as RD-88F6710 board. It is almost
entirely similar to the DB-A370 board except that the first Ethernet PHY
is SGMII-wired and the second is a switch which is RGMII-wired.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Thomas, Cl?ment, as support for other peripherals gets merged, I will update
this DTS file to reflect this. Thanks!

 arch/arm/boot/dts/armada-370-rd.dts |   61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-rd.dts

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
new file mode 100644
index 0000000..d62dfac
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -0,0 +1,61 @@
+/*
+ * Device Tree file for Marvell Armada 370 Reference Design board
+ * (RD-88F6710-A1)
+ *
+ *  Copied from arch/arm/boot/dts/armada-370-db.dts
+ *
+ *  Copyright (C) 2013 Florian Fainelli <florian@openwrt.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-370.dtsi"
+
+/ {
+	model = "Marvell Armada 370 Reference Design";
+	compatible = "marvell,a370-rd", "marvell,armada370", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+		};
+		sata at d00a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
+
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
+		ethernet at d0070000 {
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "sgmii";
+		};
+		ethernet at d0074000 {
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "rgmii-id";
+		};
+	};
+};
-- 
1.7.10.4
