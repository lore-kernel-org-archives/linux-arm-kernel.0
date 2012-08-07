From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue,  7 Aug 2012 15:34:50 +0100
Subject: [PATCH v3 5/7] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <1344350092-24050-6-git-send-email-ian.molton@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

        This patch enables mv643xx based ethernet built into the SoM on the
        csb1724, via flattened device tree.

        Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 arch/arm/boot/dts/kirkwood-csb1724.dts |   19 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi        |   33 ++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-csb1724.c |    1 +
 3 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-csb1724.dts b/arch/arm/boot/dts/kirkwood-csb1724.dts
index 44dfe9a..f43f8dd 100644
--- a/arch/arm/boot/dts/kirkwood-csb1724.dts
+++ b/arch/arm/boot/dts/kirkwood-csb1724.dts
@@ -25,6 +25,25 @@
 			nr-ports = <2>;
 			status = "ok";
 		};
+
+		smi0: mdio at 72000 {
+			status = "ok";
+		};
+
+		smi1: mdio at 76000 {
+			status = "ok";
+		};
+
+		egiga0 {
+			phy_addr = <0>;
+			status = "ok";
+		};
+
+		egiga1 {
+			phy_addr = <1>;
+			status = "ok";
+		};
+
 	};
 
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index cef9616..f5f1f92 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -76,6 +76,39 @@
 			status = "okay";
 		};
 
+		smi0: mdio at 72000 {
+			compatible = "marvell,mdio-mv643xx";
+			reg = <0x72000 0x4000>;
+			interrupts = <46>;
+			tx_csum_limit = <1600>;
+			status = "disabled";
+		};
+
+		egiga0 {
+			compatible = "marvell,mv643xx-eth";
+			reg = <0x72000 0x4000>;
+			mdio = <&smi0>;
+			interrupts = <11>;
+			status = "disabled";
+		};
+
+		smi1: mdio at 76000 {
+			compatible = "marvell,mdio-mv643xx";
+			reg = <0x76000 0x4000>;
+			interrupts = <47>;
+			shared_smi = <&smi0>;
+			tx_csum_limit = <1600>;
+			status = "disabled";
+		};
+
+		egiga1 {
+			compatible = "marvell,mv643xx-eth";
+			reg = <0x76000 0x4000>;
+			mdio = <&smi1>;
+			interrupts = <15>;
+			status = "disabled";
+		};
+
 		sata at 80000 {
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
diff --git a/arch/arm/mach-kirkwood/board-csb1724.c b/arch/arm/mach-kirkwood/board-csb1724.c
index 979112d..9c58b92 100644
--- a/arch/arm/mach-kirkwood/board-csb1724.c
+++ b/arch/arm/mach-kirkwood/board-csb1724.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include "common.h"
 #include "mpp.h"
 
 static unsigned int csb1724_mpp_config[] __initdata = {
-- 
1.7.9.5
