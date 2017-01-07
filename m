From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sun,  8 Jan 2017 00:04:51 +0900
Subject: [PATCH v4 2/2] ARM: DT: add power-off support to linkstation lsgl and
 kuroboxpro
In-Reply-To: <20170107150451.17912-1-rogershimizu@gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
Message-ID: <20170107150451.17912-3-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few models of Linkstation / KuroBox has micro-controller which
controls the power (as well as FAN, but not related here), while
others not. So remove the restart-poweroff driver in linkstation
common dtsi file, and specify the proper power driver in dts
of each device.

Devices need micro-controler to power-off:
  - Linkstation LS-GL
  - KuroBox Pro
Device continues using original restart-poweroff driver:
  - Linkstation LS-WTGL

To: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
To: Gregory Clement <gregory.clement@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ryan Tandy <ryan@nardis.ca>
Cc: linux-pm at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

Reported-by: Ryan Tandy <ryan@nardis.ca>
Tested-by: Ryan Tandy <ryan@nardis.ca>
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/orion5x-kuroboxpro.dts         |  8 ++++++++
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts   | 10 ++++++++++
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts |  4 ++++
 arch/arm/boot/dts/orion5x-linkstation.dtsi       |  4 ----
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-kuroboxpro.dts b/arch/arm/boot/dts/orion5x-kuroboxpro.dts
index 1a672b098d0b..aba38d802bda 100644
--- a/arch/arm/boot/dts/orion5x-kuroboxpro.dts
+++ b/arch/arm/boot/dts/orion5x-kuroboxpro.dts
@@ -60,6 +60,14 @@
 				 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
 				 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>,
 				 <MBUS_ID(0x01, 0x1e) 0 0xfc000000 0x1000000>;
+
+		internal-regs {
+			power_off {
+				compatible = "linkstation,power-off";
+				reg = <0x12100 0x100>;
+				clocks = <&core_clk 0>;
+			};
+		};
 	};
 
 	memory { /* 128 MB */
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
index 51dc734cd5b9..370fc17a6dd9 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
@@ -56,6 +56,16 @@
 	model = "Buffalo Linkstation Pro/Live";
 	compatible = "buffalo,lsgl", "marvell,orion5x-88f5182", "marvell,orion5x";
 
+	soc {
+		internal-regs {
+			power_off {
+				compatible = "linkstation,power-off";
+				reg = <0x12100 0x100>;
+				clocks = <&core_clk 0>;
+			};
+		};
+	};
+
 	memory { /* 128 MB */
 		device_type = "memory";
 		reg = <0x00000000 0x8000000>;
diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
index 0eead400f427..571a71f5b7ad 100644
--- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
+++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
@@ -59,6 +59,10 @@
 		reg = <0x00000000 0x4000000>;
 	};
 
+	restart_poweroff {
+		compatible = "restart-poweroff";
+	};
+
 	gpio_keys {
 		power-on-switch {
 			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/orion5x-linkstation.dtsi b/arch/arm/boot/dts/orion5x-linkstation.dtsi
index ed456ab35fd8..40770a8d4b36 100644
--- a/arch/arm/boot/dts/orion5x-linkstation.dtsi
+++ b/arch/arm/boot/dts/orion5x-linkstation.dtsi
@@ -57,10 +57,6 @@
 				 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x40000>;
 	};
 
-	restart_poweroff {
-		compatible = "restart-poweroff";
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.11.0
