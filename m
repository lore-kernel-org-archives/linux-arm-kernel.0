From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 01:28:04 +0800
Subject: [PATCH v2 1/5] dt-bindings: update device tree binding for Allwinner
 PRCM CCUs
In-Reply-To: <20170315172808.64011-1-icenowy@aosc.xyz>
References: <20170315172808.64011-1-icenowy@aosc.xyz>
Message-ID: <20170315172808.64011-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many Allwinner SoCs after A31 have a CCU in PRCM block.

Give the ones on H3 and A64 compatible strings.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Add iosc for R_CCU's on H3/A64. (A31, A23 and A33 seem to have different
  clock for mux 3 of ar100 clk. Investgations are needed for them.)

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 68512aa398a9..4a4addff595d 100644
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
@@ -20,7 +22,11 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
-Example:
+For the PRCM CCUs on H3/A64, one more clock is needed:
+- "iosc": another frequency oscillator used for CPUS (usually at 32000Hz,
+          not the same with losc)
+
+Example for generic CCU:
 ccu: clock at 01c20000 {
 	compatible = "allwinner,sun8i-h3-ccu";
 	reg = <0x01c20000 0x400>;
@@ -29,3 +35,13 @@ ccu: clock at 01c20000 {
 	#clock-cells = <1>;
 	#reset-cells = <1>;
 };
+
+Example for PRCM CCU:
+r_ccu: clock at 01f01400 {
+	compatible = "allwinner,sun50i-a64-r-ccu";
+	reg = <0x01f01400 0x100>;
+	clocks = <&osc24M>, <&osc32k>, <&osc32000>;
+	clock-names = "hosc", "losc", "iosc";
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
-- 
2.12.0
