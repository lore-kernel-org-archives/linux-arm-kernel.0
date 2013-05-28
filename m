From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 May 2013 13:52:27 -0400 (EDT)
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <20130528095528.GA14329@arm.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
 <20130523104303.GC16722@arm.com>
 <alpine.LFD.2.03.1305242350220.1918@syhkavp.arg>
 <20130528095528.GA14329@arm.com>
Message-ID: <alpine.LFD.2.03.1305281340240.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 May 2013, Catalin Marinas wrote:

> On Sat, May 25, 2013 at 04:53:19AM +0100, Nicolas Pitre wrote:
> > On Thu, 23 May 2013, Catalin Marinas wrote:
> > 
> > > An issue is that for kunmap_atomic() && VIVT we flush the same page
> > > twice. I don't think we should remove the cache flushing in
> > > __kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
> > > flush_kernel_dcache_page() (unless we just assume that highmem && vivt
> > > don't work together).
> > 
> > VIVT and highmem do work together.  Highmem for ARM was in fact 
> > developed on such a platform.
> 
> Thanks for confirming. Do you remember why kunmap() doesn't (need to)
> flush the cache alias (for VIVT)? Or if it does, where?

kunmap() calls kunmap_high() which actually does not unmap anything but 
only decrement a use count.  The page is kept around in case it is 
kmap()'d again, in which case the kmap() will be almost free and the 
page still warm.

It is only when the kmap() for a new page runs out of free pkmap  
entries that the unused but still mapped pages are unmapped.  This 
unmapping is done in flush_all_zero_pkmaps() where all the unused pages 
are all unmapped at once.  The cache for all those pages is flushed with 
flush_cache_kmaps() which on ARM maps to flush_cache_all() when the 
cache is VIVT.


Nicolas
