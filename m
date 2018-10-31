From: dev@pschenker.ch (Philippe Schenker)
Date: Wed, 31 Oct 2018 16:20:40 +0100
Subject: [RFC] ARM: dts: imx: assign static phandles
Message-ID: <a90fb286f7200b2cba60cd3c9a1be6b9a607c390.camel@pschenker.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

For the Colibri iMX6, Toradex is providing different methods on explicit
connectors vs. rather universal pin headers to connect the touch controller 
to our carrier boards. Currently we are providing fdt_fixups to alter the 
devicetree in U-Boot to select the right pins. The problem we have with this
approach is, that the phandles are dynamically assigned to the dtb.

My question is, if it would be a feasible solution for mainline to assign
those (vs. all) phandles statically. I put an example below. This example 
should just provide an idea what I mean, it is not working code.

Regards,
Philippe

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 34 ++++++++++++++++++++
 arch/arm/boot/dts/imx6dl.dtsi                |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index d08e0402793b..355709cd28aa 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -172,12 +172,46 @@
                compatible = "st,m41t0";
                reg = <0x68>;
        };
+
+       /* Atmel maxtouch controller */
+       atmel_mxt_ts: atmel_mxt_ts at 4a {
+               compatible = "atmel,maxtouch";
+               pinctrl-names = "default";
+               pinctrl-0 = <&pinctrl_mxt_ts>;
+               reg = <0x4a>;
+               interrupt-parent = <&gpio1>;
+               interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+               status = "okay";
+       };
 };
 
 &ipu1_di0_disp0 {
        remote-endpoint = <&lcd_display_in>;
 };
 
+&iomuxc {
+
+       gpio {
+               pinctrl_pcap_1: pcap-1 {
+                       fsl,pins = <
+                               /* SODIMM 28, 30 */
+                               MX6QDL_PAD_GPIO_9__GPIO1_IO09   0x130b0
+                               MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0x130b0
+                       >;
+                       phandle = <0xffff0000>;
+               };
+
+               pinctrl_mxt_ts: mxt-ts {
+                       fsl,pins = <
+                               /* SODIMM 106, 107 */
+                               MX6QDL_PAD_EIM_CS1__GPIO2_IO24  0x130b0
+                               MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0x130b0
+                       >;
+                       phandle = <0xffff0001>;
+               };
+       };
+};
+
 &pwm1 {
        status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index f0607eb41df4..984714b1ca2f 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -132,6 +132,7 @@
                      <&iomuxc 22 123 3>, <&iomuxc 25 121 1>, <&iomuxc 26 127 1>,
                      <&iomuxc 27 126 1>, <&iomuxc 28 128 1>, <&iomuxc 29 130 1>,
                      <&iomuxc 30 129 1>, <&iomuxc 31 122 1>;
+       phandle = <0xffff0002>;
 };
 
 &gpio2 {
@@ -140,6 +141,7 @@
                      <&iomuxc 20  70 1>, <&iomuxc 21  69 1>, <&iomuxc 22  68 1>,
                      <&iomuxc 23  79 2>, <&iomuxc 25 118 2>, <&iomuxc 27 117 1>,
                      <&iomuxc 28 113 4>;
+       phandle = <0xffff0003>;
 };
 
 &gpio3 {
-- 

And then from uboot alter the devicetree like:

setenv fdt_fixup 'fdt addr ${fdt_addr_r} && fdt resize && 
fdt set /soc/aips-bus at 02100000/i2c at 21a8000/atmel_mxt_ts at 4a pinctrl-0 <0xffff0000> &&
fdt set /soc/aips-bus at 02100000/i2c at 21a8000/atmel_mxt_ts at 4a interrupt-parent <0xffff0003>'
