From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Sep 2013 13:50:48 +0100
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309101435430.1305@kelly.ryd.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
 <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
 <1378807816.4200.6.camel@weser.hi.pengutronix.de>
 <9848F2DB572E5649BA045B288BE08FBE016A9D4A@039-SN2MPN1-023.039d.mgd.msft.net>
 <alpine.DEB.2.02.1309101327340.1305@kelly.ryd.net>
 <9848F2DB572E5649BA045B288BE08FBE016A9EE8@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130910114420.GC12758@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1309101435430.1305@kelly.ryd.net>
Message-ID: <20130910125048.GD12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 02:42:17PM +0200, Thommy Jakobsson wrote:
> Using pgprot_dmacoherent() in mmap they look more similar. Still 
> ~10-15% difference, but maybe that is normal for kernel/userspace. 
> 
> dma_alloc_coherent in kernel   4.257s (s=0)
> kmalloc in kernel              0.126s (s=81370000)
> dma_alloc_coherent userspace   4.907s (s=0)
> kmalloc in userspace          1.815s (s=81370000)
> malloc in userspace          0.566s (s=0)
> 
> Note that I was lazy and used the same pgprot for all mappings now, which 
> I guess is a violation. 

What it means is that the results you end up with are documented to be
"unpredictable" which gives scope to manufacturers to come up with any
behaviour they desire in that situation - and it doesn't have to be
consistent.

What that means is that if you have an area of physical memory mapped as
"normal memory cacheable" and it's also mapped "strongly ordered" elsewhere,
it is entirely legal for an access via the strongly ordered mapping to
hit the cache if a cache line exists, whereas another implementation
may miss the cache line if it exists.

Furthermore, with such mappings (and this has been true since ARMv3 days)
if you have two such mappings - one cacheable and one non-cacheable, and
the cacheable mapping has dirty cache lines, the dirty cache lines can be
evicted at any moment, overwriting whatever you're doing via the non-
cacheable mapping.

I've recently had a hard-to-track bug doing exactly that in a non-mainline
kernel on ARMv7 because someone decided it was a good idea to bypass my
test in arch/arm/mm/ioremap.c preventing system RAM being ioremap()d.  It
lead to one boot in 20ish locking up because a GPU command stream was
being overwritten by the dirty cache lines being evicted after the GPU
had started to read from that memory - or, if you typed "reboot" at the
right moment during a previous boot, you could get it to occur 100% of
the time.

I notice you turn off VM_IO - you don't want to do that...
