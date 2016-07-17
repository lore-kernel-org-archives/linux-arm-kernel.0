From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 15:34:25 -0500
Subject: [RCF 2/3] hwmon: Document bindings for ads1118 adc driver
In-Reply-To: <49eddbb75c677db62701e229330f0f5c35983130.1468626668.git.stillcompiling@gmail.com>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <49eddbb75c677db62701e229330f0f5c35983130.1468626668.git.stillcompiling@gmail.com>
Message-ID: <20160717203425.GA10236@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 05:18:22PM -0700, Joshua Clayton wrote:
> ads1118 is a 4 input 16 bit adc with a buit-in temperature gauge
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ads1118.txt          | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads1118.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads1118.txt b/Documentation/devicetree/bindings/hwmon/ads1118.txt
> new file mode 100644
> index 0000000..41c66dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads1118.txt
> @@ -0,0 +1,81 @@
> +ADS1118 (SPI)
> +
> +The ADS1118 is 16-bit analog to digital converter with 4 inputs and a
> +temperature sensor.
> +The ADS1018 is a 12-bit version of the chip.
> +
> +The inputs can be single ended or differential pair combinations.
> +
> +Each channel, 0 - 4 may be configured as a single ended adc input.
> +Channel 0 may be configured differentially with channel 1.
> +Channels 0, 1, or 2 may be configured differentially with channel 3.
> +
> +To set up a differential pair, the lower channel should be have
> +the ti,differential-endpoint property set to the higher channel in the pair.
> +
> +Each channel can be configured individually:
> + - fullscale voltage range values are +/- microvolts
> +    6144000, 4096000, 2048000, 1024000, 512000, or 256000
> +
> + - data_rate in samples per second
> +    - for the ads1018:
> +      128, 250, 490, 920, 1600, 2400, or 3300
> +    - for the ads1118:
> +      8, 16, 32, 64, 128, 250, or 860

Would be better if these are documented with the property itself.

> +
> +The sensor contains an internal pullup register to keep the data output
> +high when not in use. This may be disabled, but is enabled by default.
> +
> +1) The /ads1118 node
> +
> +  Required properties:
> +
> +   - compatible : must be "ti,ads1018" or "ti,ads1118"
> +   - spi-cpha : spi phase set to 1 (spi polarity is 0)
> +   - reg : the spi chipselect address
> +   - #address-cells : must be <1>
> +   - #size-cells : must be <0>
> +
> +  Optional properties:
> +
> +   - ti,tempsensor: enable the temperature sensor
> +   - ti,pullup-disable: disable the internal pullup resistor

Explicitly state these are boolean.

> +
> +  The node contains child nodes for each channel that the platform uses.
> +
> +2) channel nodes
> +
> +  Required properties:
> +
> +   - reg : the channel number (0, 1, 2, or 3)
> +
> +  Optional properties:
> +
> +   - ti,differential-endpoint: differential second endpoint.

Type?

> +   - ti,fullscale: fullscale range in +/- microvolts

Add standard unit suffix.

> +   - ti,datarate : the converter data rate in samples / second

Perhaps "-hz" here?

> +
> +  Example ADS1118 node:
> +
> +	ads1118 at 0 {
> +		compatible = "ti,ads1118";
> +		spi-max-frequency = <2450000>;
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ti,tempsensor;
> +		voltage0 at 0 {

Perhaps channel at 0. Either way, drop the first 0.

> +			reg = <0>;
> +			ti,fullscale = <6144000>;
> +			ti,datarate = <860>;
> +			ti,differential-endpoint = <1>;
> +		};
> +		voltage1 at 3 {
> +			reg = <3>;
> +			ti,fullscale = <6144000>;
> +			ti,datarate = <475>;
> +		};
> +	};
> +
> +For the above example, The temperature sensor is enabled as well as
> +channels 0 and 1 in differential mode, and channel 3 single ended.
> -- 
> 2.7.4
> 
