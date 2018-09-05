From: nm@ti.com (Nishanth Menon)
Date: Wed, 5 Sep 2018 11:20:22 -0500
Subject: [PATCH 1/3] arm64: dts: ti: am654: Add uart nodes
In-Reply-To: <20180905162024.28243-1-nm@ti.com>
References: <20180905162024.28243-1-nm@ti.com>
Message-ID: <20180905162024.28243-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add uart nodes for AM654 device tree components.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 30 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        | 18 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     | 18 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi            | 10 +++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts |  5 +++++
 5 files changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index faace3805c01..674a266066ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -28,4 +28,34 @@
 			#msi-cells = <1>;
 		};
 	};
+
+	main_uart0: serial at 2800000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+
+	main_uart1: serial at 2810000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+
+	main_uart2: serial at 2820000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
new file mode 100644
index 000000000000..8c611d16df44
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family MCU Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_mcu {
+	mcu_uart0: serial at 40a00000 {
+		compatible = "ti,am654-uart";
+			reg = <0x00 0x40a00000 0x00 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <96000000>;
+			current-speed = <115200>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
new file mode 100644
index 000000000000..8b4378d4d0a3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_wakeup {
+	wkup_uart0: serial at 42300000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x42300000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index ded364d20835..3d4bf369d030 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -16,6 +16,14 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+	};
+
 	chosen { };
 
 	firmware {
@@ -85,3 +93,5 @@
 
 /* Now include the peripherals for each bus segments */
 #include "k3-am65-main.dtsi"
+#include "k3-am65-mcu.dtsi"
+#include "k3-am65-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index af6956fdc13f..e146ac2ad781 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -34,3 +34,8 @@
 		};
 	};
 };
+
+&wkup_uart0 {
+	/* Wakeup UART is used by System firmware */
+	status = "disabled";
+};
-- 
2.15.1
