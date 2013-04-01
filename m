From: tpiepho@gmail.com (Trent Piepho)
Date: Mon, 1 Apr 2013 16:27:41 -0700
Subject: [PATCH 2/5] spi/mxs: Fix chip select control bits in DMA mode
In-Reply-To: <201304020113.42124.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <1364570381-17605-2-git-send-email-tpiepho@gmail.com>
 <201304020113.42124.marex@denx.de>
Message-ID: <CA+7tXih2wAVeLpVoYkt4Tmo3h0YtLoZY3vCcv5s8sUD1u8_BVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 1, 2013 at 4:13 PM, Marek Vasut <marex@denx.de> wrote:
>>
>> Change the code to set the CS bits in the message transfer function
>> once.  Now the DMA and PIO txrx functions don't need to care about CS
>> at all.
>
> Ok, lemme ask this one more time -- will the DMA work with long transfers where
> the CTRL0 will be overwritten on each turn? Did you actually test this?

I don't have SPI flash, so I can't test SPI flash.  I can test other
spi devices and by capturing the pins with  a logic analyzer.  It does
work after the patch, and does not work before the patch.  The error
should be obvious from looking at the code.

ctrl0 is not overwritten, from scratch, each on transfer.  The ctrl0
value in the PIO part of the DMA is based on the current value of
ctrl0 with additional bits ORed in.   The flaw here is that bits that
should not be set are not masked out.

>>
>> -static uint32_t mxs_spi_cs_to_reg(unsigned cs)
>> +static u32 mxs_spi_cs_to_reg(unsigned cs)
>>  {
>> -     uint32_t select = 0;
>> +     u32 select = 0;

I'll make it a separate patch.
