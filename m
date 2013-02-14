From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Feb 2013 17:14:31 +0000
Subject: [BUG] v7_coherent_kern_range broken on big.LITTLE
In-Reply-To: <1360861663.3266.58.camel@linaro1.home>
References: <1360861663.3266.58.camel@linaro1.home>
Message-ID: <20130214171431.GJ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 05:07:43PM +0000, Jon Medhurst (Tixy) wrote:
> The function v7_coherent_kern_range uses the macro icache_line_size to
> read the current CPUs icache line size for the purpose of invalidating
> all cache lines in the given range.
> 
> Unfortunately, on the TC2 big.LITTLE test chip, the A15 icache line size
> is 64 bytes, but the A7 size is only 32 bytes. So when the function
> executes on the A15 it will miss out every alternate cache line for the
> A7.

This sounds... brain dead.  So, we have a MP system with A15 and A7.  On
A15, the cache line size reported by the cache ID registers is 64 bytes.
On the A7, the cache line size is reported to be 32 bytes.

When a 64-byte cache line is invalidated on an A15 core, only one of the
two overlapping A7 cache lines gets invalidated.

So, to find out what cache line granularity we have to operate on, we have
to read the cache size registers on both CPUs, and calculate the result
from that.  That means we must boot _all_ cores and read their cache ID
registers at kernel boot time, and then shut down the cores we don't want.
Hardly a good idea for low power platforms...
