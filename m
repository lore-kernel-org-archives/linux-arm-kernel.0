From: marex@denx.de (Marek Vasut)
Date: Sun, 20 Mar 2016 00:57:05 +0100
Subject: [PATCH 2/2] ARM: socfpga: dts: Drop gmac0 from CV dtsi
In-Reply-To: <1458431825-9159-1-git-send-email-marex@denx.de>
References: <1458431825-9159-1-git-send-email-marex@denx.de>
Message-ID: <1458431825-9159-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The socfpga_cyclone5.dtsi is included by all DTS files which describe boards
using the Cyclone V SoC. The Cyclone V SoC has two ethernet controllers and
different boards use none, one or both of them.

The /soc/ethernet at ff702000/{} node in socfpga_cyclone5.dtsi unconditionaly
enabled gmac0 interface, which is clearly wrong for those boards which use
gmac1 interface instead.

This patch removes the entire /soc/ethernet at ff702000/{} node from the
socfpga_cyclone5.dtsi file. This is correct, since all of the board which
include this file also have correct gmac0 or gmac1 node present in them.
Minor correction had to be done to EBV SoCrates, which didn't define PHY
mode explicitly, but inherited it from the socfpga_cyclone5.dtsi .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5.dtsi         | 5 -----
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 418c19e..a05e3df 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -38,11 +38,6 @@
 			cap-sd-highspeed;
 		};
 
-		ethernet at ff702000 {
-			phy-mode = "rgmii";
-			status = "okay";
-		};
-
 		sysmgr at ffd08000 {
 			cpu1-start-addr = <0xffd080c4>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 019dd2f..e1a61f2 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -36,6 +36,7 @@
 };
 
 &gmac1 {
+	phy-mode = "rgmii";
 	status = "okay";
 };
 
-- 
2.7.0
