From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:50:32 +0200
Subject: [PATCH v3 5/6] ARM: mvebu: switch to the new PMSU binding in Armada
 370/XP Device Tree
In-Reply-To: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483433-25836-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
index bbb40f6..10d7786 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -203,6 +203,11 @@
 				reg = <0x20300 0x34>, <0x20704 0x4>;
 			};
 
+			pmsu at 22000 {
+				compatible = "marvell,armada-370-pmsu";
+				reg = <0x22000 0x1000>;
+			};
+
 			usb at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index af1f11e..21b588b 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -220,6 +220,11 @@
 				clocks = <&coreclk 2>;
 			};
 
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x8>;
+			};
+
 			audio_controller: audio-controller at 30000 {
 				compatible = "marvell,armada370-audio";
 				reg = <0x30000 0x4000>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index abb9f9d..0a7dff6 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -117,9 +117,9 @@
 				clock-names = "nbclk", "fixed";
 			};
 
-			armada-370-xp-pmsu at 22000 {
-				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x400>, <0x20800 0x20>;
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x20>;
 			};
 
 			eth2: ethernet at 30000 {
-- 
1.8.3.2
