From: rabin@rab.in (Rabin Vincent)
Date: Fri, 14 Apr 2017 09:41:04 +0200
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <20170413222915.GF17774@n2100.armlinux.org.uk>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk>
Message-ID: <20170414074104.GA8704@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 11:29:15PM +0100, Russell King - ARM Linux wrote:
> > 00a19f3e25c0c40e0ec77f52d4841d23ad269169 is the first bad commit
> > commit 00a19f3e25c0c40e0ec77f52d4841d23ad269169
> > Author: Rabin Vincent <rabinv@axis.com>
> > Date:   Tue Nov 8 09:21:19 2016 +0100
> > 
> >     ARM: 8627/1: avoid cache flushing in flush_dcache_page()
> >     
> >     When the data cache is PIPT or VIPT non-aliasing, and cache operations
> >     are broadcast by the hardware, we can always postpone the flush in
> >     flush_dcache_page().  A similar change was done for ARM64 in commit
> >     b5b6c9e9149d ("arm64: Avoid cache flushing in flush_dcache_page()").
> >     
> >     Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >     Signed-off-by: Rabin Vincent <rabinv@axis.com>
> >     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > It seems that staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm
> > relies on the behavior of flush_dcache_page before this patch get
> > applied. Any advices to fix this issues are appreciated.
> 
> Any ideas why this causes a problem for this driver?  From what I can see,
> it doesn't make use of flush_dcache_page().

The driver's create_pagelist() uses get_free_pages(), and
get_free_pages() calls flush_dcache_page().

The problem is that the driver fails to flush the pages which it
acquires via get_free_pages().  It's clear that the driver needs to do
it, since there is a flush in the is_vmalloc_addr() path in the same
function.  The driver probably worked earlier because of the unecessary
flush in flush_dcache_page() which existed before this patch, but the
purpose of that flush was not DMA coherency and it was never guaranteed
that it would flush all the way to the point that devices could see the
data.

See radeon_ttm_tt_pin_userptr() in drivers/gpu/drm/radeon/radeon_ttm.c
for an example of how a driver can ensure cache coherency using the DMA
mapping API if it intends to DMA from/to pages acquired by
get_free_pages().

The rest of the driver should also be converted to the DMA mapping API
instead of abusing the API's private functions (dmac_map_area etc.)
