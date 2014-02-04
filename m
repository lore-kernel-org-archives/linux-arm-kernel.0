From: mporter@linaro.org (Matt Porter)
Date: Tue,  4 Feb 2014 07:19:12 -0500
Subject: [PATCH 6/6] ARM: dts: add bcm59056 pmu support and enable for
 bcm28155-ap
In-Reply-To: <1391516352-32359-1-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Message-ID: <1391516352-32359-7-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dtsi to support the BCM59056 PMU used by the BCM281xx family
of SoCs. Enable regulators for use with the dwc2 and sdhci on
bcm28155-ap.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts |  41 ++++++++++
 arch/arm/boot/dts/bcm59056.dtsi   | 158 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm59056.dtsi

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 5ff2382..1240f42 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -47,6 +47,10 @@
 	i2c at 3500d000 {
 		status="okay";
 		clock-frequency = <400000>;
+
+		pmu: pmu at 8 {
+			reg = <0x08>;
+		};
 	};
 
 	sdio1: sdio at 3f180000 {
@@ -57,16 +61,22 @@
 	sdio2: sdio at 3f190000 {
 		non-removable;
 		max-frequency = <48000000>;
+		vmmc-supply = <&camldo1_reg>;
+		vqmmc-supply = <&iosr1_reg>;
 		status = "okay";
 	};
 
 	sdio4: sdio at 3f1b0000 {
 		max-frequency = <48000000>;
 		cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+		vmmc-supply = <&sdldo_reg>;
+		vqmmc-supply = <&sdxldo_reg>;
 		status = "okay";
 	};
 
 	usbotg: usb at 3f120000 {
+		vusb_d-supply = <&usbldo_reg>;
+		vusb_a-supply = <&iosr1_reg>;
 		status = "okay";
 	};
 
@@ -74,3 +84,34 @@
 		status = "okay";
 	};
 };
+
+#include "bcm59056.dtsi"
+
+&pmu {
+	interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+	status = "okay";
+
+	regulators {
+		camldo1_reg: regulator at 1 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		sdldo_reg: regulator at 5 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		usbldo_reg: regulator at 11 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		iosr1_reg: regulator at 14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm59056.dtsi b/arch/arm/boot/dts/bcm59056.dtsi
new file mode 100644
index 0000000..08ea3da
--- /dev/null
+++ b/arch/arm/boot/dts/bcm59056.dtsi
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2014 Linaro Limited
+ * Author: Matt Porter <mporter@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+&pmu {
+	compatible = "brcm,bcm59056";
+
+	regulators {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rfldo_reg: regulator at 0 {
+			reg = <0>;
+			regulator-compatible = "rfldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		camldo1_reg: regulator at 1 {
+			reg = <1>;
+			regulator-compatible = "camldo1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		camldo2_reg: regulator at 2 {
+			reg = <2>;
+			regulator-compatible = "camldo2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		simldo1_reg: regulator at 3 {
+			reg = <3>;
+			regulator-compatible = "simldo1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		simldo2_reg: regulator at 4 {
+			reg = <4>;
+			regulator-compatible = "simldo2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		sdldo_reg: regulator at 5 {
+			reg = <5>;
+			regulator-compatible = "sdldo";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		sdxldo_reg: regulator at 6 {
+			reg = <6>;
+			regulator-compatible = "sdxldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		mmcldo1_reg: regulator at 7 {
+			reg = <7>;
+			regulator-compatible = "mmcldo1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		mmcldo2_reg: regulator at 8 {
+			reg = <8>;
+			regulator-compatible = "mmcldo2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		audldo_reg: regulator at 9 {
+			reg = <9>;
+			regulator-compatible = "audldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		micldo_reg: regulator at 10 {
+			reg = <10>;
+			regulator-compatible = "micldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		usbldo_reg: regulator at 11 {
+			reg = <11>;
+			regulator-compatible = "usbldo";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vibldo_reg: regulator at 12 {
+			reg = <12>;
+			regulator-compatible = "vibldo";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		csr_reg: regulator at 13 {
+			reg = <13>;
+			regulator-compatible = "csr";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1440000>;
+		};
+
+		iosr1_reg: regulator at 14 {
+			reg = <14>;
+			regulator-compatible = "iosr1";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		iosr2_reg: regulator at 15 {
+			reg = <15>;
+			regulator-compatible = "iosr2";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		msr_reg: regulator at 16 {
+			reg = <16>;
+			regulator-compatible = "msr";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		sdsr1_reg: regulator at 17 {
+			reg = <17>;
+			regulator-compatible = "sdsr1";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1340000>;
+		};
+
+		sdsr2_reg: regulator at 18 {
+			reg = <18>;
+			regulator-compatible = "sdsr2";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vsr_reg: regulator at 19 {
+			reg = <19>;
+			regulator-compatible = "vsr";
+			regulator-min-microvolt = <860000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+};
-- 
1.8.4
