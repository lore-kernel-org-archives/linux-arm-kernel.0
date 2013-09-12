From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 17:19:55 +0100
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309121121400.2567@kelly.ryd.net>
References: <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
 <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
 <alpine.DEB.2.02.1309101327340.1305@kelly.ryd.net>
 <9848F2DB572E5649BA045B288BE08FBE016A9EE8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130910114420.GC12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309101435430.1305@kelly.ryd.net>
 <20130910125048.GD12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309121121400.2567@kelly.ryd.net>
Message-ID: <20130912161955.GP12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 05:58:22PM +0200, Thommy Jakobsson wrote:
> 
> 
> On Tue, 10 Sep 2013, Russell King - ARM Linux wrote:
> > What it means is that the results you end up with are documented to be
> > "unpredictable" which gives scope to manufacturers to come up with any
> > behaviour they desire in that situation - and it doesn't have to be
> > consistent.
> > 
> > What that means is that if you have an area of physical memory mapped as
> > "normal memory cacheable" and it's also mapped "strongly ordered" elsewhere,
> > it is entirely legal for an access via the strongly ordered mapping to
> > hit the cache if a cache line exists, whereas another implementation
> > may miss the cache line if it exists.
> > 
> > Furthermore, with such mappings (and this has been true since ARMv3 days)
> > if you have two such mappings - one cacheable and one non-cacheable, and
> > the cacheable mapping has dirty cache lines, the dirty cache lines can be
> > evicted at any moment, overwriting whatever you're doing via the non-
> > cacheable mapping.
>
> But isn't the memory received with dma_alloc_coherent() given a noncached 
> mapping? or even strongly ordered? Will that not conflict with the normal 
> kernel mapping which is cached?

dma_alloc_coherent() and dma_map_single()/dma_map_page() both know about
the issues and deal with any dirty cache lines - they also try and map
the memory as compatibly as possible with any existing mapping.

On pre-ARMv6, dma_alloc_coherent() will provide memory which is "non-cached
non-bufferable" - C = B = 0.  This is also called "strongly ordered" on
ARMv6 and later.  You get this with pgprot_uncached(), or
pgprot_dmacoherent() on pre-ARMv6 architectures.

On ARMv6+, it provides memory which is "memory like, uncached".  This
is what you get when you use pgprot_dmacoherent() on ARMv6 or later.

On ARMv6+, there are three classes of mapping: strongly ordered, device,
and memory-like.  Strongly ordered and device are both non-cacheable.
However, memory-like can be cacheable, and the cache properties can be
specified.  All mappings of a physical address _should_ be of the same
"class".

dma_map_single()/dma_map_page() deal with the problem completely
differently - they don't setup a new mapping, instead they perform
manual cache maintanence to ensure that the data is appropriately
visible to either the CPU or the DMA engine after the appropriate
call(s).

> Comning back to the original issue; dissassembling the code I noticed that 
> the userspace code looked really stupid with a lot of unnecessary memory 
> accesses. Kernel looked much better. Even after commenting the actual 
> memory access out in userspace, leaving just the loop itself, I got 
> terrible times.

Oh, you're not specifying any optimisation what so ever?  That'll be
the reason then - the compiler won't do _any_ optimisation unless you
ask it to.  That means it'll do stuff like saving an interator out on
the stack and then immediately read it back in, increment it, and
write it back out again.

> Kernel is with -O2 so compiling the testprogram with -O2 aswell yield more 
> reasonable results:
> dma_alloc_coherent in kernel   4.257s (s=0)
> kmalloc in kernel              0.126s (s=84560000)
> dma_alloc_coherent userspace   0.124s (s=0)
> kmalloc in userspace          0.124s (s=84560000)
> malloc in userspace          0.113s (s=0)

Great, glad you solved it.

Note however that the kmalloc version is not realistic of what's required
for the CPU to provide or read DMA data: between the CPU accessing the
data and the DMA engine accessing it, there needs to be a cache flush,
which will consume additional time.  That's where using the dma_map_*,
dma_unmap_* or dma_sync_* functions come in.
