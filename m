From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Aug 2010 19:24:16 +0100
Subject: Problems with dma_alloc_writecombine
In-Reply-To: <AANLkTi=-choRCYyU2KA7D2asOqLGwe5BJddt9mgV81KP@mail.gmail.com>
References: <AANLkTi=kbch5XF99nmjRsy_f2akwQwCR7co7eN=SDd0w@mail.gmail.com>
	<AANLkTi=-choRCYyU2KA7D2asOqLGwe5BJddt9mgV81KP@mail.gmail.com>
Message-ID: <20100825182416.GA30772@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 09:50:15AM -0700, Dave Hylands wrote:
> Replying to my own post....
> 
> On Fri, Aug 20, 2010 at 8:14 PM, Dave Hylands wrote:
> > Hi,
> >
> > We've observed a problem with dma_alloc_writecombine when the system
> > is under heavy load (heavy bus traffic).
> 
> I found the problem (well I think I found the problem)
> 
> The armv6_set_pte_ext function (from arch/arm/mm/proc-macros.S) does
> this at the end:
> 
> 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> 
> which doesn't wait for the write to hit the memory. I added
> 
> 	mcr	p15, 0, r0, c7, c10, 4		@ dsb
> 
> which ensures that the write buffer has been drained before
> continuing, and my problem goes away.
> 
> I wasn't sure if the dsb is a complete superset of flush_pte. If it
> is, then the flush_pte can be replaced with a dsb (for my test, I
> added the dsb).
> 
> I found some references in the ARM literature:
> <http://infocenter.arm.com/help/topic/com.arm.doc.genc007826/Barrier_Litmus_Tests_and_Cookbook_A08.pdf>
> 
> In "9.2.1 Ensuring the visibility of updates to instructions for a
> uniprocessor" (page 24) they use the dsb instruction, where the
> armv6_set_pte_ext function doesn't. Their example also covers the more
> general case where the page could refer to instructions or data,
> whereas the dma stuff is data only.

Partly that's because it's overhead which we don't need there.  Probably
a better solution is to add the dsb() to __dma_alloc_remap() like this:

 arch/arm/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c704eed..4bc43e5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -229,6 +229,8 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 			}
 		} while (size -= PAGE_SIZE);
 
+		dsb();
+
 		return (void *)c->vm_start;
 	}
 	return NULL;
