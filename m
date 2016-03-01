From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 1 Mar 2016 18:24:01 +0100
Subject: [PATCH 2/3] ARM: dts: stm32f429: Add Ethernet support
In-Reply-To: <1456763376-21457-3-git-send-email-alexandre.torgue@gmail.com>
References: <1456763376-21457-1-git-send-email-alexandre.torgue@gmail.com>
 <1456763376-21457-3-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <56D5D031.9080609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

     I have made a handful of changes on your patch, let me know if this 
is ok for you.
     If ok, it will be part of the PR I'll send tomorrow.

On 02/29/2016 05:29 PM, Alexandre TORGUE wrote:
> Add Ethernet support (Synopsys MAC IP 3.50a) on stm32f429 SOC.
>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index bb7a736..af0367c 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -283,6 +283,26 @@
>   					bias-disable;
>   				};
>   			};
> +
> +			ethernet0_mii: mii at 0 {
> +				mii {
> +					slew-rate = <2>;
I moved slew-rate property below the pinmux one for consistency with 
other pin configs in the file.
> +					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
> +						 <STM32F429_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
> +						 <STM32F429_PC2_FUNC_ETH_MII_TXD2>,
> +						 <STM32F429_PB8_FUNC_ETH_MII_TXD3>,
> +						 <STM32F429_PC3_FUNC_ETH_MII_TX_CLK>,
> +						 <STM32F429_PG11_FUNC_ETH_MII_TX_EN_ETH_RMII_TX_EN>,
> +						 <STM32F429_PA2_FUNC_ETH_MDIO>,
> +						 <STM32F429_PC1_FUNC_ETH_MDC>,
> +						 <STM32F429_PA1_FUNC_ETH_MII_RX_CLK_ETH_RMII_REF_CLK>,
> +						 <STM32F429_PA7_FUNC_ETH_MII_RX_DV_ETH_RMII_CRS_DV>,
> +						 <STM32F429_PC4_FUNC_ETH_MII_RXD0_ETH_RMII_RXD0>,
> +						 <STM32F429_PC5_FUNC_ETH_MII_RXD1_ETH_RMII_RXD1>,
> +						 <STM32F429_PH6_FUNC_ETH_MII_RXD2>,
> +						 <STM32F429_PH7_FUNC_ETH_MII_RXD3>;
> +				};
> +			};
>   		};
>   
>   		rcc: rcc at 40023810 {
> @@ -323,6 +343,21 @@
>   			st,mem2mem;
>   		};
>   
> +		ethernet0: dwmac at 40028000 {
> +			compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
> +			status = "disabled";
I moved status property at the end of the node for consistency
> +			reg = <0x40028000 0x8000>;
> +			reg-names = "stmmaceth";
> +			interrupts = <0 61 0>, <0 62 0>;
#interrupt-cells is set to 1 in the nvic node, meaning that a single 
cell is expected here:

interrupts = <61>, <62>;

> +			interrupt-names = "macirq", "eth_wake_irq";
> +			clock-names = "stmmaceth", "tx-clk", "rx-clk";
> +			clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
> +			st,syscon = <&syscfg 0x4>;
> +			snps,pbl = <8>;
> +			snps,mixed-burst;
> +			dma-ranges;
> +		};
> +
>   		rng: rng at 50060800 {
>   			compatible = "st,stm32-rng";
>   			reg = <0x50060800 0x400>;

Regards,
Maxime
