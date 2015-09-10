From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 15:22:28 -0700
Subject: [PATCH 1/3] clk: bcm2835: Add bindings for the auxiliary peripheral
 clock gates.
In-Reply-To: <1441923750-19404-1-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
Message-ID: <1441923750-19404-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These will be used for enabling UART1, SPI1, and SPI2.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/clock/brcm,bcm2835-aux-clock.txt      | 30 ++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835-aux.h            | 17 ++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
 create mode 100644 include/dt-bindings/clock/bcm2835-aux.h

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt b/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
new file mode 100644
index 0000000..f5ce80a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
@@ -0,0 +1,30 @@
+Broadcom BCM2835 auxiliary peripheral clocks
+
+This binding uses the common clock binding:
+    Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+This controls the clock gating for the BCM2835 auxiliary peripherals
+(UART, SPI1, and SPI2).
+
+Required properties:
+- compatible:	Should be "brcm,bcm2835-aux-clock"
+- #clock-cells:	Should be <1>. The permitted clock-specifier values can be
+		  found in include/dt-bindings/clock/bcm2835-aux.h
+- reg:		Specifies base physical address and size of the gate register
+- clocks:	The parent clock phandle
+
+Example:
+
+	clocks: cprman at 7e101000 {
+		compatible = "brcm,bcm2835-cprman";
+		#clock-cells = <1>;
+		reg = <0x7e101000 0x2000>;
+		clocks = <&clk_osc>;
+	};
+
+	aux_clocks: aux-clocks at 0x7e215004 {
+		compatible = "brcm,bcm2835-aux-clock";
+		#clock-cells = <1>;
+		reg = <0x7e215004 0x4>;
+		clocks = <&clocks BCM2835_CLOCK_VPU>;
+	};
diff --git a/include/dt-bindings/clock/bcm2835-aux.h b/include/dt-bindings/clock/bcm2835-aux.h
new file mode 100644
index 0000000..d91156e
--- /dev/null
+++ b/include/dt-bindings/clock/bcm2835-aux.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define BCM2835_AUX_CLOCK_UART		0
+#define BCM2835_AUX_CLOCK_SPI1		1
+#define BCM2835_AUX_CLOCK_SPI2		2
+#define BCM2835_AUX_CLOCK_COUNT		3
-- 
2.1.4
