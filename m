From: eric@anholt.net (Eric Anholt)
Date: Sun,  6 Sep 2015 10:57:41 -0700
Subject: [PATCH 2/4] clk: bcm2835: Add binding docs for the new platform clock
 driver.
In-Reply-To: <1441562263-19888-1-git-send-email-eric@anholt.net>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
Message-ID: <1441562263-19888-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously we've only supported a few fixed clocks based on
assumptions about how the firmware sets up the clocks, but this
binding will let us control the actual (audio power domain) clock
manager.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/clock/brcm,bcm2835-cprman.txt         | 45 +++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h                | 47 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
 create mode 100644 include/dt-bindings/clock/bcm2835.h

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt b/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
new file mode 100644
index 0000000..e56a1df
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
@@ -0,0 +1,45 @@
+Broadcom BCM2835 CPRMAN clocks
+
+This binding uses the common clock binding:
+    Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The CPRMAN clock controller generates clocks in the audio power domain
+of the BCM2835.  There is a level of PLLs deriving from an external
+oscillator, a level of PLL dividers that produce channels off of the
+few PLLs, and a level of mostly-generic clock generators sourcing from
+the PLL channels.  Most other hardware components source from the
+clock generators, but a few (like the ARM or HDMI) will source from
+the PLL dividers directly.
+
+Required properties:
+- compatible:	Should be "brcm,bcm2835-cprman"
+- #clock-cells:	Should be <1>. The permitted clock-specifier values can be
+		  found in include/dt-bindings/clock/bcm2835.h
+- reg:		Specifies base physical address and size of the registers
+- clocks:	The external oscillator clock phandle
+
+Example:
+
+	clk_osc: clock at 3 {
+		compatible = "fixed-clock";
+		reg = <3>;
+		#clock-cells = <0>;
+		clock-output-names = "osc";
+		clock-frequency = <19200000>;
+	};
+
+	clocks: cprman at 7e101000 {
+		compatible = "brcm,bcm2835-cprman";
+		#clock-cells = <1>;
+		reg = <0x7e101000 0x2000>;
+		clocks = <&clk_osc>;
+	};
+
+	i2c0: i2c at 7e205000 {
+		compatible = "brcm,bcm2835-i2c";
+		reg = <0x7e205000 0x1000>;
+		interrupts = <2 21>;
+		clocks = <&clocks BCM2835_CLOCK_VPU>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
new file mode 100644
index 0000000..d323efa
--- /dev/null
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -0,0 +1,47 @@
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
+#define BCM2835_PLLA			0
+#define BCM2835_PLLB			1
+#define BCM2835_PLLC			2
+#define BCM2835_PLLD			3
+#define BCM2835_PLLH			4
+
+#define BCM2835_PLLA_CORE		5
+#define BCM2835_PLLA_PER		6
+#define BCM2835_PLLB_ARM		7
+#define BCM2835_PLLC_CORE0		8
+#define BCM2835_PLLC_CORE1		9
+#define BCM2835_PLLC_CORE2		10
+#define BCM2835_PLLC_PER		11
+#define BCM2835_PLLD_CORE		12
+#define BCM2835_PLLD_PER		13
+#define BCM2835_PLLH_RCAL		14
+#define BCM2835_PLLH_AUX		15
+#define BCM2835_PLLH_PIX		16
+
+#define BCM2835_CLOCK_TIMER		17
+#define BCM2835_CLOCK_OTP		18
+#define BCM2835_CLOCK_UART		19
+#define BCM2835_CLOCK_VPU		20
+#define BCM2835_CLOCK_V3D		21
+#define BCM2835_CLOCK_ISP		22
+#define BCM2835_CLOCK_H264		23
+#define BCM2835_CLOCK_VEC		24
+#define BCM2835_CLOCK_HSM		25
+#define BCM2835_CLOCK_SDRAM		26
+#define BCM2835_CLOCK_TSENS		27
+#define BCM2835_CLOCK_EMMC		28
+#define BCM2835_CLOCK_PERI_IMAGE	29
+
+#define BCM2835_CLOCK_COUNT		30
-- 
2.1.4
