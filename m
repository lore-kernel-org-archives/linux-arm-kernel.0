From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 16 Jun 2016 18:53:26 +0530
Subject: [PATCH V2 3/4] clk: max77686: Add DT binding details for PMIC MAX77620
In-Reply-To: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1466083407-28793-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxim has used the same clock IP on multiple PMICs like MAX77686,
MAX77802, MAX77620. Only differences are the number of clocks
from these PMICs like MAX77686 has 3 clocks output, MAX776802 have
two clock output and MAX77620 has one clock output.

Add clock binding details and DT example for the MAX77620.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@dowhile0.org>

---
Changes from V1:
- Use proper comment for the ::::
- Added dt binding preprocessor file as maxim,max77620.h for max77620
  inline with the other chip.
- Refer the dt binding header for the supported clock index.
---
 .../devicetree/bindings/clock/maxim,max77686.txt   | 52 +++++++++++++++++-----
 include/dt-bindings/clock/maxim,max77620.h         | 21 +++++++++
 2 files changed, 63 insertions(+), 10 deletions(-)
 create mode 100644 include/dt-bindings/clock/maxim,max77620.h

diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
index 4d973b5..8398a3a 100644
--- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
+++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
@@ -1,14 +1,24 @@
-Binding for Maxim MAX77686/MAX77802 32k clock generator block
+Binding for Maxim MAX77686/MAX77802/MAX77620 32k clock generator block
 
-This is a part of device tree bindings of MAX77686/MAX77802 multi-function
-device. More information can be found in bindings/mfd/max77686.txt file for
-MAX77686 and bindings/mfd/max77802.txt for MAX77802.
+This is a part of device tree bindings of MAX77686/MAX77802/MAX77620
+multi-function device. More information can be found in MFD DT binding
+doc as follows:
+	bindings/mfd/max77686.txt for MAX77686 and
+	bindings/mfd/max77802.txt for MAX77802 and
+	bindings/mfd/max77620.txt for MAX77620.
 
 The MAX77686 contains three 32.768khz clock outputs that can be controlled
-(gated/ungated) over I2C.
+(gated/ungated) over I2C. Clocks are defined as preprocessor macros in
+dt-bindings/clock/maxim,max77686.h.
+
 
 The MAX77802 contains two 32.768khz clock outputs that can be controlled
-(gated/ungated) over I2C.
+(gated/ungated) over I2C. Clocks are defined as preprocessor macros in
+dt-bindings/clock/maxim,max77802.h.
+
+The MAX77686 contains one 32.768khz clock outputs that can be controlled
+(gated/ungated) over I2C. Clocks are defined as preprocessor macros in
+dt-bindings/clock/maxim,max77620.h.
 
 Following properties should be presend in main device node of the MFD chip.
 
@@ -21,13 +31,12 @@ Optional properties:
 
 Each clock is assigned an identifier and client nodes can use this identifier
 to specify the clock which they consume. Following indices are allowed:
-    - 0: 32khz_ap clock (max77686, max77802),
+    - 0: 32khz_ap clock (max77686, max77802), 32khz_out0 (max77620)
     - 1: 32khz_cp clock (max77686, max77802),
     - 2: 32khz_pmic clock (max77686).
 
-Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77686.h
-header for MAX77686 and dt-bindings/clock/maxim,max77802.h for MAX77802 and can
-be used in device tree sources.
+Clocks are defined as preprocessor macros in above dt-binding header for
+respective chips.
 
 Example:
 
@@ -80,3 +89,26 @@ Example:
 			clock-names = "my-clock";
 			clocks = <&max77802 MAX77802_CLK_32K_AP>;
 		};
+
+
+3. With MAX77620:
+
+#include <dt-bindings/clock/maxim,max77620.h>
+/* ... */
+
+	Node of the MFD chip
+		max77620: max77620 at 3c {
+			compatible = "maxim,max77620";
+			reg = <0x3c>;
+			#clock-cells = <1>;
+			/* ... */
+		};
+
+	Clock consumer node
+
+		foo at 0 {
+			compatible = "bar,foo";
+			/* ... */
+			clock-names = "my-clock";
+			clocks = <&max77620 MAX77620_CLK_32K_OUT0>;
+		};
diff --git a/include/dt-bindings/clock/maxim,max77620.h b/include/dt-bindings/clock/maxim,max77620.h
new file mode 100644
index 0000000..82aba28
--- /dev/null
+++ b/include/dt-bindings/clock/maxim,max77620.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants clocks for the Maxim 77620 PMIC.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_MAXIM_MAX77620_CLOCK_H
+#define _DT_BINDINGS_CLOCK_MAXIM_MAX77620_CLOCK_H
+
+/* Fixed rate clocks. */
+
+#define MAX77620_CLK_32K_OUT0		0
+
+/* Total number of clocks. */
+#define MAX77620_CLKS_NUM		(MAX77620_CLK_32K_OUT0 + 1)
+
+#endif /* _DT_BINDINGS_CLOCK_MAXIM_MAX77620_CLOCK_H */
-- 
2.1.4
