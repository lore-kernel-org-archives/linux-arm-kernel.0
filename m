From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Aug 2014 11:10:08 -0600
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
Message-ID: <53EB9BF0.9010002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 07:56 PM, Dylan Reid wrote:
> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
> processor and is similar to the Venice2 reference platform.
>
> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
> and work on the 1366x768 models.  I haven't tried on the HD systems
> yet.
>
> WiFi does not yet work, it needs at least some PMIC changes to enable
> the 32k clock.
>
> The elan trackpad is not yet functional but hopefully will be soon as
> there are patches under review.
>
> There is also an issue on reboot because the TPM isn't reset.  It will
> cause the stock firmware to enter recovery mode.  This can be worked
> around by an EC-reset, press refresh and power at the same time.

> diff --git a/arch/arm/boot/dts/tegra124-big.dts b/arch/arm/boot/dts/tegra124-big.dts

I think we need to include the SKU name in the filename and compatible 
value below, or at least plan out that for other SKUs, we'll add the SKU 
name on.

> +/ {
> +	model = "Google Big";
> +	compatible = "google,nyan-big", "nvidia,tegra124";

I think it'd be more user-friendly if the filename and compatible value 
more obviously tied to the end-user-visible product name.

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		lid {
> +			label = "Lid";
> +			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
> +			linux,input-type = <5>;
> +			linux,code = <0>;

Aren't there #defines for the 5 and 0 there?

> +	sound {
> +		compatible = "nvidia,tegra-audio-max98090-venice2",
> +			     "nvidia,tegra-audio-max98090";
> +		nvidia,model = "NVIDIA Tegra Venice2";

Those strings should all use the same board name as the filename, 
compatible value, and model of the root node. Based on the content in 
your patch, I would expect:

		compatible = "nvidia,tegra-audio-max98090-big",
			     "nvidia,tegra-audio-max98090";
		nvidia,model = "Google Big";

In particular, nvidia,model is used to index into 
/var/lib/alsa/asound.state by name, so it needs to be unique for each board.

> +		nvidia,mic-det-gpios = <&gpio TEGRA_GPIO(R, 7)
> +							GPIO_ACTIVE_HIGH>;

That property doesn't (yet) exist in the binding/code upstream. It could 
obviously be added.
