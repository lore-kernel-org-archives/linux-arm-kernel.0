From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 16:41:14 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Fix clock resources
 for various node
In-Reply-To: <20180105153055.12232-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 5 Jan 2018 16:30:55 +0100")
References: <20180105153055.12232-1-gregory.clement@free-electrons.com>
Message-ID: <87mv1s9uud.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., janv. 05 2018, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> On the CP modules we found on Armada 7K/8K, many IP block actually also
> need a "logical" clock (from the bus). This patch add them which allows
> to fix some issues hanging the kernel:
>
> If Ethernet and sdhci driver are built as modules and sdhci was loaded
> first then the kernel hang.
>
> Fixes: bb16ea1742c8 ("mmc: sdhci-xenon: Fix clock resource by adding an
> optional bus clock")
> Cc: stable at vger.kernel.org
> Reported-by: Riku Voipio <riku.voipio@linaro.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/fixes

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 13 ++++++++-----
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  9 ++++++---
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index e3b64d03fbd8..9c7724e82aff 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -63,8 +63,10 @@
>  			cpm_ethernet: ethernet at 0 {
>  				compatible = "marvell,armada-7k-pp22";
>  				reg = <0x0 0x100000>, <0x129000 0xb000>;
> -				clocks = <&cpm_clk 1 3>, <&cpm_clk 1 9>, <&cpm_clk 1 5>;
> -				clock-names = "pp_clk", "gop_clk", "mg_clk";
> +				clocks = <&cpm_clk 1 3>, <&cpm_clk 1 9>,
> +					 <&cpm_clk 1 5>, <&cpm_clk 1 18>;
> +				clock-names = "pp_clk", "gop_clk",
> +					      "mg_clk","axi_clk";
>  				marvell,system-controller = <&cpm_syscon0>;
>  				status = "disabled";
>  				dma-coherent;
> @@ -155,7 +157,8 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> -				clocks = <&cpm_clk 1 9>, <&cpm_clk 1 5>;
> +				clocks = <&cpm_clk 1 9>, <&cpm_clk 1 5>,
> +					 <&cpm_clk 1 6>, <&cpm_clk 1 18>;
>  				status = "disabled";
>  			};
>  
> @@ -338,8 +341,8 @@
>  				compatible = "marvell,armada-cp110-sdhci";
>  				reg = <0x780000 0x300>;
>  				interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
> -				clock-names = "core";
> -				clocks = <&cpm_clk 1 4>;
> +				clock-names = "core","axi";
> +				clocks = <&cpm_clk 1 4>, <&cpm_clk 1 18>;
>  				dma-coherent;
>  				status = "disabled";
>  			};
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 0d51096c69f8..87ac68b2cf37 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -63,8 +63,10 @@
>  			cps_ethernet: ethernet at 0 {
>  				compatible = "marvell,armada-7k-pp22";
>  				reg = <0x0 0x100000>, <0x129000 0xb000>;
> -				clocks = <&cps_clk 1 3>, <&cps_clk 1 9>, <&cps_clk 1 5>;
> -				clock-names = "pp_clk", "gop_clk", "mg_clk";
> +				clocks = <&cps_clk 1 3>, <&cps_clk 1 9>,
> +					 <&cps_clk 1 5>, <&cps_clk 1 18>;
> +				clock-names = "pp_clk", "gop_clk",
> +					      "mg_clk", "axi_clk";
>  				marvell,system-controller = <&cps_syscon0>;
>  				status = "disabled";
>  				dma-coherent;
> @@ -155,7 +157,8 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> -				clocks = <&cps_clk 1 9>, <&cps_clk 1 5>;
> +				clocks = <&cps_clk 1 9>, <&cps_clk 1 5>,
> +					 <&cps_clk 1 6>, <&cps_clk 1 18>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.15.1
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
