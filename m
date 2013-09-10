From: B38611@freescale.com (Duan Fugang-B38611)
Date: Tue, 10 Sep 2013 10:42:44 +0000
Subject: kmalloc memory slower than malloc
In-Reply-To: <1378807816.4200.6.camel@weser.hi.pengutronix.de>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
Message-ID: <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Lucas Stach
Data: Tuesday, September 10, 2013 6:10 PM

> To: Thommy Jakobsson
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: kmalloc memory slower than malloc
> 
> Am Dienstag, den 10.09.2013, 11:54 +0200 schrieb Thommy Jakobsson:
> >
> > On Fri, 6 Sep 2013, Lucas Stach wrote:
> >
> > > This is the relevant part where you are mapping things uncached into
> > > userspace, so no wonder it is slower than cached malloc memory. If
> > > you want to use cached userspace mappings you need bracketed MMAP
> > > access, where you tell the kernel by using an ioctl or something
> > > that userspace is accessing the mapping so it can flush/invalidate
> > > caches at the right points in time.
> > Removing the pgprot_noncached() seems to make things more what I
> expected.
> > Both buffers takes about the same time to traverse in userspace. Thanks.
> >
> > I changed the code in my testprogram and driver to do the same thing
> > in kernelspace as well. And now I don't understand the result. The
> > result stepping through and adding all bytes in a page sized buffer is
> > about 4-5 times faster to do in the kernel. This is the times for
> > looping through the buffer 10000 times on a imx6:
> > dma_alloc_coherent in kernel   4.256s (s=0)
> > kmalloc in kernel              0.126s (s=86700000)
> > dma_alloc_coherent userspace   0.566s (s=0)
> > kmalloc in userspace          0.566s (s=86700000)
> > malloc in userspace          0.566s (s=0)
> >
> How do you init the kmalloc memory? If you do a memset right before the
> test loop your "kmalloc in kernel" will most likely always hit in the L1
> cache, that's why it's really fast to do.
> 
> The userspace mapping of the kmalloc memory will get a different virtual
> address than the kernel mapping. So if you do a memset in kernelspace, but
> the test loop in userspace you'll always miss the cache as the ARM
> v7 caches are virtually indexed. So the processor always fetches data from
> memory. The performance advantage against an uncached mapping is entirely
> due to the fact that you are fetching whole cache lines
> (32bytes) from memory at once, instead of doing a memory/bus transaction
> per byte.
> 
> Regards,
> Lucas
About the diff:
dma_alloc_coherent in kernel   4.256s (s=0)
dma_alloc_coherent userspace   0.566s (s=0)

I think it call remap_pfn_range() with page attribute (vma->vm_page_prot) transferred from mmap() maybe cacheable.
So the performance is the same as malloc/kmalloc in userspace.

Regards,
Andy
