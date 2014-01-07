From: yao.yuan@freescale.com (Yao Yuan)
Date: Tue, 7 Jan 2014 09:49:02 +0000
Subject: [PATCH] the eDMA support for the LPUART send driver
In-Reply-To: <201401051544.50036.arnd@arndb.de>
References: <1388143449-28640-1-git-send-email-yao.yuan@freescale.com>
 <201401051544.50036.arnd@arndb.de>
Message-ID: <8c7c4d5a53f74c6aa2f701bcb3dbbeab@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your suggestion.

I will fix those errors and also add the "jpg" in the next version.

-----Original Message-----
From: Arnd Bergmann [mailto:arnd at arndb.de] 
Sent: Sunday, January 05, 2014 10:45 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Yuan Yao-B46683; gregkh at linuxfoundation.org; linux-serial at vger.kernel.org
Subject: Re: [PATCH] the eDMA support for the LPUART send driver

On Friday 27 December 2013, Yuan Yao wrote:
> This patch add eDMA support for LPUART send function.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi    |  12 +++
>  drivers/tty/serial/fsl_lpuart.c | 187 
> ++++++++++++++++++++++++++++++++--------
>  2 files changed, 163 insertions(+), 36 deletions(-)

Not sure if this got applied already, but you are missing the respective change to Documentation/devicetree/bindings/serial/fsl-lpuart.txt.

Please document the dma-names you use here. While you are at it, please also add the "ipg" clock-name.

	Arnd

> +static int fsl_request_dma(struct uart_port *port) {
> +	struct lpuart_port *sport = container_of(port,
> +					struct lpuart_port, port);
> +	struct dma_chan *tx_chan;
> +	struct dma_slave_config dma_tx_sconfig;
> +	dma_addr_t dma_phys;
> +	unsigned char *dma_buf;
> +	int ret;
> +
> +	tx_chan  = dma_request_slave_channel(sport->port.dev, "lpuart-tx");
> +
> +	if (!tx_chan) {
> +		dev_err(sport->port.dev, "Dma TX channel request failed!\n");
> +		return -ENODEV;
> +	}
> +
> +	dma_phys = dma_map_single(sport->port.dev,
> +				sport->port.state->xmit.buf,
> +				UART_XMIT_SIZE, DMA_TO_DEVICE);

This is wrong: Since the dma is performed by the dma engine rather than the uart, the first argument here needs to be the dma device pointer. In fact, dma_map_single is normally supposed to fail on the uart device as the dma_mask value should be zero. Not sure why this worked.

> +	if (!dma_phys) {
> +		dev_err(sport->port.dev, "Dma_phys single failed\n");
> +		return -ENOMEM;
> +	}

Please also change all references to "phys" -- it's not a phys address but a bus address. These are often the same, but that's not for the driver to know.

	Arnd
