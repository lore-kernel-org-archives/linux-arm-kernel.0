From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 25 Jun 2018 14:56:53 +0200
Subject: [PATCH] ARM64: dts: meson-axg: fix ethernet stability issue
Message-ID: <20180625125653.3404-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like the odroid-c2 and wetek, the s400 uses the RTL8211F and seems to
suffer from the kind of stability issue.

Doing an iperf3 download test, we can see a significant number of LPI
interrupts on the tx path. After a short while (5 to 15 seconds), the
network connection dies. If using rootfs over NFS, the connection may
also break during the boot sequence.

We still don't have a real explanation for this problem so let's disable
EEE once again.

Fixes: f6f6ac914b82 ("ARM64: dts: meson-axg: enable ethernet for A113D S400 board")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 4b3331fbfe39..dff9b15eb3c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -66,9 +66,22 @@
 
 &ethmac {
 	status = "okay";
-	phy-mode = "rgmii";
 	pinctrl-0 = <&eth_rgmii_y_pins>;
 	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			/* Realtek RTL8211F (0x001cc916) */
+			reg = <0>;
+			eee-broken-1000t;
+		};
+	};
 };
 
 &uart_A {
-- 
2.14.4
