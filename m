From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Jan 2016 18:04:25 +0100
Subject: [PATCH v1 5/5] ARM: at91/dt: sama5d2: add nand0 and nfc0 nodes
In-Reply-To: <1452702857-2240-6-git-send-email-romain.izard.pro@gmail.com>
References: <1452702857-2240-1-git-send-email-romain.izard.pro@gmail.com>
 <1452702857-2240-6-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <56968399.5070706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2016 17:34, Romain Izard a ?crit :
> Both nodes are required to access NAND Flash memory. Additional
> settings will be necessary at the board level to use it.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index aee571448342..80420177ec1a 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -265,6 +265,44 @@
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
> +			nfc at 90000000 {

It's nfc at c0000000

> +				compatible = "atmel,sama5d4-nfc";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = < /* NFC Command Registers */
> +					0xC0000000 0x08000000

Lower case please

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

Otherwise, it seems okay. When corrected, you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Brian, Wenyou,
I'm okay if this patch goes to Mainline with the mtd subsystem: there
should be no conflict with arm-soc for the upcoming kernel revisions.

Thanks, bye.


>  		sdmmc0: sdio-host at a0000000 {
>  			compatible = "atmel,sama5d2-sdhci";
>  			reg = <0xa0000000 0x300>;
> 


-- 
Nicolas Ferre
