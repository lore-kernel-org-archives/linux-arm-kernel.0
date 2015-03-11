From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Mar 2015 08:24:15 -0700
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <1426022847-30912-4-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
Message-ID: <20150311152414.GX5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Marek Belisko <marek@goldelico.com> [150310 14:28]:
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  .../bindings/power_supply/twl4030_madc_battery.txt | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> new file mode 100644
> index 0000000..d3dd9d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> @@ -0,0 +1,43 @@
> +twl4030_madc_battery
> +
> +Required properties:
> + - compatible : "ti,twl4030-madc-battery"
> + - capacity-uah : battery capacity in uAh
> + - ti,volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +	for charging calibration (see example)
> + - ti,volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +	for discharging calibration (see example)
> + - io-channels: Should contain IIO channel specifiers
> +	for each element in io-channel-names.
> +- io-channel-names: Should contain the following values:
> + * "temp" - The ADC channel for temperature reading
> + * "ichg" - The ADC channel for battery charging status
> + * "vbat" - The ADC channel to measure the battery voltage
> +
> +Example:
> +	madc-battery {
> +		compatible = "ti,twl4030-madc-battery";
> +		capacity-uah = <1200000>;
> +		ti,volt-to-capacity-charging-map = <4200 100>,
> +					        <4100 75>,
> +					        <4000 55>,
> +					        <3900 25>,
> +					        <3800 5>,
> +					        <3700 2>,
> +					        <3600 1>,
> +					        <3300 0>;
> +
> +		ti,volt-to-capacity-discharging-map = <4200 100>
> +						   <4100 95>,
> +						   <4000 70>,
> +						   <3800 50>,
> +						   <3700 10>,
> +						   <3600 5>,
> +						   <3300 0>;
> +		io-channels = <&twl_madc 1>,
> +	                      <&twl_madc 10>,
> +			      <&twl_madc 12>;
> +		io-channel-names = "temp",
> +		                   "ichg",
> +		                   "vbat";
> +	};

Rather than just making platform_data into device tree properties..

Can't you hide the these custom properties behind the compatible flag?

You can initialize that data in the driver based on the compatible
flag and the match data.

This makes sense if you can group things to similar configurations.

Regards,

Tony
