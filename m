From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 May 2012 16:58:59 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low
 power modes
In-Reply-To: <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
Message-ID: <20120514155859.GA13860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:50:22PM +0100, Lorenzo Pieralisi wrote:
> > 2. L2 disable
> > 3. L1 clean & invalidate
> 
> This is wrong again since while cleaning and invalidating the cache (L1 here)
> can still allocate and this must not happen.

No it isn't.  There is never anything wrong with allocating new caches lines
into a cache which is going to (eventually) be powered down.  Ever.

What would be wrong is if we end up with dirty cache lines in the cache
to be powered down for data which we _care_ about preserving when power
is lost.

That's a _very_ _very_ important difference.

Sure, if we're talking about avoiding cache snooping etc, then we may
wish to disable coherency, but, again, there's absolutely nothing wrong
with allocating cache lines.

Take a moment to think why this is.  Where's the data pulled into the
cache stored - in RAM.  The copy in the cache, while it remains clean,
is just a duplicate of what's already stored elsewhere in the system.
