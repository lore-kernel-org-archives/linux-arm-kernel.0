From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 Jun 2016 00:17:11 +0300
Subject: [PATCH v5 12/12] ARM: dts: blanche: add Ethernet support
In-Reply-To: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
Message-ID: <1791778.Vq4vL64bUW@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R8A7792  SoC  doesn't have the EtherMAC core, so SMSC  LAN89218  Ethernet
chip was used instead on the Blanche board; this chip  is compatible with
SMSC LAN9115  for  which there's a (device tree aware) driver. Describe
the  chip in  the  Blanche device tree;  enable DHCP and NFS root in the
kernel command line for the kernel booting.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes in version 3:
- refreshed the patch.

Changes in version 2:
- added Simon's ACK.

 arch/arm/boot/dts/r8a7792-blanche.dts |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
+++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
@@ -30,6 +30,27 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
+
+	d3_3v: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	ethernet at 18000000 {
+		compatible = "smsc,lan89218", "smsc,lan9115";
+		reg = <0 0x18000000 0 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&irqc>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		smsc,irq-push-pull;
+		reg-io-width = <4>;
+		vddvario-supply = <&d3_3v>;
+		vdd33a-supply = <&d3_3v>;
+	};
 };
 
 &extal_clk {
