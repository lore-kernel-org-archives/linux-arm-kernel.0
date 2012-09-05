From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Sep 2012 03:46:39 +0200
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <20120905014000.GP2362@S2101-09.ap.freescale.net>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
 <20120905014000.GP2362@S2101-09.ap.freescale.net>
Message-ID: <201209050346.39253.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Sep 04, 2012 at 06:04:25AM +0200, Marek Vasut wrote:
> > In case of a large SPI flash, the amount of DMA descriptors
> > available to the DMA driver is not large enough anymore. For
> > example 8MB SPI flash now needs 129 descriptors to be transfered
> > in one long read. There are currently 53 descriptors available in
> > one PAGE_SIZE-big block. Enlarge the allocated descriptor area to
> > four PAGE_SIZE blocks to fulfill such requirements.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Vinod (copied) is the primary maintainer and collecting dma patches now.

Understood.

Let me ask about another thing. If there'll eventually be some device that'd 
need even larger transfer (say ... hundreds of megs) we'd end up with trouble 
again.

One way to fix this is to recycle descriptors that were already used during the 
transfer, but can we really do it fast enough, so the DMA would do it's job at 
one end of the descriptor chain and we'd be building the other?

The other (easier) way is to let the device that claims the particular DMA 
channel allocate as much descriptors as it might ever need, which I think is 
wrong.

What do you think ?

Best regards,
Marek Vasut
