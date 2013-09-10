From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Sep 2013 12:10:16 +0200
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
Message-ID: <1378807816.4200.6.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 10.09.2013, 11:54 +0200 schrieb Thommy Jakobsson:
> 
> On Fri, 6 Sep 2013, Lucas Stach wrote:
> 
> > This is the relevant part where you are mapping things uncached into
> > userspace, so no wonder it is slower than cached malloc memory. If you
> > want to use cached userspace mappings you need bracketed MMAP access,
> > where you tell the kernel by using an ioctl or something that userspace
> > is accessing the mapping so it can flush/invalidate caches at the right
> > points in time.
> Removing the pgprot_noncached() seems to make things more what I expected. 
> Both buffers takes about the same time to traverse in userspace. Thanks.
> 
> I changed the code in my testprogram and driver to do the same thing in 
> kernelspace as well. And now I don't understand the result. The result 
> stepping through and adding all bytes in a page sized buffer is about 4-5 
> times faster to do in the kernel. This is the times for looping through 
> the buffer 10000 times on a imx6:
> dma_alloc_coherent in kernel   4.256s (s=0)
> kmalloc in kernel              0.126s (s=86700000)
> dma_alloc_coherent userspace   0.566s (s=0)
> kmalloc in userspace          0.566s (s=86700000)
> malloc in userspace          0.566s (s=0)
> 
How do you init the kmalloc memory? If you do a memset right before the
test loop your "kmalloc in kernel" will most likely always hit in the L1
cache, that's why it's really fast to do.

The userspace mapping of the kmalloc memory will get a different virtual
address than the kernel mapping. So if you do a memset in kernelspace,
but the test loop in userspace you'll always miss the cache as the ARM
v7 caches are virtually indexed. So the processor always fetches data
from memory. The performance advantage against an uncached mapping is
entirely due to the fact that you are fetching whole cache lines
(32bytes) from memory at once, instead of doing a memory/bus transaction
per byte.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
