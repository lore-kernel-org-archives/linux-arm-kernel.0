From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 13:03:13 +0100
Subject: [PATCH 2/6] drm/cache: Implement drm_clflush_*() for ARM
In-Reply-To: <1428590049-20357-2-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
 <1428590049-20357-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150410120312.GD12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 04:34:05PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add implementations for drm_clflush_*() on ARM by borrowing code from
> the DMA mapping API implementation. Unfortunately ARM doesn't export an
> API to flush caches on a page by page basis, so this replicates most of
> the code.

I'm _really_ not happy with this, because it's poking about in ARM
internal implementation details of the DMA API.  It's also not going
to work too well on aliasing caches either - especially when you
consider that the userspace mapping of a page may have no relationship
to the address you get from kmap.

For an aliasing cache, the way things work with the DMA API, we ensure
that the kernel alias is clean whenever pages are un-kmapped, which
means that unmapped highmem pages never have L1 cache lines associated
with the kernel alias of them.  The user aliases are handled separately
via the normal flush_dcache_page()/flush_anon_page() calls.

None of this exists here...

It gets even more hairly on older ARM CPUs - but I hope no one is
expecting to support DRM's clflush there - we should make that explicit
though, and ensure that clflush support returns an error there.

That aside, we have most of this logic already inside
dma_cache_maint_page(), and even if it was the right thing to be doing,
we shouldn't be duplicating this architecture specific code inside a
driver.

So you can take that as a NAK on this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
