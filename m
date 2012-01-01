From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 1 Jan 2012 21:29:38 +0800
Subject: [PATCH] dma/imx-sdma: add wmb before enable/run a channel
In-Reply-To: <20120101071425.GA25978@pengutronix.de>
References: <1325388460-20678-1-git-send-email-richard.zhao@linaro.org>
 <20120101071425.GA25978@pengutronix.de>
Message-ID: <20120101132935.GA1914@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 01, 2012 at 08:14:25AM +0100, Uwe Kleine-K?nig wrote:
> Hello Richard,
> 
> On Sun, Jan 01, 2012 at 11:27:40AM +0800, Richard Zhao wrote:
> > dma_alloc_coherent memory may be bufferable. We need to add
> > nececcary memory barrier.
> necessary
> 
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  drivers/dma/imx-sdma.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 2ebb2bc..8cd9492 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -403,6 +403,7 @@ static int sdma_run_channel(struct sdma_channel *sdmac)
> >  
> >  	init_completion(&sdmac->done);
> >  
> > +	wmb();
> >  	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
> >  
> >  	ret = wait_for_completion_timeout(&sdmac->done, HZ);
> > @@ -809,6 +810,7 @@ out:
> >  
> >  static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
> >  {
> > +	wmb();
> >  	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
> >  }
> I don't know the sdma code very well, but wouldn't it be nice to call
> sdma_enable_channel() in sdma_run_channel() instead of open coding it?
right.
> 
> As you probably need some rearrangements to have sdma_enable_channel()
> declared in sdma_run_channel() this might be better done with a seperate
> patch.
It'll save one wmb.

Thanks
Richard
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
