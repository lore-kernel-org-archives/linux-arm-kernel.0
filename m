From: eric@anholt.net (Eric Anholt)
Date: Tue, 09 Feb 2016 15:49:24 -0800
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
In-Reply-To: <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
Message-ID: <87d1s54f7f.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stephanolbrich at gmx.de writes:

> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> When using reverse polarity for clock (spi-cpol) on a device
> the clock line gets altered after chip-select has been asserted
> resulting in an additional clock beat, which confuses hardware.
>
> To avoid this situation this patch moves the setup of polarity
> (spi-cpol and spi-cpha) outside of the chip-select into
> prepare_message, which is run prior to asserting chip-select.

This patch surprised me.  I would have thought that the solution was to
just write the updated CNTL bits for CPOL and wait a moment whenever it
changes.  The CS only gets asserted later on when we get some data in
the TX FIFO, so I think you're just reducing the chance of losing the
race to get our inverted clock noticed by the device before the CS gets
asserted.

If we're only talking to a device that does an inverted clock, it seems
silly that we're resetting the hardware back to non-inverted clock after
every transfer/message.

I'd be OK with the patch anyway, since you reduce the number of resets
for a multi-transfer message, except for what I think is bug...

> Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
> ---
>  drivers/spi/spi-bcm2835aux.c | 54 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index d2f0067..b90aa34 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c    
> @@ -218,9 +218,9 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
>  			BCM2835_AUX_SPI_CNTL1_IDLE);
>  	}
>  
> -	/* and if rx_len is 0 then wake up completion and disable spi */
> +	/* and if rx_len is 0 then disable interrupts and wake up completion */
>  	if (!bs->rx_len) {
> -		bcm2835aux_spi_reset_hw(bs);
> +		bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>  		complete(&master->xfer_completion);
>  	}
>  
> @@ -313,9 +313,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
>  		}
>  	}
>  
> -	/* Transfer complete - reset SPI HW */
> -	bcm2835aux_spi_reset_hw(bs);
> -
>  	/* and return without waiting for completion */
>  	return 0;
>  }
> @@ -336,10 +333,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
>  	 * resulting (potentially) in more interrupts when transferring
>  	 * more than 12 bytes
>  	 */
> -	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
> -		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
> -		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
> -	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>  
>  	/* set clock */
>  	spi_hz = tfr->speed_hz;

Just below this block, we update cntl[0] with the transfer's speed bits,
so now that you're not resetting cntl[0] on each transfer, their speeds
will all get ORed all together by the end.  I think you could just mask
out the max speed before setting the new one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/014504fd/attachment.sig>
