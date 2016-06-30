From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:48 +0200
Subject: [PATCH 28/41] ARM: dts: blanche: add Ethernet support
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <f80b6dfd5e56f3908832ce89f96ae94352b616c2.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

R8A7792  SoC  doesn't have the EtherMAC core, so SMSC  LAN89218  Ethernet
chip was used instead on the Blanche board; this chip  is compatible with
SMSC LAN9115  for  which there's a (device tree aware) driver. Describe
the  chip in  the  Blanche device tree;  enable DHCP and NFS root in the
kernel command line for the kernel booting.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index e277d924441b..e7b40f0e7da6 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
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
-- 
2.7.0.rc3.207.g0ac5344
