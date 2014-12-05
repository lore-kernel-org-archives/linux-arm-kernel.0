From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 13:23:32 +0000
Subject: using DMA-API on ARM
In-Reply-To: <F51492713EF10846800D8C0ED37A7DCE019016E1@SJEXCHMB15.corp.ad.broadcom.com>
References: <5481794E.4050406@broadcom.com>
 <20141205094507.GP11285@n2100.arm.linux.org.uk>
 <20141205122423.GK1630@arm.com>
 <F51492713EF10846800D8C0ED37A7DCE019016E1@SJEXCHMB15.corp.ad.broadcom.com>
Message-ID: <20141205132332.GS11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please wrap your message - replying to a message which looks like this in
my editor is far from easy, and gives me much more work to /manually/
reformat it before I can reply to it:

On Fri, Dec 05, 2014 at 12:56:45PM +0000, Hante Meuleman wrote:
> The problem is with data coming from device, so DMA from device to host. The $
>
> However: this indicates that dma_alloc_coherent on an ARM target may result i$
>
> Regards,
> Hante

Thanks.

On Fri, Dec 05, 2014 at 12:56:45PM +0000, Hante Meuleman wrote:
> However: this indicates that dma_alloc_coherent on an ARM target may
> result in a memory buffer which can be cached which conflicts with
> the API of this function.

If the memory has an alias which is cacheable, it is possible for cache
lines to get allocated via that alias, even if the alias has no explicit
accesses to it.

This is something which I've been going on for quite literally /years/ -
mismatched cache attributes can cause unpredictable behaviour.  I've had
a lot of push back from people who are of the opinion that "if it works
for me, then there isn't a problem" and I eventually gave up fighting
the battle, especially as the ARM architecture people weakened my
reasoning behind it by publishing a relaxation of the "no differing
attributes" issue.  This was particularly true of those who wanted to
use ioremap() on system memory - and cases such as
dma_init_coherent_memory().

So, I never fixed this problem in the original DMA allocator code; I
basically gave up with it.  It's a latent bug which did need to be fixed,
and is still present today in the non-CMA case.

The symptoms which you are reporting sound very much like this kind of
problem - the virtual address for the memory returned by
dma_alloc_coherent() will not be cacheable memory - it will have been
remapped using map_vm_area().  However, there could very well be a fully
cacheable lowmem mapping of that memory, which if a read (speculative or
otherwise) will bring a cache line in, and because the caches are VIPT
or PIPT, that cache line can be hit via the non-cacheable mapping too.

What I /really/ need is more evidence of this to tell those disbelievers
where to stick their flawed arguments. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
