From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 9 Jan 2014 10:35:15 +0100
Subject: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
In-Reply-To: <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140109103515.164af26c@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Yuan Yao wrote:
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  17 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 434 +++++++++++++++++----
>  2 files changed, 365 insertions(+), 86 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..311598d 100644
> +static int lpuart_dma_tx(struct lpuart_port *sport, unsigned long count)
[...]
>  {
> -	struct lpuart_port *sport = dev_id;
> -	unsigned int flg, ignored = 0;
> -	struct tty_port *port = &sport->port.state->port;
> -	unsigned long flags;
> -	unsigned char rx, sr;
> +	struct circ_buf *xmit = &sport->port.state->xmit;
> +	dma_addr_t tx_bus_addr;
> +
> +	dma_sync_single_for_device(sport->port.dev, sport->dma_tx_buf_bus,
> +				UART_XMIT_SIZE, DMA_TO_DEVICE);
> +	sport->dma_tx_bytes = count & ~(DMA_TX_MAXBURST_MASK);
> +	tx_bus_addr = sport->dma_tx_buf_bus + xmit->tail;
> +	sport->dma_tx_desc = dmaengine_prep_slave_single(sport->dma_tx_chan,
> +					tx_bus_addr, sport->dma_tx_bytes,
> +					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
> +
> +	if (!sport->dma_tx_desc) {
> +		dev_err(sport->port.dev, "Not able to get desc for Tx\n");
s/Not able/unable/
Also the capitalization of 'Tx' looks strange. IMO 'TX' or 'tx' would
look better.

> +		return -EIO;
> +	}
>  
> -	spin_lock_irqsave(&sport->port.lock, flags);
> +	sport->dma_tx_desc->callback = lpuart_dma_tx_complete;
> +	sport->dma_tx_desc->callback_param = sport;
> +	sport->dma_tx_in_progress = 1;
> +	sport->dma_tx_cookie = dmaengine_submit(sport->dma_tx_desc);
> +	dma_async_issue_pending(sport->dma_tx_chan);
>  
> -	while (!(readb(sport->port.membase + UARTSFIFO) & UARTSFIFO_RXEMPT)) {
> -		flg = TTY_NORMAL;
> -		sport->port.icount.rx++;
> -		/*
> -		 * to clear the FE, OR, NF, FE, PE flags,
> -		 * read SR1 then read DR
> -		 */
> -		sr = readb(sport->port.membase + UARTSR1);
> -		rx = readb(sport->port.membase + UARTDR);
> +	return 0;
> +}
>  
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> -			continue;
> +static int lpuart_dma_rx(struct lpuart_port *sport)
> +{
> +	dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
> +			DMA_RX_BUFFER_SIZE, DMA_TO_DEVICE);
>
dma_alloc_coherent() (which you use to allocate the DMA rx buffer) and
dma_symc_*() are orthogonal to each other!
You either allocate DMA coherent memory as DMA buffer or use ordinary
memory with the DMA streaming API (dma_map_*(), dma_sync_*()).
See Documentation/DMA-API-HOWTO.txt

> +	sport->dma_rx_desc = dmaengine_prep_slave_single(sport->dma_rx_chan,
> +			sport->dma_rx_buf_bus, DMA_RX_BUFFER_SIZE,
> +			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +
> +	if (!sport->dma_rx_desc) {
> +		dev_err(sport->port.dev, "Not able to get desc for Rx\n");
>
Strange capitalization of 'Rx'.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
