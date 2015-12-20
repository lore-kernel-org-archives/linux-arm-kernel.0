From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sun, 20 Dec 2015 13:47:43 +0100
Subject: [PATCH v5 2/2] spi: sun4i: Add support for wait time between word
 transmissions
In-Reply-To: <20151218111627.GM30359@lukather>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
 <1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
 <20151218111627.GM30359@lukather>
Message-ID: <CAGNoLaOf6ZDxi+skRKc6gQKzAJot=fvvX91xx+H3c4ni9P-gdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2015-12-18 12:16 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:

>>       sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
>>
>> +     /*
>> +      * Setup wait time between words.
>> +      *
>> +      * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
>> +      * additional cycles to setup the wait counter, so the minimum delay
>> +      * time is 4 cycles.
>> +      */
>> +     if (spi->word_wait_ns) {
>> +             clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
>
> You should use the actual rate of the clock returned by clk_get_rate
> (or probably just use mclk_rate).
>
> The clock driver might round the frequency to something else than what
> was set in clk_set_rate, which would make your calculation here a bit
> off.

Yes, good point! And as the wait clock counter is based on the actual
SPI_CLK and not the mod clock, I need to calculate the exact clock
myself before handling the wait clock setting. Will amend the patch
and send a new version.

While looking into this, I also noticed a problem with a previous
patch of mine, which changed the spi-sun[46]i to use
transfer->speed_hz instead of the spi->max_speed_hz: I also changed
the mclk_rate calculation to be based on tfr->speed_hz, which should
have stayed with spi->max_speed_hz. In the current state, the clock
calculations only ever increase mclk_rate, wich leads to very
different clocks being set depending on which clock was used on the
previous transfer. Will send a fix for that as well in a separate
patch.

Cheers,

   Marcus
