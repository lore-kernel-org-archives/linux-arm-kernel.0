From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 13:59:52 +0100
Subject: [PATCH 1/2] ARM: Kirkwood: Add DT description of rd88f6192.
In-Reply-To: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
References: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392469193-25883-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mechanically translate rd88f6192-nas-setup.c into DT equivelent.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/kirkwood-rd88f6192.dts | 112 +++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6192.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b485e0..e6ddcba5f35d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -111,6 +111,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-nsa310a.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
+	kirkwood-rd88f6192.dtb \
 	kirkwood-sheevaplug.dtb \
 	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
new file mode 100644
index 000000000000..e9dd85049297
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -0,0 +1,112 @@
+/*
+ * Marvell RD88F6192 Board descrition
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions that are common between the three
+ * variants of the Marvell Kirkwood Development Board.
+ */
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6192.dtsi"
+
+/ {
+	model = "Marvell RD88F6192 reference design";
+	compatible = "marvell,rd88f6192", "marvell,kirkwood-88f6192", "marvell,kirkwood";
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
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-0 = <&pmx_usb_power>;
+			pinctrl-names = "default";
+
+                        pmx_usb_power: pmx-usb-power {
+                                marvell,pins = "mpp10";
+                                marvell,function = "gpo";
+                        };
+		};
+
+		serial at 12000 {
+			status = "okay";
+
+		};
+
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			m25p128 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "st,m25p128";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+			};
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+	};
+
+	regulators {
+                compatible = "simple-bus";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                pinctrl-0 = <&pmx_usb_power>;
+                pinctrl-names = "default";
+
+                usb_power: regulator at 0 {
+                        compatible = "regulator-fixed";
+                        reg = <0>;
+                        regulator-name = "USB VBUS";
+                        regulator-min-microvolt = <5000000>;
+                        regulator-max-microvolt = <5000000>;
+                        enable-active-high;
+                        regulator-always-on;
+                        regulator-boot-on;
+                        gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+                };
+	};
+};
+
+&mdio {
+        status = "okay";
+
+        ethphy0: ethernet-phy at 8 {
+                reg = <8>;
+        };
+};
+
+&eth0 {
+        status = "okay";
+        ethernet0-port at 0 {
+                phy-handle = <&ethphy0>;
+        };
+};
\ No newline at end of file
-- 
1.8.5.3
