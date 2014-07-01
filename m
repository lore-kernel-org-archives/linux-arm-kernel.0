From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 1 Jul 2014 09:45:11 +0200
Subject: [PATCH 2/5] ARM: dts: imx6sx: Fix SSI nodes
In-Reply-To: <1404194129-25543-2-git-send-email-festevam@gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-2-git-send-email-festevam@gmail.com>
Message-ID: <20140701074511.GC28033@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Jul 01, 2014 at 02:55:26AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The fsl_ssi driver only needs one clock to work, so only pass the required
> SSI clock as done in the other mx6 dtsi files.

Actually I would prefer to have the clock defined in the .dtsi files.
The fsl-ssi driver only enables the baud clock if the SSI unit is the
clock master. So in all other cases the clock is not enabled and keeps
disabled.

Also the clock is SSI specific, you don't have a choice which clock to
use, there is no board dependency on this clock. So I think we should
fix the other imx6 dtsi files instead.

> 
> Also pass the  fsl,fifo-depth property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 2929078..ef3cea2 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -301,11 +301,10 @@
>  					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -					clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
> -						 <&clks IMX6SX_CLK_SSI1>;
> -					clock-names = "ipg", "baud";
> +					clocks = <&clks IMX6SX_CLK_SSI1>;

It seems you are removing the wrong clock here. 'ipg' is necessary,
'baud' is only used for master mode.

Regards,

Markus

>  					dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
>  					dma-names = "rx", "tx";
> +					fsl,fifo-depth = <15>;
>  					status = "disabled";
>  				};
>  
> @@ -313,11 +312,10 @@
>  					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> -					clocks = <&clks IMX6SX_CLK_SSI2_IPG>,
> -						 <&clks IMX6SX_CLK_SSI2>;
> -					clock-names = "ipg", "baud";
> +					clocks = <&clks IMX6SX_CLK_SSI2>;
>  					dmas = <&sdma 41 1 0>, <&sdma 42 1 0>;
>  					dma-names = "rx", "tx";
> +					fsl,fifo-depth = <15>;
>  					status = "disabled";
>  				};
>  
> @@ -325,11 +323,10 @@
>  					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -					clocks = <&clks IMX6SX_CLK_SSI3_IPG>,
> -						 <&clks IMX6SX_CLK_SSI3>;
> -					clock-names = "ipg", "baud";
> +					clocks = <&clks IMX6SX_CLK_SSI3>;
>  					dmas = <&sdma 45 1 0>, <&sdma 46 1 0>;
>  					dma-names = "rx", "tx";
> +					fsl,fifo-depth = <15>;
>  					status = "disabled";
>  				};
>  
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/a8b5123f/attachment.sig>
