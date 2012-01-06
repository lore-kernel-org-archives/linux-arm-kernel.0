From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 06 Jan 2012 16:40:24 +0530
Subject: [PATCH 1/2] dmaengine: Fix status handling in imx-dma.
In-Reply-To: <20120106093752.GH5446@pengutronix.de>
References: <1325506706-10028-1-git-send-email-javier.martin@vista-silicon.com>
 <1325829389.1540.95.camel@vkoul-udesk3>
 <20120106093752.GH5446@pengutronix.de>
Message-ID: <1325848224.1540.102.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-06 at 10:37 +0100, Sascha Hauer wrote:
> On Fri, Jan 06, 2012 at 11:26:29AM +0530, Vinod Koul wrote:
> > On Mon, 2012-01-02 at 13:18 +0100, Javier Martin wrote:
> > > Status must only be changed to DMA_IN_PROGRESS
> > > when the DMA transfer has really begun.
> > > 
> > > However, since this driver lacks of support for
> > > multiple descriptors a new flag has to be introduced
> > > to avoid the prepare function be called multiple times.
> > Thanks this is the right approach to fix this driver
> > 
> > But this will obviously break any users of this driver as they need to
> > call the right APIs now :D
> > 
> > Sacha: can you check this patch and see which users of this driver will
> > break. we need those fixes to go along this patch as well
> 
> Which users should break? I just tried with the mxcmmc driver and this
> one does not break.
> 
> I do not really understand this patch anyway. It changes imxdmac->status
> to a write-only variable and introduces a imxdmac->prepared variable
> with the same meaning. This patch is a complicated no-op.
> 
> What was the original problem? The fact that we used a enum dma_status
> with the wrong semantics? In that case I suggest to simply replace this
> variable. All we need to track is that we do not enter
> imxdma_prep_slave_sg with an already running transfer.
the memcpy patch submitted earlier didn't use correct dmaengine API. a
descriptor is not supposed to be started in prepare. The reason given
was the driver already does so for all other prepares, so i suggested to
fix that. Descriptors should be started in issue_pending only.

I thought that change is done in this patch (looks like i didn't look
too carefully), so if prepare is used per API definition, clients which
dont call issue_pending would break...


-- 
~Vinod
