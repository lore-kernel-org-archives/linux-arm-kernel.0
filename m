From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 14:27:25 -0300
Subject: [PATCHv14][ 4/4] ARM: dts: imx25: mbimxsd25: Add displays support.
In-Reply-To: <1390410577-22073-4-git-send-email-denis@eukrea.com>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <1390410577-22073-4-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5AHdTbCQUPGjQaK0v6KJR3+fTN9Pb1sqaYwuKXgfK5U5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Wed, Jan 22, 2014 at 3:09 PM, Denis Carikli <denis@eukrea.com> wrote:
> The CMO-QVGA(With backlight), DVI-VGA and DVI-SVGA displays
> were added.

I am trying the same on a mx25pdk and these are my changes:

arch/arm/boot/dts/imx25-pdk.dts | 60 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/imxfb.c     |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index cccd8fe..700ae1c 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -21,6 +21,26 @@
         reg = <0x80000000 0x4000000>;
     };

+    display: display {
+        model = "CLAA057VC01CW";
+        native-mode = <&timing0>;
+        bits-per-pixel = <16>;
+        fsl,pcr = <0xfa208b80>;
+        display-timings {
+            timing0: 640x480 {
+                hactive = <640>;
+                vactive = <480>;
+                hback-porch = <114>;
+                hfront-porch = <45>;
+                hsync-len = <1>;
+                vback-porch = <11>;
+                vfront-porch = <33>;
+                vsync-len = <1>;
+                clock-frequency = <25000000>;
+            };
+        };
+    };
+
     regulators {
         compatible = "simple-bus";
         #address-cells = <1>;
@@ -98,6 +118,16 @@
     status = "okay";
 };

+&lcdc {
+    display = <&display>;
+    fsl,lpccr = <0x00a903ff>;
+    fsl,lscr1 = <0x00120300>;
+    fsl,dmacr = <0x00020010>;
+    pinctrl-names = "default";
+    pinctrl-0 = <&pinctrl_lcd>;
+    status = "okay";
+};
+
 &fec {
     phy-mode = "rmii";
     pinctrl-names = "default";
@@ -170,6 +200,36 @@
             >;
         };

+        pinctrl_lcd: lcdgrp {
+            fsl,pins = <
+                MX25_PAD_LD0__LD0        0x80000000
+                MX25_PAD_LD1__LD1        0x80000000
+                MX25_PAD_LD2__LD2        0x80000000
+                MX25_PAD_LD3__LD3        0x80000000
+                MX25_PAD_LD4__LD4        0x80000000
+                MX25_PAD_LD5__LD5        0x80000000
+                MX25_PAD_LD6__LD6        0x80000000
+                MX25_PAD_LD7__LD7        0x80000000
+                MX25_PAD_LD8__LD8        0x80000000
+                MX25_PAD_LD9__LD9        0x80000000
+                MX25_PAD_LD10__LD10        0x80000000
+                MX25_PAD_LD11__LD11        0x80000000
+                MX25_PAD_LD12__LD12        0x80000000
+                MX25_PAD_LD13__LD13        0x80000000
+                MX25_PAD_LD14__LD14        0x80000000
+                MX25_PAD_LD15__LD15        0x80000000
+                MX25_PAD_GPIO_E__LD16        0x80000000
+                MX25_PAD_GPIO_F__LD17        0x80000000
+                MX25_PAD_HSYNC__HSYNC        0x80000000
+                MX25_PAD_VSYNC__VSYNC        0x80000000
+                MX25_PAD_LSCLK__LSCLK        0x80000000
+                MX25_PAD_OE_ACD__OE_ACD        0x80000000
+                MX25_PAD_CONTRAST__CONTRAST    0x80000000
+            >;
+        };
+
+
+
         pinctrl_i2c1: i2c1grp {
             fsl,pins = <
                 MX25_PAD_I2C1_CLK__I2C1_CLK        0x80000000
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 086e024..45cc30b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -671,8 +671,8 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)

         fbi->lscr1 = IMXFB_LSCR1_DEFAULT;
         of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
-
         of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
+        of_property_read_u32(np, "fsl,lpccr", &fbi->pwmr);
     }

     return 0;

This last hunk if from an earlier patch from you. (I suggest you to
resend it since the location of imxfb.c has changed in linux-next).

Is there any other imxfb patch I am missing?

I turned on the backlight supply via bootloader (kernel still does not
support MC34704 PMIC yet), but the LCD screen is white and I cannot
see the Linux logo. The /dev/fb0 does exist though.

Any ideas?

Regards,

Fabio Estevam
