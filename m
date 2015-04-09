From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Apr 2015 09:20:26 +0200
Subject: [PATCH RFC v9 14/20] Documentation: dt-bindings: Add bindings
 for Himax HX8369A DRM panel driver
In-Reply-To: <1423720903-24806-15-git-send-email-Ying.Liu@freescale.com>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-15-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20150409072025.GB12103@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 02:01:37PM +0800, Liu Ying wrote:
> This patch adds device tree bindings for Himax HX8369A DRM panel driver.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v8->v9:
>  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
> 
> v7->v8:
>  * None.
> 
> v6->v7:
>  * None.
> 
> v5->v6:
>  * None.
> 
> v4->v5:
>  * Merge the bs[3:0]-gpios properties into one property - bs-gpios.
>    This addresses Andrzej Hajda's comment.
> 
> v3->v4:
>  * Newly introduced in v4.  This is separated from the relevant driver patch
>    in v3 to address Stefan Wahren's comment.
> 
>  .../devicetree/bindings/panel/himax,hx8369a.txt    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/panel/himax,hx8369a.txt
> 
> diff --git a/Documentation/devicetree/bindings/panel/himax,hx8369a.txt b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
> new file mode 100644
> index 0000000..3a44b70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
> @@ -0,0 +1,39 @@
> +Himax HX8369A WVGA 16.7M color TFT single chip driver with internal GRAM
> +
> +Himax HX8369A is a WVGA resolution driving controller.
> +It is designed to provide a single chip solution that combines a source
> +driver and power supply circuits to drive a TFT dot matrix LCD with
> +480RGBx864 dots at the maximum.
> +
> +The HX8369A supports several interface modes, including MPU MIPI DBI Type
> +A/B mode, MIPI DPI/DBI Type C mode, MIPI DSI video mode, MIPI DSI command
> +mode and MDDI mode. The interface mode is selected by the external hardware
> +pins BS[3:0].
> +
> +Currently, only the MIPI DSI video mode is supported.

This doesn't make much sense. The binding is supposed to describe the
hardware, so saying "only video mode is supported" is weird. Perhaps if
you have no way to test other modes you could reword as:

	This version of the device tree binding only specifies MIPI DSI
	video mode.

Then again, would the device tree content be different based on the
video mode?

> +Required properties:
> +  - compatible: should be a panel's compatible string

I don't understand this. If this chip isn't a panel, why should the
compatible string contain the panel's compatible string? Is this some
kind of bridge chip that can drive different panels? I guess I'll see
when I look at the driver.

Anyway, if it isn't a panel it shouldn't have the panel's compatible
string.

> +  - reg: the virtual channel number of a DSI peripheral, as described in [1]
> +  - reset-gpios: a GPIO spec for the reset pin, as described in [2]
> +
> +Optional properties:
> +  - vdd1-supply: I/O and interface power supply
> +  - vdd2-supply: analog power supply
> +  - vdd3-supply: logic power supply
> +  - dsi-vcc-supply: DSI and MDDI power supply
> +  - vpp-supply: OTP programming voltage
> +  - bs-gpios: a GPIO spec for the pins BS[3:0], as described in [2]
> +
> +[1] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
> +[2] Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +	panel {
> +		compatible = "truly,tft480800-16-e-dsi";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_mipi_panel>;
> +		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
> +		bs-gpios = <0>, <0>, <&gpio6 14 GPIO_ACTIVE_HIGH>, <0>;
> +	};

Again this doesn't make sense. You're mixing two things here: the HIMAX
chip that is presumably a bridge and the panel connected to it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/f0033d97/attachment.sig>
