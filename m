From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:40 +0100
Subject: [PATCH 4/7] arm: mvebu: move DT cpu clock nodes to the Armada XP
 specific .dtsi
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu clock nodes have originally been added in
armada-xp.dtsi. However, this .dtsi file is common to all SoCs in the
Armada XP family: the MV78230, the MV78260 and the MV78460. Those SoCs
differ in a number of ways, but one of the main difference is the
number of CPUs: one CPU in the MV78230, two CPUs in the MV78260 and
four CPUs in the MV78460.

Therefore, this patch moves the cpu clock DT nodes into the
armada-xp-mv78230.dtsi, armada-xp-mv78260.dtsi and
armada-xp-mv78460.dtsi files, instantiating the right number of CPUs
and CPU clocks as needed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   11 +++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   17 +++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi         |   29 -----------------------------
 4 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index ea35519..0be699b 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -24,6 +24,17 @@
 		gpio1 = &gpio1;
 	};
 
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+	}
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78230-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2057863..4417b87 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -25,6 +25,23 @@
 		gpio2 = &gpio2;
 	};
 
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+
+	    cpu at 1 {
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78260-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index ffac983..1313c3e 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -25,6 +25,36 @@
 		gpio2 = &gpio2;
 	};
 
+
+	cpus {
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    cpu at 0 {
+		compatible = "marvell,sheeva-v7";
+		reg = <0>;
+		clocks = <&cpuclk 0>;
+	    };
+
+	    cpu at 1 {
+		compatible = "marvell,sheeva-v7";
+		reg = <1>;
+		clocks = <&cpuclk 1>;
+	    };
+
+	    cpu at 2 {
+		compatible = "marvell,sheeva-v7";
+		reg = <2>;
+		clocks = <&cpuclk 2>;
+	    };
+
+	    cpu at 3 {
+		compatible = "marvell,sheeva-v7";
+		reg = <3>;
+		clocks = <&cpuclk 3>;
+	    };
+	};
+
 	soc {
 		pinctrl {
 			compatible = "marvell,mv78460-pinctrl";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 84cb87d..a3824ac 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -34,35 +34,6 @@
 		    <0xd0021870 0x58>;
 	};
 
-	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
-
-	    cpu at 0 {
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
-
-	    cpu at 1 {
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
-
-	    cpu at 2 {
-		compatible = "marvell,sheeva-v7";
-		reg = <2>;
-		clocks = <&cpuclk 2>;
-	    };
-
-	    cpu at 3 {
-		compatible = "marvell,sheeva-v7";
-		reg = <3>;
-		clocks = <&cpuclk 3>;
-	    };
-	};
-
 	soc {
 		serial at d0012200 {
 				compatible = "ns16550";
-- 
1.7.9.5
