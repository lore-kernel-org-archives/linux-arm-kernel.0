From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 00:33:58 +0100
Subject: [PATCH 1/2] ARM: mvebu: ensure the mdio node has a clock reference on
 Armada 370/XP
In-Reply-To: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395790439-21332-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvmdio driver accesses some register of the Ethernet unit. It
therefore takes a reference and enables a clock. However, on Armada
370/XP, no clock specification was given in the Device Tree, which
leads the mvmdio driver to fail when being used as a module and loaded
before the mvneta driver: it tries to access a register from a
hardware unit that isn't clocked.

Cc: stable at vger.kernel.org
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index bbb40f6..bb77970 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -230,6 +230,7 @@
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
 				reg = <0x72004 0x4>;
+				clocks = <&gateclk 4>;
 			};
 
 			eth1: ethernet at 74000 {
-- 
1.8.3.2
