From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 5 Jun 2013 10:28:35 +0200 (CEST)
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <3675801.kLfsmmiSOq@wuerfel>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <2862988.jnTv0iSQcj@wuerfel>
 <alpine.DEB.2.00.1305311721160.7395@axis700.grange>
 <3675801.kLfsmmiSOq@wuerfel>
Message-ID: <Pine.LNX.4.64.1306051020340.19739@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On Fri, 31 May 2013, Arnd Bergmann wrote:

> On Friday 31 May 2013 17:30:01 Guennadi Liakhovetski wrote:
> > On Fri, 31 May 2013, Arnd Bergmann wrote:
> > > On Friday 31 May 2013 16:52:13 Guennadi Liakhovetski wrote:
> 
> > > I think it's more a matter of using the API correctly. The dmaengine
> > > API is an abstraction to separate the slave driver from the master
> > > through well-defined calls. If you make additional assumptions
> > > in the slave driver about the master, that is a layering violation.
> > 
> > I think it is a common practice, see e.g.
> > 
> > drivers/mmc/host/omap_hsmmc.c
> > drivers/mmc/host/davinci_mmc.c
> 
> Yes, those should be fixed as well.

Then we'll have to fix quite a few of those - I only looked under 
drivers/mmc for now.

But isn't that a separate issue? The problem we have to address now is 
broken compilation, for which, I think, my patch is the simplest solution. 
DMA slave drivers being DMAC implementation agnostic is good, no doubt 
about that, even though many of them will ever only use one DMAC type, but 
isn't that a separate issue? Fixing it would require patching 3 locations: 
a header to add a callback field, arches to add filters and drivers to 
actually call them instead of hard-coded functions. In the worst case 
those changes would go via 3 different git-trees, so, might take 3 kernel 
releases... Ok, at least two if we puch the header change together with 
arch updates via the same tree with suitable acks, still, that's too long, 
IMHO.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
