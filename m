From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  6 Dec 2015 20:52:15 +0100
Subject: [PATCH v9 2/8] ARM: dt: Binding documentation for imx25 GCQ
In-Reply-To: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1449431542-1892-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation describes the bindings for the imx25 GCQ unit which is
essentially a generic conversion queue using the imx25 ADC.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v9:
     - Added the dt-bindings header to this patch instead of the driver
    
    Changes in v6:
     - Changed bindings to use adc-refp and adc-refn. Also a bit of cleanup in the
       setup routine.
    
    Changes in v5:
     - Fixed locking
     - Removed module owner

 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 58 ++++++++++++++++++++++
 include/dt-bindings/iio/adc/fsl-imx25-gcq.h        | 18 +++++++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
 create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
new file mode 100644
index 000000000000..b0866d36a307
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
@@ -0,0 +1,58 @@
+Freescale i.MX25 ADC GCQ device
+
+This is a generic conversion queue device that can convert any of the
+analog inputs using the ADC unit of the i.MX25.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-gcq".
+ - reg: Should be the register range of the module.
+ - interrupts: Should be the interrupt number of the module.
+   Typically this is <1>.
+ - interrupt-parent: phandle to the tsadc module of the i.MX25.
+ - #address-cells: Should be <1> (setting for the subnodes)
+ - #size-cells: Should be <0> (setting for the subnodes)
+
+Optional properties:
+ - vref-ext-supply: The regulator supplying the ADC reference voltage.
+   Required when at least one subnode uses the this reference.
+ - vref-xp-supply: The regulator supplying the ADC reference voltage on pin XP.
+   Required when at least one subnode uses this reference.
+ - vref-yp-supply: The regulator supplying the ADC reference voltage on pin YP.
+   Required when at least one subnode uses this reference.
+
+Sub-nodes:
+Optionally you can define subnodes which define the reference voltage
+for the analog inputs.
+
+Required properties for subnodes:
+ - reg: Should be the number of the analog input.
+     0: xp
+     1: yp
+     2: xn
+     3: yn
+     4: wiper
+     5: inaux0
+     6: inaux1
+     7: inaux2
+Optional properties for subnodes:
+ - fsl,adc-refp: specifies the positive reference input as defined in
+     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+ - fsl,adc-refn: specifies the negative reference input as defined in
+     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+
+Example:
+
+	adc: adc at 50030800 {
+		compatible = "fsl,imx25-gcq";
+		reg = <0x50030800 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		inaux at 5 {
+			reg = <5>;
+			fsl,adc-refp = <MX25_ADC_REFP_INT>;
+			fsl,adc-refn = <MX25_ADC_REFN_NGND>;
+		};
+	};
diff --git a/include/dt-bindings/iio/adc/fsl-imx25-gcq.h b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
new file mode 100644
index 000000000000..87abdd4a7674
--- /dev/null
+++ b/include/dt-bindings/iio/adc/fsl-imx25-gcq.h
@@ -0,0 +1,18 @@
+/*
+ * This header provides constants for configuring the I.MX25 ADC
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+#define _DT_BINDINGS_IIO_ADC_FS_IMX25_GCQ_H
+
+#define MX25_ADC_REFP_YP	0 /* YP voltage reference */
+#define MX25_ADC_REFP_XP	1 /* XP voltage reference */
+#define MX25_ADC_REFP_EXT	2 /* External voltage reference */
+#define MX25_ADC_REFP_INT	3 /* Internal voltage reference */
+
+#define MX25_ADC_REFN_XN	0 /* XN ground reference */
+#define MX25_ADC_REFN_YN	1 /* YN ground reference */
+#define MX25_ADC_REFN_NGND	2 /* Internal ground reference */
+#define MX25_ADC_REFN_NGND2	3 /* External ground reference */
+
+#endif
-- 
2.6.2
