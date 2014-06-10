From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 10 Jun 2014 11:49:11 +0900
Subject: [RFC PATCH 2/3] DMA, CMA: use general CMA reserved area
 management framework
In-Reply-To: <xa1twqcyjx3z.fsf@mina86.com>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1twqcyjx3z.fsf@mina86.com>
Message-ID: <20140610024910.GB19036@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 09:00:48AM +0200, Michal Nazarewicz wrote:
> On Tue, Jun 03 2014, Joonsoo Kim wrote:
> > Now, we have general CMA reserved area management framework,
> > so use it for future maintainabilty. There is no functional change.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> > diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> > index dfb1dc9..ecb85ac 100644
> > --- a/include/linux/dma-contiguous.h
> > +++ b/include/linux/dma-contiguous.h
> > @@ -53,9 +53,10 @@
> >  
> >  #ifdef __KERNEL__
> >  
> > +#include <linux/device.h>
> > +
> 
> Why is this suddenly required?
> 
> >  struct cma;
> >  struct page;
> > -struct device;
> >  
> >  #ifdef CONFIG_DMA_CMA
> 

Without including device.h, build failure occurs.
In dma-contiguous.h, we try to access to dev->cma_area, so we need
device.h. In the past, we included it luckily by swap.h in
drivers/base/dma-contiguous.c. Swap.h includes node.h and then node.h
includes device.h, so we were happy. But, in this patch, I remove
'include <linux/swap.h>' so we need to include device.h explicitly.

Thanks.
