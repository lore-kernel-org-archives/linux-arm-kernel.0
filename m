From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Wed, 27 Dec 2017 20:00:01 +0200
Subject: [PATCH] Device tree binding for Avago APDS990X light sensor
In-Reply-To: <20171227091828.GA3307@amd>
References: <20171227091828.GA3307@amd>
Message-ID: <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Thanks for the patch. Please see my comments below.

On Wed, Dec 27, 2017 at 10:18:28AM +0100, Pavel Machek wrote:
> From: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> 
> This prepares binding for light sensor used in Nokia N9. 
> 
> Signed-off-by: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> Signed-off-by: Pavel machek <pavel@ucw.cz>
> 
> ---
> 
> Patches to convert APDS990X driver to device tree and to switch to iio
> are available.
> 
> diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> new file mode 100644
> index 0000000..e038146
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> @@ -0,0 +1,39 @@
> +Avago APDS990X driver
> +
> +Required properties:
> +- compatible: "avago,apds990x"
> +- reg: address on the I2C bus
> +- interrupts: external interrupt line number
> +- Vdd-supply: power supply for VDD
> +- Vled-supply: power supply for LEDA

AFAIK the custom is to use lower case letters for regulator supplies.

> +- ga: Glass attenuation
> +- cf1: Clear channel factor 1
> +- irf1: IR channel factor 1
> +- cf2: Clear channel factor 2
> +- irf2: IR channel factor 2
> +- df: Device factor
> +- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> +- ppcount: Proximity pulse count

Are these device specific? If so, please add the vendor prefix to them.

I might not use short abbreviations such as "df" either. I wonder what
others think.

> +
> +Example (Nokia N9):
> +
> +	als_ps at 39 {
> +		compatible = "avago,apds990x";
> +		reg = <0x39>;
> +
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <19 10>; /* gpio_83, IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW */
> +
> +		Vdd-supply = <&vaux1>;
> +		Vled-supply = <&vbat>;
> +
> +		ga	= <168834>;
> +		cf1	= <4096>;
> +		irf1	= <7824>;
> +		cf2	= <877>;
> +		irf2	= <1575>;
> +		df	= <52>;
> +
> +		pdrive	= <0x2>; /* APDS_IRLED_CURR_25mA */
> +		ppcount	= <5>;
> +	};
> 

-- 
Kind regards,

Sakari Ailus
sakari.ailus at linux.intel.com
