From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 27 Oct 2012 02:55:50 +0900
Subject: [PATCH 4/7] ARM: dts: add initial dts file for EXYNOS5440, SSDK5440
In-Reply-To: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
References: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1351274153-3120-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial dts file for EXYNOS5440 SoC and adds the
dts file for SSDK5440 board which is a kind of reference board.
More properties will be added later.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |   49 ++++++++++
 arch/arm/boot/dts/exynos5440.dtsi         |  142 +++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 create mode 100644 arch/arm/boot/dts/exynos5440.dtsi

diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
new file mode 100644
index 0000000..82960f0
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -0,0 +1,49 @@
+/*
+ * SAMSUNG SSDK5440 board device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos5440.dtsi"
+
+/ {
+	model = "SAMSUNG SSDK5440 board based on EXYNOS5440";
+	compatible = "samsung,ssdk5440", "samsung,exynos5440";
+
+	memory {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x81000000,8M console=ttySAC2,115200 init=/linuxrc";
+	};
+
+	spi {
+		status = "disabled";
+	};
+
+	i2c at F0000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		gpios = <&gpb3 0 2 3 0>,
+			<&gpb3 1 2 3 0>;
+	};
+
+	i2c at 100000 {
+		status = "disabled";
+	};
+
+	watchdog {
+		status = "disabled";
+	};
+
+	rtc {
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
new file mode 100644
index 0000000..380a89a
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -0,0 +1,142 @@
+/*
+ * SAMSUNG EXYNOS5440 SoC device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "samsung,exynos5440";
+
+	interrupt-parent = <&gic>;
+
+	gic:interrupt-controller at 2E0000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x2E0000 0x1000>, <0x2E1000 0x1000>;
+	};
+
+	cpus {
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				interrupts = <? ? ?>;
+				clock-frequency = <1000000>;
+			};
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				interrupts = <1 14 0x308>;
+				clock-frequency = <1000000>;
+			};
+		};
+		cpu at 2 {
+			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				interrupts = <1 14 0x308>;
+				clock-frequency = <1000000>;
+			};
+		};
+		cpu at 3 {
+			compatible = "arm,cortex-a15";
+			timer {
+				compatible = "arm,armv7-timer";
+				interrupts = <1 14 0x308>;
+				clock-frequency = <1000000>;
+			};
+		};
+	};
+
+	common {
+		compatible = "samsung,exynos5440";
+
+	};
+
+	serial at B0000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0xB0000 0x1000>;
+		interrupts = <0 2 0>;
+	};
+
+	serial at C0000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0xC0000 0x1000>;
+		interrupts = <0 3 0>;
+	};
+
+	spi {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0xD0000 0x1000>;
+		interrupts = <0 4 0>;
+		tx-dma-channel = <&pdma0 5>; /* preliminary */
+		rx-dma-channel = <&pdma0 4>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pinctrl {
+		compatible = "samsung,pinctrl-exynos5440";
+		reg = <0xE0000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	i2c at F0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0xF0000 0x1000>;
+		interrupts = <0 5 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c at 100000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x100000 0x1000>;
+		interrupts = <0 6 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	watchdog {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x110000 0x1000>;
+		interrupts = <0 1 0>;
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 121A0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x120000 0x1000>;
+			interrupts = <0 34 0>;
+		};
+
+		pdma1: pdma at 121B0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121000 0x1000>;
+			interrupts = <0 35 0>;
+		};
+	};
+
+	rtc {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x130000 0x1000>;
+		interrupts = <0 16 0>, <0 17 0>;
+	};
+};
-- 
1.7.4.4
