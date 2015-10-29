From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 15:42:17 +0300
Subject: [PATCH v4 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <cover.1446122247.git.p.fedin@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
Message-ID: <f1fbd1a7877090f4318705f0fccbf4d96c0ebc9c.1446122247.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new subnode properties, allowing bank configuration.
Based on u-boot implementation, but heavily reworked.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 .../bindings/arm/samsung/exynos-srom.txt           | 50 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
index 33886d5..02ecc7f 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -5,8 +5,54 @@ Required properties:
 
 - reg: offset and length of the register set
 
-Example:
+- #address-cells, #size-cells : should be '1' if the device has sub-nodes
+				with 'reg' property.
+- ranges: allows valid 1:1 translation between child's address space and
+	  parent's address space
+
+Sub-nodes:
+The SROM controller can be used to attach external peripherials. In this case
+device nodes should be added as subnodes to the SROMc node. These subnodes,
+except regular device specification, should contain the following properties,
+describing configuration of the relevant SROM bank:
+
+Required properties:
+- samsung,srom-bank : bank number (0 - 3)
+
+- samsung,srom-timing : array of 7 integers: PMC, Tacp, Tcah, Tcoh, Tacc, Tcos,
+			Tacs
+
+Optional properties:
+- samsung,srom-data-width : data width in bytes (1 or 2). If omitted, default
+			    of 1 is used.
+
+Example: basic definition, no banks are configured
 	sromc at 12570000 {
 		compatible = "samsung,exynos-srom";
-		reg = <0x12570000 0x10>;
+		reg = <0x12570000 0x14>;
+	};
+
+Example: SROMc with smsc 911x ethernet chip on bank 3
+	sromc at 12570000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x14>;
+
+		ethernet at 07000000 {
+			compatible = "smsc,lan9115";
+			reg = <0x07000000 0x10000>;
+			phy-mode = "mii";
+			interrupt-parent = <&gpx0>;
+			interrupts = <5 8>;
+			reg-io-width = <2>;
+			smsc,irq-push-pull;
+			smsc,force-internal-phy;
+
+			samsung,srom-bank = <3>;
+			samsung,srom-data-width = <2>;
+			samsung,srom-timing = <1 9 12 1 9 1 1>;
+		};
 	};
-- 
2.4.4
