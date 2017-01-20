From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 20 Jan 2017 16:22:28 +0100
Subject: [PATCH v3 5/9] ARM64: dts: meson-gxbb-wetek-hub: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170120152232.13943-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state.
While here also specify the phy-handle of the ethmac node to make the
PHY configuration similar to the one we have on GXL devices. This will
allow us to specify OF-properties for the PHY itself.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 56f855901262..47fe4e444f33 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -64,3 +64,27 @@
 		status = "disabled";
 	};
 };
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			compatible = "ethernet-phy-id001c.c916",
+				     "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
+};
-- 
2.11.0
