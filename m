From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 26 Mar 2013 08:26:13 +0100
Subject: [PATCH V5 8/9] ARM: tegra: Provide regulator to pwm-backlight
In-Reply-To: <1364260913-25490-9-git-send-email-achew@nvidia.com>
References: <1364260913-25490-1-git-send-email-achew@nvidia.com>
 <1364260913-25490-9-git-send-email-achew@nvidia.com>
Message-ID: <20130326072613.GA31388@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:21:52PM -0700, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-medcom-wide.dts | 1 +
>  arch/arm/boot/dts/tegra20-tamonten.dtsi   | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
> index a2d6d65..90d665e 100644
> --- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
> +++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
> @@ -32,6 +32,7 @@
>  
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
>  		default-brightness-level = <6>;
> +		power-supply = <&backlight_power_reg>;
>  	};
>  
>  	sound {
> diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
> index 6e9d91f..2d8e7f2 100644
> --- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
> +++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
> @@ -485,5 +485,10 @@
>  			regulator-max-microvolt = <5000000>;
>  			regulator-always-on;
>  		};
> +
> +		backlight_power_reg: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "backlight-power";
> +		};

This is missing a reg property to mirror the unit address "@1". I've
just checked the schematics and there is indeed a physical pin that
can be used to enable backlight power on Tamonten. It just happens to
not be connected on Medcom-Wide for some reason.

The physical pin is Tegra's GPIO PB5 and the schematic calls the supply
"lcd_bl_en", so I think a more accurate description of this would be:

	backlight_power_reg: regulator at 1 {
		compatible = "regulator-fixed";
		reg = <1>;
		regulator-name = "lcd_bl_en";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		gpio = <&gpio 13 0>; /* gpio PB5 */
		enable-active-high;
	};

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/777ee6c2/attachment.sig>
