From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 9 Jun 2012 00:04:09 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FD24CC3.50700@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FBAA64A.200@wwwdotorg.org> <4FD24CC3.50700@ti.com>
Message-ID: <201206090004.10086.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 June 2012, Jon Hunter wrote:
> On 05/21/2012 03:32 PM, Stephen Warren wrote:
> > On 05/21/2012 12:18 PM, Arnd Bergmann wrote:
> >> On Monday 21 May 2012, Stephen Warren wrote:
> >>>
> >>> If so, that seems a little odd; you have to request a DMA channel for
> >>> "TX", but then end up having the common code check all the entries in
> >>> the dmas property since it can't know which are TX, and then have the
> >>> wrong ones almost accidentally fail, since the DMAC will then determine
> >>> that it can't support TX on the RX DMA request IDs.
> >>
> >> I think the direction must be encoded in a way that does not depend on
> >> the binding for the specific controller. There are two ways I can see
> >> how we might do it:
> >>
> >> 1. have separate property names for tx and rx channels, and probably
> >>    one for combined rx/tx channels
> > 
> >> 2. define the second cell in each channel specifier to be the direction
> >>    in a predefined format, followed by the other (controller specific)
> >>    attributes, if any.
> > 
> > In this option, lets say bit 0 is 0==TX, 1==RX (or perhaps 2 bits if
> > combined TX/RX is needed)
> > 
> > Then, we could reserve say bits 7:1 as client DMA request ID.
> > 
> > And then have bits 31:8 as DMAC specific data.
> > 
> > Wouldn't that allow us to have our cake and eat it?
> 
> Sorry for not responding sooner.
> 
> It seems to me we were pretty close on alignment. In fact, I was quite
> happy with Steven's 2nd to last proposal of  ...
> 
> simple 1 req:
> dmas = <0 &dmac1 xxx>;
> 
> simple 2 req:
> dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;
> 
> multiple dmacs:
> dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;
> 
> Arnd, I know that you had some concerns. However, in the above case I
> would expect that the 3rd parameter be optional and it can be some sort
> of match variable. In other words, we don't care how the 32-bits are
> encoded or what they represent but they would be used appropriately by
> the xlate function being used. So the xlate and this "match" variable
> would have to speak the same language.

I would at least put the &dmac part first to be consistent with other
bindings that refer to some node. That controller should then be
able to specify the number of additional cells used to describe the
dma request. We can define that the first cell after the controller
phandle is always the same thing, e.g. the direction (in/out/inout)
or a client-specific ID or a combination of that with other predefined
bits that are not dependent on dma controller specifics.

As I said previously, I think just encoding the direction but not
the client specific ID (meaning we would have to disambiguate
the more complex cases that Stephen mentioned using a dma-names
property) would be the best because it keeps the common case simple,
but I could live with other things going in there too.

> I think that I prefer the idea of having a 3rd optional match variable
> than encoding the DMA request ID and match data together in 1 32-bit
> variable. However, not a big deal either way.

I agree on that part, I would usually prefer to encode different things
in separate cells rather than putting them together into a single cell
just because they require less than 32 bits combined.

	Arnd
