From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 15:01:25 +0200
Subject: [PATCH 2/6] arm/arm64: KVM: fix potential NULL dereference in
 user_mem_abort()
In-Reply-To: <1410990981-665-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140929130125.GB25697@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:56:17PM -0700, Ard Biesheuvel wrote:
> Handle the potential NULL return value of find_vma_intersection()
> before dereferencing it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kvm/mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 152e0f896e63..c093e95ff7ef 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -776,7 +776,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	/* Let's check if we will get back a huge page backed by hugetlbfs */
>  	down_read(&current->mm->mmap_sem);
>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
> -	if (is_vm_hugetlb_page(vma)) {
> +	if (unlikely(!vma)) {
> +		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
> +		up_read(&current->mm->mmap_sem);
> +		return -EFAULT;
> +	} else if (is_vm_hugetlb_page(vma)) {
>  		hugetlb = true;
>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>  	} else {
> -- 
> 1.8.3.2
> 
Nice catch!

(This would only happen if the guest unmaps an mmap region after
registering the memslot I believe, but still, we should absolutely merge
this.).

Thanks,
-Christoffer
