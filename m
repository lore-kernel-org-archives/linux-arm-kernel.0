From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 16:53:04 +0200
Subject: [PATCH 3/3] ARM: dts: cubox: add LCD controller and TDA998x
 configuration
In-Reply-To: <E1fcpom-0003ZI-FL@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Tue, 10 Jul 2018 11:24:24 +0100")
References: <20180710102344.GH17271@n2100.armlinux.org.uk>
 <E1fcpom-0003ZI-FL@rmk-PC.armlinux.org.uk>
Message-ID: <87601ca94f.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On mar., juil. 10 2018, Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Add DT configuration for the HDMI display output on the Dove Cubox.
> This adds support for the LCD0 controller which is connected to a
> TDA19988 HDMI encoder.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/dove-cubox.dts | 43 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> index 580e3cbcfbf7..f6dd56f63d09 100644
> --- a/arch/arm/boot/dts/dove-cubox.dts
> +++ b/arch/arm/boot/dts/dove-cubox.dts
> @@ -67,6 +67,25 @@
>  	gpu-subsystem {
>  		status = "okay";
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		display_reserved: framebuffer {
> +			compatible = "marvell,dove-framebuffer";

I didn't find the binding documentation associated to
"marvell,dove-framebuffer".

Could you point me on the accurate file?


> +			size = <0x02000000>;
> +			alignment = <0x02000000>;
> +			no-map;
> +		};
> +	};
> +
> +	display-subsystem {
> +		compatible = "marvell,dove-display-subsystem";

Same for this one.

Thanks,

Gregory

> +		memory-region = <&display_reserved>;
> +		ports = <&lcd0_port>;
> +	};
>  };
>  
>  &uart0 { status = "okay"; };
> @@ -117,6 +136,30 @@
>  			silabs,pll-master;
>  		};
>  	};
> +
> +	tda998x: hdmi-encoder {
> +		compatible = "nxp,tda998x";
> +		reg = <0x70>;
> +		video-ports = <0x234501>;
> +		interrupts-extended = <&gpio0 27 IRQ_TYPE_LEVEL_LOW>;
> +
> +		port {
> +			tda998x_video: endpoint {
> +				remote-endpoint = <&lcd0_rgb>;
> +			};
> +		};
> +	};
> +};
> +
> +&lcd0 {
> +	status = "okay";
> +	clocks = <&si5351 0>;
> +	clock-names = "ext_ref_clk1";
> +	lcd0_port: port {
> +		lcd0_rgb: endpoint {
> +			remote-endpoint = <&tda998x_video>;
> +		};
> +	};
>  };
>  
>  &sdio0 {
> -- 
> 2.7.4
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
