From: chunkeey@gmail.com (Christian Lamparter)
Date: Tue, 10 Apr 2018 16:18:16 +0200
Subject: [PATCH v3 2/2] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <20180410141816.30452-1-chunkeey@gmail.com>
References: <20180410141816.30452-1-chunkeey@gmail.com>
Message-ID: <20180410141816.30452-2-chunkeey@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
Setting up any gpio-hog in the device-tree for his device would
"kill the bootup completely":

| [    0.477838] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
| [    0.499828] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferring probe
| [    1.298883] requesting hog GPIO enable USB2 power (chip 1000000.pinctrl, offset 58) failed, -517
| [    1.299609] gpiochip_add_data: GPIOs 0..99 (1000000.pinctrl) failed to register
| [    1.308589] ipq4019-pinctrl 1000000.pinctrl: Failed register gpiochip
| [    1.316586] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl at 1000000/serial_pinmux, deferring probe
| [    1.322415] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl at 1000000/spi_0_pinmux, deferri

This was also verified on a RT-AC58U (IPQ4018) which would
no longer boot, if a gpio-hog was specified. (Tried forcing
the USB LED PIN (GPIO0) to high.).

The problem is that Pinctrl+GPIO registration is currently
peformed in the following order in pinctrl-msm.c:
	1. pinctrl_register()
	2. gpiochip_add()
	3. gpiochip_add_pin_range()

The actual error code -517 == -EPROBE_DEFER is coming from
pinctrl_get_device_gpio_range(), which is called through:
        gpiochip_add
            of_gpiochip_add
                of_gpiochip_scan_gpios
                    gpiod_hog
                        gpiochip_request_own_desc
                            __gpiod_request
                                chip->request
                                    gpiochip_generic_request
                                       pinctrl_gpio_request
                                          pinctrl_get_device_gpio_range

pinctrl_get_device_gpio_range() is unable to find any valid
pin ranges, since nothing has been added to the pinctrldev_list yet.
so the range can't be found, and the operation fails with -EPROBE_DEFER.

This patch fixes the issue by adding the "gpio-ranges" property
to the pinctrl device node of all upstream Qcom SoC, so the
ranges are added by of_gpiochip_add_pin_range(), which is
called by of_gpiochip_add() before the call to
of_gpiochip_scan_gpios() happens.gpiochip_add_pin_range() is longer
needed and removed (to prevent adding the same entry to the
pinctrldev_list twice).

Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi   | 1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi   | 1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi   | 1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi   | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 +
 13 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3ca96e361878..17ad9cbd9f8c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -327,6 +327,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&tlmm_pinmux 0 0 90>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0e1e98707e3f..d9481d083802 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -396,6 +396,7 @@
 			compatible = "qcom,apq8084-pinctrl";
 			reg = <0xfd510000 0x4000>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 147>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 10d112a4078e..9a81d2da87a0 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -146,6 +146,7 @@
 			compatible = "qcom,ipq4019-pinctrl";
 			reg = <0x01000000 0x300000>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 100>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 1e0a3b446f7a..26eab9a68d90 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -108,6 +108,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c852b69229c9..cfdaca5f259a 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -128,6 +128,7 @@
 		msmgpio: pinctrl at 800000 {
 			compatible = "qcom,mdm9615-pinctrl";
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 88>;
 			#gpio-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 33030f9419fe..47cf9c4ca062 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -110,6 +110,7 @@
 			reg = <0x800000 0x4000>;
 
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 173>;
 			#gpio-cells = <2>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 1733d8f40ab1..f6d8b1af5a8a 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -102,6 +102,7 @@
 		msmgpio: pinctrl at 800000 {
 			compatible = "qcom,msm8960-pinctrl";
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 152>;
 			#gpio-cells = <2>;
 			interrupts = <0 16 0x4>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..1250e071a6e2 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -696,6 +696,7 @@
 			compatible = "qcom,msm8974-pinctrl";
 			reg = <0xfd510000 0x4000>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2bc5dec5614d..d2c36b467466 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -24,11 +24,12 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		pinctrl at 1000000 {
+		tlmm: pinctrl at 1000000 {
 			compatible = "qcom,ipq8074-pinctrl";
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 70>;
 			#gpio-cells = <0x2>;
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e51b04900726..e06cb90c8ec3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -281,6 +281,7 @@
 			reg = <0x1000000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 122>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 171578747ed0..173b6bc60816 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -179,6 +179,7 @@
 			reg = <0xfd510000 0x4000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index f33c41d01c86..68705db4696b 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -141,6 +141,7 @@
 			reg = <0xfd510000 0x4000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 146>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0a6f7952bbb1..18511e782cbd 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -530,6 +530,7 @@
 			reg = <0x01010000 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
+			gpio-ranges = <&msmgpio 0 0 150>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.17.0
