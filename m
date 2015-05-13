From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 May 2015 08:45:16 -0600
Subject: [PATCH] ARM: tegra: Enable TPM on tegra124 nyan boards
In-Reply-To: <1431526427-13340-1-git-send-email-sjg@chromium.org>
References: <1431526427-13340-1-git-send-email-sjg@chromium.org>
Message-ID: <5553637C.5010506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 08:13 AM, Simon Glass wrote:
> Regenerate the pinmux from the latest tegra-pinmux-scripts.

(Dropping most CCs; DT maintainers and lists generally don't get CC'd on 
simple DT content changes but rather on schema adds/changes and perhaps 
major DT content changes depending on context)

> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts

>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pinmux_default>;
>
> -		pinmux_default: common {
> +		state_default: pinmux {

This change will break compilation, since it changes the label name, yet 
the old name is still referenced in pinctrl-0 above. Same applies in the 
other file too.

> diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze.dts b/arch/arm/boot/dts/tegra124-nyan-blaze.dts

> @@ -437,18 +437,18 @@
>   			usb_vbus_en0_pn4 {
>   				nvidia,pins = "usb_vbus_en0_pn4";
>   				nvidia,function = "usb";
> -				nvidia,pull = <TEGRA_PIN_PULL_UP>;
> +				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>   				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>   				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
> -				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
> +				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
>   			};
>   			usb_vbus_en1_pn5 {
>   				nvidia,pins = "usb_vbus_en1_pn5";
>   				nvidia,function = "usb";
> -				nvidia,pull = <TEGRA_PIN_PULL_UP>;
> +				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>   				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>   				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
> -				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
> +				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
>   			};

Tomeu, can you comment on those changes? Evidently the pinmux 
configuration that's you added to the kernel doesn't exactly match the 
pinmux configuration that you added to tegra-pinmux-scripts. Is the 
change above correct, or do we need to propagate this change from the 
kernel DT into tegra-pinmux-scripts, and hence also into the U-Boot 
pinmux setup table?

My understanding of how these pins are generally used is that open-drain 
is likely correct. I have no idea whether Tegra should supply the pullup 
for these pins, or whether the board has a pullup resistor in which case 
Tegra doesn't need to pull up.
