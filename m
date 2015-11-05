From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 05 Nov 2015 15:03:00 +0300
Subject: [PATCH v6 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <cover.1446724046.git.p.fedin@samsung.com>
References: <cover.1446724046.git.p.fedin@samsung.com>
Message-ID: <26ce9f26ee8537b2f81ad0bf470d1c6b1c8a1a31.1446724046.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new subnode properties, allowing bank configuration.
Based on u-boot implementation, but heavily reworked.

Also, fix size of SROMc mapping in the example.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 .../bindings/arm/samsung/exynos-srom.txt           | 71 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
index 33886d5..cce5c1f 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -5,8 +5,75 @@ Required properties:
 
 - reg: offset and length of the register set
 
-Example:
+Optional properties:
+The SROM controller can be used to attach external peripherals. In this case
+extra properties, describing the bus behind it, should be specified as below:
+
+- #address-cells: Must be set to 2 to allow memory address translation
+
+- #size-cells: Must be set to 1 to allow CS address passing
+
+- ranges: Must be set up to reflect the memory layout with four integer values
+	  per bank:
+		<bank-number> 0 <physical address of bank> <size>
+
+Sub-nodes:
+The actual device nodes should be added as subnodes to the SROMc node. These
+subnodes, except regular device specification, should contain the following
+properties, describing configuration of the relevant SROM bank:
+
+Required properties:
+- reg: bank number, base address (relative to start of the bank) and size of
+       the memory mapped for the device. Note that base address will be
+       typically 0 as this is the start of the bank.
+
+- samsung,srom-timing : array of 6 integers, specifying bank timings in the
+                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
+                        Each value is specified in cycles and has the following
+                        meaning and valid range:
+                        Tacp : Page mode access cycle at Page mode (0 - 15)
+                        Tcah : Address holding time after CSn (0 - 15)
+                        Tcoh : Chip selection hold on OEn (0 - 15)
+                        Tacc : Access cycle (0 - 32)
+                        Tcos : Chip selection set-up before OEn (0 - 15)
+                        Tacs : Address set-up before CSn (0 - 15)
+
+Optional properties:
+- reg-io-width : data width in bytes (1 or 2). If omitted, default of 1 is used.
+
+- samsung,srom-page-mode : page mode configuration for the bank:
+			   0 - normal (one data)
+			   1 - four data
+			   If omitted, default of 0 is used.
+
+Example: basic definition, no banks are configured
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x14>;
+	};
+
+Example: SROMc with SMSC911x ethernet chip on bank 3
 	sromc at 12570000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x04000000 0x20000   // Bank0
+			  1 0 0x05000000 0x20000   // Bank1
+			  2 0 0x06000000 0x20000   // Bank2
+			  3 0 0x07000000 0x20000>; // Bank3
+
 		compatible = "samsung,exynos-srom";
-		reg = <0x12570000 0x10>;
+		reg = <0x12570000 0x14>;
+
+		ethernet at 3 {
+			compatible = "smsc,lan9115";
+			reg = <3 0 0x10000>;	   // Bank 3, offset = 0
+			phy-mode = "mii";
+			interrupt-parent = <&gpx0>;
+			interrupts = <5 8>;
+			reg-io-width = <2>;
+			smsc,irq-push-pull;
+			smsc,force-internal-phy;
+
+			samsung,srom-config = <1 9 12 1 9 1 1>;
+		};
 	};
-- 
2.4.4
