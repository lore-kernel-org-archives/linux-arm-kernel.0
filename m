From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 21:26:50 -0700
Subject: [PATCH] ARM: bcm2835: fix clock node aliasing in device tree
Message-ID: <1358224010-6619-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both clock nodes in the current device tree are named "clock" and hence
end up being the same node. Rename the nodes to different names to avoid
this. In fact, fixed-clock uses the node name as the clock name, so name
the nodes after the clock they represent. Move the clocks into a
"clocks" sub-node to group them and avoid any possible naming conflicts
with other nodes also named after the device type.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index c69a591..4bf2a87 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -89,15 +89,23 @@
 		};
 	};
 
-	clk_i2c: clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <150000000>;
-	};
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	clk_mmc: clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
+		clk_mmc: mmc {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+		};
+
+		clk_i2c: i2c {
+			compatible = "fixed-clock";
+			reg = <1>;
+			#clock-cells = <0>;
+			clock-frequency = <150000000>;
+		};
 	};
 };
-- 
1.7.10.4
