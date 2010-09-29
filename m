From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 15:51:21 +0100
Subject: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED
	L1 entries
In-Reply-To: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 17 Sep 2010 15:17:45 +0530")
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <tnxzkv0hac6.fsf@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
> types so that at boot-up, we can map memories outside system memory
> at page level granularity
>
> Previously the mapping was limiting to section level, which creates
> unnecessary addiotional mapping for which physical memory may not
> present. On the newer ARM with speculation, this is dangerous and can
> result in untraceable aborts.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/mm/mmu.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 6e1c4f6..3e986a6 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -246,6 +246,9 @@ static struct mem_type mem_types[] = {
>  		.domain    = DOMAIN_USER,
>  	},
>  	[MT_MEMORY] = {
> +		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> +				L_PTE_USER | L_PTE_EXEC,
> +		.prot_l1   = PMD_TYPE_TABLE,

Just a quick question - does this need to have L_PTE_USER? Is it
read-only or it needs L_PTE_WRITE as well?

Thanks.

-- 
Catalin
