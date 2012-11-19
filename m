From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:43 +0100
Subject: [PATCH 7/7] arm: mvebu: fix SATA clocks on Armada 370/XP
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/XP have gatable clocks for the SATA0 and SATA1 ports,
and are not connected directly to the core clocks. Therefore, we
adjust the clock references to reflect this.

Note that the clock references are moved down from the common
armada-370-xp.dtsi to the more specific armada-370.dtsi and
armada-xp.dtsi because the gatable clock driver is different on both
SoCs. Also, the Armada XP has two more "SATA Link" clocks that we may
have to use in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    1 -
 arch/arm/boot/dts/armada-370.dtsi    |    5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     |    5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 08ec354..c0414ae 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -94,7 +94,6 @@
 			compatible = "marvell,orion-sata";
 			reg = <0xd00a0000 0x2400>;
 			interrupts = <55>;
-			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 1ed9e5c..5901995 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -82,6 +82,11 @@
 			interrupts = <91>;
 		};
 
+		sata at d00a0000 {
+			clocks = <&gateclk 15>, <&gateclk 30>;
+			clock-names = "0", "1";
+		};
+
 		coreclk: mvebu-sar at d0018230 {
 			compatible = "marvell,armada-370-core-clock";
 			reg = <0xd0018230 0x08>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 781127e..be4c7cf 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -92,5 +92,10 @@
 				interrupts = <14>;
 				status = "disabled";
 		};
+
+		sata at d00a0000 {
+			clocks = <&gateclk 15>, <&gateclk 30>;
+			clock-names = "0", "1";
+		};
 	};
 };
-- 
1.7.9.5
