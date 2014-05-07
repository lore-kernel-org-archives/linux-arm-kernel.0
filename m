From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 May 2014 17:14:52 -0300
Subject: Adding esdhc4 eMMC support on mx6sabresd
Message-ID: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

I have tested the following patch to add support for the emmc port on
mx6qsabresd:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -444,6 +444,21 @@
                                MX6QDL_PAD_SD3_DAT7__SD3_DATA7          0x17059
                        >;
                };
+
+               pinctrl_usdhc4: usdhc4grp {
+                       fsl,pins = <
+                               MX6QDL_PAD_SD4_CMD__SD4_CMD             0x17059
+                               MX6QDL_PAD_SD4_CLK__SD4_CLK             0x10059
+                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0          0x17059
+                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1          0x17059
+                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2          0x17059
+                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3          0x17059
+                               MX6QDL_PAD_SD4_DAT4__SD4_DATA4          0x17059
+                               MX6QDL_PAD_SD4_DAT5__SD4_DATA5          0x17059
+                               MX6QDL_PAD_SD4_DAT6__SD4_DATA6          0x17059
+                               MX6QDL_PAD_SD4_DAT7__SD4_DATA7          0x17059
+                       >;
+               };
        };

        gpio_leds {
@@ -535,3 +550,11 @@
        wp-gpios = <&gpio2 1 0>;
        status = "okay";
 };
+
+&usdhc4 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_usdhc4>;
+       bus-width = <8>;
+       non-removable;
+       status = "okay";
+};


,and this is the result:

mmc2: new high speed DDR MMC card at address 0001
mmcblk1: mmc2:0001 SEM08G 7.39 GiB
mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
mmcblk1: error -110 sending stop command, original cmd response 0x900, card sta0
mmcblk1: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card 0
mmcblk1: retrying using single block read
mmcblk1: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card 0
end_request: I/O error, dev mmcblk1, sector 0
mmcblk1: error -84 transferring data, sector 1, nr 7, cmd response 0x900, card 0
end_request: I/O error, dev mmcblk1, sector 1
mmcblk1: error -84 transferring data, sector 2, nr 6, cmd response 0x900, card 0
end_request: I/O error, dev mmcblk1, sector 2
mmcblk1: error -84 transferring data, sector 3, nr 5, cmd response 0x900, card 0
end_request: I/O error, dev mmcblk1, sector 3
mmcblk1: error -84 transferring data, sector 4, nr 4, cmd response 0x900, card 0
....

Is there any extra patch I need to apply? I am running linux-next 20140506.

Thanks,

Fabio Estevam
