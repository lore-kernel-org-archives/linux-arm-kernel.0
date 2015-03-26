From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Mar 2015 01:26:22 +0000
Subject: [PATCH 0/4] RFC: split text and linear mappings using tagged
 pointers
In-Reply-To: <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150326012622.GB1676@flaeskesteg-linux.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Mar 23, 2015 at 03:36:52PM +0000, Ard Biesheuvel wrote:
> This implements a split mapping of the kernel Image using the AArch64
> tagged pointers feature. The kernel text is emitted with bit 56 cleared,
> which can be used by the virt to phys translation to choose one translation
> regime or another.

This looks neat!

I definitely want to see the linear mapping decoupled from the text mapping,
but I'm rather worried by the prospect of tagged pointers in the kernel (there
are a lot of edge cases for those w.r.t. the preservations of the tag bits),
and if possible I'd like to avoid their use. I think that we can achieve the
same effect by reorganising the VA layout within the 56 bits we have to play
with.

Nit: please s/translation regime/mapping/ (or some other wording to that
effect) for these patches; the architectural definition of "translation regime"
differs from what you're referring to here, and we should avoid overloading
that terminology.

Thanks,
Mark.

> The purpose is to allow PHYS_OFFSET to start at an arbitrary offset below
> the kernel image, so that memory below the kernel Image can be used, allowing
> the Image to be loaded anywhere in physical memory.
>
> This series moves the kernel text right below PAGE_OFFSET, next to the modules
> area. PHYS_OFFSET is chosen to be a suitable aligned boundary somewhere below
> the kernel Image (1 GB or 512 MB depending on chosen page size).
> 
> Output from a QEMU/EFI boot:
> 
> System RAM:
>  memory[0x0]	[0x00000040000000-0x000000bfffffff], 0x80000000 bytes flags: 0x0
> 
> Kernel image:
>  reserved[0x0]	[0x0000005f680000-0x0000005fe68fff], 0x7e9000 bytes flags: 0x0
> 
> Virtual kernel memory layout:
>     vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
>     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>               0xffffffbdc1000000 - 0xffffffbdc3000000   (    32 MB actual)
>     fixed   : 0xffffffbff69fd000 - 0xffffffbff6c00000   (  2060 KB)
>     PCI I/O : 0xffffffbff6e00000 - 0xffffffbff7e00000   (    16 MB)
>     modules : 0xffffffbff8000000 - 0xffffffbffc000000   (    64 MB)
>     memory  : 0xffffffc000000000 - 0xffffffc080000000   (  2048 MB)
>       .init : 0xfeffffbffc783000 - 0xfeffffbffc7c6000   (   268 KB)
>       .text : 0xfeffffbffc080000 - 0xfeffffbffc782344   (  7177 KB)
>       .data : 0xfeffffbffc7ca000 - 0xfeffffbffc830c00   (   411 KB)
> 
> Note that this time, no relocations were harmed in the making of these
> patches. With added relocation support, it should be possible to move
> the combined modules and kernel text anywhere in the vmalloc area (for
> kaslr)
> 
> There are probably some places where the cleared bit 56 in the virtual
> address may cause trouble. Known problem is the module loader, but there
> are surely others.
> 
> 
> Ard Biesheuvel (4):
>   arm64: use tagged pointers to distinguish kernel text from the linear
>     mapping
>   arm64: fixmap: move translation tables to dedicated region
>   arm64: move kernel text below PAGE_OFFSET
>   arm64: align PHYS_OFFSET to block size
> 
>  arch/arm64/include/asm/linkage.h       |  2 ++
>  arch/arm64/include/asm/memory.h        | 27 +++++++++++++++++--
>  arch/arm64/include/asm/pgtable-hwdef.h |  1 +
>  arch/arm64/kernel/head.S               | 48 +++++++++++++++++++++++++---------
>  arch/arm64/kernel/vmlinux.lds.S        | 19 +++++++++-----
>  arch/arm64/mm/mmu.c                    | 21 +++++++++------
>  arch/arm64/mm/proc.S                   |  3 ++-
>  7 files changed, 91 insertions(+), 30 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
