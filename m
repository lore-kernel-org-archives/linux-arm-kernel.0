From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 16 Nov 2018 21:42:35 +0100
Subject: [PATCH 2/2] ARM: dts: meson: add the clock inputs for the Meson timer
In-Reply-To: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
References: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181116204235.3925-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson Timer IP block has two clock inputs:
- clk81 for using the system clock as timebase
- xtal for a timebase with 1us, 10us, 100us and 1ms resolution

The clocksource driver does not use these yet, but it's still a good
idea to add them as this describes how the hardware actually works
internally.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 2 +-
 arch/arm/boot/dts/meson6.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index f0255450bcb2..0839da07a75c 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -197,7 +197,7 @@
 				interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 			};
 
-			timer at 9940 {
+			timer_abcde: timer at 9940 {
 				compatible = "amlogic,meson6-timer";
 				reg = <0x9940 0x18>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 9b463211339f..ca978ab952cd 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -88,6 +88,11 @@
 	status = "disabled";
 };
 
+&timer_abcde {
+	clocks = <&xtal>, <&clk81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	clocks = <&xtal>, <&clk81>, <&clk81>;
 	clock-names = "xtal", "pclk", "baud";
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 08c54cf5420a..3be5fbd07997 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -387,6 +387,11 @@
 	clocks = <&clkc CLKID_CLK81>;
 };
 
+&timer_abcde {
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	compatible = "amlogic,meson8-uart", "amlogic,meson-uart";
 	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 46b3564a6536..587a855f872b 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -370,6 +370,11 @@
 	clock-names = "core", "clkin";
 };
 
+&timer_abcde {
+	clocks = <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
+	clock-names = "xtal", "pclk";
+};
+
 &uart_AO {
 	compatible = "amlogic,meson8b-uart", "amlogic,meson-uart";
 	clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_XTAL>, <&clkc CLKID_CLK81>;
-- 
2.19.1
