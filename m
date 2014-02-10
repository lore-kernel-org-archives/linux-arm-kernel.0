From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 10 Feb 2014 12:10:58 +0200
Subject: [PATCH v6 3/3] arm: dts: keystone: add keystone timer entry
In-Reply-To: <1392027058-11680-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1392027058-11680-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1392027058-11680-4-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keystone timer entry to keystone device tree.
This 64-bit timer is used as backup clock event device.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi | 10 ++++++++++
 arch/arm/boot/dts/keystone.dtsi        |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 2363593..16d2aba 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -737,6 +737,16 @@ clocks {
 		domain-id = <0>;
 	};
 
+	clktimer15: clktimer15 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "timer15";
+		reg = <0x02350000 0xb00>, <0x02350000 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <0>;
+	};
+
 	clkuart0: clkuart0 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index b420290..cac9841 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -208,5 +208,12 @@
 				usb-phy = <&usb_phy>, <&usb_phy>;
 			};
 		};
+
+		clock_event: timer at 22f0000 {
+			compatible = "ti,keystone-timer";
+			reg = <0x022f0000 0x80>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clktimer15>;
+		};
 	};
 };
-- 
1.8.3.2
