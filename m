From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2009 20:57:02 +0100
Subject: Highmem crash
In-Reply-To: <049b01ca32e8$01b7baa0$LocalHost@wipultra793>
References: <049b01ca32e8$01b7baa0$LocalHost@wipultra793>
Message-ID: <20090911195702.GA28199@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2009 at 07:28:56PM +0530, Hemanth V wrote:
> I am seeing the below crash if I pass __GFP_HIGHMEM flag to
> dma_alloc_coherent. Is this a known issue. I am currently using
> 2.6.31-rc7 kernel along with 2 latest highmem patches from Nicolas Pitre
> tree (http://git.marvell.com/?p=orion.git;a=summary).

You can't just throw __GFP_HIGHMEM at the code without understanding:

(a) how highmem works
(b) what changes with a highmem page
(c) what other changes the code therefore requires

Nevertheless, allowing DMA pages from highmem is something I do want
to permit.

The issue is that for highmem pages, page_address(page) is not valid.
It has to be kmapped.  However, the right kmap function needs to be
called (since it may be atomic) and a kmap number needs to be allocated
to make sure it doesn't clash with other kmap_atomic users.
