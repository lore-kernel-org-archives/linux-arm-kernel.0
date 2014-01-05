From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon,  6 Jan 2014 00:46:40 +0100
Subject: [PATCH v5 3/4] ARM: BCM5301X: add dts files for BCM4708 SoC
In-Reply-To: <1388965601-18329-1-git-send-email-hauke@hauke-m.de>
References: <1388965601-18329-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1388965601-18329-4-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses the newly added BCM5301X SoC code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile                  |    1 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts |   20 ++++++
 arch/arm/boot/dts/bcm4708.dtsi              |  102 +++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-netgear-r6250.dts
 create mode 100644 arch/arm/boot/dts/bcm4708.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a6..9c385bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
 	bcm28155-ap.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+dtb-$(CONFIG_ARCH_BCM_5301X) += bcm4708-netgear-r6250.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
new file mode 100644
index 0000000..34875f6
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -0,0 +1,20 @@
+/*
+ * Broadcom BCM470X / BCM5301X arm platform code.
+ *
+ * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	compatible = "netgear,r6250v1", "brcm,bcm4708";
+	model = "Netgear R6250 V1 (BCM4708)";
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
new file mode 100644
index 0000000..36937f1
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -0,0 +1,102 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ *
+ * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "brcm,bcm4708";
+	model = "Broadcom BCM4708";
+	interrupt-parent = <&gic>;
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* As long as we do not have a real clock driver us this
+		 * fixed clock */
+		clk_periph: periph {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
+	};
+
+	uart at 18000300 {
+		compatible = "ns16550";
+		reg = <0x18000300 0x100>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <100000000>;
+	};
+
+	uart at 18000400 {
+		compatible = "ns16550";
+		reg = <0x18000400 0x100>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <100000000>;
+	};
+
+	scu at 19020000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x19020000 0x100>;
+	};
+
+	timer at 19020200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x19020200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk_periph>;
+	};
+
+	local-timer at 19020600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x19020600 0x100>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk_periph>;
+	};
+
+	gic: interrupt-controller at 19021000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x19021000 0x1000>,
+		      <0x19020100 0x100>;
+	};
+
+	L2: cache-controller at 19022000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x19022000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+};
-- 
1.7.10.4
