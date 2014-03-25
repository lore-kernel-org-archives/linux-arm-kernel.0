From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 00:33:59 +0100
Subject: [PATCH 2/2] ARM: mvebu: ensure the mdio node has a clock reference on
 Armada 38x
In-Reply-To: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395790439-21332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395790439-21332-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvmdio driver accesses some register of the Ethernet unit. It
therefore takes a reference and enables a clock. However, on Armada
38x, no clock specification was given in the Device Tree, which leads
the mvmdio driver to fail when being used as a module and loaded
before the mvneta driver: it tries to access a register from a
hardware unit that isn't clocked.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a064f59..ca8813b 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -336,6 +336,7 @@
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
 				reg = <0x72004 0x4>;
+				clocks = <&gateclk 4>;
 			};
 
 			coredivclk: clock at e4250 {
-- 
1.8.3.2
