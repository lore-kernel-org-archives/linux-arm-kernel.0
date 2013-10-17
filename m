From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 17 Oct 2013 16:39:57 +0200 (CEST)
Subject: [PATCH 01/28] dmaengine: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <20131017142755.GA4477@breakpoint.cc>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
 <1381940926-25564-2-git-send-email-vinod.koul@intel.com>
 <Pine.LNX.4.64.1310162028340.22648@axis700.grange>
 <CAPcyv4hOZHmegDiPYmeVWzOUCasQaixzCzpLHs37i7RZznhGsA@mail.gmail.com>
 <20131017020745.GA14013@intel.com> <20131017142755.GA4477@breakpoint.cc>
Message-ID: <Pine.LNX.4.64.1310171638030.27369@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian

On Thu, 17 Oct 2013, Sebastian Andrzej Siewior wrote:

> On Thu, Oct 17, 2013 at 07:37:45AM +0530, Vinod Koul wrote:
> > index 0bc7275..683c380 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -45,16 +45,17 @@ static inline int dma_submit_error(dma_cookie_t cookie)
> >  
> >  /**
> >   * enum dma_status - DMA transaction status
> > - * @DMA_SUCCESS: transaction completed successfully
> > + * @DMA_COMPLETE: transaction completed
> >   * @DMA_IN_PROGRESS: transaction not yet processed
> >   * @DMA_PAUSED: transaction is paused
> >   * @DMA_ERROR: transaction failed
> >   */
> >  enum dma_status {
> > -	DMA_SUCCESS,
> > +	DMA_COMPLETE,
> >  	DMA_IN_PROGRESS,
> >  	DMA_PAUSED,
> >  	DMA_ERROR,
> > +	DMA_SUCCESS,
> >  };
> 
> There are some drivers which compare against == or != DMA_SUCCESS. Shouldn't this
> become
>   enum dma_status {
>  -	DMA_SUCCESS,
>  +	DMA_COMPLETE = 0, DMA_SUCCESS = 0,
>   	DMA_IN_PROGRESS,
>   	DMA_PAUSED,
>   	DMA_ERROR,
>   };
> 
> so nothing breaks during the transition?

Good catch. I would do

 enum dma_status {
-	DMA_SUCCESS,
+	DMA_COMPLETE,
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
 };
 
+ #define DMA_SUCCESS DMA_COMPLETE

and then just remove the last line again

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
