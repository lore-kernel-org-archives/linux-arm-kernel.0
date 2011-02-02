From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Feb 2011 10:39:48 +0100
Subject: [PATCH] mmci: restrict DMA usage to large,
	even multiblock transfers
In-Reply-To: <20110201144437.GL31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
	<20110201115832.GF31216@n2100.arm.linux.org.uk>
	<AANLkTimN=bxJzGFDc50-ZUMmCtXaGxVUd9-Zg1+QGfNf@mail.gmail.com>
	<20110201144437.GL31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinB4Ca9UtDhorC+rDHuSFQLV_B6YH0H5zFw7GnO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Feb 01, 2011 at 03:07:12PM +0100, Linus Walleij wrote:
>> However I think this weird bit turning off all single requests
>> is there for some reason and I still try to find out what the
>> usecase really is. I highly suspect that it's related to either
>> doing some SDIO usecase or pleasing some buggy DMA
>> controller.
>
> We aren't turning off single requests - by clearing DMAREQCTL, we're
> actually turning them back on.

Yes that's what I meant, sorry for the confusion.

> What I think is going on is someone had an idea of using LBREQ to
> transfer the last one to seven transfers as a burst, rather than one
> to seven separate single transfers as an optimization. ?However, this
> can only work if the DMA controller obeys the transfer count and doesn't
> try to transfer more than the remainder of the transfer in any burst.
> IOW, the DMAC has to truncate bursts to the smaller of the burst size
> and remainder. ?If it can't, DMAREQCTL causes problems.

Seems plausible. I'll try to look into it.

> I assume that the U8500/U300 documentation isn't publically available...
> A quick google doesn't seem to help.

In this case it doesn't help... U300 does not have this peculiar
feature BTW, it's a pure ux500 thing.

If it gives clear performance improvements (need measurements)
we can always patch it in later. For now much is already achieved
by this patch.

Yours,
Linus Walleij
