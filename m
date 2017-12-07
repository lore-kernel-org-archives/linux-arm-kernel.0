From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 7 Dec 2017 15:57:30 +0000
Subject: [PATCH] KVM: arm/arm64: Fix HYP unmapping going off limits
In-Reply-To: <20171207114545.23845-1-marc.zyngier@arm.com>
References: <20171207114545.23845-1-marc.zyngier@arm.com>
Message-ID: <f9ba612e-4f68-2251-6fc3-27af8197ddc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/12/17 11:45, Marc Zyngier wrote:
> When we unmap the HYP memory, we try to be clever and unmap one
> PGD at a time. If we start with a non-PGD aligned address and try
> to unmap a whole PGD, things go horribly wrong in unmap_hyp_range
> (addr and end can never match, and it all goes really badly as we
> keep incrementing pgd and parse random memory as page tables...).
> 
> The obvious fix is to let unmap_hyp_range do what it does best,
> which is to iterate over a range.
> 
> Cc: stable at vger.kernel.org
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for the patch (and the hours of analysis that preceded it)!
So yes, that fixes the crash with 4.15-rc1 on my Midway (with the
original DT). As expected, KVM gets shuts down in the process, so no one
is at home under chardev 10/232 anymore - with this patch only, that is.

Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  virt/kvm/arm/mmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index b36945d49986..b4b69c2d1012 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -509,8 +509,6 @@ static void unmap_hyp_range(pgd_t *pgdp, phys_addr_t start, u64 size)
>   */
>  void free_hyp_pgds(void)
>  {
> -	unsigned long addr;
> -
>  	mutex_lock(&kvm_hyp_pgd_mutex);
>  
>  	if (boot_hyp_pgd) {
> @@ -521,10 +519,10 @@ void free_hyp_pgds(void)
>  
>  	if (hyp_pgd) {
>  		unmap_hyp_range(hyp_pgd, hyp_idmap_start, PAGE_SIZE);
> -		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
> -			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);
> -		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
> -			unmap_hyp_range(hyp_pgd, kern_hyp_va(addr), PGDIR_SIZE);
> +		unmap_hyp_range(hyp_pgd, kern_hyp_va(PAGE_OFFSET),
> +				(uintptr_t)high_memory - PAGE_OFFSET);
> +		unmap_hyp_range(hyp_pgd, kern_hyp_va(VMALLOC_START),
> +				VMALLOC_END - VMALLOC_START);
>  
>  		free_pages((unsigned long)hyp_pgd, hyp_pgd_order);
>  		hyp_pgd = NULL;
> 
