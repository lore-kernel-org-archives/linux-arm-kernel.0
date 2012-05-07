From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 17:21:33 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FA7F009.5010003@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <CAJe_Zhe8jYd1j=ti6FvqxXL7i5mbgf0jqb-84sFMTeUqyAonpw@mail.gmail.com>
 <4FA7F009.5010003@wwwdotorg.org>
Message-ID: <201205071721.33704.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Stephen Warren wrote:
> > That way dmac and client drivers using DT could do away with the filter_fn.
> > 
> > Roughly speaking (I am not very well versed with DT syntax)
> > 
> > Client Node:-
> > 
> > mmc1: mmc at 13002000 {
> >         ...
> >         dma_tx = <891>   //some platform-wide unique value
> >         dma_rx = <927>   //some platform-wide unique value
> >         ...
> >  };
> 
> I believe we specifically don't want to introduce any global concept of
> DMA channel ID, either within the kernel, or at the device tree level.

I agree.

> While we do have global interrupt and GPIO IDs within the kernel, this
> has caused problems, I think primarily due to the need to manage this
> unified namespace and allocate a single global ID for a bunch of
> different ranges of controller-specific IDs.
> 
> Within device tree, everything is always represented as an ID
> relative-to or within a particular controller, so it's easy to namespace
> things separately.

Right. Note that strictly speaking the requirement is that everything
is local to a particular namespace, which does not have to be the
device controlling the property.

For instance, we can map interrupt numbers to different controllers
using the interrupt-maps property. It is a fairly complex method,
but something similar or a somewhat simpler method could be applied
to define a namespace for dma controllers from which you can pick
a request line.

The example I've given earlier does just that.

	Arnd
