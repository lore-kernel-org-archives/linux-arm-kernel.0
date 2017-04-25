From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Apr 2017 16:59:55 -0700
Subject: [PATCH v2 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170425235357.7690-2-eric@anholt.net>
References: <20170425235357.7690-1-eric@anholt.net>
 <20170425235357.7690-2-eric@anholt.net>
Message-ID: <0cb00eb7-41d0-0390-4687-d966499ed9f4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2017 04:53 PM, Eric Anholt wrote:
> Cygnus has a single AMAC controller connected to the B53 switch with 2
> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
> the external ethernet jacks.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> 
> v2: Call the node "switch", just call the ports "port" (suggestions by
>     Florian), drop max-speed on the phys (suggestion by Andrew Lunn),
>     call the other nodes "ethernet" and "ethernet-phy" (suggestions by
>     Sergei Shtylyov)
> 
>  arch/arm/boot/dts/bcm-cygnus.dtsi      | 58 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm911360_entphn.dts |  8 +++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 009f1346b817..9fd89be0f5e0 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -142,6 +142,54 @@
>  			interrupts = <0>;
>  		};
>  
> +		mdio: mdio at 18002000 {
> +			compatible = "brcm,iproc-mdio";
> +			reg = <0x18002000 0x8>;
> +			#size-cells = <1>;
> +			#address-cells = <0>;

Sorry for not noticing earlier, since you override this correctly in the
board-level DTS file can you put a:

			status = "disabled"

property in there by default?

Thanks!

> +
> +			gphy0: ethernet-phy at 0 {
> +				reg = <0>;
> +			};
> +
> +			gphy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +
> +		switch: switch at 18007000 {
> +			compatible = "brcm,bcm11360-srab", "brcm,cygnus-srab";
> +			reg = <0x18007000 0x1000>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					phy-handle = <&gphy0>;
> +					phy-mode = "rgmii";
> +				};
> +
> +				port at 1 {
> +					reg = <1>;
> +					phy-handle = <&gphy1>;
> +					phy-mode = "rgmii";
> +				};
> +
> +				port at 8 {
> +					reg = <8>;
> +					label = "cpu";
> +					ethernet = <&eth0>;
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +					};
> +				};
> +			};
> +		};
> +
>  		i2c0: i2c at 18008000 {
>  			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
>  			reg = <0x18008000 0x100>;
> @@ -295,6 +343,16 @@
>  			status = "disabled";
>  		};
>  
> +		eth0: ethernet at 18042000 {
> +			compatible = "brcm,amac";
> +			reg = <0x18042000 0x1000>,
> +			      <0x18110000 0x1000>;
> +			reg-names = "amac_base", "idm_base";
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			max-speed = <1000>;
> +			status = "disabled";
> +		};
> +
>  		nand: nand at 18046000 {
>  			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
>  			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
> diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
> index 8b3800f46288..e037dea63f4a 100644
> --- a/arch/arm/boot/dts/bcm911360_entphn.dts
> +++ b/arch/arm/boot/dts/bcm911360_entphn.dts
> @@ -57,6 +57,14 @@
>  	};
>  };
>  
> +&eth0 {
> +	status = "okay";
> +};
> +
> +&switch {
> +	status = "okay";
> +};
> +
>  &uart3 {
>  	status = "okay";
>  };
> 


-- 
Florian
