From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 30 Apr 2013 10:40:59 -0700
Subject: [PATCH 4/4] ARM: KVM: fix use of S2_PGD_SIZE
In-Reply-To: <1367331446-28030-5-git-send-email-marc.zyngier@arm.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
 <1367331446-28030-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAEDV+gK5ifY0atTZqku=Y4J=1pfWY4XAz-ayXJ61Sf7MtjOG4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 7:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> S2_PGD_SIZE describe the number of pages a used by a stage-2 PGD,
> not the size of the PGD.
>
> Fix the VM_BUG_ON() call that doesn't check much when S2_PGD_SIZE
> is equal to 1.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index b978ebe..09ece5c 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -377,7 +377,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>                 return -ENOMEM;
>
>         /* stage-2 pgd must be aligned to its size */
> -       VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
> +       VM_BUG_ON((unsigned long)pgd & (PAGE_SIZE * S2_PGD_SIZE - 1));

I think the define is broken and should be fixed and/or renamed instead.

>
>         memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
>         kvm_clean_pgd(pgd);
> --
> 1.8.2.1
>
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
