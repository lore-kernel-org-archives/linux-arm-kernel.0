From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Oct 2013 14:17:40 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131007104132.GI2954@intel.com>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007104132.GI2954@intel.com>
Message-ID: <Pine.LNX.4.64.1310071415280.20796@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Vinod Koul wrote:

> On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
> > On Sun, 6 Oct 2013, Vinod Koul wrote:
> > > > > Do you see any problems using, say, a threaded interrupt handler, apart 
> > > > > from possible performance issues? That seems to be pretty convenient. 
> > > > > Otherwise we should really mandate somewhere, that bottom half processing 
> > > > > should take place in a tasklet?
> > > > 
> > > > The documentation has always stated that callbacks will be made from
> > > > tasklet context.  The problem with allowing different contexts from
> > > > different drivers is taht spinlocking becomes problematical.  Remember
> > > > that we have _bh() variants which lock against tasklets but allow IRQs.
> > 
> > Vinod, Dan, what do you think about the bottom half interrupt processing? 
> > Do we want to make the use of a tasklet compulsory or can we also allow 
> > other contexts?
> I dont see any advantage of using threaded handler as compared to tasklet, As
> Russell pointed out its going to make locking and common handling very
> complicated to be invoked from different contexts. What will be benefit from
> this?

I think using a (devm_)request_threaded_irq() and returning 
IRQ_WAKE_THREAD in the ISR is prettier and easier than maintaining an 
additional tasklet. BTW, shdma-base.c already does that.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
