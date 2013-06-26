From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 26 Jun 2013 04:08:59 +0000
Subject: [PATCH 2/5] ARM: dts: add AM33XX MMC support
In-Reply-To: <1372209881-6616-1-git-send-email-joelagnel@ti.com>
References: <1372209881-6616-1-git-send-email-joelagnel@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC43DC8@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 06:54:41, Fernandes, Joel wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Adds AM33XX MMC support for am335x-bone, am335x-evm, and
> am335x-evmsk.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts  |    7 +++++++
>  arch/arm/boot/dts/am335x-evm.dts   |    7 +++++++
>  arch/arm/boot/dts/am335x-evmsk.dts |    7 +++++++
>  arch/arm/boot/dts/am33xx.dtsi      |   28 ++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 5302f79..80bff9c 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -120,6 +120,8 @@
>  		};
>  
>  		ldo3_reg: regulator at 5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
>  
> @@ -136,3 +138,8 @@
>  &cpsw_emac1 {
>  	phy_id = <&davinci_mdio>, <1>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&ldo3_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 0423298..62af561 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -232,6 +232,8 @@
>  		};
>  
>  		vmmc_reg: regulator at 12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
>  	};
> @@ -244,3 +246,8 @@
>  &cpsw_emac1 {
>  	phy_id = <&davinci_mdio>, <1>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&vmmc_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index f67c360..8904b88 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -244,7 +244,14 @@
>  		};
>  
>  		vmmc_reg: regulator at 12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
>  			regulator-always-on;
>  		};
>  	};
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&vmmc_reg>;
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index b4fda12..119f8a9 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -229,6 +229,34 @@
>  			status = "disabled";
>  		};
>  
> +		mmc1: mmc at 48060000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc1";
> +			ti,dual-volt;
> +			ti,needs-special-reset;
> +			dmas = <&edma 24
> +				&edma 25>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};


MMC1 also needs "ti,needs-special-hs-handling" dt property to indicate support 
for properly supporting SD HS cards.

>From commit
commit cd587096c0e2b85a67e77721a753679bac89b394

    mmc: omap_hsmmc: Enable HSPE bit for high speed cards

    HSMMC IP on AM33xx need a special setting to handle High-speed cards.
    Other platforms like TI81xx, OMAP4 may need this as-well. This depends
    on the HSMMC IP timing closure done for the high speed cards.

> +
> +		mmc2: mmc at 481d8000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc2";
> +			ti,needs-special-reset;
> +			dmas = <&edma 2
> +				&edma 3>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		mmc3: mmc at 47810000 {
> +			compatible = "ti,omap3-hsmmc";
> +			ti,hwmods = "mmc3";
> +			ti,needs-special-reset;
> +			status = "disabled";
> +		};
> +
>  		wdt2: wdt at 44e35000 {
>  			compatible = "ti,omap3-wdt";
>  			ti,hwmods = "wd_timer2";
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
