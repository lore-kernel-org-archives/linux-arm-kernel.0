From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Apr 2014 12:10:33 -0300
Subject: SD CRC error on mx27pdk
Message-ID: <CAOMZO5AZ4gJZMo-DZRPffaF+NdzmzMf32YwPu2gEp9AH8gDk4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to add sd card support on mx27pdk with the following patch
against Shawn's for-next:

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 0dbb16a..749aa72 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -20,6 +20,22 @@
         reg = <0xa0000000 0x08000000>;
     };

+    regulators {
+        compatible = "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        reg_mmc: regulator at 0 {
+            compatible = "regulator-fixed";
+            reg = <0>;
+            regulator-name = "3v3";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            enable-active-high;
+            gpio = <&gpio2 25 0>;
+        };
+    };
+
     usbphy {
         compatible = "simple-bus";
         #address-cells = <1>;
@@ -92,6 +108,14 @@
     nand-on-flash-bbt;
 };

+&sdhci1 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_sdhc1>;
+    cd-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+    vmmc-supply = <&reg_mmc>;
+    status = "okay";
+};
+
 &uart1 {
     fsl,uart-has-rtscts;
     pinctrl-names = "default";
@@ -148,6 +172,19 @@
             >;
         };

+        pinctrl_sdhc1: sdhc1grp {
+            fsl,pins = <
+                MX27_PAD_SD1_D0__SD1_D0        0x0
+                MX27_PAD_SD1_D1__SD1_D1        0x0
+                MX27_PAD_SD1_D2__SD1_D2        0x0
+                MX27_PAD_SD1_D3__SD1_D3        0x0
+                MX27_PAD_SD1_CMD__SD1_CMD    0x0
+                MX27_PAD_SD1_CLK__SD1_CLK    0x0
+                MX27_PAD_USBH1_RCV__GPIO2_25    0x0
+                MX27_PAD_USBH1_FS__GPIO2_26    0x0
+            >;
+        };
+
         pinctrl_uart1: uart1grp {
             fsl,pins = <
                 MX27_PAD_UART1_TXD__UART1_TXD 0x0
--

,but I get this error:

mxc-mmc 10013000.sdhci: mxcmci_finish_data: -EILSEQ
mmc0: error -84 whilst initialising SD card
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SDHC card@address b5a1
mmcblk0: mmc0:b5a1 SD04G 3.69 GiB
 mmcblk0: unknown partition table

,which comes from STATUS_CRC_READ_ERR being set.

Any suggestions?

Thanks,

Fabio Estevam
