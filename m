From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 21 Apr 2010 12:08:24 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100421063712.GJ19534@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D85BCCC@AUSP01VMBX24.collaborationhost.net>
	<20100421063712.GJ19534@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D8C8544@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 20, 2010 11:37 PM, Mika Westerberg wrote:
> On Tue, Apr 20, 2010 at 05:16:10PM -0500, H Hartley Sweeten wrote:
>> On Tuesday, April 20, 2010 8:12 AM, Mika Westerberg wrote:
>>>
>>> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>>> in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
>>> 
>>> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>> 
>> Mika,
>> 
>> I discovered one gotcha with this driver.  Bear with me through this...
>> 
>> 1. ep93xx_spi_process_message is called by the workqueue worker function to handle
>>    a spi_message queued in by the ep93xx_spi_transfer function.  Before starting
>>    the actual transfer the chip select to the device is asserted.
>> 2. ep93xx_spi_process_transfer processes each transfer in the spi_message, one at a
>>    time, and does a wait_for_completion on each transfer.
>> 3. When the entire spi_message has been transferred the chip select to the device
>>    is deasserted.
>
> Yes. There is possibility that last transfer ->cs_change is set which can be used
> by SPI controller drivers to keep the chip selected in case next message is going
> to the same device.
>
> However, I haven't implemented that as it is optional (but trivial to add afterwards).

It should be implemented.  The mmc_spi driver basically requires this.  Refer to this
comment in the mmc_spi driver:

 * - We tell the controller to keep the chipselect active from the
 *   beginning of an mmc_host_ops.request until the end.  So beware
 *   of SPI controller drivers that mis-handle the cs_change flag!
 *
 *   However, many cards seem OK with chipselect flapping up/down
 *   during that time ... at least on unshared bus segments.

>> The problem is if a hardware design uses the SFRM1 pin as part of the chip select
>> logic.  The EP93xx User's Guide states that "the SFRMOUT signal behaves as a slave
>> Select" in Motorola SPI mode.  This signal behaves differently depending on the
>> SPI_MODE_* used.
>> 
>> Modes 0 and 2:
>>   SFRMOUT is forced HIGH during idle periods.
>>   Start of transmission, SFRMOUT is driven LOW.
>>   Single word transmission, SFRMOUT is returned to its idle HIGH state one
>>     SCLKOUT period after the last bit has been captured.
>>   Back-to-back transmissions, SFRMOUT signal is pulsed HIGH between each
>>     data word transfer.  On completion the SFRMOUT pin returns to its idle
>>     HIGH state one SCLKOUT period after the last bit has been captured.
>> 
>> Modes 1 and 3:
>>   SFRMOUT is forced HIGH during idle periods.
>>   Start of transmission, SFRMOUT is driven LOW.
>>   Single word transmission, SFRMOUT is returned to its idle HIGH state one
>>     SCLKOUT period after the last bit has been captured.
>>   Back-to-back transmissions, SFRMOUT signal is held LOW between each
>>     data word transfer.  On completion the SFRMOUT pin returns to its idle
>>     HIGH state one SCLKOUT period after the last bit has been captured.
>> 
>> So, since each transfer does a wait_for_completion, all the data is transmitted
>> which causes the SFRMOUT pin to go HIGH between each transfer in the message.
>
> Yes, unfortunately. SFRMOUT cannot be software controlled so it is
> not suitable for general purpose chipselect. This was the sole
> purpose of using GPIO lines for chipselects.

I agree.  But existing ep93xx designs, the EDB93xx boards and Sim.One for
instance, use the SFRMOUT either directly for the chip select or as part of
the logic generating the chip select.  If possible it would be nice to handle
this.

>> For devices like the sst25lf040a SPI Flash on the EDB93xx boards this causes a
>> problem.  To read data from that device you need to send a two part message.  The
>> first part is a write transfer with the one byte command and three byte address.
>> This is then followed by a read transfer to get the data.  But since the SFRMOUT
>> pin goes high this ends the command.>
>> 
>> The driver Ryan and I worked on actually does work with the sst25lf040a on the
>> EDB93xx boards.  But now that I know what the issue is, it was actually a race
>> condition.  Sometimes it worked and sometimes it didn't...
>> 
>> I would think the Sim.One board (Martin?) would have the same issue with the mmc
>> card since that design uses the SFRMOUT pin directly for the chip select.
>> 
>> Is there anyway to keep the transfers going in a muiltipart message?
>
> I'm not exactly sure but "polling" mode sounds something that could
> work around that. It just need to be sure that it transmits
> continuously to keep the SFRMOUT asserted.
>
> You could try v3 of the driver with:
>	# modprobe ep93xx-spi transfer_method=0
>
> and see if it works there.

I'll try to test this later.  The driver Ryan and I had used polling and it
worked but I think there was a race condition in it which occasionally broke
the transfer.

> An alternative would be that interrupt handler schedules tasklet which then
> takes next transfer immediately once current transfer is finished.

I think you would need to:

1. detect when all the transmit data in a transfer has been sent to the fifo
2. if there is another transfer pending, and a cs_change has not been requested,
   get it and start pumping it's transmit data into the fifo
3. read the remaining data for the first transfer then complete it
4. the pending transfer, which is already started, becomes the current transfer

Does this sound reasonable?

Regards,
Hartley
