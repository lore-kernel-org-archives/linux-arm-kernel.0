From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 11:00:12 +0800
Subject: [PATCH v2 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
In-Reply-To: <20181119102528.2830-4-dev@pschenker.ch>
References: <20181119102528.2830-1-dev@pschenker.ch>
 <20181119102528.2830-4-dev@pschenker.ch>
Message-ID: <20181128030011.GG20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 11:25:28AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules

iMX6 and T30 changes need to be separate patches.

Shawn

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - Put common ADC settings in mfd
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
>  4 files changed, 57 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 3dc99dd8dde1..8db476d8978d 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -331,11 +331,18 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -345,17 +352,16 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..2e303d79c7f8 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -262,11 +262,18 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -276,17 +283,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* 3.25 MHz ADC clock speed */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 7f112f192fe9..850b0d13549a 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -976,11 +976,18 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
> +			/* forbid to use ADC channels 3-0 (touch) */
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -990,17 +997,16 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index 35af03ca9e90..1f9198bb24ff 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -845,11 +845,18 @@
>  			id = <0>;
>  			blocks = <0x5>;
>  			irq-trigger = <0x1>;
> +			/* 3.25 MHz ADC clock speed */
> +			st,adc-freq = <1>;
> +			/* 12-bit ADC */
> +			st,mod-12b = <1>;
> +			/* internal ADC reference */
> +			st,ref-sel = <0>;
> +			/* ADC converstion time: 80 clocks */
> +			st,sample-time = <4>;
> +			/* forbid to use ADC channels 3-0 (touch) */
>  
>  			stmpe_touchscreen {
>  				compatible = "st,stmpe-ts";
> -				/* 3.25 MHz ADC clock speed */
> -				st,adc-freq = <1>;
>  				/* 8 sample average control */
>  				st,ave-ctrl = <3>;
>  				/* 7 length fractional part in z */
> @@ -859,17 +866,16 @@
>  				 * current limit value
>  				 */
>  				st,i-drive = <1>;
> -				/* 12-bit ADC */
> -				st,mod-12b = <1>;
> -				/* internal ADC reference */
> -				st,ref-sel = <0>;
> -				/* ADC converstion time: 80 clocks */
> -				st,sample-time = <4>;
>  				/* 1 ms panel driver settling time */
>  				st,settling = <3>;
>  				/* 5 ms touch detect interrupt delay */
>  				st,touch-det-delay = <5>;
>  			};
> +
> +			stmpe_adc {
> +				compatible = "st,stmpe-adc";
> +				st,norequest-mask = <0x0F>;
> +			};
>  		};
>  
>  		/*
> -- 
> 2.19.1
> 
