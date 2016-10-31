From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 21:42:32 -0500
Subject: [PATCH 2/6] arm: dts: ls1021a: update MSI node
In-Reply-To: <1477398945-22774-2-git-send-email-Minghuan.Lian@nxp.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
 <1477398945-22774-2-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20161031024232.wqvfrcinrp2aqgxu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 08:35:41PM +0800, Minghuan Lian wrote:
> 1. Change compatible to "fsl,ls-scfg-msi"

That is obvious from the diff. Write your commit message to answer the 
question Why?

This also breaks compatibility with old DTBs.

> 2. Move two MSI dts node into the parent node "msi-controller".
> So a PCIe device can request the MSI from the two MSI controllers.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 368e219..7a3b510 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -119,18 +119,22 @@
>  
>  		};
>  
> -		msi1: msi-controller at 1570e00 {
> -			compatible = "fsl,1s1021a-msi";
> -			reg = <0x0 0x1570e00 0x0 0x8>;
> +		msi: msi-controller {
> +			compatible = "fsl,ls-scfg-msi";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
>  			msi-controller;
> -			interrupts =  <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> -		};
>  
> -		msi2: msi-controller at 1570e08 {
> -			compatible = "fsl,1s1021a-msi";
> -			reg = <0x0 0x1570e08 0x0 0x8>;
> -			msi-controller;
> -			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> +			msi0 at 1570e00 {
> +				reg = <0x0 0x1570e00 0x0 0x8>;
> +				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			msi1 at 1570e08 {
> +				reg = <0x0 0x1570e08 0x0 0x8>;
> +				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> +			};
>  		};
>  
>  		ifc: ifc at 1530000 {
> @@ -643,7 +647,7 @@
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> -			msi-parent = <&msi1>;
> +			msi-parent = <&msi>;
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
> @@ -666,7 +670,7 @@
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> -			msi-parent = <&msi2>;
> +			msi-parent = <&msi>;
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 1.9.1
> 
