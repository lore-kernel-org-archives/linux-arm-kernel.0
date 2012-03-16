From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Mar 2012 04:21:27 +0000
Subject: [PATCH 7/9] ARM: kirkwood: fdt: define uart[01] as disabled,
 enable uart0
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <df6c6160b649e0f4bbf032be5428691378eda244.1331868507.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define both uarts in kirkwood.dtsi as they are common to all kirkwood
SoCs.  Each board may enable all or none of them, so they are disabled
by default.  uart0 is enabled for the dreamplug.

tclk can vary for each board, so we leave it undefined in the kirkwood
dtsi.  Each board can then set it as appropriate when enabling the uart.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   11 +++++------
 arch/arm/boot/dts/kirkwood.dtsi          |   26 +++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 333f11b..a5376b8 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -15,11 +15,10 @@
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
 	};
 
-	serial at f1012000 {
-		compatible = "ns16550a";
-		reg = <0xf1012000 0x100>;
-		reg-shift = <2>;
-		interrupts = <33>;
-		clock-frequency = <200000000>;
+	ocp at f1000000 {
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 702b955..825310b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -2,5 +2,29 @@
 
 / {
 	compatible = "mrvl,kirkwood";
-};
 
+	ocp at f1000000 {
+		compatible = "simple-bus";
+		ranges = <0 0xf1000000 0x1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		serial at 12000 {
+			compatible = "ns16550a";
+			reg = <0x12000 0x100>;
+			reg-shift = <2>;
+			interrupts = <33>;
+			/* set clock-frequency in board dts */
+			status = "disabled";
+		};
+
+		serial at 12100 {
+			compatible = "ns16550a";
+			reg = <0x12100 0x100>;
+			reg-shift = <2>;
+			interrupts = <34>;
+			/* set clock-frequency in board dts */
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.3.4
