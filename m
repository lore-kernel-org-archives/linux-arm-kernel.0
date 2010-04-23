From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 23 Apr 2010 12:24:03 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100423052003.GF26418@gw.healthdatacare.com>
References: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<z2h56d259a01004201654y93f6c533j11b5accd7e2f46e7@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BDD8@AUSP01VMBX24.collaborationhost.net>
	<n2u56d259a01004201810j22c17bcfn9fee59e9c65c4d7f@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D85BE26@AUSP01VMBX24.collaborationhost.net>
	<20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 22, 2010 10:20 PM, Mika Westerberg wrote:
> On Thu, Apr 22, 2010 at 03:43:24PM -0500, H Hartley Sweeten wrote:
>> On Thursday, April 22, 2010 10:55 AM, Mika Westerberg wrote:
>>> Could you test this in your setup?
>> 
>> Same results.
>
> OK. thanks for testing.
>
>> I hacked your driver to allow me to toggle a gpio when the interrupt routine
>> starts and exits.
>> 
>> I captured the 4 byte write/2 byte read caused by the spi_write_then_read in
>> the sst25l driver when it does the Read-ID command.  The chip select goes low
>> followed by the first 4 byte transfer of the message due to the fifo's getting
>> primed.  This transfer actually doesn't finish since the rx data has not been
>> received.  So the interrupts just get enabled as normal.
>> 
>> The data starts transferring when the first byte is placed in the tx fifo.  It
>> takes about 4.45us to send/receive the 4 bytes.  Approximately 15.9us after the
>> last byte has been received the interrupt routine starts.  It then takes about
>> 5.7us for the second 2 byte transfer to start.  So there is a total of about
>> 21.6us between the two transfers where SFRM is deasserted.
>
> If I understand this correctly, for this particular message it might have worked if
> the priming is not done? What I mean is that if we start the transfer in interrupt
> handler and after the transfer is finished, immediately continue with the next one
> (like in the patch) could it make SFRM to stay asserted (at least shorten the gap)?

Hmmm.. It might have.  I didn't test that before I started hacking...

>>>  /*
>>>   * ep93xx_spi_process_message() - process one SPI message
>>>   * @espi: ep93xx SPI controller struct
>>> @@ -569,6 +669,8 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
>>>  	struct spi_transfer *t;
>>>  	int err;
>>>  
>>> +	espi->continuous = (bool)msg->state;
>>> +
>>>  	/*
>>>  	 * Enable the SPI controller and its clock.
>>>  	 */
>>> @@ -606,12 +708,43 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
>>>  	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
>>>  	ep93xx_spi_select_device(espi, msg->spi);
>>>  
>>> -	list_for_each_entry(t, &msg->transfers, transfer_list) {
>>> -		ep93xx_spi_process_transfer(espi, msg, t);
>>> -		if (msg->status)
>>> -			break;
>>> +	if (espi->continuous) {
>>> +		/*
>>> +		 * We can transfer all the transfers continuously.
>>> +		 */
>>> +		espi->rx = 0;
>>> +		espi->tx = 0;
>>> +		msg->state = list_first_entry(&msg->transfers, struct spi_transfer,
>>> +					transfer_list);
>>> +
>>> +		/* prime the first transfer */
>>> +		if (ep93xx_spi_read_write(espi)) {
>> 
>> On the first read/write for a transfer this condition can never succeed.
>> 
>> The ep93xx_spi_read_write function first empties the rx fifo then fills the
>> tx fifo.  Putting any data in the tx fifo means that you are going to have to
>> come back to empty the rx fifo.
>> 
>> So, the block below never executes.
>
> I also figured that out after I sent the hack to you...
>
>>> +			/*
>>> +			 * Transfer was completed. Pick next one and continue
>>> +			 * if necessary.
>>> +			 */
>>> +			t = msg->state;
>>> +			if (list_is_last(&t->transfer_list, &msg->transfers))
>>> +				goto done;
>>> +
>>> +			espi->rx = 0;
>>> +			espi->tx = 0;
>>> +			msg->state = list_entry(t->transfer_list.next,
>>> +						struct spi_transfer,
>>> +						transfer_list);
>>> +		}
>>> +
>>> +		ep93xx_spi_enable_interrupts(espi);
>>> +		wait_for_completion(&espi->wait);
>> 
>> Even if the first read/write did succeed you are not starting the second transfer.
>> This is just passing the operation off to the interrupt routine using the second
>> transfer in the message.
>
> Right.
>
>>> -/**
>>>   * ep93xx_spi_interrupt() - SPI interrupt handler
>>>   * @irq: IRQ number (not used)
>>>   * @dev_id: pointer to EP93xx controller struct
>>> @@ -792,6 +841,27 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
>>>  			 * interrupt then.
>>>  			 */
>>>  			return IRQ_HANDLED;
>>> +		} else {
>>> +			struct spi_message *msg = espi->current_msg;
>>> +			struct spi_transfer *t = msg->state;
>>> +
>>> +			if (!espi->continuous)
>>> +				goto done;
>>> +
>>> +			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
>>> +				/*
>>> +				 * Pick next transfer and refill the FIFO.
>>> +				 */
>>> +				msg->state = list_entry(t->transfer_list.next,
>>> +							struct spi_transfer,
>>> +							transfer_list);
>>> +				espi->rx = 0;
>>> +				espi->tx = 0;
>>> +
>>> +				ep93xx_spi_read_write(espi);
>>> +				return IRQ_HANDLED;
>>> +			}
>>
>> Here the N transfer has been completed and we are trying to continue with the N+1
>> transfer.  This should work but I need to figure out a way to capture it with my
>> logic analyzer.  The only problem is if the N transfer is complete that means the
>> tx and rx fifos are empty so the SFRM signal is going to be deasserted.  The N+1
>> transfer might start really soon after but there will still be a glitch in the SFRM
>> signal.
>
> It would be great if you manage to capture it with the logic analyzer.
> Even if we get small glitch it means that we are going into right
> direction (then we just need to figure out how to keep the FIFO
> from emptying).

I still haven't been able to catch this.

> Other alternative is to use polling mode in v3 of the driver and
> see if it works better.

I think the interrupt mode is still the better way to go.

I was able to hack your driver to keep the continuous transfer going in a multi-transaction
message.  Unfortunately I don't have an easy way to generate a diff to send the necessary
patch.  The hack does work with the sst25l driver.  It correctly detects the end of the
first 4 byte transfer and immediately chains in the second 2 byte transfer.  It ends up
looking like this:

WWWWwwIRRRRFCRRFi

Where:
  'W' is a write for the current transfer
  'w' is a write for the next transfer
  'I' is the start of the interrupt
  'R' is a read for the current transfer
  'F' is the completion of the current transfer
  'C' is the chain to the next transfer
  'i' is the end of the interrupt

So, at the start of the message the fifo's get primed with the 4+2 of the entire message.
Then interrupts are enabled.  When the interrupt occurs the first 4 byte transfer is read.
When that completes the interrupt routine chains to the next transfer and then reads the
next 2 bytes.  When that completes the message is finished so the interrupts get disabled
and espi->wait is completed.

Unfortunately is seems to break the mmc_spi driver for some reason.  I still haven't
figured out why.

If you can post your latest updates to the v4 driver I will create a patch against it
so others can test this also.

Regards,
Hartley
