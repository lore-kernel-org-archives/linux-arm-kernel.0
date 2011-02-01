From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 14:44:37 +0000
Subject: [PATCH] mmci: restrict DMA usage to large, even multiblock
	transfers
In-Reply-To: <AANLkTimN=bxJzGFDc50-ZUMmCtXaGxVUd9-Zg1+QGfNf@mail.gmail.com>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
	<20110201115832.GF31216@n2100.arm.linux.org.uk>
	<AANLkTimN=bxJzGFDc50-ZUMmCtXaGxVUd9-Zg1+QGfNf@mail.gmail.com>
Message-ID: <20110201144437.GL31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 03:07:12PM +0100, Linus Walleij wrote:
> 2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > So... I think this patch will work fine on ST variants, returning the
> > DMA request signals back to their classic meaning. ?That being LSREQ
> > is only activated on the _final_ transfer rather than the last 8
> > transfers, which as Linus describes makes your DMA controller complete
> > on the 8th-to-last transfer.
> 
> I've tested this patch on MMC and SD on U8500 and it works
> fine, so
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> However I think this weird bit turning off all single requests
> is there for some reason and I still try to find out what the
> usecase really is. I highly suspect that it's related to either
> doing some SDIO usecase or pleasing some buggy DMA
> controller.

We aren't turning off single requests - by clearing DMAREQCTL, we're
actually turning them back on.

What I think is going on is someone had an idea of using LBREQ to
transfer the last one to seven transfers as a burst, rather than one
to seven separate single transfers as an optimization.  However, this
can only work if the DMA controller obeys the transfer count and doesn't
try to transfer more than the remainder of the transfer in any burst.
IOW, the DMAC has to truncate bursts to the smaller of the burst size
and remainder.  If it can't, DMAREQCTL causes problems.

I assume that the U8500/U300 documentation isn't publically available...
A quick google doesn't seem to help.
