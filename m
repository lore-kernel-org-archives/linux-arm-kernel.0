From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Nov 2015 15:20:45 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151118152044.GD10644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Nov 18, 2015 at 09:03:19AM -0600, Jeremy Linton wrote:
> The HP m400 fails to boot the linux 4.4rc1 kernel. 

Are you using defconfig? If not, can you share your config?

> It usually hangs or sometimes takes an unhanded exception around the
> DMA zone messages. This was bisected to the new CONT PTE changes.

Do you have any examples of the unhandled exception cases? Are they a
mixed bag, or a consistent exception class?

> Adding an extra flush_tlb_all() in the code path which is
> changing the kernel permissions allows the machine to boot
> consistently.

As you mention changing permissions, I take it you're using
CONFIG_DEBUG_RODATA?

Thanks,
Mark.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e3f563c..e92fe77 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -121,6 +121,7 @@ static void __populate_init_pte(pte_t *pte, unsigned long addr,
>  		pfn++;
>  		addr += PAGE_SIZE;
>  	} while (addr != end);
> +	flush_tlb_all();
>  }
>  
>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
> -- 
> 2.4.3
> 
