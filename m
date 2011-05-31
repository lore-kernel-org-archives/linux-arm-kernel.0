From: rientjes@google.com (David Rientjes)
Date: Tue, 31 May 2011 15:11:40 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110531210027.GA3660@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
	<20110529215656.GA5576@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
	<20110531072650.GC21382@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105311253510.5646@chino.kir.corp.google.com>
	<20110531210027.GA3660@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105311501570.16259@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011, Russell King - ARM Linux wrote:

> > The problem certainly isn't being ignored in this thread, or in the patch 
> > that I sent to fix Dmitry's issue by default, so that doesn't seem to be 
> > the case.  What would be ignored, though, is if it just emitted a 
> > WARN_ON() without failing the allocation so everything works perfectly.
> 
> Sorry, you did not send a patch to fix it.  You sent a *bodge* to enable
> the DMA zone.  As long as you insist that's a valid fix, you're going
> to carry zero credibility with me.
> 
> The fact is that this driver should not be using GFP_DMA to allocate
> things which aren't even DMA buffers, and its use of GFP_DMA should be
> removed.  But rather than look at that and work it out, and then produce
> a patch to sort that out, the only thing you can do is come up with
> bodge to enable the DMA zone, and continue to insist that's the right
> solution.
> 

I'm not going to hack on an arm driver when I have no idea what its DMA 
requirements are and have no ability to test the change.  I'll rely on the 
authors or maintainers of that driver to figure it out.  In the meantime, 
I suggested enabling CONFIG_ZONE_DMA for that driver because, in its 
current state, it is using GFP_DMA and you haven't provided a single 
reason why enabling CONFIG_ZONE_DMA is going to cause an issue.

In other words, I cannot do your work for you: if GFP_DMA can be removed 
from that driver, great, in the meantime it should enable CONFIG_ZONE_DMA 
to fix the invalid configurations that are currently allowed.  It's 
simple: if you're going to pass GFP_DMA to the page allocator, you need to 
require CONFIG_ZONE_DMA for it to be useful.  Anything else is an invalid 
configuration and is error prone.

> Your whinge that we should re-enable the DMA zone which has been
> disabled for quite a long time now to work around this new restriction
> is extremely idiotic.
> 

The restriction isn't new: GFP_DMA only makes sense with CONFIG_ZONE_DMA.  
The fact that the page allocator completely ignored GFP_DMA in the past 
for CONFIG_ZONE_DMA=n doesn't change that.  That's obviously error prone 
since it will return memory from anywhere simply because of the fact that 
it is an invalid configuration.
