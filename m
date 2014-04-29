From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 11:15:32 +0900
Subject: [PATCH 2/3] ARM: shmobile: henninger: add Ether DT support
In-Reply-To: <cover.1398737464.git.horms+renesas@verge.net.au>
References: <cover.1398737464.git.horms+renesas@verge.net.au>
Message-ID: <26b0d2cf73cb5091962c81598a36346d05e9ba83.1398737464.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Henninger board dependent part of the Ether device node.
Enable DHCP and NFS root for the kernel booting.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 0053f52..f82f306 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,38400 ignore_loglevel";
+		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
 
 	memory at 40000000 {
@@ -40,6 +40,16 @@
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
 	};
+
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq0";
+		renesas,function = "intc";
+	};
 };
 
 &scif0 {
@@ -48,3 +58,19 @@
 
 	status = "okay";
 };
+
+&ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "ok";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
-- 
1.8.5.2
