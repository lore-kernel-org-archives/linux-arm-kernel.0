From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 18 Mar 2018 20:12:40 +0300 (MSK)
Subject: [PATCHv2 8/8] ARM: dts: berlin2cd: add Valve Steam Link board
In-Reply-To: <20180314162856.2096bb70@xhacker.debian>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-9-amonakov@ispras.ru>
 <20180314142326.572642c3@xhacker.debian>
 <alpine.LNX.2.20.13.1803141013040.21514@monopod.intra.ispras.ru>
 <20180314154323.184cf435@xhacker.debian>
 <20180314162856.2096bb70@xhacker.debian>
Message-ID: <alpine.LNX.2.20.13.1803182011580.26526@monopod.intra.ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valve Steam Link is a consumer device built around the Marvell BG2CD SoC.
This board file enables the UART, USB and Ethernet interfaces as well as
internal I2C and SDIO, and adds SoC voltage regulator and board-specific
GPIO restart method info.

Cc: Sam Lantinga <saml@valvesoftware.com>
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
v2: address feedback from Jisheng:
* adjust styling of opening comment with SPDX license info

 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts | 79 +++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..82153e323030 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
 dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2-sony-nsz-gs7.dtb \
 	berlin2cd-google-chromecast.dtb \
+	berlin2cd-valve-steamlink.dtb \
 	berlin2q-marvell-dmp.dtb
 dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
diff --git a/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts b/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
new file mode 100644
index 000000000000..79ac842ae461
--- /dev/null
+++ b/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 Alexander Monakov <amonakov@gmail.com>
+ */
+/dts-v1/;
+
+#include "berlin2cd.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Valve Steam Link";
+	compatible = "valve,steamlink", "marvell,berlin2cd", "marvell,berlin";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&porta 6 GPIO_ACTIVE_HIGH>;
+		active-delay = <100>;
+		inactive-delay = <10>;
+		wait-delay = <100>;
+		priority = <200>;
+	};
+};
+
+&cpu {
+	cpu-supply = <&vcpu>;
+	operating-points = <
+		/* kHz    uV */
+		1000000 1325000
+	>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	/* There are two regulators on the board. One is accessible via I2C,
+	 * with buck1 providing SoC power (set up by bootloader to 1.325V or
+	 * less depending on leakage value in OTP), and buck2 likely used for
+	 * DRAM (providing 1.35V). The other regulator on the opposite side
+	 * of the board is probably supplying SDIO and NAND fixed voltages. */
+	regulator at 19 {
+		compatible = "marvell,88pg868";
+		reg = <0x19>;
+
+		vcpu: buck1 {
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1325000>;
+		};
+	};
+};
+
+/* Fixed interface to on-board Marvell 8897 Wi-Fi/Bluetooth/NFC chip. */
+&sdhci0 {
+	keep-power-in-suspend;
+	non-removable;
+	status = "okay";
+};
+
+&uart0 {
+	/* RX/TX are routed to TP50/TP51 on the board. */
+	status = "okay";
+};
+
+/* The SoC is connected to on-board USB hub that in turn has one downstream
+ * port wired to the on-board Steam Controller wireless receiver chip. */
+&usb_phy1 { status = "okay"; };
+
+&usb1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&eth1 { status = "okay"; };
-- 
2.11.0
