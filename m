From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 18:44:43 +0200
Subject: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
In-Reply-To: <20110630133003.GZ21898@n2100.arm.linux.org.uk>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<201106301512.46788.arnd@arndb.de>
	<20110630133003.GZ21898@n2100.arm.linux.org.uk>
Message-ID: <201107011844.44058.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 June 2011, Russell King - ARM Linux wrote:
> We've been here before - with PCMCIA's card insertion code, where you
> have to go through a sequence of events (insert, power up, reset, etc).
> The PCMCIA code used to have a collection of small functions to do
> each step, one chained after the other in a state machine fashion.
> The result was horrid.  That's exactly what you'll end up with here.
> 
> Threads have their place, and this is one of them.

Ok, fair enough. The performance enhancement is certainly here already
with getting the cache management operations out of the hot path,
and for the fully asynchronous case it's not getting better by trying
to be smarter.

At least for ARM, the overhead of the DMA mapping operations will
dwarf the overhead of the extra context switches for the foreseeable
future, so we don't need to bother.

Things might be different for coherent low-end CPU cores like Atom
when mmc device become much faster and block access becomes CPU
bound.

	Arnd
