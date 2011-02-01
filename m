From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Feb 2011 15:07:12 +0100
Subject: [PATCH] mmci: restrict DMA usage to large,
	even multiblock transfers
In-Reply-To: <20110201115832.GF31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
	<20110201115832.GF31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimN=bxJzGFDc50-ZUMmCtXaGxVUd9-Zg1+QGfNf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> So... I think this patch will work fine on ST variants, returning the
> DMA request signals back to their classic meaning. ?That being LSREQ
> is only activated on the _final_ transfer rather than the last 8
> transfers, which as Linus describes makes your DMA controller complete
> on the 8th-to-last transfer.

I've tested this patch on MMC and SD on U8500 and it works
fine, so
Tested-by: Linus Walleij <linus.walleij@linaro.org>

However I think this weird bit turning off all single requests
is there for some reason and I still try to find out what the
usecase really is. I highly suspect that it's related to either
doing some SDIO usecase or pleasing some buggy DMA
controller.

Having it deactivated most likely works for all MMC/SD cards
and then we have to think about having (ST-Specific)
if (mmc_card_sdio()) clauses for SDIO usecases, which we
can defer until we know what's going on.

Yours,
Linus Walleij
