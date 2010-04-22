From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 22 Apr 2010 15:43:24 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100422175503.GE26418@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 22, 2010 10:55 AM, Mika Westerberg wrote:
> On Wed, Apr 21, 2010 at 01:00:56PM -0500, H Hartley Sweeten wrote:
>>  
>> Same results are your v4 driver.  But, I think your on the right track.
>> 
>> I think the problem is in the ep93xx_spi_read_write routine.  That function
>> returns 0 as long as there is still data left in the current transfer.  The
>> only time it doesn't return 0, which will cause the can_continue, is when:
>> 
>> 	if (espi->rx == t->len) {
>> 		msg->actual_length += t->len;
>> 		return t->len;
>> 	}
>> 
>> At this point the tx and rx fifos will both be empty, which causes the SSP
>> peripheral to raise the SFRM signal.
>
> Hi again,
>
> I crafted up next hack. It includes also your priming the FIFO
> finding (thanks for that). 

Great!

> Following patch is against v4 version of the driver.
>
> It performs another read/write after given transfer is finished.
> I'm hoping that it could make it before SFRMOUT is deasserted.
> 
> Could you test this in your setup?

Same results.

I hacked your driver to allow me to toggle a gpio when the interrupt routine
starts and exits.

I captured the 4 byte write/2 byte read caused by the spi_write_then_read in
the sst25l driver when it does the Read-ID command.  The chip select goes low
followed by the first 4 byte transfer of the message due to the fifo's getting
primed.  This transfer actually doesn't finish since the rx data has not been
received.  So the interrupts just get enabled as normal.

The data starts transferring when the first byte is placed in the tx fifo.  It
takes about 4.45us to send/receive the 4 bytes.  Approximately 15.9us after the
last byte has been received the interrupt routine starts.  It then takes about
5.7us for the second 2 byte transfer to start.  So there is a total of about
21.6us between the two transfers where SFRM is deasserted.

Let me know if you want the picture posted.

[snip]

> +/**
> + * ep93xx_spi_read_write() - perform next RX/TX transfer
> + * @espi: ep93xx SPI controller struct
> + *
> + * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
> + * called several times, the whole transfer will be completed. Returns %0 when
> + * current transfer was not yet completed otherwise length of the transfer
> + * (>%0). When this function is finished, RX FIFO should be empty and TX FIFO
> + * should be full.
> + */
> +static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
> +{
> +	struct spi_message *msg = espi->current_msg;
> +	struct spi_transfer *t = msg->state;
> +
> +	/* read as long as RX FIFO has frames in it */
> +	while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)) {
> +		ep93xx_do_read(espi, t);
> +		espi->fifo_level--;
> +	}
> +
> +	/* write as long as TX FIFO has room */
> +	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
> +		ep93xx_do_write(espi, t);
> +		espi->fifo_level++;
> +	}
> +
> +	if (espi->rx == t->len) {
> +		msg->actual_length += t->len;
> +		return t->len;
> +	}
> +
> +	return 0;
> +}
> +
> +
>  /*
>   * ep93xx_spi_process_message() - process one SPI message
>   * @espi: ep93xx SPI controller struct
> @@ -569,6 +669,8 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
>  	struct spi_transfer *t;
>  	int err;
>  
> +	espi->continuous = (bool)msg->state;
> +
>  	/*
>  	 * Enable the SPI controller and its clock.
>  	 */
> @@ -606,12 +708,43 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
>  	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
>  	ep93xx_spi_select_device(espi, msg->spi);
>  
> -	list_for_each_entry(t, &msg->transfers, transfer_list) {
> -		ep93xx_spi_process_transfer(espi, msg, t);
> -		if (msg->status)
> -			break;
> +	if (espi->continuous) {
> +		/*
> +		 * We can transfer all the transfers continuously.
> +		 */
> +		espi->rx = 0;
> +		espi->tx = 0;
> +		msg->state = list_first_entry(&msg->transfers, struct spi_transfer,
> +					transfer_list);
> +
> +		/* prime the first transfer */
> +		if (ep93xx_spi_read_write(espi)) {

On the first read/write for a transfer this condition can never succeed.

The ep93xx_spi_read_write function first empties the rx fifo then fills the
tx fifo.  Putting any data in the tx fifo means that you are going to have to
come back to empty the rx fifo.

So, the block below never executes.

> +			/*
> +			 * Transfer was completed. Pick next one and continue
> +			 * if necessary.
> +			 */
> +			t = msg->state;
> +			if (list_is_last(&t->transfer_list, &msg->transfers))
> +				goto done;
> +
> +			espi->rx = 0;
> +			espi->tx = 0;
> +			msg->state = list_entry(t->transfer_list.next,
> +						struct spi_transfer,
> +						transfer_list);
> +		}
> +
> +		ep93xx_spi_enable_interrupts(espi);
> +		wait_for_completion(&espi->wait);

Even if the first read/write did succeed you are not starting the second transfer.
This is just passing the operation off to the interrupt routine using the second
transfer in the message.

[snip]

> -/**
>   * ep93xx_spi_interrupt() - SPI interrupt handler
>   * @irq: IRQ number (not used)
>   * @dev_id: pointer to EP93xx controller struct
> @@ -792,6 +841,27 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
>  			 * interrupt then.
>  			 */
>  			return IRQ_HANDLED;
> +		} else {
> +			struct spi_message *msg = espi->current_msg;
> +			struct spi_transfer *t = msg->state;
> +
> +			if (!espi->continuous)
> +				goto done;
> +
> +			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
> +				/*
> +				 * Pick next transfer and refill the FIFO.
> +				 */
> +				msg->state = list_entry(t->transfer_list.next,
> +							struct spi_transfer,
> +							transfer_list);
> +				espi->rx = 0;
> +				espi->tx = 0;
> +
> +				ep93xx_spi_read_write(espi);
> +				return IRQ_HANDLED;
> +			}

Here the N transfer has been completed and we are trying to continue with the N+1
transfer.  This should work but I need to figure out a way to capture it with my
logic analyzer.  The only problem is if the N transfer is complete that means the
tx and rx fifos are empty so the SFRM signal is going to be deasserted.  The N+1
transfer might start really soon after but there will still be a glitch in the SFRM
signal.

> +			/* we are done here */

Regards,
Hartley
