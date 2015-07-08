From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 17:02:35 +0200
Subject: [PATCHv2 6/8] ARM: mvebu: add suspend/resume related definitions in
 Armada 38x Device Tree
In-Reply-To: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1436367757-14202-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support suspend/resume, the SoC-level Armada 38x Device
Tree file must be improved with the following additions:

 - Description of the SDRAM controller registers, which are needed in
   order to allow the suspend/resume code to put the RAM in
   self-refresh. This is similar to what was done in commit
   6e6db2bea3ea ("ARM: mvebu: add SDRAM controller description for
   Armada XP") for Armada XP.

 - Description of additional registers for the MBus controller, which
   need to be saved/restored accross a suspend/resume cycle. This is
   similar to what was done in commit 8b7dc9d37a44e ("ARM: mvebu:
   adjust mbus controller description on Armada 370/XP") for Armada
   XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 04ecfe6..60adb44 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -138,6 +138,11 @@
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
 
+			sdramc at 1400 {
+				compatible = "marvell,armada-xp-sdram-controller";
+				reg = <0x1400 0x500>;
+			};
+
 			L2: cache-controller at 8000 {
 				compatible = "arm,pl310-cache";
 				reg = <0x8000 0x1000>;
@@ -371,7 +376,7 @@
 
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
 			};
 
 			mpic: interrupt-controller at 20a00 {
-- 
2.4.5
