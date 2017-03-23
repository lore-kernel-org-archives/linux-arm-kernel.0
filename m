From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Mar 2017 17:46:48 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: add PPv2.2 description to Armada
 7K/8K
In-Reply-To: <1489677388-19320-2-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 16 Mar 2017 16:16:27 +0100")
References: <1489677388-19320-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1489677388-19320-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87o9wsc553.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., mars 16 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the description of the PPv2.2 hardware block for the
> Marvell Armada 7K and Armada 8K processors, and their corresponding Armada
> 7040 and 8040 Development boards.

Applied on mvebu/dt64

Thanks,

Gregory

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 25 +++++++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 16 ++++++++++
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 37 ++++++++++++++++++++++
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 37 ++++++++++++++++++++++
>  4 files changed, 115 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 070b589..bb0e1e8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -146,3 +146,28 @@
>  &cpm_usb3_1 {
>  	status = "okay";
>  };
> +
> +&cpm_mdio {
> +	phy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&cpm_ethernet {
> +	status = "okay";
> +};
> +
> +&cpm_eth1 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "sgmii";
> +};
> +
> +&cpm_eth2 {
> +	status = "okay";
> +	phy = <&phy1>;
> +	phy-mode = "rgmii-id";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 6e6f182..80e685e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -124,6 +124,22 @@
>  	status = "okay";
>  };
>  
> +&cpm_mdio {
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&cpm_ethernet {
> +	status = "okay";
> +};
> +
> +&cpm_eth2 {
> +	status = "okay";
> +	phy = <&phy1>;
> +	phy-mode = "rgmii-id";
> +};
> +
>  /* CON5 on CP1 expansion */
>  &cps_pcie2 {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 3a99c36..9a2ce2a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -59,6 +59,43 @@
>  			interrupt-parent = <&gic>;
>  			ranges = <0x0 0x0 0xf2000000 0x2000000>;
>  
> +			cpm_ethernet: ethernet at 0 {
> +				compatible = "marvell,armada-7k-pp22";
> +				reg = <0x0 0x100000>, <0x129000 0xb000>;
> +				clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>, <&cpm_syscon0 1 5>;
> +				clock-names = "pp_clk", "gop_clk", "mg_clk";
> +				status = "disabled";
> +				dma-coherent;
> +
> +				cpm_eth0: eth0 {
> +					interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <0>;
> +					gop-port-id = <0>;
> +					status = "disabled";
> +				};
> +
> +				cpm_eth1: eth1 {
> +					interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <1>;
> +					gop-port-id = <2>;
> +					status = "disabled";
> +				};
> +
> +				cpm_eth2: eth2 {
> +					interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <2>;
> +					gop-port-id = <3>;
> +					status = "disabled";
> +				};
> +			};
> +
> +			cpm_mdio: mdio at 12a200 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "marvell,orion-mdio";
> +				reg = <0x12a200 0x10>;
> +			};
> +
>  			cpm_syscon0: system-controller at 440000 {
>  				compatible = "marvell,cp110-system-controller0",
>  					     "syscon";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 9e09c4d..c9dfa24 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -59,6 +59,43 @@
>  			interrupt-parent = <&gic>;
>  			ranges = <0x0 0x0 0xf4000000 0x2000000>;
>  
> +			cps_ethernet: ethernet at 0 {
> +				compatible = "marvell,armada-7k-pp22";
> +				reg = <0x0 0x100000>, <0x129000 0xb000>;
> +				clocks = <&cps_syscon0 1 3>, <&cps_syscon0 1 9>, <&cps_syscon0 1 5>;
> +				clock-names = "pp_clk", "gop_clk", "mg_clk";
> +				status = "disabled";
> +				dma-coherent;
> +
> +				cps_eth0: eth0 {
> +					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <0>;
> +					gop-port-id = <0>;
> +					status = "disabled";
> +				};
> +
> +				cps_eth1: eth1 {
> +					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <1>;
> +					gop-port-id = <2>;
> +					status = "disabled";
> +				};
> +
> +				cps_eth2: eth2 {
> +					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> +					port-id = <2>;
> +					gop-port-id = <3>;
> +					status = "disabled";
> +				};
> +			};
> +
> +			cps_mdio: mdio at 12a200 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "marvell,orion-mdio";
> +				reg = <0x12a200 0x10>;
> +			};
> +
>  			cps_syscon0: system-controller at 440000 {
>  				compatible = "marvell,cp110-system-controller0",
>  					     "syscon";
> -- 
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
