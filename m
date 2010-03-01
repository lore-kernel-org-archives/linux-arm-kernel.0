From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Mar 2010 11:06:10 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267439954.23333.41.camel@e102109-lin.cambridge.arm.com>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<1267439954.23333.41.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100301110610.GA16604@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 01, 2010 at 10:39:14AM +0000, Catalin Marinas wrote:
> On Sun, 2010-02-28 at 05:01 +0000, James Bottomley wrote:
> > But the point of all of this is that I cache invalidation doesn't appear
> > anywhere in the I/O path ... so  if we're getting I/D incoherency,
> > there's some problem in the mm code (or there's a missing arch
> > assumption ... like I cache gets moved in more aggressively than we
> > expect).  Parisc is very sensitive to I/D incoherency, so we'd notice if
> > there were a serious generic problem here.
> 
> On ARM PIPT, it's probably because flush_cache_page isn't implemented.
> But as I said above, given the speculative fetches I don't think it
> would help much (well, it would work a bit better but not a complete
> fix).

Not quite.  flush_cache_page() is called when we unmap or replace a page
in userspace, which is completely the wrong place to do I-cache coherency
when you have speculatively loaded caches - or even D-cache coherency if
your cache behaves as a speculatively loaded PIPT or non-aliasing VIPT.

Flushing the I-cache after a page has been in userspace does nothing to
ensure that there aren't any I-cache lines associated with that page
when you next come to map it into userspace.
