From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:41 +0900
Subject: [PATCH/RFC 04/19] ARM: shmobile: r8a7793: add iic(b)  to device tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1449802376-11301-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate iic(b) controllers in r8a7793 device tree.

Based on similar work for the r8a7791 and r8a7791 by Wolfram Sang.

Cc: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
The out-of order aliasing of iic to i2c is as per the documentation.
This differs from the scheme in use in the dtsi files for
other R-Car SoCs.

It would be nice to harmonise this somehow but I'm unsure of the backwards
compatibility issues.

For reference those aliases are:

* r8a7790:
  - i2c0 = &i2c0;
  - i2c1 = &i2c1;
  - i2c2 = &i2c2;
  - i2c3 = &i2c3;
  - i2c4 = &iic0;
  - i2c5 = &iic1;
  - i2c6 = &iic2;
  - i2c7 = &iic3;

  Notes:
  - The documentation does not make note of i2c aliases for iic
    (v1.02, table 12.2.1)
  - i2c4 and i2c5 are not present on this SoC

* r8a7791:
  - i2c0 = &i2c0;
  - i2c1 = &i2c1;
  - i2c2 = &i2c2;
  - i2c3 = &i2c3;
  - i2c4 = &i2c4;
  - i2c5 = &i2c5;
  - i2c6 = &i2c6;
  - i2c7 = &i2c7;
  - i2c8 = &i2c8;

  Notes:
  - i2c is used in place of iic and it is my understanding that
    i2c6 is iic0, i2c7 is iic1 and i2c8 is iic3.
  - iic3 is not present on this SoC
  - Documentation makes note of (v1.02, table 12.2.1).
    They are the same as those used in this patch for the r8a7793

* r8a7794:
  - i2c0 = &i2c0;
  - i2c1 = &i2c1;
  - i2c2 = &i2c2;
  - i2c3 = &i2c3;
  - i2c4 = &i2c4;
  - i2c5 = &i2c5;

  Notes:
  - iic0 and iic1 nodes not present in mainline but are present on this SoC
  - Documentation makes note of the following aliases (v1.02, table 12.2.1)
    - iic6 = &iic0
    - iic8 = &iic1
  - iic2 and iic3 are not present on this SoC
---
 arch/arm/boot/dts/r8a7793.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index b8998b9519f6..cdf40abcc36c 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -25,6 +25,9 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		i2c6 = &iic3;
+		i2c7 = &iic0;
+		i2c8 = &iic1;
 		spi0 = &qspi;
 	};
 
@@ -478,6 +481,45 @@
 		status = "disabled";
 	};
 
+	iic0: i2c at e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_IIC0>;
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	iic1: i2c at e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x425>;
+		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_IIC1>;
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	iic3: i2c at e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x425>;
+		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_IICDVFS>;
+		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
-- 
2.1.4
