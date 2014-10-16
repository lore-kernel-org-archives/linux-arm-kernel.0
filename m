From: jeroen@myspectrum.nl (Jeroen Hofstee)
Date: Thu, 16 Oct 2014 20:45:58 +0200
Subject: imx6: ipu: wrong pixel clock
Message-ID: <54401266.7090802@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First of all, I am not sure if this is the right mailinglist, but I couldn't
find a imx specific one.

I am trying to get a small lcd working connected to the wandboard. I am
currently at 2d65a9f48fcdf7866aab6457bc707ca233e0c791, with
some small modifications as listed below.

The good thing is, this works. The not so nice thing is that the kernel
thinks the lcd is driven at 9Mhz, but it is actually at around 21Mhz.
When changing the clock to 8Mhz, the DI is used as pixel clock and
the pixel clock is fine.

9Mhz -> actual 21 Mhz when measured
[    1.707543] imx-ipuv3 2400000.ipu: disp 0: panel size = 480 x 272
[    1.707568] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI 
24000000Hz Needed 9000000Hz
[    1.707672] imx-ipuv3 2400000.ipu:   IPU clock can give 9103448 with 
divider 29, error 1.1%
[    1.707889] imx-ipuv3 2400000.ipu: Want 9000000Hz IPU 264000000Hz DI 
9000000Hz using DI, 9000000Hz
[    1.708026] imx-ipuv3 2400000.ipu: dmfc: trying to allocate 7Mpixel/s 
for IPU channel 23
[    1.708038] imx-ipuv3 2400000.ipu: dmfc: freeing 0 slots starting 
from segment 0
[    1.708131] imx-ipuv3 2400000.ipu: dmfc: using 2 slots starting from 
segment 0 for IPU channel 23

8Mhz -> correct when measured
[    1.719676] imx-ipuv3 2400000.ipu: disp 0: panel size = 480 x 272
[    1.719701] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI 
24000000Hz Needed 8000000Hz
[    1.719796] imx-ipuv3 2400000.ipu:   IPU clock can give 8000000 with 
divider 33, error 0.0%
[    1.719825] imx-ipuv3 2400000.ipu: Want 8000000Hz IPU 264000000Hz DI 
24000000Hz using IPU, 8000000Hz
[    1.719954] imx-ipuv3 2400000.ipu: dmfc: trying to allocate 7Mpixel/s 
for IPU channel 23
[    1.719969] imx-ipuv3 2400000.ipu: dmfc: freeing 0 slots starting 
from segment 0
[    1.720062] imx-ipuv3 2400000.ipu: dmfc: using 2 slots starting from 
segment 0 for IPU channel 23

Am I missing something in the device tree or is there something wrong
in linux/drivers/gpu/ipu-v3/ipu-di.c?

With kind regards,
Jeroen


+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -17,6 +17,9 @@
   * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   * MA 02110-1301, USA.
   */
  #include <linux/component.h>
  #include <linux/module.h>
  #include <linux/export.h>
@@ -166,7 +169,7 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
                 sig_cfg.Vsync_pol = 1;

         sig_cfg.enable_pol = 1;
-       sig_cfg.clk_pol = 0;
+       sig_cfg.clk_pol = 1;


and

diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts 
b/arch/arm/boot/dts/imx6q-wandboard.dts
index 4a8a6ee..3b90e2d 100644
--- a/arch/arm/boot/dts/imx6q-wandboard.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard.dts
@@ -19,6 +19,84 @@
         memory {
                 reg = <0x10000000 0x80000000>;
         };
+
+       display at di0 {
+               compatible = "fsl,imx-parallel-display";
+               crtcs = <&ipu1 0>;
+               interface-pix-fmt = "rgb24";
+               pinctrl-names = "default";
+               pinctrl-0 = <&pinctrl_ipu_disp0>;
+               status = "okay";
+
+               port {
+                       display0_in: endpoint {
+                               remote-endpoint = <&ipu1_di0_disp0>;
+                       };
+               };
+
+               display-timings {
+                       panel {
+                               //native-mode;
+                               clock-frequency = <9000000>;
+                               hactive = <480>;
+                               vactive = <272>;
+                               hback-porch = <145>;
+                               hsync-len = <1>;
+                               hfront-porch = <1>;
+                               vback-porch = <10>;
+                               vsync-len = <1>;
+                               vfront-porch = <2>;
+                               hsync-active = <0>;
+                               vsync-active = <0>;
+                               de-active = <1>;
+                               pixelclk-active = <0>;
+                       };
+               };
+       };
+};
+
+&iomuxc {
+       pinctrl-names = "default";
+
+       imx6qdl-wandboard {
+               pinctrl_ipu_disp0: disp0grp-1 {
+                       fsl,pins = <
+ MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+ MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+ MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+ MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+ MX6QDL_PAD_SD4_DAT3__GPIO2_IO11            0x10
+ MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+ MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+ MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+ MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+ MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+ MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+ MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+ MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+ MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+ MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+ MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+ MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+ MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+ MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+ MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+ MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+ MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+ MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+ MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+ MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+ MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+ MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+ MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+ MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+                       >;
+               };
+       };
+};
+
+&ipu1_di0_disp0 {
+       remote-endpoint = <&display0_in>;
  };

  &sata {
