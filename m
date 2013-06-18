From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jun 2013 16:29:05 +0100
Subject: [PATCH 1/2] ARM: mmu: fix the hang when we steal a section
 unaligned size memory
In-Reply-To: <1371113826-1231-1-git-send-email-b32955@freescale.com>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
Message-ID: <20130618152905.GB8534@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 09:57:05AM +0100, Huang Shijie wrote:
> If we want to steal 128K memory in the machine_desc->reserve() hook, we
> will hang up immediately.
> 
> The hang reason is like this:
> 
>   [1] Stealing 128K makes the left memory is not aligned with the SECTION_SIZE.
> 
>   [2] So when the map_lowmem() tries to maps the lowmem memory banks,
>       it will call the memblock_alloc(in early_alloc_aligned()) to allocate
>       a page to store the pte. This pte page is in the unaligned region
>       which is not mapped yet.
> 
>   [3] And when we use the memset() in the early_alloc_aligned(), we will hang
>       right now.
> 
>   [4] The hang only occurs in the map_lowmem(). After the map_lowmem(), we have
>       setup the PTE mappings. So in the later places, such as
>       dma_contiguous_remap(), the hang will never occurs,
> 
> This patch adds a global variable, in_map_lowmem, to check if we are in
> the map_lowmem() or not. If we are in the map_lowmem(), and we steal
> a SECTION_SIZE unaligned memory, we will use the memblock_alloc_base()
> to allocate the pte page. The @max_addr for memblock_alloc_base() is the
> last mapped address.

Wouldn't this be better achieved with a parameter, rather than a global
state variable? That said, I don't completely follow why memblock_alloc is
giving you back an unmapped physical address. It sounds like we're freeing
too much as part of the stealing (or simply that stealing has to be section
aligned), but memblock only deals with physical addresses.

Could you elaborate please?

Will
