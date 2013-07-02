From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:00:20 +0200
Subject: [PATCH v6 3/7] ARM: orion5x: add gigabit ethernet and mvmdio device
 tree nodes
In-Reply-To: <1372762824-12202-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372762824-12202-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372762824-12202-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mv643xx_eth and mvmdio device tree nodes for DT enabled
Orion5x boards. Phy nodes are also added with reg property set on a
per-board basis.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v5->v6:
- rebase for v3.11-rc1

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: netdev at vger.kernel.org
---
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |   17 +++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     |   29 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0077fc8..aed83de 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -53,3 +53,20 @@
 		};
 	};
 };
+
+&mdio {
+	status = "okay";
+
+	ethphy: ethernet-phy {
+		device-type = "ethernet-phy";
+		reg = <8>;
+	};
+};
+
+&eth {
+	status = "okay";
+
+	ethernet-port at 0 {
+		phy-handle = <&ethphy>;
+	};
+};
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index f82ece7..2d241fc 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -131,5 +131,34 @@
 			interrupts = <28>;
 			status = "okay";
 		};
+
+		mdio: mdio-bus at 72004 {
+			compatible = "marvell,orion-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72004 0x84>;
+			interrupts = <22>;
+			status = "disabled";
+
+			/* add phy nodes in board file */
+		};
+
+		eth: ethernet-controller at 72000 {
+			compatible = "marvell,orion-eth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72000 0x4000>;
+			marvell,tx-checksum-limit = <1600>;
+			status = "disabled";
+
+			ethernet-port at 0 {
+				device_type = "network";
+				compatible = "marvell,orion-eth-port";
+				reg = <0>;
+				/* overwrite MAC address in bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				/* set phy-handle property in board file */
+			};
+		};
 	};
 };
-- 
1.7.2.5
