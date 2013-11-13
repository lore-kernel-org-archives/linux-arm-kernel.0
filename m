From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 13 Nov 2013 04:57:07 -0600
Subject: [PATCHv3] dmaengine: Add support for BCM2835
In-Reply-To: <528154A1.1050303@koalo.de>
References: <528154A1.1050303@koalo.de>
Message-ID: <2B888C9F-DA6A-472C-AF14-95FB9CF1D41A@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Nov 11, 2013, at 4:05 PM, Florian Meier <florian.meier@koalo.de> wrote:

> Add support for DMA controller of BCM2835 as used in the Raspberry Pi.
> Currently it only supports cyclic DMA.
> 
> Signed-off-by: Florian Meier <florian.meier@koalo.de>
> ---
> 
> Thank you for your comments!
> I hope I have now removed all leftovers of the sg struct.
> Regarding the endian-ness: I have not found any hint about that in the datasheet. Therefore, I chose uint32_t. If you think fixed le32 is more likely I will change it.
> The PAD fields do not seem to be used, but the datasheet states they should be set to 0.
> 
> 
> .../devicetree/bindings/dma/bcm2835-dma.txt        |   57 ++
> arch/arm/boot/dts/bcm2835.dtsi                     |   23 +
> drivers/dma/Kconfig                                |    6 +
> drivers/dma/Makefile                               |    1 +
> drivers/dma/bcm2835-dma.c                          |  810 ++++++++++++++++++++
> 5 files changed, 897 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/dma/bcm2835-dma.txt
> create mode 100644 drivers/dma/bcm2835-dma.c
> 
> diff --git a/Documentation/devicetree/bindings/dma/bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/bcm2835-dma.txt
> new file mode 100644
> index 0000000..9542ac8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/bcm2835-dma.txt
> @@ -0,0 +1,57 @@
> +* BCM2835 DMA controller
> +
> +Required properties:
> +- compatible: Should be "brcm,bcm2835-dma".
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Should contain all DMA interrupts. First cell is the IRQ bank
> +		Second cell is the IRQ number.

Can you be more specific about what you mean by ?all DMA interrupts??

> +- #dma-cells: Must be <1>, used to represent the number of integer cells in
> +the dmas property of client devices.
> +- dma-channels: Maximum number of DMA channels available
> +- dma-requests: Number of DMA Requests. 
> +- dma-channel-mask: Bit mask representing the channels available.

Should be brcm,dma-channel-mask

> +
> +Example:
> +
> +dma: dma at 7e007000 {
> +	compatible = "brcm,bcm2835-dma";
> +	reg = <0x7e007000 0xf00>;
> +	interrupts = <1 16
> +		      1 17
> +		      1 18
> +		      1 19
> +		      1 20
> +		      1 21
> +		      1 22
> +		      1 23
> +		      1 24
> +		      1 25
> +		      1 26
> +		      1 27
> +		      1 28>;
> +	
> +	#dma-cells = <1>;
> +	dma-channels = <15>;
> +	dma-requests = <32>;
> +	dma-channel-mask = <0x7f35>;
> +};
> +
> +DMA clients connected to the BCM2835 DMA controller must use the format
> +described in the dma.txt file, using a two-cell specifier for each channel:
> +a phandle plus one integer cells.
> +The two cells in order are:
> +
> +1. A phandle pointing to the DMA controller.
> +2. The DREQ number.
> +
> +Example:
> +
> +bcm2835_i2s: i2s at 7e203000 {
> +	compatible = "brcm,bcm2835-i2s";
> +	reg = <	0x7e203000 0x20
> +		0x7e101098 0x02>;
> +
> +	dmas = <&dma 2
> +		&dma 3>;
> +	dma-names = "tx", "rx";
> +};

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
