From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 17:09:30 -0700
Subject: [PATCH 09/10] ARM: dts: Hurricane 2: Add basic support for Ubiquiti
 UniFi Switch 8
In-Reply-To: <20170926000931.670-1-f.fainelli@gmail.com>
References: <20170926000931.670-1-f.fainelli@gmail.com>
Message-ID: <20170926000931.670-10-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic board support for the Ubiquiti UniFi Switch 8 port model. This
is a small home and office use managed switch based on the BCM53342
switching control SoC.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |  2 +
 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts | 85 +++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index faf46abaa4a2..6942c48d0d88 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -117,6 +117,8 @@ dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
 	bcm911360k.dtb \
 	bcm958300k.dtb \
 	bcm958305k.dtb
+dtb-$(CONFIG_ARCH_BCM_HR2) += \
+	bcm53340-ubnt-unifi-switch8.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
 	bcm28155-ap.dtb \
 	bcm21664-garnet.dtb \
diff --git a/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
new file mode 100644
index 000000000000..f8ac37022ebf
--- /dev/null
+++ b/arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dts
@@ -0,0 +1,85 @@
+/*
+ * DTS for Unifi Switch 8 port
+ *
+ * Copyright (C) 2017 Florian Fainelli <f.fainelli@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm-hr2.dtsi"
+
+/ {
+	compatible = "ubnt,unifi-switch8", "brcm,bcm53342", "brcm,hr2";
+	model = "Ubiquiti UniFi Switch 8 (BCM53342)";
+
+	/* Hurricane 2 designs use the second UART */
+	chosen {
+		bootargs = "console=ttyS1,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>,
+		      <0x68000000 0x08000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+	bspi-sel = <0>;
+
+	flash: m25p80 at 0 {
+		compatible = "m25p80";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <12500000>;
+		spi-cpol;
+		spi-cpha;
+
+		partition at 0 {
+			label = "u-boot";
+			reg = <0x0 0xc0000>;
+		};
+
+		partition at c0000 {
+			label = "u-boot-env";
+			reg = <0xc0000 0x10000>;
+		};
+
+		partition at d0000 {
+			label = "shmoo";
+			reg = <0xd0000 0x10000>;
+		};
+
+		partition at e0000 {
+			label = "kernel0";
+			reg = <0xe0000 0xf00000>;
+		};
+
+		partition at fe0000 {
+			label = "kernel1";
+			reg = <0xfe0000 0xf10000>;
+		};
+
+		partition at 1ef0000 {
+			label = "cfg";
+			reg = <0x1ef0000 0x100000>;
+		};
+
+		partition at 1ff0000 {
+			label = "EEPROM";
+			reg = <0x1ff0000 0x10000>;
+		};
+	};
+};
+
+&pcie0 {
+	/* Attaches to the internal switch */
+	status = "okay";
+};
-- 
2.14.1
