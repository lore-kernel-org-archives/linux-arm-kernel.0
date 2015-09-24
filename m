From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 24 Sep 2015 05:57:03 -0700
Subject: [PATCH v4 8/8] pinctrl: freescale: imx: imx7d iomuxc-lpsr
 devicetree bindings
In-Reply-To: <1442593798-11501-8-git-send-email-aalonso@freescale.com>
References: <1442593798-11501-1-git-send-email-aalonso@freescale.com>
 <1442593798-11501-8-git-send-email-aalonso@freescale.com>
Message-ID: <20150924125703.GU3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 11:29:58AM -0500, Adrian Alonso wrote:
> Add iomuxc-lpsr devicetree bindings documentation
> Provide documentation context as well an example on
> pheriperals that could use pad from either iomuxc controller
> supported by iMX7D SoC
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V2: New patch on imx7d iomuxc-lpsr patch series
> Changes for V3: Add shared input select register notes
> Changes for V4: Resend
> 
>  .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> index 8bbf25d..19697bd 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> @@ -1,10 +1,33 @@
>  * Freescale i.MX7 Dual IOMUX Controller
>  
> +iMX7D supports two iomuxc controllers, fsl,imx7d-iomuxc controller is similar
> +as previous iMX SoC generation and fsl,imx7d-iomuxc-lpsr which provides low
> +power state rentetion capabilities on gpios that are part of iomuxc-lpsr

s/rentetion/retention

> +(GPIO1_IO7..GPIO1_IO0). While iomuxc-lpsr provides its own set of registers for
> +mux and pad control settings it shares the input select register from iomuxc
> +for daisy chain settings, the input-sel phandle and SHARE_INPUT_SELECT_REG flag

SHARE_INPUT_SELECT_REG is a Linux device driver implementation details,
which shouldn't be in bindings doc.

> +extends fsl,imx-pinctrl driver to support iomuxc-lpsr controller.
> +
> +iomuxc_lpsr: iomuxc-lpsr at 302c0000 {
> +	compatible = "fsl,imx7d-iomuxc-lpsr";
> +	reg = <0x302c0000 0x10000>;
> +	input-sel = <&iomuxc>;
> +};
> +
> +iomuxc: iomuxc at 30330000 {
> +	compatible = "fsl,imx7d-iomuxc";
> +	reg = <0x30330000 0x10000>;
> +};
> +
> +Pheriparials using pads from iomuxc-lpsr support low state retention power
> +state, under LPSR mode GPIO's state of pads are retain.
> +
>  Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
>  and usage.
>  
>  Required properties:
>  - compatible: "fsl,imx7d-iomuxc"
> +- compatible: "fsl,imx7d-iomuxc-lpsr"

This is a bit confusing, and should probably be reworded like:

   - compatible: "fsl,imx7d-iomuxc" for main IOMUXC controller, or
                 "fsl,imx7d-iomuxc-lpsr" for Low Power State Retention
                 IOMUXC controller.

And 'input-sel' should be documented in 'Required properties' list as
well.  Also, as this is a vendor specific property, I suggest you name
it 'fsl,input-sel'.

>  - fsl,pins: each entry consists of 6 integers and represents the mux and config
>    setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
>    input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> @@ -25,3 +48,37 @@ PAD_CTL_DSE_X1                  (0 << 0)
>  PAD_CTL_DSE_X2                  (1 << 0)
>  PAD_CTL_DSE_X3                  (2 << 0)
>  PAD_CTL_DSE_X4                  (3 << 0)
> +
> +Examples:
> +While iomuxc-lpsr is intended to be used by dedicated peripherals to take
> +advantages of LPSR power mode, is also possible that an IP to use pads from

s/is/it's ?

> +any of the iomux controllers. For example the I2C1 IP can use SCL pad from
> +iomuxc-lpsr controller and SDA pad from iomuxc controller as:
> +
> +i2c1: i2c at 30a20000 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_1 &pinctrl_i2c1_2>;
> +	status = "okay";
> +};
> +
> +iomuxc-lpsr at 302c0000 {
> +	compatible = "fsl,imx7d-iomuxc-lpsr";
> +	reg = <0x302c0000 0x10000>;
> +
> +	pinctrl_i2c1_1: i2c1grp-1 {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO04__I2C1_SCL 0x4000007f
> +		>;
> +	};
> +};
> +
> +iomuxc at 30330000 {
> +	compatible = "fsl,imx7d-iomuxc";
> +	reg = <0x30330000 0x10000>;
> +
> +	pinctrl_i2c1_2: i2c1grp-2 {
> +		fsl,pins = <
> +			MX7D_PAD_I2C1_SCL__I2C1_SCL 0x4000007f

It's should be about 'SDA' pad than 'SCL', right?

Shawn

> +		>;
> +	};
> +};
> -- 
> 2.1.4
> 
