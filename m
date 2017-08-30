From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 Aug 2017 16:17:14 +0100
Subject: [PATCH ] ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
Message-ID: <1504106234-41450-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the iWave RainboW-G22D board dependent part of the Ethernet
AVB device node.

On some older versions of the platform (before R4.0) the phy address
may be 1 or 3. The address is fixed to 3 for R4.0 onwards (which
will be the first mainstream release), hence using 3 in the dts.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
This patch is tested against renesas-dev tag 20170830-v4.13-rc7

 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 442a5cb..aac84c6 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -17,9 +17,11 @@
 
 	aliases {
 		serial0 = &scif4;
+		ethernet0 = &avb;
 	};
 
 	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 };
@@ -29,6 +31,11 @@
 		groups = "scif4_data_b";
 		function = "scif4";
 	};
+
+	avb_pins: avb {
+		groups = "avb_mdio", "avb_gmii";
+		function = "avb";
+	};
 };
 
 &scif4 {
@@ -37,3 +44,22 @@
 
 	status = "okay";
 };
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy3>;
+	phy-mode = "gmii";
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy3: ethernet-phy at 3 {
+	/*
+	 * On some older versions of the platform (before R4.0) the phy address
+	 * may be 1 or 3. The address is fixed to 3 for R4.0 onwards.
+	 */
+		reg = <3>;
+		micrel,led-mode = <1>;
+	};
+};
-- 
1.9.1
