From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Mar 2015 15:56:34 -0700
Subject: [PATCHv5 26/35] ARM: dts: omap3: add minimal l4 bus layout with
 control module support
In-Reply-To: <1426877086-17131-27-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
 <1426877086-17131-27-git-send-email-t-kristo@ti.com>
Message-ID: <20150330225634.GL10805@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [150320 11:46]:
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -87,6 +87,60 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		l4_core: l4 at 48000000 {
> +			compatible = "ti,omap3-l4-core", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x48000000 0x1000000>;
> +
> +			scm: scm at 2000 {
> +				compatible = "ti,omap3-scm", "simple-bus";
> +				reg = <0x2000 0x2000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x2000 0x2000>;
> +
> +				omap3_pmx_core: pinmux at 30 {
> +					compatible = "ti,omap3-padconf",
> +						     "pinctrl-single";
> +					reg = <0x30 0x230>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#interrupt-cells = <1>;
> +					interrupt-controller;
> +					pinctrl-single,register-width = <16>;
> +					pinctrl-single,function-mask = <0xff1f>;
> +				};

Just noticed we may be now missing few pins as diffing the dmesg before
and after this series produces this on omap3:

-pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
+pinctrl-single 48002030.pinmux: 280 pins at pa fa002030 size 560

Care to check that?

Regards,

Tony
