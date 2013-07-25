From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Jul 2013 23:59:35 -0300
Subject: Enabling USBH1 on mx53qsb
Message-ID: <CAOMZO5CAdxzn-3Xc2DZDYEXwsEznRrcqPbCbTDc5ieBkQkA8=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to get USBH1 port to work on mx53qsb (with Dialog pmic)
with the following patch against linux-next-20130724:

--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -93,6 +93,15 @@
                        regulator-max-microvolt = <3200000>;
                        regulator-always-on;
                };
+
+               reg_usb_vbus: usb_vbus {
+                       compatible = "regulator-fixed";
+                       regulator-name = "usb_vbus";
+                       regulator-min-microvolt = <5000000>;
+                       regulator-max-microvolt = <5000000>;
+                       gpio = <&gpio7 8 0>;
+                       enable-active-high;
+               };
        };

        sound {
@@ -145,6 +154,7 @@
                                MX53_PAD_EIM_DA12__GPIO3_12       0x80000000
                                MX53_PAD_EIM_DA13__GPIO3_13       0x80000000
                                MX53_PAD_PATA_DA_0__GPIO7_6       0x80000000
+                               MX53_PAD_PATA_DA_2__GPIO7_8       0x80000000
                                MX53_PAD_GPIO_16__GPIO7_11        0x80000000
                        >;
                };
@@ -302,7 +312,8 @@
 };

 &usbh1 {
-       status = "okay";
+       vbus-supply = <&reg_usb_vbus>;
+       status = "okay";
 };

 &usbotg {


mx53qsb board has two USB host ports:

- The top port is USBH1
- The bottom port is OTG (also shared with J3 connector)

After applying the above patch the OTG port does work, but the USBH1 does not.

However, if I access USBH1 within U-boot prior to launching the
kernel, then I am able to use USBH1 in the kernel succesfully.

Any idea of something I am missing?

Thanks,

Fabio Estevam
