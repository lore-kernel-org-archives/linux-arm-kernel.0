From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  6 Jul 2017 12:24:23 +0200
Subject: [PATCH 3/3] dt-bindings: clock: amlogic,gxbb-aoclkc: Update bindings
In-Reply-To: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
References: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the first revision of the bindings, only the gates + resets were known
in the AO Clock HW, but more registers used to configures AO clock are known
to be spread among the AO register space.
This patch adds these registers to the Ao Clock bindings with direct access
and shared extcon access.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt         | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index a55d31b..5c5ccec 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -7,7 +7,10 @@ Required Properties:
 
 - compatible: should be "amlogic,gxbb-aoclkc"
 - reg: physical base address of the clock controller and length of memory
-       mapped region.
+       mapped region for each registers listed in reg-names.
+- reg-names: should contain the following register names :
+	"aoclk", "aocrt" and "aortc".
+- amlogic,pwr-ctrl: A phandle to the AO Power Control node.
 
 - #clock-cells: should be 1.
 
@@ -27,9 +30,13 @@ Example: AO Clock controller node:
 
 	clkc_AO: clock-controller at 040 {
 		compatible = "amlogic,gxbb-aoclkc";
-		reg = <0x0 0x040 0x0 0x4>;
+		reg = <0x0 0x00040 0x0 0x4>,
+		      <0x0 0x00068 0x0 0x4>,
+		      <0x0 0x00094 0x0 0x8>;
+		reg-names = "aoclk", "aocrt", "aortc";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		amlogic,pwr-ctrl = <&pwr_AO>;
 	};
 
 Example: UART controller node that consumes the clock and reset generated
-- 
1.9.1
