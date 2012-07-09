From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 14:51:18 +0800
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
 <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
Message-ID: <20120709065116.GB11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 05:56:34PM -0500, Kim Phillips wrote:
> but it doesn't function as it stands right now, at least on Power.
> The compatible in the device tree's sec_mon node "fsl,sec-v4.0-mon"
> and the driver's "fsl,sec-v4.0-mon-rtc-lp" don't match.  Here are
> the device tree changes I used:
> 
> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> index 7990e0d..14c933b 100644
> --- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
> @@ -104,6 +104,14 @@ crypto: crypto at 300000 {
>  
>  sec_mon: sec_mon at 314000 {
>         compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       ranges = <0 0x314000 0x1000>;
>         reg = <0x314000 0x1000>;
>         interrupts = <93 2 0 0>;
> +
> +       sec_mon_rtc_lp at 34 {
> +               compatible = "fsl,sec-v4.2-mon-rtc-lp", "fsl,sec-v4.0-mon-rtc-lp";
> +               reg = <0x34 0x58>;
> +       };
>  };
> 
Yes, the way that this dts is written as well as the examples in
Documentation/devicetree/bindings/crypto/fsl-sec4.txt assume there
is a sec_mon driver.  This driver will match "fsl,sec-v4.0-mon" and
populate rtc-lp device probed by the rtc-snvs driver created by the
patch.

While there is no such sec_mon driver right now.  I did a quick
tweaking on imx6q.dtsi to have rtc-snvs probed without the need of
sec_mon driver.

> btw, I don't see any imx6q.dtsi changes.
> 
See below.

Either way, being a driver of SNVS LP RTC, rtc-snvs should just stand
as it stands right now.  It should not care about how the device is
populated, by DT core or by sec_mon driver.

Regards,
Shawn

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..26c42da 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -455,8 +455,16 @@
                        };

                        snvs at 020cc000 {
-                               reg = <0x020cc000 0x4000>;
-                               interrupts = <0 19 0x04 0 20 0x04>;
+                               compatible = "fsl,sec-v4.0-mon", "simple-bus";
+                               #address-cells = <1>;
+                               #size-cells = <1>;
+                               ranges = <0 0x020cc000 0x4000>;
+
+                               snvs-rtc-lp at 34 {
+                                       compatible = "fsl,sec-v4.0-mon-rtc-lp";
+                                       reg = <0x34 0x58>;
+                                       interrupts = <0 19 0x04 0 20 0x04>;
+                               };
                        };

                        epit at 020d0000 { /* EPIT1 */
