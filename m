From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Apr 2017 17:50:56 +0800
Subject: [PATCH v4 1/5] dt-bindings: update device tree binding for Allwinner
 PRCM CCUs
In-Reply-To: <20170404095100.18649-1-icenowy@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
Message-ID: <20170404095100.18649-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Many Allwinner SoCs after A31 have a CCU in PRCM block.

Give the ones on H3 and A64 compatible strings.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Add Rob's ACK.
Changes in v3:
- Removed frequency info of iosc in this device tree binding document.
Changes in v2:
- Add iosc for R_CCU's on H3/A64.

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 68512aa398a9..e9c5a1d9834a 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -7,9 +7,11 @@ Required properties :
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-h3-ccu"
+		- "allwinner,sun8i-h3-r-ccu"
 		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun9i-a80-ccu"
 		- "allwinner,sun50i-a64-ccu"
+		- "allwinner,sun50i-a64-r-ccu"
 		- "allwinner,sun50i-h5-ccu"
 
 - reg: Must contain the registers base address and length
@@ -20,7 +22,10 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
-Example:
+For the PRCM CCUs on H3/A64, one more clock is needed:
+- "iosc": the SoC's internal frequency oscillator
+
+Example for generic CCU:
 ccu: clock at 01c20000 {
 	compatible = "allwinner,sun8i-h3-ccu";
 	reg = <0x01c20000 0x400>;
@@ -29,3 +34,13 @@ ccu: clock at 01c20000 {
 	#clock-cells = <1>;
 	#reset-cells = <1>;
 };
+
+Example for PRCM CCU:
+r_ccu: clock at 01f01400 {
+	compatible = "allwinner,sun50i-a64-r-ccu";
+	reg = <0x01f01400 0x100>;
+	clocks = <&osc24M>, <&osc32k>, <&iosc>;
+	clock-names = "hosc", "losc", "iosc";
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
-- 
2.12.2
