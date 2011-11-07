From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon,  7 Nov 2011 22:31:45 +0100
Subject: [PATCH 3/3 V2] ARM: pxa: Add basic DTS files for PXA/Vpac270 testing
 machine
In-Reply-To: <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1320701506-26812-4-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>
---
 arch/arm/boot/dts/pxa-vpac270.dts |   37 +++++++++++++++++++
 arch/arm/boot/dts/pxa.dtsi        |   71 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa-vpac270.dts
 create mode 100644 arch/arm/boot/dts/pxa.dtsi

V2: Fix typo -- rename alias -> aliases in the pxa270.dtsi
    Drop marvell,pxa250 option, instead leave all ports disable and let user
    select, which will be registered. This depends on the user not doing
    something stupid (like registering HWUART, which is available only on
    pxa250) on pxa320.

diff --git a/arch/arm/boot/dts/pxa-vpac270.dts b/arch/arm/boot/dts/pxa-vpac270.dts
new file mode 100644
index 0000000..48dd9e5
--- /dev/null
+++ b/arch/arm/boot/dts/pxa-vpac270.dts
@@ -0,0 +1,37 @@
+/*
+ * pxa-vpac270.dts - Device Tree file for Voipac PXA270 board
+ *
+ * Copyright (C) 2011 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+/include/ "pxa.dtsi"
+
+/ {
+	model = "Voipac VPAC270";
+	compatible = "voipac,vpac270";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 mem=128M at 0xa0000000";
+		linux,stdout-path = &ffuart;
+	};
+
+	memory at a0000000 {
+		reg = <0xa0000000 0x8000000>;
+	};
+
+	pxabus {
+		ffuart: uart at 40100000 {
+			status = "okay";
+		};
+
+		btuart: uart at 40200000 {
+			status = "okay";
+		};
+
+		stuart: uart at 40700000 {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa.dtsi b/arch/arm/boot/dts/pxa.dtsi
new file mode 100644
index 0000000..4c9c4c7
--- /dev/null
+++ b/arch/arm/boot/dts/pxa.dtsi
@@ -0,0 +1,71 @@
+/*
+ * pxa.dtsi - Device Tree Include file for Marvell PXA2xx/PXA3xx family SoC
+ *
+ * Copyright (C) 2011 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell PXA2xx/PXA3xx family SoC";
+	compatible = "marvell,pxa";
+	interrupt-parent = <&pxairq>;
+
+	aliases {
+		serial0 = &ffuart;
+		serial1 = &btuart;
+		serial2 = &stuart;
+		serial3 = &hwuart;
+	};
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,xscale";
+		};
+	};
+
+	pxabus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pxairq: interrupt-controller at 40d00000 {
+			#interrupt-cells = <1>;
+			compatible = "marvell,pxa-irq";
+			interrupt-controller;
+			interrupt-parent;
+			reg = <0x40d00000 0xd0>;
+		};
+
+		ffuart: uart at 40100000 {
+			compatible = "marvell,pxa2xx-uart";
+			reg = <0x40100000 0x30>;
+			interrupts = <22>;
+			status = "disabled";
+		};
+
+		btuart: uart at 40200000 {
+			compatible = "marvell,pxa2xx-uart";
+			reg = <0x40200000 0x30>;
+			interrupts = <21>;
+			status = "disabled";
+		};
+
+		stuart: uart at 40700000 {
+			compatible = "marvell,pxa2xx-uart";
+			reg = <0x40700000 0x30>;
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		hwuart: uart at 41100000 {
+			compatible = "marvell,pxa2xx-uart";
+			reg = <0x41100000 0x30>;
+			interrupts = <7>;
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.7.1
