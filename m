From: scottwood@freescale.com (Scott Wood)
Date: Thu, 18 Jun 2015 21:49:11 -0500
Subject: [RFC PATCH 1/8] ARM: dts: ls1021a: Fix clockgen node
In-Reply-To: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
Message-ID: <1434682158-7243-2-git-send-email-scottwood@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding requires compatible and reg properties, but the ls1021a
device tree does not contain them.  This will break with subsequent
clock driver changes.  If required (it's not clear to me whether the
ls1 code currently works at all -- I tried multi_v7_defconfig and it
didn't boot, whereas I was able to boot an SDK kernel), backwards
compatibility can be retained with a device tree fixup.

LS1021A also deviates from existing QorIQ clockgen practice by making
the sysclk node be a fixed-clock node rather than the U-Boot
compatibility hack of having a clock-frequency property in the clockgen
node itself, and a fsl,qoriq-sysclk-... node that exports the clock.
While this is not a violation of the existing binding, the upcoming
rework of the clock driver requires that a driver for the clockgen node
itself be able to find the input clock.  Thus, a clocks property is
added to reference the sysclk node.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Jingchang Lu <b35083@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..a0a1c51 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -146,9 +146,12 @@
 		};
 
 		clockgen: clocking at 1ee1000 {
+			compatible = "fsl,ls201a-clockgen";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			reg = <0 0x1ee1000 0x10000>;
 			ranges = <0x0 0x0 0x1ee1000 0x10000>;
+			clocks = <&sysclk>;
 
 			sysclk: sysclk {
 				compatible = "fixed-clock";
-- 
2.1.4
