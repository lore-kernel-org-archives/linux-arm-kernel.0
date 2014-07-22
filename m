From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 10:57:09 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: add always on pcie regulator
In-Reply-To: <1405707270-22901-1-git-send-email-l.stach@pengutronix.de>
References: <1405707270-22901-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140722025708.GU8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 08:14:30PM +0200, Lucas Stach wrote:
> Everything in the PCI specification assumes devices to be
> enumerable on startup. This is only possible if they have
> power available.
> 
> A future improvement may allow this regulator to be switched
> off for D3hot and D3cold power states, but there is a lot
> of work to do the pcie host controller side for this to work.
> To keep things simple always enable the regulator for now.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Just curious if this fixes any known PCIe issue?

> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index ec43dde78525..bbbd501098e6 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -54,6 +54,17 @@
>  			gpio = <&gpio4 10 0>;
>  			enable-active-high;
>  		};
> +
> +		reg_pcie: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "pcie-supply";

I would start asking to name the regulator in the same way that board
document like schematics names it.  In this case, it should be
"MPCIE_3V3".

> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio3 19 0>;
> +			regulator-always-on;
> +			enable-active-high;
> +		};
>  	};
>  
>  	gpio-keys {
> @@ -323,6 +334,7 @@
>  				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
>  				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
>  				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
> +				MX6QDL_PAD_EIM_D19__GPIO3_IO19  0x80000000

No more GPIO setup in hog group, and no more 0x80000000 on pad config.
Please have a dedicate pinctrl entry for it with a proper config value,
and refer to the entry in that reg_pcie node.

Shawn

>  			>;
>  		};
>  
> -- 
> 2.0.1
> 
