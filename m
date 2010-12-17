From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 09:48:18 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <8c67e174d807416f0c6c190cc72d3f5a.squirrel@www.codeaurora.org>
References: <4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
	<4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
	<20101209103835.GA31465@n2100.arm.linux.org.uk>
	<4D017B45.4000805@codeaurora.org>
	<AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
	<4D045692.4050607@codeaurora.org>
	<AANLkTimwqC6DqN8ft10EyRbPh9XvibN1fA-Cug4OdS5m@mail.gmail.com>
	<8c67e174d807416f0c6c190cc72d3f5a.squirrel@www.codeaurora.org>
Message-ID: <20101217094818.GA9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 06:55:06PM -0800, Saravana Kannan wrote:
> 
> > On 12 December 2010 04:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> >> As you and James suggested, having the NS bit set by the secure world is
> >> definitely a solution that would work. But IMHO, the explicit cache
> >> flush/invalidate approach keeps the design simple and easy to maintain.
> >
> > That is indeed an approach to the problem. But it depends on whether
> > we consider the DMA API appropriate for this. We can view the secure
> > world as a non-coherent agent accessing the memory and could try to
> > justify the use of the DMA API in Linux.
> >
> > At some point we'll probably have platforms supporting cacheable DMA
> > (e.g. via the ARM coherency port) and the DMA API would no longer give
> > you what you need. But it is also possible that platforms with ACP
> > would only have 1 or 2 devices on that port (some HD LCD controller
> > for example) and the rest of devices non-coherent. In this case, we
> > need to have different DMA operations depending on the bus/device (via
> > get_dma_ops) and thus we can allow your scenario via dedicated DMA
> > ops.
> 
> Catalin,
> 
> Looks like you agree with our approach. If that's the case, would you mind
> Acking Jeff's initial patch that this thread is based on?

I read Catalin's reply as agreeing with me.

> Russell,
> 
> Does Catalin's proposal sound acceptable to you?

Catalin's proposal for get_dma_ops doesn't work for you because you
don't have a struct device for your CPUs - and as we don't have anything
supporting ACP at the moment, there's little point engineering it in.

The basic point here is that using the DMA API to achieve DMA coherency
with something that is not DMA is going to be prone to failure, because
we aren't going to guarantee that it'll do what you want.  There's
already a history of people abusing the DMA API, and then when we fix
stuff in the DMA API, they complain that their drivers have broken.

What I've been saying is never use it for its properties (for its uncached
memory) as that is _not_ guaranteed - use it for its purpose instead
(which is to provide coherent memory for DMA devices) which is guaranteed.
