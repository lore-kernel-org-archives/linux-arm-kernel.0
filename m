From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Jun 2011 07:27:02 -0700
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <1309426647-31587-2-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
Message-ID: <20110630142702.GV23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few comments on the .dts data layout below.

* G, Manjunath Kondaiah <manjugk@ti.com> [110630 02:44]:
> --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> @@ -2,11 +2,6 @@
>  
>  / {
>  	i2c at 48072000 {
> -		compatible = "ti,omap3-i2c";
> -		reg = <0x48072000 0x80>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
>  		eeprom at 50 {
>  			compatible = "at,at24c01";
>  			reg = < 0x50 >;

The board .dts file should include the omap3 SoC .dts file.

The omap3 SoC .dts file should have the devices mapped to L3 and L4
busses, and the then i2c at 1 would just contain the bus offset.

Then the i2c at 1 entry would be repeated in the board specific
.dts and tell that the i2c at 1 is enabled.

> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -4,4 +4,46 @@
>  / {
>  	model = "TI OMAP3 BeagleBoard";
>  	compatible = "ti,omap3-beagle";
> +	interrupt-parent = <&gic>;
> +
> +	gic: interrupt-controller at 48241000 {
> +		compatible = "ti,omap-gic", "arm,gic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x48200000 0x1000>;
> +	};

There's no GIC on omap3, that's only on Cortex A9 systems.

Regards,

Tony
