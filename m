From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 08 Oct 2013 20:03:10 +0200
Subject: [PATCH v2 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20131008194232.7d74b9e6@armhf>
References: <20131008194232.7d74b9e6@armhf>
Message-ID: <525448DE.5030004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 07:42 PM, Jean-Francois Moine wrote:
> This patch activates the audio device of the Cubox.
>
> The audio flow (pin mpp_audio1) is output on both I2S and S/PDIF.
>
> The third si5351 clock (#2, pin mpp13) is used as the external clock.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   arch/arm/boot/dts/dove-cubox.dts | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index 022646e..bb38a24 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -132,3 +132,23 @@
>   		reg = <0>;
>   	};
>   };
> +
> +&pinctrl {
> +	pmx_gpio_13_audio1: pmx-gpio-13-audio1 {

Jean-Francois,

please name the node "pmx_audio1_extclk: pmx-audio1-extclk"
and move both to the corresponding section in dove.dtsi.
We can reuse them on other Dove boards for sure.

> +		marvell,pins = "mpp13";
> +		marvell,function = "audio1";
> +	};
> +
> +	pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
> +		marvell,pins = "mpp_audio1";
> +		marvell,function = "i2s1/spdifo";
> +	};
> +};
> +
> +&audio1 {
> +	status = "okay";
> +	clocks = <&gate_clk 13>, <&si5351 2>;
> +	clock-names = "internal", "extclk";
> +	pinctrl-0 = <&pmx_audio1_i2s1_spdifo &pmx_gpio_13_audio1>;

The above needs updated phandles then.

Otherwise,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +	pinctrl-names = "default";
> +};
>
