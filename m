From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Mar 2014 14:38:04 +0100
Subject: [PATCH 5/6] ARM: mvebu: switch to the new PMSU binding in Armada
 370/XP Device Tree
In-Reply-To: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395927485-11842-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Following the introduction of the new PMSU Device Tree binding, as
well as the separate CPU reset binding, this commit switches the
Armada 370 and Armada XP Device Trees to use them.

The PMSU node is moved from the Armada XP specific armada-xp.dtsi to
the common Armada 370/XP armada-370-xp.dtsi because the PMSU is in
fact available at the same location on both SOCs.

The CPU reset node is then added on both Armada 370 and Armada XP,
with a different compatible string. On Armada 370, the CPU reset
driver is not really needed as Armada 370 is single core and the only
use of the CPU reset driver is to boot secondary processors, but it
still makes sense to have this CPU reset register described in the
Device Tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++++
 arch/arm/boot/dts/armada-370.dtsi    | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi     | 6 +++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 74b5964..d286d67 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -199,6 +199,11 @@
 				interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			};
 
+			armada-370-pmsu at 22000 {
+				compatible = "marvell,armada-370-pmsu";
+				reg = <0x22000 0x1000>;
+			};
+
 			usb at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 0d8530c..4636a22 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -196,6 +196,11 @@
 				clocks = <&coreclk 2>;
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x8>;
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index b8b84a2..4d36a12 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -111,9 +111,9 @@
 				clock-names = "nbclk", "fixed";
 			};
 
-			armada-370-xp-pmsu at 22000 {
-				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x400>, <0x20800 0x20>;
+			cpurst at 20800 {
+				compatible = "marvell,armada-xp-cpu-reset";
+				reg = <0x20800 0x20>;
 			};
 
 			eth2: ethernet at 30000 {
-- 
1.8.3.2
