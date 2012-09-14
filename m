From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 14 Sep 2012 08:36:15 +0530
Subject: [PATCH] mxs/dma: Enlarge the CCW descriptor area to 4 pages
In-Reply-To: <201209050346.39253.marex@denx.de>
References: <1346731465-6301-1-git-send-email-marex@denx.de>
 <20120905014000.GP2362@S2101-09.ap.freescale.net>
 <201209050346.39253.marex@denx.de>
Message-ID: <1347591975.1943.12.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-05 at 03:46 +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Tue, Sep 04, 2012 at 06:04:25AM +0200, Marek Vasut wrote:
> > > In case of a large SPI flash, the amount of DMA descriptors
> > > available to the DMA driver is not large enough anymore. For
> > > example 8MB SPI flash now needs 129 descriptors to be transfered
> > > in one long read. There are currently 53 descriptors available in
> > > one PAGE_SIZE-big block. Enlarge the allocated descriptor area to
> > > four PAGE_SIZE blocks to fulfill such requirements.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Dan Williams <djbw@fb.com>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Vinod (copied) is the primary maintainer and collecting dma patches now.
> 
> Understood.
> 
> Let me ask about another thing. If there'll eventually be some device that'd 
> need even larger transfer (say ... hundreds of megs) we'd end up with trouble 
> again.
> 
> One way to fix this is to recycle descriptors that were already used during the 
> transfer, but can we really do it fast enough, so the DMA would do it's job at 
> one end of the descriptor chain and we'd be building the other?
See the comment in dma_ctrl_flags:
* @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
*  acknowledges receipt, i.e. has has a chance to establish any dependency
*  chains
Setting this would mean that driver can reuse the descriptor once the
transaction has completed.

> 
> The other (easier) way is to let the device that claims the particular DMA 
> channel allocate as much descriptors as it might ever need, which I think is 
> wrong.
Correct.
> 
> What do you think ?
> 
> Best regards,
> Marek Vasut
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
