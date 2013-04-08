From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Apr 2013 11:55:57 +0100
Subject: [PATCH 2/2] mm: vmemmap: arm64: add vmemmap_verify check for
 hot-add node case
In-Reply-To: <1365415000-10389-3-git-send-email-linfeng@cn.fujitsu.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <1365415000-10389-3-git-send-email-linfeng@cn.fujitsu.com>
Message-ID: <20130408105556.GB17476@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 08, 2013 at 10:56:40AM +0100, Lin Feng wrote:
> In hot add node(memory) case, vmemmap pages are always allocated from other
> node, but the current logic just skip vmemmap_verify check. 
> So we should also issue "potential offnode page_structs" warning messages
> if we are the case.
> 
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Lin Feng <linfeng@cn.fujitsu.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 70b8cd4..9f1e417 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -427,8 +427,8 @@ int __meminit vmemmap_populate(struct page *start_page,
>  				return -ENOMEM;
>  
>  			set_pmd(pmd, __pmd(__pa(p) | prot_sect_kernel));
> -		} else
> -			vmemmap_verify((pte_t *)pmd, node, addr, next);
> +		}
> +		vmemmap_verify((pte_t *)pmd, node, addr, next);
>  	} while (addr = next, addr != end);
>  
>  	return 0;

Given that we don't have NUMA support or memory-hotplug on arm64 yet, I'm
not sure that this change makes much sense at the moment. early_pfn_to_nid
will always return 0 and we only ever have one node.

To be honest, I'm not sure what that vmemmap_verify check is trying to
achieve anyway. ia64 does some funky node affinity initialisation early on
but, for the rest of us, it looks like we always just check the distance
from node 0.

Will
