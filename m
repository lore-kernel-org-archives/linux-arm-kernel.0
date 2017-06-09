From: han.xu@nxp.com (Han Xu)
Date: Fri, 9 Jun 2017 19:17:03 +0000
Subject: [PATCH v6 2/3] ARM: dts: imx7: add GPMI NAND and APBH DMA
In-Reply-To: <d4aaef68978524bb46eee79d639dde2b83e8bb5f.1496961128.git-series.stefan@agner.ch>
References: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
 <d4aaef68978524bb46eee79d639dde2b83e8bb5f.1496961128.git-series.stefan@agner.ch>
Message-ID: <5699f899-32f8-4c8d-fb47-aa257a51863a@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/2017 05:34 PM, Stefan Agner wrote:
> Add i.MX 7 APBH DMA and GPMI NAND modules.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Han Xu <han.xu@nxp.com>
> ---
>   arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index c4f12fd..4902f62 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -995,5 +995,36 @@
>   				status = "disabled";
>   			};
>   		};
> +
> +		dma_apbh: dma-apbh at 33000000 {
> +			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
> +			reg = <0x33000000 0x2000>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
> +			#dma-cells = <1>;
> +			dma-channels = <4>;
> +			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
> +		};
> +
> +		gpmi: gpmi-nand at 33002000{
> +			compatible = "fsl,imx7d-gpmi-nand";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
> +			reg-names = "gpmi-nand", "bch";
> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "bch";
> +			clocks = <&clks IMX7D_NAND_RAWNAND_CLK>,
> +				<&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
> +			clock-names = "gpmi_io", "gpmi_bch_apb";
> +			dmas = <&dma_apbh 0>;
> +			dma-names = "rx-tx";
> +			status = "disabled";
> +			assigned-clocks = <&clks IMX7D_NAND_ROOT_SRC>;
> +			assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_500M_CLK>;
> +		};
>   	};
>   };
