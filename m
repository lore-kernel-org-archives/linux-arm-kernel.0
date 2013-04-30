From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Apr 2013 12:22:25 +0100
Subject: [PATCH V3 2/2] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130421220629.GA25571@schnuecks.de>
References: <20121008174428.GB3204@arm.com>
 <20121008200216.GA14167@schnuecks.de>
 <20121008202040.GC4625@n2100.arm.linux.org.uk>
 <20121008230733.GA17819@schnuecks.de>
 <20121118211005.GW22106@titan.lakedaemon.net>
 <20130418111608.GF27197@titan.lakedaemon.net>
 <20130418112201.GQ14496@n2100.arm.linux.org.uk>
 <20130418114016.GG27197@titan.lakedaemon.net>
 <20130418135104.GA18616@arm.com>
 <20130421220629.GA25571@schnuecks.de>
Message-ID: <20130430112225.GD29766@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 11:06:30PM +0100, Simon Baatz wrote:
> On Thu, Apr 18, 2013 at 02:51:04PM +0100, Catalin Marinas wrote:
> > On Thu, Apr 18, 2013 at 12:40:16PM +0100, Jason Cooper wrote:
> > > Ok, got it.  I should have been more explicit.  LVM doesn't work on ARM.
> > > iirc, Simon had a demo of dm-crypt also faulting on ARM.  This patch was
> > > not the correct approach.  Is there an interest (particularly Simon) in
> > > fixing the problem?
> > 
> > I think fixing this for ARM is useful but I don't have any time to
> > allocate. I think I acked the first patch in the series but I don't
> > fully remember the details behind the second one.
> > 
> > As Russell said, flush_kernel_dcache_page() is not the right API.
> 
> It is not the driver itself which is using the API, it is the
> generic scatterlist memory iterator. And I don't think that this is
> wrong, as I have tried to explain in [1].

Trying to remember what we've discussed over the past months on this
topic. It looks like sg_miter_stop() does the right thing in calling
flush_kernel_dcache_page(). Commit f8b63c1 (ARM: 6382/1: Remove
superfluous flush_kernel_dcache_page()) removed this function entirely.
The code previously had this comment - /* highmem pages are always
flushed upon kunmap already */ which I think it wasn't fully correct
either. The kunmap_atomic() flushes the caches but kunmap() doesn't, so
I suspect we only get the flushing if SG_MITER_ATOMIC.

So it looks to me like flush_kernel_dcache_page() should be implemented
even for highmem pages (with VIVT or aliasing VIPT, at least for non
kmap_atomic addresses by checking for FIXADDR_START). If highmem is
disabled, I suspect we still need this function since the calling code
doesn't care whether kmap/kunmap was a no-op. But can we keep it as a
simple call to __cpuc_flush_dcache_area(page_address(page), PAGE_SIZE)?

-- 
Catalin
