From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 29 Jul 2015 01:16:02 +0300
Subject: [PATCH RESEND] ARM: shmobile: silk: add Ether DT support
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <6826396.5PIZbPW8q4@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SILK board dependent part of the Ether device node.
Enable DHCP and NFS root for the kernel booting.

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20150728-v4.2-rc4' tag of Simon
Horman's 'renesas.git' repo.  It depends on just posted SILK board initial DT
patch in order to apply and on R8A7794 PFC DT patch posted yesterday in order
to compile.

 arch/arm/boot/dts/r8a7794-silk.dts |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif2;
 	};
 
@@ -41,6 +41,16 @@
 		renesas,groups = "scif2_data";
 		renesas,function = "scif2";
 	};
+
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq8";
+		renesas,function = "intc";
+	};
 };
 
 &scif2 {
@@ -49,3 +59,19 @@
 
 	status = "okay";
 };
+
+&ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
