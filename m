From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 08 Feb 2017 11:12:14 +0100
Subject: [PATCH] ARM: dts: imx53-qsb: Provide the TVE DAC regulators
In-Reply-To: <1483470751-8073-1-git-send-email-festevam@gmail.com>
References: <1483470751-8073-1-git-send-email-festevam@gmail.com>
Message-ID: <1486548734.2309.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-03 at 17:12 -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> On imx53-qsb the TVE DAC regulator comes from:
> 
> - LDO7 on the board with the Dialog DA9052 PMIC
> - VDAC on the board with the MC34708 PMIC
> 
> Pass them in the 'dac-supply' node.
> 
> While at it, remove the 'regulator-always-on/regulator-boot-on'
> properties as the TVE driver will properly handle it.
> 
> Tested on a imx53-qsb board with a Dialog DA9052 PMIC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx53-qsb.dts  | 5 ++++-
>  arch/arm/boot/dts/imx53-qsrb.dts | 6 ++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 3799396..f4c158c 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -90,7 +90,6 @@
>  			ldo7_reg: ldo7 {
>  				regulator-min-microvolt = <1200000>;
>  				regulator-max-microvolt = <3600000>;

As Lucas pointed out, we could limit the board constraints to the
necessary voltage here.
Since this regulator is used as the TVDAC analog power supply, this
range should at least be limited to the analog power supply range of the
TVDAC, listed in Table 74-9. of the i.MX53 reference manual (2.5-2.75V).

But since the nominal voltage is 2.75V, which was used to determine the
analog gain that is supposed to result in the necessary 0.7V
peak-to-peak amplitude on the VGA output, I'd say we should just fix the
voltage to 2750000 here.

> -				regulator-always-on;
>  			};
>  
>  			ldo8_reg: ldo8 {
> @@ -113,3 +112,7 @@
>  		};
>  	};
>  };
> +
> +&tve {
> +	dac-supply = <&ldo7_reg>;
> +};
> diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
> index 96d7eed..479ca4c 100644
> --- a/arch/arm/boot/dts/imx53-qsrb.dts
> +++ b/arch/arm/boot/dts/imx53-qsrb.dts
> @@ -130,8 +130,6 @@
>  				regulator-name = "VDAC";
>  				regulator-min-microvolt = <2500000>;
>  				regulator-max-microvolt = <2775000>;

Same as above.

> -				regulator-boot-on;
> -				regulator-always-on;
>  			};
>  
>  			vgen1_reg: vgen1 {
> @@ -152,3 +150,7 @@
>  		};
>  	};
>  };
> +
> +&tve {
> +	dac-supply = <&vdac_reg>;
> +};

regards
Philipp
