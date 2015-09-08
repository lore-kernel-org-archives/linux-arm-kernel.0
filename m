From: aalonso@freescale.com (Alonso Adrian)
Date: Tue, 8 Sep 2015 16:15:58 +0000
Subject: [PATCH v2 8/8] pinctrl: freescale: imx: imx7d iomuxc-lpsr
 devicetree bindings
In-Reply-To: <20150907024212.GG30746@tiger>
References: <1441147753-13239-1-git-send-email-aalonso@freescale.com>
 <1441147753-13239-8-git-send-email-aalonso@freescale.com>,
 <20150907024212.GG30746@tiger>
Message-ID: <BN3PR03MB1509B275680CB6F23ED8D25CA8530@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

See comments below.

Regards
Adrian
________________________________________
From: Shawn Guo <shawnguo@kernel.org>
Sent: Sunday, September 6, 2015 9:42 PM
To: Alonso Lazcano Adrian-B38018
Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org; linus.walleij at linaro.org; lznuaa at gmail.com; linux-gpio at vger.kernel.org; devicetree at vger.kernel.org; robh+dt at kernel.org; Huang Yongcai-B20788; Li Frank-B20596; Gong Yibin-B38343; Garg Nitin-B37173
Subject: Re: [PATCH v2 8/8] pinctrl: freescale: imx: imx7d iomuxc-lpsr devicetree bindings

On Tue, Sep 01, 2015 at 05:49:13PM -0500, Adrian Alonso wrote:
> Add iomuxc-lpsr devicetree bindings documentation
> Provide documentation context as well an example on
> pheriperals that could use pad from either iomuxc controller
> supported by iMX7D SoC
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: New patch on imx7d iomuxc-lpsr patch series
>
>  .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> index 8bbf25d..c7310fc 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> @@ -1,10 +1,19 @@
>  * Freescale i.MX7 Dual IOMUX Controller
>
> +iMX7D supports two iomuxc controllers, fsl,imx7d-iomuxc controller is similar
> +as previous iMX SoC generation and fsl,imx7d-iomuxc-lpsr which provides low
> +power state rentetion capabilities on gpios that are part of iomuxc-lpsr
> +(GPIO1_IO7..GPIO1_IO0).

I think the speciality of the select_input registers should be
mentioned too.
[Adrian] Agree will add notes for shared select input.

> +
> +Pheriparials using pads from iomuxc-lpsr support low state retention power
> +state, under LPSR mode GPIO's state of pads are retain.
> +
>  Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
>  and usage.
>
>  Required properties:
>  - compatible: "fsl,imx7d-iomuxc"
> +- compatible: "fsl-imx7d-iomuxc-lpsr"

s/fsl-imx7d-iomuxc-lpsr/fsl,imx7d-iomuxc-lpsr
[Adrian] Will fix this, thanks.
Shawn

>  - fsl,pins: each entry consists of 6 integers and represents the mux and config
>    setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
>    input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> @@ -25,3 +34,37 @@ PAD_CTL_DSE_X1                  (0 << 0)
>  PAD_CTL_DSE_X2                  (1 << 0)
>  PAD_CTL_DSE_X3                  (2 << 0)
>  PAD_CTL_DSE_X4                  (3 << 0)
> +
> +Examples:
> +While iomuxc-lpsr is intended to be used by dedicated peripherals to take
> +advantages of LPSR power mode, is also possible that an IP to use pads from
> +any of the iomux controllers. For example the I2C1 IP can use SCL pad from
> +iomuxc-lpsr controller and SDA pad from iomuxc controller as:
> +
> +i2c1: i2c at 30a20000 {
> +     pinctrl-names = "default";
> +     pinctrl-0 = <&pinctrl_i2c1_1 &pinctrl_i2c1_2>;
> +     status = "okay";
> +};
> +
> +iomuxc-lpsr at 302c0000 {
> +     compatible = "fsl,imx7d-iomuxc-lpsr";
> +     reg = <0x302c0000 0x10000>;
> +
> +     pinctrl_i2c1_1: i2c1grp-1 {
> +             fsl,pins = <
> +                     MX7D_PAD_GPIO1_IO04__I2C1_SCL 0x4000007f
> +             >;
> +     };
> +};
> +
> +iomuxc at 30330000 {
> +     compatible = "fsl,imx7d-iomuxc";
> +     reg = <0x30330000 0x10000>;
> +
> +     pinctrl_i2c1_2: i2c1grp-2 {
> +             fsl,pins = <
> +                     MX7D_PAD_I2C1_SCL__I2C1_SCL 0x4000007f
> +             >;
> +     };
> +};
> --
> 2.1.4
>
