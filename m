From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:55 +0200
Subject: [PATCH 6/6] ARM: dts: pxa3xx: add pincontrol helpers
In-Reply-To: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
References: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1459838155-28803-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various pxa3xx variants have a really weird pin scheme assignement,
when you want the pin number relative to a known gpio pin.

This change adds the various tools to ease up writing the pinmux and
pinconf devicetree parts.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 6995b11ce042..9d6f3aacedb7 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -1,6 +1,96 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
 #include "pxa2xx.dtsi"
 
+#define MFP_PIN_PXA300(gpio)				\
+	((gpio <= 2) ? (0x00b4 + 4 * gpio) :		\
+	 (gpio <= 26) ? (0x027c + 4 * (gpio - 3)) :	\
+	 (gpio <= 98) ? (0x0400 + 4 * (gpio - 27)) :	\
+	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
+	 0)
+
+#define MFP_PIN_PXA310(gpio)				\
+	((gpio <= 2) ? (0x00b4 + 4 * gpio) :		\
+	 (gpio <= 26) ? (0x027c + 4 * (gpio - 3)) :	\
+	 (gpio <= 29) ? (0x0400 + 4 * (gpio - 27)) :	\
+	 (gpio <= 98) ? (0x0418 + 4 * (gpio - 30)) :	\
+	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
+	 (gpio <= 262) ? 0 :				\
+	 (gpio <= 268) ? (0x052c + 4 * (gpio - 263)) :	\
+	 0)
+
+#define MFP_PIN_PXA320(gpio)				\
+	((gpio <= 4) ? (0x0124 + 4 * gpio) :		\
+	 (gpio <= 9) ? (0x028c + 4 * (gpio - 5)) :	\
+	 (gpio <= 10) ? (0x0458 + 4 * (gpio - 10)) :	\
+	 (gpio <= 26) ? (0x02a0 + 4 * (gpio - 11)) :	\
+	 (gpio <= 48) ? (0x0400 + 4 * (gpio - 27)) :	\
+	 (gpio <= 62) ? (0x045c + 4 * (gpio - 49)) :	\
+	 (gpio <= 73) ? (0x04b4 + 4 * (gpio - 63)) :	\
+	 (gpio <= 98) ? (0x04f0 + 4 * (gpio - 74)) :	\
+	 (gpio <= 127) ? (0x0600 + 4 * (gpio - 99)) :	\
+	 0)
+
+/*
+ * MFP Alternate functions for pins having a gpio.
+ * Example of use: pinctrl-single,pins = < MFP_PIN_PXA310(21) MFP_AF1 >
+ */
+#define MFP_AF0		(0 << 0)
+#define MFP_AF1		(1 << 0)
+#define MFP_AF2		(2 << 0)
+#define MFP_AF3		(3 << 0)
+#define MFP_AF4		(4 << 0)
+#define MFP_AF5		(5 << 0)
+#define MFP_AF6		(6 << 0)
+
+/*
+ * MFP drive strength functions for pins.
+ * Example of use: pinctrl-single,drive-strength = MFP_DS03X;
+ */
+#define MFP_DSMSK	(0x7 << 10)
+#define MFP_DS01X	< (0x0 << 10) MFP_DSMSK >
+#define MFP_DS02X	< (0x1 << 10) MFP_DSMSK >
+#define MFP_DS03X	< (0x2 << 10) MFP_DSMSK >
+#define MFP_DS04X	< (0x3 << 10) MFP_DSMSK >
+#define MFP_DS06X	< (0x4 << 10) MFP_DSMSK >
+#define MFP_DS08X	< (0x5 << 10) MFP_DSMSK >
+#define MFP_DS10X	< (0x6 << 10) MFP_DSMSK >
+#define MFP_DS13X	< (0x7 << 10) MFP_DSMSK >
+
+/*
+ * MFP low power mode for pins.
+ * Example of use:
+ *   pinctrl-single,low-power-mode = MFP_LPM(MFP_LPM_PULL_LOW|MFP_LPM_EDGE_FALL);
+ *
+ * Table that determines the low power modes outputs, with actual settings
+ * used in parentheses for don't-care values. Except for the float output,
+ * the configured driven and pulled levels match, so if there is a need for
+ * non-LPM pulled output, the same configuration could probably be used.
+ *
+ * Output value  sleep_oe_n  sleep_data  pullup_en  pulldown_en  pull_sel
+ *                 (bit 7)    (bit 8)    (bit 14)     (bit 13)   (bit 15)
+ *
+ * Input            0          X(0)        X(0)        X(0)       0
+ * Drive 0          0          0           0           X(1)       0
+ * Drive 1          0          1           X(1)        0	  0
+ * Pull hi (1)      1          X(1)        1           0	  0
+ * Pull lo (0)      1          X(0)        0           1	  0
+ * Z (float)        1          X(0)        0           0	  0
+ */
+#define MFP_LPM(x)		< (x) MFP_LPM_MSK >
+
+#define MFP_LPM_MSK		0xe1f0
+#define MFP_LPM_INPUT		0x0000
+#define MFP_LPM_DRIVE_LOW	0x2000
+#define MFP_LPM_DRIVE_HIGH	0x4100
+#define MFP_LPM_PULL_LOW	0x2080
+#define MFP_LPM_PULL_HIGH	0x4180
+#define MFP_LPM_FLOAT		0x0080
+
+#define MFP_LPM_EDGE_NONE	0x0000
+#define MFP_LPM_EDGE_RISE	0x0010
+#define MFP_LPM_EDGE_FALL	0x0020
+#define MFP_LPM_EDGE_BOTH	0x0030
+
 / {
 	model = "Marvell PXA3xx familiy SoC";
 	compatible = "marvell,pxa3xx";
-- 
2.1.4
