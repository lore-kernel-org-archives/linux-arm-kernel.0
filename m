From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 17 May 2018 09:17:44 +0100
Subject: [PATCH] KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE
 aligned in unmap_stage2_range
In-Reply-To: <1526537487-14804-1-git-send-email-hejianet@gmail.com>
References: <1526537487-14804-1-git-send-email-hejianet@gmail.com>
Message-ID: <698b0355-d430-86b8-cd09-83c6d9e566f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jia,

On 17/05/18 07:11, Jia He wrote:
> I ever met a panic under memory pressure tests(start 20 guests and run
> memhog in the host).

Please avoid using "I" in the commit description and preferably stick to
an objective description.

> 
> The root cause might be what I fixed at [1]. But from arm kvm points of
> view, it would be better we caught the exception earlier and clearer.
> 
> If the size is not PAGE_SIZE aligned, unmap_stage2_range might unmap the
> wrong(more or less) page range. Hence it caused the "BUG: Bad page
> state"

I don't see why we should ever panic with a "positive" size value. Anyways,
the unmap requests must be in units of pages. So this check might be useful.


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> 
> [1] https://lkml.org/lkml/2018/5/3/1042
> 
> Signed-off-by: jia.he at hxt-semitech.com
> ---
>   virt/kvm/arm/mmu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 7f6a944..8dac311 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -297,6 +297,8 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>   	phys_addr_t next;
>   
>   	assert_spin_locked(&kvm->mmu_lock);
> +	WARN_ON(size & ~PAGE_MASK);
> +
>   	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>   	do {
>   		/*
> 
