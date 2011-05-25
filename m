From: phil@nwl.cc (Phil Sutter)
Date: Wed, 25 May 2011 12:32:30 +0200
Subject: ARM, AF_PACKET: caching problems on Marvell Kirkwood
In-Reply-To: <20110506161753.GC20777@orbit.nwl.cc>
References: <20110408130643.GA8730@orbit.nwl.cc>
	<20110505141107.GC30443@orbit.nwl.cc>
	<20110505194601.GA10565@lunn.ch>
	<20110506161753.GC20777@orbit.nwl.cc>
Message-ID: <20110525103230.GA6057@orbit.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 06, 2011 at 06:17:53PM +0200, Phil Sutter wrote:
> On Thu, May 05, 2011 at 09:46:01PM +0200, Andrew Lunn wrote:
> > I can reproduce it on a Kirkwood:
> > 
> > [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
> 
> Thanks for the information. Seems like we have the same CPU:
> 
> | [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053177
> | [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> 
> and it's actually VIVT, not VIPT as I wrote in an earlier mail.

I have been looking at flush_dcache_page(), which is supposed to do the
trick when caches need to be flushed/dropped for the mmapped memory.
Interestingly, there seems to be no page mapping - so page_mapping(page)
returns NULL and therefore __flush_dcache_aliases(mapping, page) is
never being called.

Could that be the culprit here? I guess there should always be a mapping
present for mmapped pages, right?

Greetings, Phil
