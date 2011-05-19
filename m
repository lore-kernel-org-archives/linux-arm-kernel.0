From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 19:36:23 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
In-Reply-To: <BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
Message-ID: <BANLkTi=mQbPt9rcqEVyMLy3rkF2D7FMh=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/19 Vitaly Wool <vitalywool@gmail.com>:

>> +
>> + ? ? ? ? ? ? ? timeout = jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
>> + ? ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
>> + ? ? ? ? ? ? ? ? ? ? ? time = jiffies;
>> ? ? ? ? ? ? ? ? ? ? ? ?readwriter(pl022);
>> + ? ? ? ? ? ? ? ? ? ? ? if (time_after(time, timeout)) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_warn(&pl022->adev->dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "%s: timeout!\n", __func__);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? message->state = STATE_ERROR;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto out;
>> + ? ? ? ? ? ? ? ? ? ? ? }
>> + ? ? ? ? ? ? ? }
>
> just out of curiosity: is it a busy wait? Looks like it is...

Yep that's the polling mode part. IRQ and DMA mode should
be the norm I guess.

Magnus: do you have a specific use case for this thing?

Yours,
Linus Walleij
