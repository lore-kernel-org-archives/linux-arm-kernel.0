From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Jan 2016 11:47:08 +0000
Subject: [PATCH] arm64: Honour !PTE_WRITE in set_pte_at() for kernel
 mappings
In-Reply-To: <CAKv+Gu9RbzCNi-UHbL52rP=vtfutxqy8Vkn=WkQ-UQqo2Csdmg@mail.gmail.com>
References: <1452182840-5120-1-git-send-email-catalin.marinas@arm.com>
 <CAKv+Gu9RbzCNi-UHbL52rP=vtfutxqy8Vkn=WkQ-UQqo2Csdmg@mail.gmail.com>
Message-ID: <20160111114708.GE9554@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 11:59:44AM +0100, Ard Biesheuvel wrote:
> This works, as far as I can tell. However, I still need the patch
> below to make sure that the KAsan zero page is mapped read-only. (The
> reason is that, depending on the alignment of the regions,
> kasan_populate_zero_shadow() may never call
> zero_[pud|pmd|pte]_populate())
> 
> Before this patch (and my change), the KAsan shadow regions looks like this:
> 
> 0xffffff8000000000-0xffffff8200800000  8200M RW NX SHD AF     UXN MEM/NORMAL
> 0xffffff8200800000-0xffffff8200c00000     4M RW NX SHD AF BLK UXN MEM/NORMAL
> 0xffffff8200c00000-0xffffff8800000000 24564M RW NX SHD AF     UXN MEM/NORMAL
> 0xffffff8800000000-0xffffff8820200000   514M RW NX SHD AF BLK UXN MEM/NORMAL
> 
> and after:
> 
> 0xffffff8000000000-0xffffff8200800000  8200M ro NX SHD AF     UXN MEM/NORMAL
> 0xffffff8200800000-0xffffff8200c00000     4M RW NX SHD AF BLK UXN MEM/NORMAL
> 0xffffff8200c00000-0xffffff8800000000 24564M ro NX SHD AF     UXN MEM/NORMAL
> 0xffffff8800000000-0xffffff8820200000   514M RW NX SHD AF BLK UXN MEM/NORMAL
> 
> 
> ---------8<--------------
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 72fe2978b38a..c3c14204d196 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -140,6 +140,7 @@ void __init kasan_init(void)
>  {
>         u64 kimg_shadow_start, kimg_shadow_end;
>         struct memblock_region *reg;
> +       int i;
> 
>         kimg_shadow_start = round_down((u64)kasan_mem_to_shadow(_text),
>                                        SWAPPER_BLOCK_SIZE);
> @@ -185,6 +186,14 @@ void __init kasan_init(void)
>                                 pfn_to_nid(virt_to_pfn(start)));
>         }
> 
> +       /*
> +        * KAsan may reuse the current contents of kasan_zero_pte
> directly, so we
> +        * should make sure that it maps the zero page read-only.
> +        */
> +       for (i = 0; i < PTRS_PER_PTE; i++)
> +               set_pte(&kasan_zero_pte[i],
> +                       pfn_pte(virt_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
> +
>         memset(kasan_zero_page, 0, PAGE_SIZE);
>         cpu_replace_ttbr1(swapper_pg_dir);

That's complementary to my patch. Could you please send it with a proper
description so that Will can pick them up? For your patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
