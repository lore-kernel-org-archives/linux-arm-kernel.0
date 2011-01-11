From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 11 Jan 2011 21:18:16 +0900
Subject: Locking in the clk API
In-Reply-To: <201101111830.18597.jeremy.kerr@canonical.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111101314.GA774@linux-sh.org>
	<201101111830.18597.jeremy.kerr@canonical.com>
Message-ID: <20110111121816.GB774@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:30:18PM +0800, Jeremy Kerr wrote:
> Hi Paul,
> 
> > No, the sleeping clock case is and always will be a corner case, and I
> > have no interest in pretending otherwise. On SH we have hundreds of
> > clocks that are all usable in the atomic context and perhaps less than a
> > dozen that aren't (and even in those cases much of the PLL negotiation is
> > handled in hardware so there's never any visibility for the lock-down
> > from the software side, other architectures also have similar behaviour).
> 
> I'm not too worried about the corner-cases on the *implementation* side, more 
> the corner-cases on the API side: are we seeing more users of the API that 
> require an atomic clock, or more that don't care?
> 
Again, you are approaching it from the angle that an atomic clock is a
special requirement rather than the default behaviour. Sleeping for
lookup, addition, and deletion are all quite acceptable, but
enable/disable pairs have always been intended to be usable from atomic
context. Anyone that doesn't count on that fact is either dealing with
special case clocks (PLLs, root clocks, etc.) or simply hasn't bothered
implementing any sort of fine grained runtime power management for their
platform.

It's unfortunate that you managed to pick one of the three or so
platforms with broken semantics to base your implementation off of, but
rest assured, everyone else did infact get it right, at least so far.
