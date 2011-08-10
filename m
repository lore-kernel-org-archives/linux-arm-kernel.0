From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 10 Aug 2011 14:36:50 +0200
Subject: [RFC/PATCH 11/14] dt: omap3: add soc file for handling i2c
	controllers
In-Reply-To: <1312897232-4792-12-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-12-git-send-email-manjugk@ti.com>
Message-ID: <4E427B62.1000907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>
> Add omap3 soc file for handling omap3 soc i2c controllers existing
> on l4-core bus.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>   arch/arm/boot/dts/omap3-soc.dtsi |   62 ++++++++++++++++++++++++++++++++++++++
>   1 files changed, 62 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
> new file mode 100644
> index 0000000..85de92f
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-soc.dtsi
> @@ -0,0 +1,62 @@
> +/*
> + * Device Tree Source for OMAP3 SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	#address-cells =<1>;
> +	#size-cells =<1>;
> +	model = "ti,omap3";
> +
> +	aliases {
> +		i2c1 =&i2c1;
> +		i2c2 =&i2c2;
> +		i2c3 =&i2c3;
> +	};
> +
> +	l4-core {

That comment is probably subject to discussion, but even if this 
interconnect is there physically, I'm not sure of the added value to add it.
It will add an extra level of indentation and that all. Moreover, it 
will mess up the physical address that are expressed using absolute 
value in the TRM with a less readable offset value.
In fact, most DTS files in the ARM directory are using a purely flat 
representation of the interconnect.

> +		compatible = "ti,omap3-l4-core";

Assuming we will keep that, you should probably add a more generic 
compatible name after that one. Like "ti,s3220" or even "sonics,s3220", 
assuming that this IP is generic enough for other SoC.

> +		#address-cells =<1>;
> +		#size-cells =<1>;
> +		ranges =<0 0x48000000 0x1000000>;
> +
> +		i2c1: i2c at 70000 {
> +			#address-cells =<1>;
> +			#size-cells =<0>;
> +			compatible = "ti,omap3-i2c";

The I2C IP and thus the driver is generic across OMAP generations and is 
even potentially used by other non-OMAP TI chips like DSP or Davinci. So 
having an extra compatible entry with "ti,i2c" or "ti, omap-i2c" seems 
mandatory.

Regards,
Benoit
