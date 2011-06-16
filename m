From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 16 Jun 2011 17:44:16 +0800
Subject: Slow spi_sync() on pxa2xx_spi
In-Reply-To: <20110616091931.GB10075@excalibur.local>
References: <20110616082112.GA10075@excalibur.local>
	<BANLkTikuo_fHbw9FFMtorpg15vOnXMK-+g@mail.gmail.com>
	<20110616091931.GB10075@excalibur.local>
Message-ID: <BANLkTinU+chEbZRpFSdRH_dPE2vhK_7pHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 5:19 PM, Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> Hello.
>
> On Thu, 2011-06-16 at 16:34, Eric Miao wrote:
>> On Thu, Jun 16, 2011 at 4:21 PM, Stefan Schmidt
>> <stefan@datenfreihafen.org> wrote:
>> > Hello.
>> >
>> > I'm working on the Imote2 (pxa27x based) platform [1] which includes a
>> > radio chip (cc2420, IEEE 802.15.4) connected over SPI [2].
>> >
>> > The problem I'm facing is that the spi_sync() call of the driver to
>> > write/read from the registers over the SPI bus takes up to 26 milli
>> > seconds. The minimum I measured was 500 micro seconds for the call.
>> >
>> > That creates a problem as the workflow to send a frame over the radio
>> > includes to write to a spi register for sending out the frame from a
>> > pre-filled FIFO. Then wait up to 320 micro seconds for a GPIO to raise
>> > and polling a status register until a TX_ACTIVE bit is no longer set
>> > afterwards.
>> >
>> > But the first register write to initiate the sending already takes so
>> > long that the GPIO is already low again and the TX_ACTIVE is also gone
>> > when I come back from the spi_sync() call.
>> >
>> > It really smells like I'm doing something seriously wrong here. For
>> > the pxa2xx_spi driver I already tried various options without any
>> > difference I could see. Enable/disbale DMA, different tx/rx
>> > thresholds, different dma burst sizes, different timeout, etc.
>> >
>> > I can only explain the long time with some sleeping in SPI while
>> > other parts are scheduled. Is there a way to avoid this for SPI? Or
>> > is there an API I did not found yet to cover my needs?
>> >
>> > The measurement is done with getnstimeofday btw and I verified that a
>> > basic operation like two multiplications are down in the 5 micro
>> > seconds area which gives me faith that the measurements should be
>> > correct:
>> >
>> > getnstimeofday (&before);
>> > ret = spi_sync(lp->spi, &msg);
>> > getnstimeofday (&after);
>> >
>> > result = timespec_sub(after, before);
>> > printk("Strobe time: %lu secs and %lu nsecs (strobe %i)\n", (long)result.tv_sec, result.tv_nsec, addr);
>> >
>> > I'm out of ideas what to change here. The only option, I want to
>> > avoid, is trying to drive the SPI pins manually and see if I have
>> > better results with bit-banging it myself.
>>
>> What is the SPI frequency?
>
> I tried various settings in .max_speed_hz from the original 6.6 MHt to
> 10 MHz and 13MHz as maximum of the controller. Did also not change
> anything for me.
>
> That reminds me that after defining DEBUG in pxa2xx_spi it did always
> report 13MHz to me. Need to have a look at it.
>
>> For PIO, the transfer actually happens in the interrupt handler so it's
>> supposed to be fast (did you enable threaded IRQ by the way?).
>
> You mean with request_threaded_irq()? (Seems there is no config option
> for it) No, I'm not using it neither did I modify the pxa2xx_spi
> driver to use it.
>
> Thanks for the informations about PIO happen in the interrupt handler.
> We already suspected that DMA might come with some overhead and for
> our smallish register access we did not need it. Sadly .enable_dma = 0
> did not make any difference. Will have another look into this.
>
> I'm on 2.6.38 here btw. But the pxa2xx_spi driver did not get mayn
> updates since then. The only commit that may be interested ?is this
> one:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=850a28ecd8044ef36b2c7699d2e3736a410b4d0a
>
>> And since the transfer happens on message base, what is the size
>> of each of your message? And if it could be enlarged to big blocks.
>
> Its either 8bit or 16bit for a message. The mentioned problem happens
> on a 8 bit message. It does nothing else then writing to a defined
> register address to trigger the hardware sending the data in the FIFO.

This might get too much overhead. I didn't check the source code, but
my guess is it's waiting for interrupt for each message, and once the
interrupt of message being flushed out happens, it starts the next one
waiting for the FIFO empty interrupt coming. Did you try stuff more
bytes into a single message?

>
> The FIFO reading and writing has no time critical elements here and
> gets pre-filled.
>
> regards
> Stefan Schmidt
>
