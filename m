From: Trond.Myklebust@netapp.com (Trond Myklebust)
Date: Wed, 05 Jan 2011 13:12:25 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20110105172641.GF8638@n2100.arm.linux.org.uk>
References: <1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<20110105134045.GS25121@pengutronix.de>
	<1294239193.3014.9.camel@heimdal.trondhjem.org>
	<4D2487CA.5040501@pengutronix.de>
	<1294240457.3014.13.camel@heimdal.trondhjem.org>
	<20110105155230.GC8638@n2100.arm.linux.org.uk>
	<1294247847.2998.23.camel@heimdal.trondhjem.org>
	<20110105172641.GF8638@n2100.arm.linux.org.uk>
Message-ID: <1294251145.3574.16.camel@heimdal.trondhjem.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-05 at 17:26 +0000, Russell King - ARM Linux wrote: 
> On Wed, Jan 05, 2011 at 12:17:27PM -0500, Trond Myklebust wrote:
> > We should already be flushing the kernel direct mapping after writing by
> > means of the calls to flush_dcache_page() in xdr_partial_copy_from_skb()
> > and all the helpers in net/sunrpc/xdr.c.
> 
> Hmm, we're getting into the realms of what flush_dcache_page() is supposed
> to do and what it's not supposed to do.
> 
> Is this page an associated with a mapping (iow, page_mapping(page) is non-
> NULL)?  If not, flush_dcache_page() won't do anything, and from my
> understanding, its flush_anon_page() which you want to be using there
> instead.

Actually, none of these pages are ever mapped into userspace, nor are
they mapped into the page cache.

They are allocated directly using alloc_page() by the thread that called
the readdir() syscall, so afaics there should be no incoherent mappings
other than the kernel direct mapping and the one created by
vm_map_ram().

So, yes, you are right that we don't need the flush_dcache_page() here.

> > The only new thing is the read access through the virtual address
> > mapping. That mapping is created outside the loop in
> > nfs_readdir_xdr_to_array(), which is why I'm thinking we do need the
> > invalidate_kernel_vmap_range(): we're essentially doing a series of
> > writes through the kernel direct mapping (i.e. readdir RPC calls), then
> > reading the results through the virtual mapping.
> > 
> > i.e. we're doing
> > 
> > ptr = vm_map_ram(lowmem_pages);
> > while (need_more_data) {
> > 
> > for (i = 0; i < npages; i++) {
> > addr = kmap_atomic(lowmem_page[i]);
> > *addr = rpc_stuff;
> > flush_dcache_page(lowmem_page[i]);
> > kunmap_atomic(lowmem_page[i]);
> > }
> > 
> > invalidate_kernel_vmap_range(ptr); // Needed here?
> 
> Yes, you're going to need some cache maintainence in there to make it work,
> because accessing 'ptr' will load that data into the cache, and that won't
> be updated by the writes via kmap_atomic().
> 
> Provided you don't write to ptr, then using invalidate_kernel_vmap_range()
> will be safe.

Thanks! That is what Marc's testing appears to confirm.

-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust at netapp.com
www.netapp.com
