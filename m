From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 May 2013 12:50:31 -0300
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 11:13 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Commit e5aba13 (i2c: i2c-mxs: move to use generic DMA helper) changed
> i2c-mxs.txt and drivers/i2c/busses/i2c-mxs.c to only use one I2C interrupt.
>
> Adapt the dtsi bindings with such change.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 33389b8..2e1ba4b 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -878,7 +878,7 @@
>                                 #size-cells = <0>;
>                                 compatible = "fsl,imx28-i2c";
>                                 reg = <0x80058000 0x2000>;
> -                               interrupts = <111 68>;
> +                               interrupts = <111>;
>                                 clock-frequency = <100000>;
>                                 dmas = <&dma_apbx 6>;
>                                 dma-names = "rx-tx";
> @@ -891,7 +891,7 @@
>                                 #size-cells = <0>;
>                                 compatible = "fsl,imx28-i2c";
>                                 reg = <0x8005a000 0x2000>;
> -                               interrupts = <110 69>;
> +                               interrupts = <110>;
>                                 clock-frequency = <100000>;
>                                 dmas = <&dma_apbx 7>;
>                                 dma-names = "rx-tx";

Actually the correct is:

--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -878,7 +878,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 0x2000>;
-				interrupts = <111 68>;
+				interrupts = <68>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 6>;
 				dma-names = "rx-tx";
@@ -891,7 +891,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 0x2000>;
-				interrupts = <110 69>;
+				interrupts = <69>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 7>;
 				dma-names = "rx-tx";

,but then i2c fails to probe.

Has anyone tried mxs i2c dma recently?

Here is what I do on linux-next-20130516:

- Revert  b871f1ad3c8a1ac2 (will send this later to alsa-devel)
- Booting mx28evk will show:

[    6.378298]  mmcblk0: p1 p2 p3
[   29.547791] sgtl5000 0-000a: Failed to get supply 'VDDD': -19
[   29.556308] 0-000a: 1200 mV normal
[   29.562225] sgtl5000 0-000a: Using internal LDO instead of VDDD
[   29.573156] sgtl5000 0-000a: sgtl5000 revision 0x11

,ie, i2c is too slow as it takes 13 seconds to read the sgtl5000 codec
registers. Looks like i2c dma is disabled

Then I apply

--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -878,7 +878,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x80058000 0x2000>;
-				interrupts = <111 68>;
+				interrupts = <68>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 6>;
 				dma-names = "rx-tx";
@@ -891,7 +891,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
 				reg = <0x8005a000 0x2000>;
-				interrupts = <110 69>;
+				interrupts = <69>;
 				clock-frequency = <100000>;
 				dmas = <&dma_apbx 7>;
 				dma-names = "rx-tx";

and the sgtl5000 probe fails.
