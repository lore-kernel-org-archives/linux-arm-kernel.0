From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 12 Jul 2010 13:46:06 +0100
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <1278935613.9481.20.camel@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007092130.17504.arnd@arndb.de>
	<1278714714.30012.14.camel@e102109-lin.cambridge.arm.com>
	<201007121339.48719.arnd@arndb.de>
	<20100712115035.GA7559@shareable.org>
	<1278935613.9481.20.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100712124606.GB7559@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Mon, 2010-07-12 at 12:50 +0100, Jamie Lokier wrote:
> > Arnd Bergmann wrote:
> > > Ah, that's right: writel and outl both need the barrier before the access,
> > > but writel will never need a barrier after the access.
> > > The x86 variant of outl also has the implicit ordering after the access,
> > > but I'm not sure if we need to emulate that. I can't currently think
> > > of a case where it's strictly required because any later access to the same
> > > PCI function will be ordered anyway.
> > 
> > What about those ARMs which can buffer a write for an indefinite period?
> > Do any drivers expect writes to be posted in a reasonably short time?
> 
> Writing to any device is not guaranteed to succeed (i.e. change the
> state of the device) in a certain amount of time (this is probably the
> case on x86 as well). If you need this certainty in the code, you do a
> read back from the device. Since Device memory accesses are ordered in
> ARM, we don't need additional barriers for such situations.

There's a time between a "certain amount" and "infinite".

I'm pretty sure the write buffering time for x86 is guaranteed to be
finite and quite short (without specifying exactly how short - just
like instructions don't specify how long they take to execute), as in
it's just a buffer, whose delay is a similar order of magnitude to bus
transactions.  It's not a cache.

A recent commit changes ARM cpu_relax() because it can keep writes
buffered indefinitely.  The commit message does say it's because reads
are prioritised over writes, so perhaps that's only an issue in loops
which use cpu_relax() anyway.

If any chips buffer PCI writes indefinitely outside a
cpu_relax()-using loop, I wouldn't be surprised to see some drivers
work incorrectly.  Not *break* exactly, but things like actions
getting delayed until something else happens, or reduced performance.

-- Jamie
