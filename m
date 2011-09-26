From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 14:00:14 +0100
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <1312393430.2855.51.camel@mulgrave>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-7-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<201107051427.44899.arnd@arndb.de>
	<1312393430.2855.51.camel@mulgrave>
Message-ID: <20110926130014.GG22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 12:43:50PM -0500, James Bottomley wrote:
> I assume from the above that ARM has a hardware page walker?

Correct, and speculative prefetch (which isn't prevented by not having
TLB entries), so you can't keep entries out of the TLB.  If it's in
the page tables it can end up in the TLB.

The problem is that we could end up with conflicting attributes available
to the hardware for the same physical page, and it is _completely_
undefined how hardware behaves with that (except that it does not halt -
and there's no exception path for the condition because there's no
detection of the problem case.)

So, if you had one mapping which was fully cacheable and another mapping
which wasn't, you can flush the TLB all you like - it could be possible
that you still up with an access through the non-cacheable mapping being
cached (either hitting speculatively prefetched cache lines via the
cacheable mapping, or the cacheable attributes being applied to the
non-cacheable mapping - or conversely uncacheable attributes applied to
the cacheable mapping.)

Essentially, the condition is labelled 'unpredictable' in the TRMs,
which basically means that not even observed behaviour can be relied
upon, because there may be cases where the observed behaviour fails.
