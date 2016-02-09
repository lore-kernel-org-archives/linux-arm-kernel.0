From: eric@anholt.net (Eric Anholt)
Date: Tue, 09 Feb 2016 15:45:32 -0800
Subject: [PATCH 2/4] spi: bcm2835aux: disable tx fifo empty irq
In-Reply-To: <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-3-git-send-email-stephanolbrich@gmx.de>
Message-ID: <87io1x4fdv.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stephanolbrich at gmx.de writes:

> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> The tx empty irq can be disabled when all data was copied.
> This prevents unnecessary interrupts while the last bytes are sent.
>
> Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
> ---
>  drivers/spi/spi-bcm2835aux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index ecc73c0..d2f0067 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -212,6 +212,12 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
>  		ret = IRQ_HANDLED;
>  	}
>  
> +	if (!bs->tx_len) {
> +		/* disable tx fifo empty interrupt */
> +		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1] |
> +			BCM2835_AUX_SPI_CNTL1_IDLE);
> +	}
> +
>  	/* and if rx_len is 0 then wake up completion and disable spi */
>  	if (!bs->rx_len) {
>  		bcm2835aux_spi_reset_hw(bs);
> -- 
> 2.5.0

Right, we don't want to come back in here with a spurious TX empty
interrupt while we wait for the RX bits to trickle in through the FIFO.
I'm having a hard time reasoning through how likely this would be, but
it seems like a good change.

Reviewed-by: Eric Anholt <eric@anholt.net>

Aside: I think I see a problem that we reset the hardware before it has
asserted SPI_STAT_BUSY, since we reset as soon as we've collected our RX
data (!bs->rx_len).  That means we've potentially missed the trailing
hold time on CS at the end of the transfer, and it's going to resume at
the same point in its state machine when we reassert CNTL0_ENABLE for
the next transfer.  That doesn't seem like what we want.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/dc3a5fe5/attachment.sig>
