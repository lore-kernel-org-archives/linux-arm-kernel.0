From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Apr 2015 15:05:59 +0200
Subject: [PATCH 2/6] drm/cache: Implement drm_clflush_*() for ARM
In-Reply-To: <20150410120312.GD12732@n2100.arm.linux.org.uk>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
 <1428590049-20357-2-git-send-email-thierry.reding@gmail.com>
 <20150410120312.GD12732@n2100.arm.linux.org.uk>
Message-ID: <20150410130557.GB32473@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 01:03:13PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 09, 2015 at 04:34:05PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Add implementations for drm_clflush_*() on ARM by borrowing code from
> > the DMA mapping API implementation. Unfortunately ARM doesn't export an
> > API to flush caches on a page by page basis, so this replicates most of
> > the code.
> 
> I'm _really_ not happy with this, because it's poking about in ARM
> internal implementation details of the DMA API.  It's also not going
> to work too well on aliasing caches either - especially when you
> consider that the userspace mapping of a page may have no relationship
> to the address you get from kmap.
> 
> For an aliasing cache, the way things work with the DMA API, we ensure
> that the kernel alias is clean whenever pages are un-kmapped, which
> means that unmapped highmem pages never have L1 cache lines associated
> with the kernel alias of them.  The user aliases are handled separately
> via the normal flush_dcache_page()/flush_anon_page() calls.
> 
> None of this exists here...
> 
> It gets even more hairly on older ARM CPUs - but I hope no one is
> expecting to support DRM's clflush there - we should make that explicit
> though, and ensure that clflush support returns an error there.
> 
> That aside, we have most of this logic already inside
> dma_cache_maint_page(), and even if it was the right thing to be doing,
> we shouldn't be duplicating this architecture specific code inside a
> driver.
> 
> So you can take that as a NAK on this.

Perhaps I should take a step back and explain what I'm trying to solve,
maybe that'll allow us to come up with a more proper solution.

Both the MSM and Tegra drivers allocate framebuffers from shmem in the
presence of an IOMMU. The problem with allocating pages from the shmem
is that pages end up not being flushed, resulting in visual artifacts
on the screen (horizontal black lines) when the cachelines from earlier
allocations of these pages get flushed. The drivers also use the IOMMU
API directly to manage the IOVA space.

Currently both drivers work around this by faking up an sg_table and
calling dma_map_sg(), which ends up doing the right thing. Unfortunately
this only works if nothing backs the DMA API and we end up getting the
regular arm_dma_ops. If an IOMMU registers with the ARM/DMA glue, we'll
end up getting a different set of dma_ops and things break (buffers are
mapped through the IOMMU twice, ...).

Still, this has worked fine on Tegra (and I assume the same is true for
MSM) so far because we don't register an IOMMU with the ARM/DMA glue.
However while porting this to 64-bit ARM I started seeing failures to
map buffers because SWIOTLB is enabled by default and gets in the way.

With regards to code duplication, I suspect we could call something like
arm_dma_ops.sync_sg_for_device() directly, but that raises the question
about which device to pass in. It isn't clear at allocation time which
device will use the buffer. It may in fact be used by multiple devices
at once.

Do you have an alternative suggestion on how to fix this?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/d26ac0a7/attachment.sig>
