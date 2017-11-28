From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Nov 2017 18:35:52 +0000
Subject: [PATCH] arm64: kaslr: Fix kaslr end boundary of virt addr
In-Reply-To: <1511235853-8407-1-git-send-email-puck.chen@hisilicon.com>
References: <1511235853-8407-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <20171128183551.GP9266@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 11:44:13AM +0800, Chen Feng wrote:
> With kaslr and kasan enable both, I got the follow issue.
> 
> [   16.130523s]kasan: reg->base = 100000000, phys_end =1c0000000,start = ffffffff40000000, end = ffffffc000000000
> [   16.142517s]___alloc_bootmem_nopanic:257
> [   16.148284s]__alloc_memory_core_early:63, addr = 197fc7fc0
> [   16.155670s]__alloc_memory_core_early:65, virt = ffffffffd7fc7fc0
> [   16.163635s]__alloc_memory_core_early:67, toshow = ffffff8ffaff8ff8
> [   16.171783s]__alloc_memory_core_early:69, show_phy = ffffffe2649f8ff8
> [   16.180145s]Unable to handle kernel paging request at virtual address ffffff8ffaff8ff8
> [   16.189971s]pgd = ffffffad9c507000
> [   16.195220s][ffffff8ffaff8ff8] *pgd=0000000197fc8003, *pud=0000000197fc8003
> 
> *reg->base = 100000000, phys_end =1c0000000,start = ffffffff40000000, end = ffffffc000000000*
> 
> memstart_addr 0
> ARM64_MEMSTART_ALIGN 0x40000000
> memstart_offset_seed 0xffc7
> PHYS_OFFSET = 0 - memstart_addr = 0 - 3E40000000 = FFFFFFC1C0000000
> 
> reg->base = 0x100000000  -> 0xffffffff40000000
> phys_end  = 0x1c0000000  -> 0xffffffc000000000  This is confused, end less than start.
> 
> And In memblock it use "start_addr + size" as the end addr. So in function kasan_init,
> if the start >= end, it will not map the hole block address. But the memory in this
> block is valid. And it can be allocated as well.
> 
> So donot use the last memory region. Changing "range = range / ARM64_MEMSTART_ALIGN + 1" to
> range = range / ARM64_MEMSTART_ALIGN;
> 
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Chen Xiang <chenxiang9@huawei.com>
> ---
>  arch/arm64/mm/init.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Ard -- can you take a look at this please? I've not found time to page this
in, but if there's a fix in here somewhere then I'm happy to apply it.

Will

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 716d122..60112c0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -267,11 +267,8 @@ void __init arm64_memblock_init(void)
>  		 * margin, the size of the region that the available physical
>  		 * memory spans, randomize the linear region as well.
>  		 */
> -		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> -			range = range / ARM64_MEMSTART_ALIGN + 1;
> -			memstart_addr -= ARM64_MEMSTART_ALIGN *
> -					 ((range * memstart_offset_seed) >> 16);
> -		}
> +		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN)
> +			memstart_addr -= (range * memstart_offset_seed) >> 16;
>  	}
>  
>  	/*
> -- 
> 1.9.1
> 
