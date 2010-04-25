From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sun, 25 Apr 2010 14:55:08 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <p2h56d259a01004241114qb1b1815em9657e5a857a9d4ee@mail.gmail.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<p2h56d259a01004241114qb1b1815em9657e5a857a9d4ee@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D9B7E4F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 24, 2010 11:15 AM, Martin Guy wrote:
> Hi, another little fix:
> 
> EP93xx User's Manual -> Synchronous Serial Port -> Registers
> 
> SSPIIR description:
> "Read Only
> Note: A write to this register clears the receive overrun interrupt,
> regardless of the data
>       value written."
> 
> It doesn't affect the RIS/TIS ones, which are caused by the state of the device.
> 
> so
> 
> static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
> {
> ...
>         if (!(irq_status & (SSPIIR_RORIS | SSPIIR_TIS | SSPIIR_RIS)))
>                 return IRQ_NONE; /* not for us */
> 
> -       /* clear the interrupt */
> -       ep93xx_spi_write_u8(espi, SSPICR, 0);
> 
>         /*
>          * If we got ROR (receive overrun) interrupt we know that something is
>          * wrong. Just abort the message.
>          */
>         if (unlikely(irq_status & SSPIIR_RORIS)) {
> +               /* clear the overrun interrupt */
> +               ep93xx_spi_write_u8(espi, SSPICR, 0);
>                 dev_warn(&espi->pdev->dev,
>                          "receive overrun, aborting the message\n");
>                 espi->current_msg->status = -EIO;
>         } else {

With this patch the interrupts only get cleared if it's a ROR interrupt.

Do the RIS/TIS interrupts get cleared by the upper layers?  If so, do we
really need to clear the ROR interrupt here?

Regards,
Hartley
