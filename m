From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 6 Jul 2011 12:57:12 -0600
Subject: [RFC PATCH 2/5] OMAP4:I2C: Add device tree nodes for panda board
In-Reply-To: <1309426647-31587-3-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-3-git-send-email-manjugk@ti.com>
Message-ID: <20110706185712.GK4871@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 03:07:24PM +0500, G, Manjunath Kondaiah wrote:
> 
> Add I2C and it's child device nodes for beagle board.
> The I2C1 controller child devices are not populated and it
> should be handled along with OMAP clock changes.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda.dts |   57 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 58909e9..f9af72f 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -8,4 +8,61 @@
>  / {
>  	model = "TI OMAP4 PandaBoard";
>  	compatible = "ti,omap4-panda", "ti,omap4430";
> +	interrupt-parent = <&gic>;
> +
> +	gic: interrupt-controller at 48241000 {
> +		compatible = "ti,omap-gic", "arm,gic";

ti,omap4-gic

> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x48241000 0x1000>,
> +		      <0X48240100 0x0200>;
> +	};
> +
> +	i2c at 48070000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";

ti,omap4-i2c.  Actually, it is quite possibly appropriate to do:

	compatible = "ti,omap4-i2c", "ti,omap3-i2c";

> +		reg = <0x48070000 0x100>;
> +		interrupts = < 88 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;

Frequency should be a Hz value, not kHz or MHz.

> +		status = "disabled";
> +	};
> +
> +	i2c at 48072000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48072000 0x100>;
> +		interrupts = < 89 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;
> +		status = "ok";
> +	};
> +
> +	i2c at 48060000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48060000 0x100>;
> +		interrupts = < 93 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <100>;
> +		status = "ok";
> +		eeprom at 50 {
> +			compatible = "at,at24c01";
> +			reg = < 0x50 >;
> +		};
> +	};
> +
> +	i2c at 48350000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48350000 0x100>;
> +		interrupts = < 94 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;
> +		status = "ok";
> +	};
>  };
> -- 
> 1.7.4.1
> 
