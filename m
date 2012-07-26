From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 07:14:34 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1343284960.1726.8978.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
Message-ID: <201207260714.34540.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 July 2012, Vinod Koul wrote:
> > > But from a client POV it makes sense as with the given direction you
> > > would need a specific request line for a channel. So this is right.
> > > But direction is something I don't expect to be used for "give me a
> > > channel" 
> > 
> > Ok. The thought was that the user would have the following means of
> > requesting a channel ...
> > 
> > 1. By name
> Bare name maynot be enough. In a dmac we have many channels which one to
> choose?

The name is what is associated with the property in the client device
node, which describes everything the dmac driver needs to know.
If the dmac needs to pick a specific channel, it can find out from the
"dmas" property in combination with that name. If it is allowed to
pick any channel, it doesn't need to bother.

> > 2. By a filter parameter (flags)
> Even with direction same problem can arise

Again this is just identifying which dma specifier from the "dmas"
property to pick. The use case is the very common one that there
is at most one "read" and one "write" channel. In this case all
the client has to know is that it wants a channel that fits the
description given in DT for the direction it's looking for.

> > 3. By name and a filter parameter
> Additionally we need to say which channel, or making dmaengine already
> aware will help here.

The channel is still described in the specifier, the client should
not care about it.

	Arnd
