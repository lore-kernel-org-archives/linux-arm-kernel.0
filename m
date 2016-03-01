From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 13:28:52 +0100
Subject: [PATCH v4 5/5] ARM: at91/dt: sama5d2: add nand0 and nfc0 nodes
In-Reply-To: <1455098187-9442-6-git-send-email-romain.izard.pro@gmail.com>
References: <1455098187-9442-1-git-send-email-romain.izard.pro@gmail.com>
 <1455098187-9442-6-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <56D58B04.3050106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/02/2016 10:56, Romain Izard a ?crit :
> Both nodes are required to access NAND Flash memory. Additional
> settings will be necessary at the board level to use it.
> 
> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I add it in our at91-4.6-dt branch.

Thanks, bye.

> ---
> v4: collect Tested-by and Reviewed-by tags
> v3: no change
> v2: fix device address, hexadecimal with minuscules
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 3f750f6170f2..484bd8ea6602 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -263,6 +263,44 @@
>  			cache-level = <2>;
>  		};
>  
> +		nand0: nand at 80000000 {
> +			compatible = "atmel,sama5d2-nand";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = < /* EBI CS3 */
> +				0x80000000 0x08000000
> +				/* SMC PMECC regs */
> +				0xf8014070 0x00000490
> +				/* SMC PMECC Error Location regs */
> +				0xf8014500 0x00000200
> +				/* ROM Galois tables */
> +				0x00040000 0x00018000
> +				>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
> +			atmel,nand-addr-offset = <21>;
> +			atmel,nand-cmd-offset = <22>;
> +			atmel,nand-has-dma;
> +			atmel,has-pmecc;
> +			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
> +			status = "disabled";
> +
> +			nfc at c0000000 {
> +				compatible = "atmel,sama5d4-nfc";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = < /* NFC Command Registers */
> +					0xc0000000 0x08000000
> +					/* NFC HSMC regs */
> +					0xf8014000 0x00000070
> +					/* NFC SRAM banks */
> +					0x00100000 0x00100000
> +					>;
> +				clocks = <&hsmc_clk>;
> +				atmel,write-by-sram;
> +			};
> +		};
> +
>  		sdmmc0: sdio-host at a0000000 {
>  			compatible = "atmel,sama5d2-sdhci";
>  			reg = <0xa0000000 0x300>;
> 


-- 
Nicolas Ferre
