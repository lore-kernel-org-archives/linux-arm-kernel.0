From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2012 17:19:15 +0000
Subject: [PATCH 3/3] ARM: dma-mapping: fix array out of bound access
In-Reply-To: <1329494160-26942-1-git-send-email-ajeet.yadav.77@gmail.com>
References: <1329494160-26942-1-git-send-email-ajeet.yadav.77@gmail.com>
Message-ID: <20120217171915.GO27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 09:26:00PM +0530, Ajeet Yadav wrote:
> In __dma_alloc_remap(*,size,*,*)/ __dma_free_remap(*,size) functions
> if virtual address is in the last consistent mapping region
> i.e idx == ((CONSISTENT_END - base) >> PMD_SHIFT) - 1
> and off == PTRS_PER_PTE.
> then we have array out of bound access condition.

How?  Where?

At the first loop, off will _never_ be PTRS_PER_PTE.

                u32 off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);

There is _absolutely_ _no_ _way_ that off could ever be PTRS_PER_PTE
here.

If 'base' is CONSISTENT_END, then we have far bigger problems, because
it means that we have a zero sized region - it certainly can't be any
larger than zero size because then we'd be overflowing the DMA region
into something else.

Plus, we know that 'end of region' allocations work fine, because the
code allocates from the top of the region downwards.

So, I don't think there's a problem here.
