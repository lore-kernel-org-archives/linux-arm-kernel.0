From: chunkeey@gmail.com (Christian Lamparter)
Date: Mon, 28 May 2018 13:06:01 +0200
Subject: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: add gpio-ranges,
 gpio-reserved-ranges
Message-ID: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the gpio-ranges and gpio-reserved-ranges property
definitions to the binding text files supported by the pinctrl-msm
driver framework.

gpio-ranges:
For DT-based platforms the pinctrl-msm framework currently relies
on the deprecated-for-DT gpiochip_add_pin_range() function to add
the range of GPIOs to be handled by the pin controller. Due to
interactions within gpiolib code, this causes the pinctrl-msm
driver to bail out (-517) during boot when a gpio-hog is declared.
This can be fatal and cause the system to not boot or reset
(for a detailed explanation and call-trace, refer to patch:
"pinctrl: msm: fix gpio-hog related boot issues" in this series).

gpio-reserved-ranges:
The binding has been added as a precaution since the TrustZone
firmware (aka QSEE), which is running as the hypervisor, might
have reserved certain, but undisclosed pins. Hence reading or
writing to the registers for those pins will cause an
XPU violation and this subsequently crashes the kernel.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 .../devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt | 6 ++++++
 .../devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt | 6 ++++++
 .../devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt | 6 ++++++
 .../devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt | 6 ++++++
 .../devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt | 6 ++++++
 .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt | 9 +++++++++
 .../devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt | 9 +++++++++
 12 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
index a752a4716486..c2dbb3e8d840 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
@@ -10,6 +10,11 @@ Required properties:
 - #gpio-cells : Should be two.
                 The first cell is the gpio pin number and the
                 second cell is used for optional parameters.
+- gpio-ranges: see ../gpio/gpio.txt
+
+Optional properties:
+
+- gpio-reserved-ranges: see ../gpio/gpio.txt
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
@@ -67,6 +72,7 @@ Example:
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&gsbi5_uart_default>;
+		gpio-ranges = <&msmgpio 0 0 90>;
 
 		gsbi5_uart_default: gsbi5_uart_default {
 			mux {
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
index c4ea61ac56f2..68e93d5b7ede 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt
@@ -40,6 +40,14 @@ MSM8960 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -154,6 +162,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 147>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 208 0>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
index 93374f478b9e..991be0cd0948 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
@@ -13,6 +13,11 @@ Required properties:
 - #gpio-cells : Should be two.
                 The first cell is the gpio pin number and the
                 second cell is used for optional parameters.
+- gpio-ranges: see ../gpio/gpio.txt
+
+Optional properties:
+
+- gpio-reserved-ranges: see ../gpio/gpio.txt
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
@@ -64,6 +69,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 100>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 208 0>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
index 6e88e91feb11..7ed56a1b70fc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
@@ -10,6 +10,11 @@ Required properties:
 - #gpio-cells : Should be two.
                 The first cell is the gpio pin number and the
                 second cell is used for optional parameters.
+- gpio-ranges: see ../gpio/gpio.txt
+
+Optional properties:
+
+- gpio-reserved-ranges: see ../gpio/gpio.txt
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
@@ -67,6 +72,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&pinmux 0 0 69>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 32 0x4>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
index 407b9443629d..6dd72f8599e9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
@@ -40,6 +40,14 @@ IPQ8074 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -148,6 +156,7 @@ Example:
 		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 70>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
index 1b52f01ddcb7..86ecdcfc4fb8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt
@@ -40,6 +40,14 @@ MDM9615 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -127,6 +135,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&msmgpio 0 0 88>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 16 0x4>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
index df9a838ec5f9..cdc4787e59d2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
@@ -10,6 +10,11 @@ Required properties:
 - #gpio-cells : Should be two.
                 The first cell is the gpio pin number and the
                 second cell is used for optional parameters.
+- gpio-ranges: see ../gpio/gpio.txt
+
+Optional properties:
+
+- gpio-reserved-ranges: see ../gpio/gpio.txt
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
@@ -62,6 +67,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&msmgpio 0 0 173>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 16 0x4>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
index 498caff6029e..195a7a0ef0cc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt
@@ -40,6 +40,14 @@ MSM8916 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -162,6 +170,7 @@ Example:
 		interrupts = <0 208 0>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 122>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
index eb8d8aa41f20..5034eb6653c7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt
@@ -40,6 +40,14 @@ MSM8960 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -156,6 +164,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&msmgpio 0 0 152>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 16 0x4>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
index 453bd7c76d6b..c22e6c425d0b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
@@ -10,6 +10,11 @@ Required properties:
 - #gpio-cells : Should be two.
                 The first cell is the gpio pin number and the
                 second cell is used for optional parameters.
+- gpio-ranges: see ../gpio/gpio.txt
+
+Optional properties:
+
+- gpio-reserved-ranges: see ../gpio/gpio.txt
 
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
@@ -87,6 +92,7 @@ Example:
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&msmgpio 0 0 146>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		interrupts = <0 208 0>;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
index 13cd629f896e..f15443f6e78e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
@@ -42,6 +42,14 @@ MSM8994 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -160,6 +168,7 @@ Example:
 		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&msmgpio 0 0 146>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
index aaf01e929eea..fa97f609fe45 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
@@ -40,6 +40,14 @@ MSM8996 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/gpio/gpio.h>
 
+- gpio-ranges:
+	Usage: required
+	Definition:  see ../gpio/gpio.txt
+
+- gpio-reserved-ranges:
+	Usage: optional
+	Definition: see ../gpio/gpio.txt
+
 Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
 a general description of GPIO and interrupt bindings.
 
@@ -180,6 +188,7 @@ Example:
 		reg = <0x01010000 0x300000>;
 		interrupts = <0 208 0>;
 		gpio-controller;
+		gpio-ranges = <&tlmm 0 0 150>;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-- 
2.17.0
