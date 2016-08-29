From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 21:41:00 +0800
Subject: [PATCH] ARM: dts: imx6sx: Add GPU bindings
In-Reply-To: <20160826142254.6950-1-marex@denx.de>
References: <20160826142254.6950-1-marex@denx.de>
Message-ID: <20160829134100.GO30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:22:54PM +0200, Marek Vasut wrote:
> Add bindings for the Vivante GC400T GPU found in the i.MX6SX .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 6a993bfda..901c2d2 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -1250,6 +1250,16 @@
>  			};
>  		};
>  
> +		gpu: gpu at 01800000 {

Wrong place for the node.  It should go right before dma-apbh at 01804000.
I fixed it up and applied patch.

Shawn

> +			compatible = "vivante,gc";
> +			reg = <0x01800000 0x4000>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6SX_CLK_GPU>,
> +				 <&clks IMX6SX_CLK_GPU>,
> +				 <&clks IMX6SX_CLK_GPU>;
> +			clock-names = "bus", "core", "shader";
> +		};
> +
>  		pcie: pcie at 0x08000000 {
>  			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
>  			reg = <0x08ffc000 0x4000>; /* DBI */
> @@ -1273,4 +1283,9 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	gpu-subsystem {
> +		compatible = "fsl,imx-gpu-subsystem";
> +		cores = <&gpu>;
> +	};
>  };
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
