From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 17:53:35 +0100
Subject: arm64 ioremap question
In-Reply-To: <1381853652.4093.10.camel@weser.hi.pengutronix.de>
References: <1381850404.27955.9.camel@deneb.redhat.com>
 <20131015155216.GD25034@n2100.arm.linux.org.uk>
 <1381853652.4093.10.camel@weser.hi.pengutronix.de>
Message-ID: <20131015165335.GF25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 06:14:12PM +0200, Lucas Stach wrote:
> Am Dienstag, den 15.10.2013, 16:52 +0100 schrieb Russell King - ARM
> Linux:
> > On Tue, Oct 15, 2013 at 11:20:04AM -0400, Mark Salter wrote:
> > > ioremap() has a test to prevent RAM from being remapped:
> > > 
> > > 	/*
> > > 	 * Don't allow RAM to be mapped.
> > > 	 */
> > > 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> > > 		return NULL;
> > > 
> > > 
> > > Is this really necessary even for reserved pages which are not being
> > > used for anything else?
> > 
> > It helps to stop the abuse of using ioremap() on normal memory, which has
> > happened soo much in Aarch32 for years.  Unfortuantely, bad habbits die
> > hard.
> > 
> > "Reserved pages not being used for anything else" are still mapped, and
> > still subject to speculative fetches.
> 
> Only slightly related to the issue here, but I'm really wondering if the
> speculative fill can happen on real implementations.
> I'm well aware that there is nothing in the arch preventing a
> speculative fill on a cached alias, but at least for the A9
> implementation the ARM infocenter claims that the prefetcher will not
> cross a 4KB boundary [1].
> So as long as we are talking about full pages, having a conflicting
> mapping should not cause any issues as long as you don't touch the
> memory region explicitly through the cached mapping.
> 
> I know that we generally aim to avoid basing any kernel infrastructure
> on such vague guarantees, but I'm really wondering if my analysis is
> correct or is there anything I'm overlooking here?

And I know where this is leading so frankly I'm not answering.  I don't
want to see any more of people commenting out code like this in their
vendor kernels because they don't care.  Sorry if I'm being unhelpful
but I have experience of what happens here.
