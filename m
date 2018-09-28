From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 28 Sep 2018 15:55:16 +0200
Subject: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
In-Reply-To: <20180927083636.5415-1-jorik@kippendief.biz>
References: <20180927083636.5415-1-jorik@kippendief.biz>
Message-ID: <20180928135516.jxhnsgaa3s2nagv7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Sep 27, 2018 at 10:36:36AM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>

The prefix of your commit title should be "ARM: dts: ..."

> The Orange Pi Plus board lacks voltage scaling capabilities in its
> current form. This results in random freezes during boot when cpufreq is
> enabled, probably due to wrong voltages.
> 
> This patch (a copy/paste of 06139c) does the following things on this
> board:
> - enable r_i2c
> - add sy8106a to the r_i2c bus
> - have the sy8106a regulate VDD of cpu
> 
> I have tested this on two Orange Pi Plus boards, and they run stable
> across a range of voltages (and frequencies).

How was this tested?

> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index b403e5d78..fd64b5c94 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -74,6 +74,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_vdd_cpux>;
> +};
> +
>  &ehci3 {
>  	status = "okay";
>  };
> @@ -119,6 +123,31 @@
>  	};
>  };
>  
> +&r_i2c {
> +	status = "okay";
> +
> +	reg_vdd_cpux: regulator at 65 {
> +		compatible = "silergy,sy8106a";
> +		reg = <0x65>;
> +		regulator-name = "vdd-cpux";
> +		silergy,fixed-microvolt = <1200000>;
> +		/*
> +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> +		 * however both the Armbian DVFS table and the official one
> +		 * have operating points with voltage under 1.1V, and both
> +		 * DVFS table are known to work properly at the lowest
> +		 * operating point.
> +		 *
> +		 * Use 1.0V as the minimum voltage instead.
> +		 */

There's not much point to that comment, since it's been that way for
all the other SoCs from Allwinner. However, that would be great to
have it in the commit log.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
