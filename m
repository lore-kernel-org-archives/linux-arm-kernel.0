From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Nov 2013 18:00:12 +0100
Subject: [PATCH 3/3] serial: mxs-auart: move irq handling to a tasklet
In-Reply-To: <1385742927-11358-4-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
 <1385742927-11358-4-git-send-email-hector.palacios@digi.com>
Message-ID: <201311291800.12366.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hector Palacios,

> The ISR was handling CTS flag and RX/TX processing.
> Occasionally interrupts were coming in the middle of the ISR and
> led to blocking transmission (with hw flow) or loss of data.
> This patch moves this processing to a tasklet that the ISR schedules.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 61
> +++++++++++++++++++++++++++--------------- 1 file changed, 39
> insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c
> b/drivers/tty/serial/mxs-auart.c index e5540c89dd48..7021269c70b2 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -148,6 +148,10 @@ struct mxs_auart_port {
>  	struct clk *clk;
>  	struct device *dev;
> 
> +	struct tasklet_struct tasklet;
> +	unsigned int irq_status;
> +	unsigned int status;
> +
>  	/* for DMA */
>  	struct scatterlist tx_sgl;
>  	struct dma_chan	*tx_dma_chan;
> @@ -680,38 +684,48 @@ static void mxs_auart_settermios(struct uart_port *u,
>  	}
>  }
> 
> +/*
> + * tasklet handling tty stuff outside the interrupt handler.
> + */
> +static void mxs_auart_tasklet_func(unsigned long data)
> +{
> +	struct uart_port *port = (struct uart_port *)data;
> +	struct mxs_auart_port *s = to_auart_port(port);
> +
> +	/* Handle status irq */
> +	if (s->irq_status & AUART_INTR_CTSMIS) {
> +		uart_handle_cts_change(&s->port, s->status & AUART_STAT_CTS);
> +		writel(AUART_INTR_CTSMIS,
> +		       s->port.membase + AUART_INTR_CLR);
> +	}
> +	/* Handle receive irq */
> +	if (s->irq_status & (AUART_INTR_RTIS | AUART_INTR_RXIS)) {
> +		if (!auart_dma_enabled(s))
> +			mxs_auart_rx_chars(s);
> +	}
> +	/* Handle transmit irq */
> +	if (s->irq_status & AUART_INTR_TXIS)
> +		mxs_auart_tx_chars(s);
> +}
> +
>  static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
>  {
> -	u32 istat;
>  	struct mxs_auart_port *s = context;
> -	u32 stat = readl(s->port.membase + AUART_STAT);
> 
> -	istat = readl(s->port.membase + AUART_INTR);
> +	s->status = readl(s->port.membase + AUART_STAT);
> +	s->irq_status = readl(s->port.membase + AUART_INTR);

Aren't you up for a nice race condition here if you get interrupt while checking 
the s->irq_status bits in the tasklet ?
