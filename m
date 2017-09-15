From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 15 Sep 2017 22:43:26 +0300
Subject: [PATCH v2 8/8] arm64: dts: renesas: eagle: add EtherAVB support
Message-ID: <20170915194449.538504992@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Eagle board  dependent part of the EtherAVB device node.
Enable DHCP  and NFS root for the kernel booting.

Based  on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- uncommented the "renesas,no-ether-link" property;
- removed the "max-speed" property from the PHY node.

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -18,10 +18,11 @@
 
 	aliases {
 		serial0 = &scif0;
+		ethernet0 = &avb;
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
@@ -43,3 +44,14 @@
 &scif0 {
 	status = "okay";
 };
+
+&avb {
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+	};
+};
