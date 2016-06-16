From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 16 Jun 2016 18:53:25 +0530
Subject: [PATCH V2 2/4] clk: Combine DT binding doc for max77686 and max77802
In-Reply-To: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1466083407-28793-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock IP used on the Maxim PMICs max77686 and max77802 are
same. The configuration of clock register is also same except
the number of clocks.

Define the common DT binding file for the clocks of Maxim PMICs
MAX77686 and MAX77802. For this, remove the separate DT binding
document file for maxim,max77802 and move all information to
maxim,max77686 DT binding document.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@dowhile0.org>

---
Changes from V1:
- Rewrite description to remvoe ref to driver.
- Taken care of comment from Krzysztof on the supported clocks and
  DT bindings.
---
 .../devicetree/bindings/clock/maxim,max77686.txt   | 82 ++++++++++++++++------
 .../devicetree/bindings/clock/maxim,max77802.txt   | 44 ------------
 2 files changed, 59 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/maxim,max77802.txt

diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
index 9c40739..4d973b5 100644
--- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
+++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
@@ -1,11 +1,15 @@
-Binding for Maxim MAX77686 32k clock generator block
+Binding for Maxim MAX77686/MAX77802 32k clock generator block
 
-This is a part of device tree bindings of MAX77686 multi-function device.
-More information can be found in bindings/mfd/max77686.txt file.
+This is a part of device tree bindings of MAX77686/MAX77802 multi-function
+device. More information can be found in bindings/mfd/max77686.txt file for
+MAX77686 and bindings/mfd/max77802.txt for MAX77802.
 
 The MAX77686 contains three 32.768khz clock outputs that can be controlled
 (gated/ungated) over I2C.
 
+The MAX77802 contains two 32.768khz clock outputs that can be controlled
+(gated/ungated) over I2C.
+
 Following properties should be presend in main device node of the MFD chip.
 
 Required properties:
@@ -17,30 +21,62 @@ Optional properties:
 
 Each clock is assigned an identifier and client nodes can use this identifier
 to specify the clock which they consume. Following indices are allowed:
-    - 0: 32khz_ap clock,
-    - 1: 32khz_cp clock,
-    - 2: 32khz_pmic clock.
+    - 0: 32khz_ap clock (max77686, max77802),
+    - 1: 32khz_cp clock (max77686, max77802),
+    - 2: 32khz_pmic clock (max77686).
 
 Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77686.h
-header and can be used in device tree sources.
+header for MAX77686 and dt-bindings/clock/maxim,max77802.h for MAX77802 and can
+be used in device tree sources.
+
+Example:
+
+1. With MAX77686:
+
+#include <dt-bindings/clock/maxim,max77686.h>
+/* ... */
+
+	Node of the MFD chip
+		max77686: max77686 at 09 {
+			compatible = "maxim,max77686";
+			interrupt-parent = <&wakeup_eint>;
+			interrupts = <26 0>;
+			reg = <0x09>;
+			#clock-cells = <1>;
+
+			/* ... */
+		};
+
+	Clock consumer node
+
+		foo at 0 {
+			compatible = "bar,foo";
+			/* ... */
+			clock-names = "my-clock";
+			clocks = <&max77686 MAX77686_CLK_PMIC>;
+		};
+
+2. With MAX77802:
 
-Example: Node of the MFD chip
+#include <dt-bindings/clock/maxim,max77802.h>
+/* ... */
 
-	max77686: max77686 at 09 {
-		compatible = "maxim,max77686";
-		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 0>;
-		reg = <0x09>;
-		#clock-cells = <1>;
+	Node of the MFD chip
+		max77802: max77802 at 09 {
+			compatible = "maxim,max77802";
+			interrupt-parent = <&wakeup_eint>;
+			interrupts = <26 0>;
+			reg = <0x09>;
+			#clock-cells = <1>;
 
-		/* ... */
-	};
+			/* ... */
+		};
 
-Example: Clock consumer node
+	Clock consumer node
 
-	foo at 0 {
-		compatible = "bar,foo";
-		/* ... */
-		clock-names = "my-clock";
-		clocks = <&max77686 MAX77686_CLK_PMIC>;
-	};
+		foo at 0 {
+			compatible = "bar,foo";
+			/* ... */
+			clock-names = "my-clock";
+			clocks = <&max77802 MAX77802_CLK_32K_AP>;
+		};
diff --git a/Documentation/devicetree/bindings/clock/maxim,max77802.txt b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
deleted file mode 100644
index c6dc783..0000000
--- a/Documentation/devicetree/bindings/clock/maxim,max77802.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Binding for Maxim MAX77802 32k clock generator block
-
-This is a part of device tree bindings of MAX77802 multi-function device.
-More information can be found in bindings/mfd/max77802.txt file.
-
-The MAX77802 contains two 32.768khz clock outputs that can be controlled
-(gated/ungated) over I2C.
-
-Following properties should be present in main device node of the MFD chip.
-
-Required properties:
-- #clock-cells: From common clock binding; shall be set to 1.
-
-Optional properties:
-- clock-output-names: From common clock binding.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. Following indices are allowed:
-     - 0: 32khz_ap clock,
-     - 1: 32khz_cp clock.
-
-Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77802.h
-header and can be used in device tree sources.
-
-Example: Node of the MFD chip
-
-	max77802: max77802 at 09 {
-		compatible = "maxim,max77802";
-		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 0>;
-		reg = <0x09>;
-		#clock-cells = <1>;
-
-		/* ... */
-	};
-
-Example: Clock consumer node
-
-	foo at 0 {
-		compatible = "bar,foo";
-		/* ... */
-		clock-names = "my-clock";
-		clocks = <&max77802 MAX77802_CLK_32K_AP>;
-	};
-- 
2.1.4
