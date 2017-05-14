From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 00:30:33 +0800
Subject: [PATCH v7 01/13] dt-bindings: add binding for the Allwinner DE2 CCU
In-Reply-To: <20170514163045.40366-1-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
Message-ID: <20170514163045.40366-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner "Display Engine 2.0" contains some clock controls in it.

In order to add them as clock drivers, we need a device tree binding.
Add the binding here.

Also add the device tree binding headers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- Added V3s compatible.
Changes in v6:
- Added Rob's ACK.
- Droped A64's compatible as it's not appropriate now.
Changes in v5:
- Moved dt-binding headers here.
- Changed dt-binding headers' license header to SPDX license.
Changes in v4:
- Dropped the leading 0 in clock at 1000000 .
Changes in v3:
- Fill the address space length of DE2 CCU to 0x100000, just reach the start of mixer0.

 .../devicetree/bindings/clock/sun8i-de2.txt        | 31 ++++++++++++++++++++++
 include/dt-bindings/clock/sun8i-de2.h              | 18 +++++++++++++
 include/dt-bindings/reset/sun8i-de2.h              | 14 ++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
 create mode 100644 include/dt-bindings/clock/sun8i-de2.h
 create mode 100644 include/dt-bindings/reset/sun8i-de2.h

diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
new file mode 100644
index 000000000000..631d27cd89d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
@@ -0,0 +1,31 @@
+Allwinner Display Engine 2.0 Clock Control Binding
+--------------------------------------------------
+
+Required properties :
+- compatible: must contain one of the following compatibles:
+		- "allwinner,sun8i-a83t-de2-clk"
+		- "allwinner,sun8i-v3s-de2-clk"
+		- "allwinner,sun50i-h5-de2-clk"
+
+- reg: Must contain the registers base address and length
+- clocks: phandle to the clocks feeding the display engine subsystem.
+	  Three are needed:
+  - "mod": the display engine module clock
+  - "bus": the bus clock for the whole display engine subsystem
+- clock-names: Must contain the clock names described just above
+- resets: phandle to the reset control for the display engine subsystem.
+- #clock-cells : must contain 1
+- #reset-cells : must contain 1
+
+Example:
+de2_clocks: clock at 1000000 {
+	compatible = "allwinner,sun8i-a83t-de2-clk";
+	reg = <0x01000000 0x100000>;
+	clocks = <&ccu CLK_BUS_DE>,
+		 <&ccu CLK_DE>;
+	clock-names = "bus",
+		      "mod";
+	resets = <&ccu RST_BUS_DE>;
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
new file mode 100644
index 000000000000..3bed63b524aa
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-de2.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_SUN8I_DE2_H_
+#define _DT_BINDINGS_CLOCK_SUN8I_DE2_H_
+
+#define CLK_BUS_MIXER0		0
+#define CLK_BUS_MIXER1		1
+#define CLK_BUS_WB		2
+
+#define CLK_MIXER0		6
+#define CLK_MIXER1		7
+#define CLK_WB			8
+
+#endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
new file mode 100644
index 000000000000..9526017432f0
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-de2.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#ifndef _DT_BINDINGS_RESET_SUN8I_DE2_H_
+#define _DT_BINDINGS_RESET_SUN8I_DE2_H_
+
+#define RST_MIXER0	0
+#define RST_MIXER1	1
+#define RST_WB		2
+
+#endif /* _DT_BINDINGS_RESET_SUN8I_DE2_H_ */
-- 
2.12.2
