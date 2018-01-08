From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 8 Jan 2018 17:56:55 +0100
Subject: [RFC] ARM: dts: sama5d2: qspi DMA fixes spi DMA
In-Reply-To: <1514317960-27094-1-git-send-email-aford173@gmail.com>
References: <1514317960-27094-1-git-send-email-aford173@gmail.com>
Message-ID: <3871e6bb-7673-b949-8b49-652d63b48f5a@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/12/2017 at 20:52, Adam Ford wrote:
> For some reason without this patch, using SPI0 with DMA yields the
> following message:
> 
> atmel_spi f8000000.spi: DMA TX channel not available, SPI unable to use DMA
> 
> With the patch, trying to use SPI0 yields the following:
> 
> atmel_spi f8000000.spi: Using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers

It seems related to SPI interface, handled by drivers/spi/spi-atmel.c
driver. DMA properties are already set for this driver.

> The QSPI driver doesn't appear to me to be using the DMA but the
> datasheet seems indicate the DMA is supported.  I am not sure why patch would
> fix the errors, so I'm posting it as RFC.

QSPI is a totally different IP and so driver:
drivers/mtd/spi-nor/atmel-quadspi.c

Actually what you modify hereunder is the QSPI DT and the DMA is
disabled for it because we miss a way to make sure that the buffer we
are handling are DMA capable (continuous for instance).

The support for a way to handle this is being discussed right now (by
Cyrille in copy). Once settled, we will be able to use DMA with QSPI in
this driver. DT binding is not determined yet BTW.

For now, your patch is not usable.

Thanks, best regards.
  Nicolas

> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 61f68e5..fd55e91 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -999,6 +999,13 @@
>  				reg = <0xf0020000 0x100>, <0xd0000000 0x08000000>;
>  				reg-names = "qspi_base", "qspi_mmap";
>  				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
> +				dmas = <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(4))>,
> +				       <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(5))>;
> +				dma-names = "tx", "rx";
>  				clocks = <&qspi0_clk>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -1010,6 +1017,13 @@
>  				reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
>  				reg-names = "qspi_base", "qspi_mmap";
>  				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
> +				dmas = <&dma1
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(48))>,
> +				       <&dma0
> +					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
> +					 AT91_XDMAC_DT_PERID(49))>;
> +				dma-names = "tx", "rx";
>  				clocks = <&qspi1_clk>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> 


-- 
Nicolas Ferre
