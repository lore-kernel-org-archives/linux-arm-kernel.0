From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 11 May 2017 15:35:15 +0800
Subject: [PATCH] arm64: dts: ls1088a: update the sata node
In-Reply-To: <1494213209-39673-1-git-send-email-andy.tang@nxp.com>
References: <1494213209-39673-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170511073514.GE5833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 11:13:29AM +0800, Yuantian Tang wrote:
> 1. Sata ecc should be disabled due to a erratum.
> Provide the ecc register address for driver to use.

This is a bit confusing.  Are you saying that the ECC register address
is provided in DT for SATA driver to disable ECC function?

> 2. Enable dma coherence operation
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 2946fd7..90edd76 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -265,10 +265,13 @@
>  
>  		sata: sata at 3200000 {
>  			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
> -			reg = <0x0 0x3200000 0x0 0x10000>;
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +				<0x0 0x20140520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
>  			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 3>;
>  			status = "disabled";
> +			dma-coherent;

Please add it above 'status' line, which we generally keep at the bottom
of property list.

Shawn

>  		};
>  	};
>  
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
