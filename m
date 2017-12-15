From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 15 Dec 2017 11:29:49 +0100
Subject: [PATCH 12/12] ARM64: dts: marvell: use reworked NAND controller
 driver on Armada 8K
In-Reply-To: <20171207201814.30411-13-miquel.raynal@free-electrons.com>
 (Miquel Raynal's message of "Thu, 7 Dec 2017 21:18:14 +0100")
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171207201814.30411-13-miquel.raynal@free-electrons.com>
Message-ID: <87y3m4l1wi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On jeu., d?c. 07 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Use the new bindings of the reworked Marvell NAND controller driver.
> Also adapt the nand controller node organization to distinguish which
> property is relevant for the controller, and which one is NAND chip
> specific. Expose the partitions as a subnode of the NAND chip.
>
> Remove the 'marvell,nand-enable-arbiter' property, not needed anymore as
> the driver activates the arbiter by default for all boards (either
> needed or harmless).
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 46 +++++++++++++---------
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 10 ++---
>  2 files changed, 32 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index b1f6cccc5081..c25ac3fa9aec 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -272,27 +272,35 @@
>   * Proper NAND usage will require DPR-76 to be in position 1-2, which disables
>   * MDIO signal of CP1.
>   */
> -&cps_nand {
> -	num-cs = <1>;
> +&cps_nand_controller {
>  	pinctrl-0 = <&nand_pins>, <&nand_rb>;
>  	pinctrl-names = "default";
> -	nand-ecc-strength = <4>;
> -	nand-ecc-step-size = <512>;
> -	marvell,nand-enable-arbiter;
> -	marvell,system-controller = <&cps_syscon0>;
> -	nand-on-flash-bbt;
> -
> -	partition at 0 {
> -		label = "U-Boot";
> -		reg = <0 0x200000>;
> -	};
> -	partition at 200000 {
> -		label = "Linux";
> -		reg = <0x200000 0xe00000>;
> -	};
> -	partition at 1000000 {
> -		label = "Filesystem";
> -		reg = <0x1000000 0x3f000000>;
> +
> +	nand at 0 {
> +		reg = <0>;
> +		marvell,rb = <0>;
> +		nand-on-flash-bbt;
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "U-Boot";
> +				reg = <0 0x200000>;
> +			};
> +			partition at 200000 {
> +				label = "Linux";
> +				reg = <0x200000 0xe00000>;
> +			};
> +			partition at 1000000 {
> +				label = "Filesystem";
> +				reg = <0x1000000 0x3f000000>;
> +			};
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index cb1fb49ccf81..8610163bb1a4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -310,20 +310,20 @@
>  				status = "disabled";
>  			};
>  
> -			cps_nand: nand at 720000 {
> +			cps_nand_controller: nand at 720000 {
>  				/*
>  				 * Due to the limiation of the pin available
>  				 * this controller is only usable on the CPM
>  				 * for A7K and on the CPS for A8K.
>  				 */
> -				compatible = "marvell,armada370-nand",
> -					     "marvell,armada-8k-nand";
> +				compatible = "marvell,armada-8k-nand-controller",
> +					     "marvell,armada370-nand-controller";
>  				reg = <0x720000 0x54>;
>  				#address-cells = <1>;
> -				#size-cells = <1>;
> +				#size-cells = <0>;
>  				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&cps_clk 1 2>;
> -				marvell,system-controller = <&cpm_syscon0>;
> +				marvell,system-controller = <&cps_syscon0>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.11.0
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
