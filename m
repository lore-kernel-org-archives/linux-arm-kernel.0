From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 17:27:49 +0100
Subject: [PATCH v2 7/9] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <1441980871-24475-8-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-8-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911162749.GD18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> These nodes are required to get the fdma driver working
> on STiH407 based silicon.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 51 +++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 838b812..da07474b 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -565,5 +565,56 @@
>  						  <&phy_port2 PHY_TYPE_USB3>;
>  			};
>  		};
> +
> +		fdma0: fdma0-audio at 8e20000 {

I'm not familiar with the FDMA driver, so can't comment knowledgeably,
but the <dev> part of <dev>@<base_address> should only describe the
type of hardware.  I believe in this case it should just be
dma at 08e20000.  Also notice the leading zero in the address, which I
believe mitigates possible confusion.  Then you be more specific with
the label, so something like 'fdma-audio' seems appropriate here.

> +			compatible = "st,stih407-fdma-mpe31";
> +			reg = <0x8e20000 0x20000>;

I personally find padding up to 32bits helpful in the addresses.

> +			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
> +			dma-channels = <16>;
> +			#dma-cells = <3>;
> +			st,fdma-id = <0>;

We usually shy away from ID properties.  What is it required for in
this case?

> +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "fdma_slim",
> +				      "fdma_hi",
> +				      "fdma_low",
> +				      "fdma_ic";
> +		};
> +
> +		fdma1: fdma1-app at 8e40000 {
> +			compatible = "st,stih407-fdma-mpe31";
> +			reg = <0x8e40000 0x20000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
> +			dma-channels = <16>;
> +			#dma-cells = <3>;
> +			st,fdma-id = <1>;
> +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> +				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> +				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "fdma_slim",
> +				      "fdma_hi",
> +				      "fdma_low",
> +				      "fdma_ic";
> +		};
> +
> +		fdma2: fdma2-free_running at 8e60000 {
> +			compatible = "st,stih407-fdma-mpe31";
> +			reg = <0x8e60000 0x20000>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
> +			dma-channels = <16>;
> +			#dma-cells = <3>;
> +			st,fdma-id = <2>;
> +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> +				 <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names = "fdma_slim",
> +				      "fdma_hi",
> +				      "fdma_low",
> +				      "fdma_ic";
> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
