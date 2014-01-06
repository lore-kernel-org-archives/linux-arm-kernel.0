From: andrew@lunn.ch (Andrew Lunn)
Date: Mon,  6 Jan 2014 23:49:17 +0100
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
Message-ID: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-implement the Marvell Kirkwood ts41x-setup.c in DT.

As with the QNAP 119, there are two variants, depending on which SoC
has been used. They differ on Ethernet PHY addresses and number of
PCIe busses.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile                |    4 +-
 arch/arm/boot/dts/kirkwood-ts419-6281.dts |   20 ++++++++
 arch/arm/boot/dts/kirkwood-ts419-6282.dts |   32 ++++++++++++
 arch/arm/boot/dts/kirkwood-ts419.dtsi     |   75 +++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0447d726a6bc..938a62f75255 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -104,7 +104,9 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
 	kirkwood-ts219-6281.dtb \
-	kirkwood-ts219-6282.dtb
+	kirkwood-ts219-6282.dtb \
+	kirkwood-ts419-6281.dtb \
+	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb
diff --git a/arch/arm/boot/dts/kirkwood-ts419-6281.dts b/arch/arm/boot/dts/kirkwood-ts419-6281.dts
new file mode 100644
index 000000000000..aa22aa862857
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts419-6281.dts
@@ -0,0 +1,20 @@
+/*
+ * Device Tree file for QNAP TS41X with 6281 SoC
+ *
+ * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "kirkwood-ts219.dtsi"
+#include "kirkwood-ts419.dtsi"
+
+&ethphy0 { reg = <8>; };
+&ethphy1 { reg = <0>; };
diff --git a/arch/arm/boot/dts/kirkwood-ts419-6282.dts b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
new file mode 100644
index 000000000000..d7512d4cdced
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
@@ -0,0 +1,32 @@
+/*
+ * Device Tree file for QNAP TS41X with 6282 SoC
+ *
+ * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "kirkwood-ts219.dtsi"
+#include "kirkwood-ts419.dtsi"
+
+/ {
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+};
+
+&ethphy0 { reg = <0>; };
+&ethphy1 { reg = <1>; };
diff --git a/arch/arm/boot/dts/kirkwood-ts419.dtsi b/arch/arm/boot/dts/kirkwood-ts419.dtsi
new file mode 100644
index 000000000000..1a9c624c7a92
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ts419.dtsi
@@ -0,0 +1,75 @@
+/*
+ * Device Tree include file for QNAP TS41X
+ *
+ * Copyright (C) 2013, Andrew Lunn <andrew@lunn.ch>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/ {
+	model = "QNAP TS419 family";
+	compatible = "qnap,ts419", "marvell,kirkwood";
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-names = "default";
+
+			pmx_USB_copy_button: pmx-USB-copy-button {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_reset_button: pmx-reset-button {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+			/*
+			 * JP1 indicates if an LCD module is installed
+			 * on the serial port (0), or if the port is used
+			 * as a console (1).
+			 */
+			pmx_jumper_jp1: pmx-jumper_jp1 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "USB Copy";
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		};
+		button at 2 {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy1: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+                /* overwrite reg property in board file */
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
1.7.10.4
