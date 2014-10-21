From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 12:40:18 +0200
Subject: [PATCH v8 7/9] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1413888020-8790-8-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for now it is wary basic SoC description with most important IPs needed
to make this device work

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/boot/dts/Makefile                      |  2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts | 13 +++++
 arch/arm/boot/dts/alphascale-asm9260.dtsi       | 63 +++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..8943d72 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -492,6 +492,8 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
 
+dtb-$(CONFIG_MACH_ASM9260) += alphascale-asm9260-devkit.dtb
+
 targets += dtbs dtbs_install
 targets += $(dtb-y)
 endif
diff --git a/arch/arm/boot/dts/alphascale-asm9260-devkit.dts b/arch/arm/boot/dts/alphascale-asm9260-devkit.dts
new file mode 100644
index 0000000..c77e2c9
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260-devkit.dts
@@ -0,0 +1,13 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under the X11 license or the GPL v2 (or later)
+ */
+
+/dts-v1/;
+#include "alphascale-asm9260.dtsi"
+
+/ {
+	model = "Alphascale asm9260 Development Kit";
+	compatible = "alphascale,asm9260devkit", "alphascale,asm9260";
+};
diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale-asm9260.dtsi
new file mode 100644
index 0000000..907fc7b
--- /dev/null
+++ b/arch/arm/boot/dts/alphascale-asm9260.dtsi
@@ -0,0 +1,63 @@
+/*
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under the X11 license or the GPL v2 (or later)
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/alphascale,asm9260.h>
+
+/ {
+	interrupt-parent = <&icoll>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x20000000 0x2000000>;
+	};
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			clocks = <&acc CLKID_SYS_CPU>;
+		};
+	};
+
+	osc24m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-accuracy = <30000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		acc: clock-controller at 80040000 {
+			compatible = "alphascale,asm9260-clock-controller";
+			#clock-cells = <1>;
+			clocks = <&osc24m>;
+			reg = <0x80040000 0x204>;
+		};
+
+		icoll: interrupt-controller at 80054000 {
+			compatible = "alphascale,asm9260-icoll";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x80054000 0x200>;
+		};
+
+		timer0: timer at 80088000 {
+			compatible = "alphascale,asm9260-timer";
+			reg = <0x80088000 0x4000>;
+			clocks = <&acc CLKID_AHB_TIMER0>;
+			interrupts = <29>;
+		};
+	};
+};
-- 
1.9.1
