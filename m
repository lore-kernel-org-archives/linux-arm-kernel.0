From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 15:23:24 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer
In-Reply-To: <20110519124454.GC2219@pengutronix.de>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
	<20110519124454.GC2219@pengutronix.de>
Message-ID: <BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 2:44 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Hi,
>
>> - ? ? ? ? ? ? /* FIXME: insert a timeout so we don't hang here indefinitely */
>> - ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
>> +
>> + ? ? ? ? ? ? timeout = jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
>
> Won't you miss the transfer if you get interrupted here longer than
> SPI_POLLING_TIMEOUT?

Yeah... preempted for a second hm.

>> + ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
>> + ? ? ? ? ? ? ? ? ? ? if (time_after(jiffies, timeout)) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_warn(&pl022->adev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "%s: timeout!\n", __func__);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? message->state = STATE_ERROR;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto out;
>> + ? ? ? ? ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? ? ? ? ? readwriter(pl022);
>> + ? ? ? ? ? ? }

What about we move readerwriter() above if (time_after...) then it atleast
gets one chance to run even if we're preempted for 10 seconds.

Any other design patterns that'd be better?

Yours,
Linus Walleij
