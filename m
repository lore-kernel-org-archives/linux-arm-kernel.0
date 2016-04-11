From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 11 Apr 2016 13:12:23 +0530
Subject: [RESPIN v2 1/6] dt-bindings: EXYNOS: Add exynos-srom device tree
 binding
In-Reply-To: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
References: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1460360548-32127-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds exynos-srom binding information for SROM Controller
driver on Exynos SoCs. Documentation for new subnode properties,
allowing bank configuration are added based on u-boot implementation,
but heavily reworked.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
[p.fedin: Added SROMc configuration description and fixed SROMc mapping]
Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../bindings/memory-controllers/exynos-srom.txt    | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
new file mode 100644
index 0000000..f633b5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
@@ -0,0 +1,79 @@
+SAMSUNG Exynos SoCs SROM Controller driver.
+
+Required properties:
+- compatible : Should contain "samsung,exynos4210-srom".
+
+- reg: offset and length of the register set
+
+Optional properties:
+The SROM controller can be used to attach external peripherals. In this case
+extra properties, describing the bus behind it, should be specified as below:
+
+- #address-cells: Must be set to 2 to allow device address translation.
+		  Address is specified as (bank#, offset).
+
+- #size-cells: Must be set to 1 to allow device size passing
+
+- ranges: Must be set up to reflect the memory layout with four integer values
+	  per bank:
+		<bank-number> 0 <parent address of bank> <size>
+
+Sub-nodes:
+The actual device nodes should be added as subnodes to the SROMc node. These
+subnodes, in addition to regular device specification, should contain the following
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
+                        Tacc : Access cycle (0 - 31, the actual time is N + 1)
+                        Tcos : Chip selection set-up before OEn (0 - 15)
+                        Tacs : Address set-up before CSn (0 - 15)
+
+Optional properties:
+- reg-io-width : data width in bytes (1 or 2). If omitted, default of 1 is used.
+
+- samsung,srom-page-mode : if page mode is set, 4 data page mode will be configured,
+			   else normal (1 data) page mode will be set.
+
+Example: basic definition, no banks are configured
+	memory-controller at 12570000 {
+		compatible = "samsung,exynos4210-srom";
+		reg = <0x12570000 0x14>;
+	};
+
+Example: SROMc with SMSC911x ethernet chip on bank 3
+	memory-controller at 12570000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x04000000 0x20000   // Bank0
+			  1 0 0x05000000 0x20000   // Bank1
+			  2 0 0x06000000 0x20000   // Bank2
+			  3 0 0x07000000 0x20000>; // Bank3
+
+		compatible = "samsung,exynos4210-srom";
+		reg = <0x12570000 0x14>;
+
+		ethernet at 3,0 {
+			compatible = "smsc,lan9115";
+			reg = <3 0 0x10000>;	   // Bank 3, offset = 0
+			phy-mode = "mii";
+			interrupt-parent = <&gpx0>;
+			interrupts = <5 8>;
+			reg-io-width = <2>;
+			smsc,irq-push-pull;
+			smsc,force-internal-phy;
+
+			samsung,srom-page-mode;
+			samsung,srom-timing = <9 12 1 9 1 1>;
+		};
+	};
-- 
2.4.5
