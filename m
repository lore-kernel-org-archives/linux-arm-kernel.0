From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 21:16:29 +0000
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <1267807960.2581.5.camel@e102109-lin.cambridge.arm.com>
References: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
	<1267807960.2581.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100305211629.GF4885@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 04:52:40PM +0000, Catalin Marinas wrote:
> As Ben said, I think we can set PG_dcache_clean in the
> clear/copy_user_page() functions. My doubt with these functions is the
> highmem cases where kunmap_atomic() only flushes the D-cache in one
> situation, the other just calling kunmap_high() which doesn't seem to do
> anything to the caches.

In which case you're totally missing the point with these functions.
The copy_user_page and clear_user_page functions specifically do tricks
to ensure that they can avoid additional cache maintainence - or any
cache maintainence at all.

For instance, on aliasing VIPT, they will map the user page in using
the same colour as the ultimate userspace address, ensuring that any
cache lines created will be visible to the userspace application.

So what kunmap_atomic() does with caches is not really relevant to the
coherency issue.
