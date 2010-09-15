From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Sep 2010 08:49:39 +0900
Subject: [PATCH v2] ARM: Samsung: s5p-fimc: fix dma coherent mask
In-Reply-To: <004201cb53ee$ff8e2a60$feaa7f20$%szyprowski@samsung.com>
References: <000301cb4fb7$b4448530$1ccd8f90$%kim@samsung.com>
	<1283998673-14899-1-git-send-email-m.szyprowski@samsung.com>
	<011101cb5010$fdb1d520$f9157f60$%kim@samsung.com>
	<004201cb53ee$ff8e2a60$feaa7f20$%szyprowski@samsung.com>
Message-ID: <027d01cb5530$ac5cb8a0$051629e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
Hi ;-)

> On Thursday, September 09, 2010 1:20 PM Kukjin Kim wrote:
> 
> > Marek Szyprowski wrote:
> > >
> > > FIMC driver uses DMA_coherent allocator, which requires proper dma
mask
> > > to be set.
> > >
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >
> > > Chnages since v1:
> > > - use DMA_BIT_MASK() macro, minor coding style change
> > >
> > > ---
> > >  arch/arm/plat-s5p/dev-fimc0.c |    7 +++++++
> > >  arch/arm/plat-s5p/dev-fimc1.c |    7 +++++++
> > >  arch/arm/plat-s5p/dev-fimc2.c |    7 +++++++
> > >  3 files changed, 21 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-
> > fimc0.c
> > > index d3f1a9b..f9203fa 100644
> > > --- a/arch/arm/plat-s5p/dev-fimc0.c
> > > +++ b/arch/arm/plat-s5p/dev-fimc0.c
> > > @@ -10,6 +10,7 @@
> > >   */
> > >
> > >  #include <linux/kernel.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/ioport.h>
> > > @@ -28,9 +29,15 @@ static struct resource s5p_fimc0_resource[] = {
> > >  	},
> > >  };
> > >
> > > +static u64 s5p_fimc0_dma_mask = DMA_BIT_MASK(32);
> > > +
> > >  struct platform_device s5p_device_fimc0 = {
> > >  	.name		= "s5p-fimc",
> > >  	.id		= 0,
> > >  	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
> > >  	.resource	= s5p_fimc0_resource,
> > > +	.dev		= {
> > > +		.dma_mask		= &s5p_fimc0_dma_mask,
> > > +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > > +	},
> > >  };
> > > diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-
> > fimc1.c
> > > index 41bd698..7ed91a3 100644
> > > --- a/arch/arm/plat-s5p/dev-fimc1.c
> > > +++ b/arch/arm/plat-s5p/dev-fimc1.c
> > > @@ -10,6 +10,7 @@
> > >   */
> > >
> > >  #include <linux/kernel.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/ioport.h>
> > > @@ -28,9 +29,15 @@ static struct resource s5p_fimc1_resource[] = {
> > >  	},
> > >  };
> > >
> > > +static u64 s5p_fimc1_dma_mask = DMA_BIT_MASK(32);
> > > +
> > >  struct platform_device s5p_device_fimc1 = {
> > >  	.name		= "s5p-fimc",
> > >  	.id		= 1,
> > >  	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
> > >  	.resource	= s5p_fimc1_resource,
> > > +	.dev		= {
> > > +		.dma_mask		= &s5p_fimc1_dma_mask,
> > > +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > > +	},
> > >  };
> > > diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-
> > fimc2.c
> > > index dfddeda..5543d6373 100644
> > > --- a/arch/arm/plat-s5p/dev-fimc2.c
> > > +++ b/arch/arm/plat-s5p/dev-fimc2.c
> > > @@ -10,6 +10,7 @@
> > >   */
> > >
> > >  #include <linux/kernel.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/ioport.h>
> > > @@ -28,9 +29,15 @@ static struct resource s5p_fimc2_resource[] = {
> > >  	},
> > >  };
> > >
> > > +static u64 s5p_fimc2_dma_mask = DMA_BIT_MASK(32);
> > > +
> > >  struct platform_device s5p_device_fimc2 = {
> > >  	.name		= "s5p-fimc",
> > >  	.id		= 2,
> > >  	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
> > >  	.resource	= s5p_fimc2_resource,
> > > +	.dev		= {
> > > +		.dma_mask		= &s5p_fimc2_dma_mask,
> > > +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> > > +	},
> > >  };
> > > --
> > > 1.7.2.2
> >
> > looks good to me..will apply :-)
> 
> What about merging this patch also to the kgene/s5p-fixes-for-linus
branch?
> IMHO this and the fimc clocks patch are pure bug fixes that should be
merged
> into final 2.6.36 kernel. Without these two patches fimc driver is
useless.
> 
Hmm...ok...will sort out with other fixes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
