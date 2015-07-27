From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 27 Jul 2015 22:43:05 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <201507271943.32453.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201507241034.15406.marex@denx.de>
 <CAOMqctTsA5ZxBWFTzirqhQBoR2sO6B+uMFXWMHuSVb_EygCDvw@mail.gmail.com>
 <201507271943.32453.marex@denx.de>
Message-ID: <CAOMqctRPOv3_YZqS-g+SuuMT5UpOJMFs1OtBuZAhLR_SZnfTyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2015 at 19:43, Marek Vasut <marex@denx.de> wrote:
> On Monday, July 27, 2015 at 11:46:25 AM, Michal Suchanek wrote:
>> On 24 July 2015 at 10:34, Marek Vasut <marex@denx.de> wrote:
>> > On Thursday, July 23, 2015 at 07:03:47 PM, Michal Suchanek wrote:
>> >
>> Ok, so here is some summary.
>>
>> I have a NOR flash attached to a s3c64xx SPI controller with 64byte
>> fifo and a pl330 dma controller.
>>
>> Normally DMA controller is used for transfers that do not fit into the
>> FIFO.
>>
>> I tried adding the flash memory ID to the spi-nor driver table and
>> adding a DT node for it.
>>
>> The flash is rated at 120MHz so I used that speed but the ID was
>> bit-shifted and identification failed. There is DT property
>> samsung,spi-feedback-delay for addressing this and at 120MHz it must
>> be 2 or 3 on this board. 40MHz works with default value 0.
>>
>> The next step after identification worked was to try reading the flash
>> content. For this the DMA controller is used because data is
>> transferred in blocks larger than 64 bytes. When reading the whole 4MB
>> flash the transfer failed silently. I got a 4MB file of all ones or
>> all zeroes.
>>
>> It turns out that
>>
>>  - the pl330 locks up when transfering large amount of data.
>> Specifically, the maximum power of 2 sized transfer at 120MHz is 128
>> bytes and 64k at 40MHz. Transferring more than this results in the
>> pl330 locking up and never signalling completion of the transfer.
>
> Hypothesis:
> I think this might just be that the controller didn't catch all the
> inbound clock ticks and thus counted less inbound data than it was
> set up to receive. The controller thus waits for more data.

The flash chip can transfer data as long as you keep the clock going,
especially when you transfer 64k off a 4M flash.

The read command is bound just by stopping the clock. There is always
more data to be had.

>
>> Data
>> is left in FIFO which causes subsequent commands to fail since garbage
>> is returned instead of command reply. Also subsequent read may cause
>> I/O error or or return an empty page depending on the garbage around.
>
> So the driver for the DMA controller might need to be augmented to handle
> this case -- add a timeout and in case DMA times out, drain the FIFO to
> make sure subsequent transfers do not fail.

There is no way to add timeout in the DMA driver since it does not
know the SPI clock.

The timeout is handled by the SPI driver and it should be possible to
augment it to drain the FIFO when DMA fails so long as FIFO level is
readable somewhere.

>
>> - the I/O errors are not checked in spi-nor at all which leads to
>> silent data corruption.
>>
>> On a suggestion that this may improve reliability I changed the
>> s3c64xx driver to use DMA for all transfers. This caused
>> identification to fail in spin-nor because the ID was prefixed with
>> extra 00  byte. Testing with spidev confirmed that everything is
>> prefixed with extra 00.
>
> The determinism of this is in fact excellent news.
>
>> Also when the DMA controller locked up no
>> transfers were possible anymore. When DMA was not used for sending
>> commands the controller would recover on next command. I made the
>> option to always use DMA configurable and it turns out that the
>> returned data is prefixed with 00 only when no transfer without DMA
>> was ever made. Loading the spi-nor driver with the dma-only option off
>> and then with dma-only option on results in correct operation. Only
>> loading the dma-only driver first causes the 00 prefix.
>
> Can we conclude that the PIO codepath somehow programs a register somewhere
> which gets rid of this 0x00 prefix ? If so, this should then also be part
> of the DMA codepath, or even better, this should be set in probe() somewhere.

Yes, it looks like it.

Thanks

Michal
