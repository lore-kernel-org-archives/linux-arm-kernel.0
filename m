From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 13:59:53 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: convert rd88f6281-setup.c to DT.
In-Reply-To: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
References: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392469193-25883-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perform a mechanical translation of rd88f6281-setup.c into DT.  Since
the hardware differs between the A0 and A1 stepping, two dts files are
used, and a .dtsi file for the common parts. The A0 part does not have
a "wan" port on the switch and uses PHY address 10 to address the
switch. The A1 part does have the "wan" port and uses address 0.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts |  26 +++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts |  31 ++++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 152 ++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6ddcba5f35d..5a0165b4d996 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -112,6 +112,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
 	kirkwood-rd88f6192.dtb \
+	kirkwood-rd88f6281-a0.dtb \
+	kirkwood-rd88f6281-a1.dtb \
 	kirkwood-sheevaplug.dtb \
 	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
new file mode 100644
index 000000000000..a803bbb70bc8
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
@@ -0,0 +1,26 @@
+/*
+ * Marvell RD88F6181 A0 Board descrition
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions for the board with the A0 variant of
+ * the SoC. The ethernet switch does not have a "wan" port.
+ */
+
+/dts-v1/;
+#include "kirkwood-rd88f6281.dtsi"
+
+/ {
+	model = "Marvell RD88f6281 Reference design, with A0 SoC";
+	compatible = "marvell,rd88f6281-a0", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	dsa at 0 {
+		switch at 0 {
+			reg = <10 0>;    /* MDIO address 10, switch 0 in tree */
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts b/arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
new file mode 100644
index 000000000000..baeebbf1d8c7
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
@@ -0,0 +1,31 @@
+/*
+ * Marvell RD88F6181 A1 Board descrition
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions for the board with the A1 variant of
+ * the SoC. The ethernet switch has a "wan" port.
+ */
+
+/dts-v1/;
+
+#include "kirkwood-rd88f6281.dtsi"
+
+/ {
+	model = "Marvell RD88f6281 Reference design, with A1 SoC";
+	compatible = "marvell,rd88f6281-a1", "marvell,rd88f6281","marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	dsa at 0 {
+		switch at 0 {
+			reg = <0 0>;    /* MDIO address 0, switch 0 in tree */
+			port at 4 {
+				reg = <4>;
+				label = "wan";
+			};
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
new file mode 100644
index 000000000000..d6368c39102e
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -0,0 +1,152 @@
+/*
+ * Marvell RD88F6181 Common Board descrition
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions that are common between the two
+ * variants of the Marvell Kirkwood Development Board.
+ */
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+
+/ {
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
+			pinctrl-0 = <&pmx_sdio_cd>;
+			pinctrl-names = "default";
+
+			pmx_sdio_cd: pmx-sdio-cd {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+		};
+
+		serial at 12000 {
+			status = "okay";
+
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+		mvsdio at 90000 {
+			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
+			pinctrl-names = "default";
+			status = "okay";
+			cd-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+			/* No WP GPIO */
+		};
+	};
+
+	dsa at 0 {
+		compatible = "marvell,dsa";
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		dsa,ethernet = <&eth0>;
+		dsa,mii-bus = <&ethphy1>;
+
+		switch at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan1";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "lan2";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan3";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan4";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+			};
+		};
+       };
+};
+
+&nand {
+	status = "okay";
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	partition at 100000 {
+		label = "uImage";
+		reg = <0x0100000 0x200000>;
+	};
+
+	partition at 300000 {
+		label = "data";
+		reg = <0x0300000 0x500000>;
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at ff {
+		reg = <0xff>; /* No PHY attached */
+		speed = <1000>;
+		duple = <1>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
+
+&eth1 {
+	status = "okay";
+	ethernet1-port at 0 {
+		phy-handle = <&ethphy1>;
+	};
+};
-- 
1.8.5.3
