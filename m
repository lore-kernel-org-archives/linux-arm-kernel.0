From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 19:10:17 +0100
Subject: [PATCH] arm64: Implement cache_line_size() based on CTR_EL0.CWG
In-Reply-To: <20140502173121.GB5341@arm.com>
References: <1399046132-5760-1-git-send-email-catalin.marinas@arm.com>
 <20140502171247.GG20642@arm.com> <20140502173121.GB5341@arm.com>
Message-ID: <20140502181017.GC14645@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 06:31:21PM +0100, Catalin Marinas wrote:
> On Fri, May 02, 2014 at 06:12:47PM +0100, Will Deacon wrote:
> > On Fri, May 02, 2014 at 04:55:32PM +0100, Catalin Marinas wrote:
> > > The hardware provides the maximum cache line size in the system via the
> > > CTR_EL0.CWG bits. This patch implements the cache_line_size() function
> > > to read such information, together with a sanity check if the statically
> > > defined L1_CACHE_BYTES is smaller than the hardware value.

[...]

> > > +static inline int cache_line_size(void)
> > > +{
> > > +	u32 cwg = cache_type_cwg();
> > > +	return cwg ? 4 << cwg : L1_CACHE_BYTES;
> > > +}
> > 
> > Hmmm, but the CWG is not the same thing as the L1 cache line size, so
> > something is amiss here. If I have an L2 cache with bigger lines, then
> > reporting L1_CACHE_BYTES is wrong here.
> 
> L1 is usually DMinSize while CWG is the maximum in the system. If a
> system has a system cache, it should be covered by CWG (especially those
> semi-transparent system caches).

I wouldn't bet on that, but it should at least define the maximum line size
of your inner caches.

> Using this macro is misleading indeed but Linux has lots of assumptions
> about the cache line size and only using L1_CACHE_BYTES, including cache
> line aligned sections. I consider L1 in this context to actually mean
> any cache line flushed by the standard DC instructions.

Yes, Linux uses L1_CACHE_BYTES and __cacheline_aligned etc for all sorts of
cases. Some of these are performance improvements, and should be as small as
possible (since they probably just refer to the L1 size for coherent CPUs)
but others are critical for correct operation, and should be large enough to
get things right (like early boot synchronisation).

I suppose that means we always use CWG and should loudly if it's bogus...
which is exactly what your patch does!

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
