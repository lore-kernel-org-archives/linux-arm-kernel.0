From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Nov 2013 10:57:18 -0500
Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu
 mappings
In-Reply-To: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
References: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5286445E.2090300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013 10:40 AM, Marc Zyngier wrote:
> Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
> Thankfully, the kernel offers a way to obtain the physical address
> of such a mapping.
> 
> Add a new create_hyp_percpu_mappings function to deal with those.
> 
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Santosh, can you please give this new patch a spin on your HW?
> 
Works except to make guest boot on my machine, phys_addr_t
update is needed as discussed ;-)


> 
>  arch/arm/include/asm/kvm_mmu.h   |  1 +
>  arch/arm/kvm/arm.c               |  2 +-
>  arch/arm/kvm/mmu.c               | 32 ++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
[..]

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index b0de86b..f2a552b 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -331,6 +331,38 @@ int create_hyp_mappings(void *from, void *to)
>  }
>  
>  /**
> + * create_hyp_percpu_mappings - duplicate a percpu kernel virtual address
> + *				range in Hyp mode
> + * @from:	The virtual kernel start address of the range
> + * @to:		The virtual kernel end address of the range (exclusive)
> + *
> + * The same virtual address as the kernel virtual address is also used
> + * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
> + * physical pages. It *has* to be a percpu region.
> + */
> +int create_hyp_percpu_mappings(void *from, void *to)
> +{
> +	unsigned long phys_addr;
s/unsigned long/phys_addr_t

regards,
Santosh
