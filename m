From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jul 2011 13:29:38 +0100
Subject: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
In-Reply-To: <201107011844.44058.arnd@arndb.de>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<201106301512.46788.arnd@arndb.de>
	<20110630133003.GZ21898@n2100.arm.linux.org.uk>
	<201107011844.44058.arnd@arndb.de>
Message-ID: <20110702122938.GI21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 06:44:43PM +0200, Arnd Bergmann wrote:
> On Thursday 30 June 2011, Russell King - ARM Linux wrote:
> > We've been here before - with PCMCIA's card insertion code, where you
> > have to go through a sequence of events (insert, power up, reset, etc).
> > The PCMCIA code used to have a collection of small functions to do
> > each step, one chained after the other in a state machine fashion.
> > The result was horrid.  That's exactly what you'll end up with here.
> > 
> > Threads have their place, and this is one of them.
> 
> Ok, fair enough. The performance enhancement is certainly here already
> with getting the cache management operations out of the hot path,
> and for the fully asynchronous case it's not getting better by trying
> to be smarter.
> 
> At least for ARM, the overhead of the DMA mapping operations will
> dwarf the overhead of the extra context switches for the foreseeable
> future, so we don't need to bother.
> 
> Things might be different for coherent low-end CPU cores like Atom
> when mmc device become much faster and block access becomes CPU
> bound.

One other thing to be considered here is whether this idea should be
limited to just MMC or whether it should be extended further, to
move the DMA mapping stuff out of the hot path for other block devices
too.

There are ARM systems with SATA which do 28MB/s - which could be
improved by this technique.
