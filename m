From: dhylands@gmail.com (Dave Hylands)
Date: Tue, 24 Aug 2010 09:50:15 -0700
Subject: Problems with dma_alloc_writecombine
In-Reply-To: <AANLkTi=kbch5XF99nmjRsy_f2akwQwCR7co7eN=SDd0w@mail.gmail.com>
References: <AANLkTi=kbch5XF99nmjRsy_f2akwQwCR7co7eN=SDd0w@mail.gmail.com>
Message-ID: <AANLkTi=-choRCYyU2KA7D2asOqLGwe5BJddt9mgV81KP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replying to my own post....

On Fri, Aug 20, 2010 at 8:14 PM, Dave Hylands wrote:
> Hi,
>
> We've observed a problem with dma_alloc_writecombine when the system
> is under heavy load (heavy bus traffic).

I found the problem (well I think I found the problem)

The armv6_set_pte_ext function (from arch/arm/mm/proc-macros.S) does
this at the end:

	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte

which doesn't wait for the write to hit the memory. I added

	mcr	p15, 0, r0, c7, c10, 4		@ dsb

which ensures that the write buffer has been drained before
continuing, and my problem goes away.

I wasn't sure if the dsb is a complete superset of flush_pte. If it
is, then the flush_pte can be replaced with a dsb (for my test, I
added the dsb).

I found some references in the ARM literature:
<http://infocenter.arm.com/help/topic/com.arm.doc.genc007826/Barrier_Litmus_Tests_and_Cookbook_A08.pdf>

In "9.2.1 Ensuring the visibility of updates to instructions for a
uniprocessor" (page 24) they use the dsb instruction, where the
armv6_set_pte_ext function doesn't. Their example also covers the more
general case where the page could refer to instructions or data,
whereas the dma stuff is data only.

I've checked the sources, and the problem still seems to exist in the
latest kernel (2.6.35).

I've never submitted a patch to the kernel before. Is there a web page
which describes the process?

I gather from other posts that using gmail is unacceptable - which is
fine, I have other email accounts I can use to actually submit the
patch.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
