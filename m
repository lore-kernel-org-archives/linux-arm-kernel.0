From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 11:47:18 +0100
Subject: [PATCH 2/5] ARM: KVM: add missing dsb before invalidating
 Stage-2 TLBs
In-Reply-To: <1371648006-8036-3-git-send-email-marc.zyngier@arm.com>
References: <1371648006-8036-1-git-send-email-marc.zyngier@arm.com>
 <1371648006-8036-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130620104718.GI2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 02:20:03PM +0100, Marc Zyngier wrote:
> When performing a Stage-2 TLB invalidation, it is necessary to
> make sure the write to the page tables is observable by all CPUs.
> 
> For this purpose, add a dsb instruction to __kvm_tlb_flush_vmid_ipa
> before doing the TLB invalidation itself.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/interrupts.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index d0a8fa3..afa6c04 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -49,6 +49,7 @@ __kvm_hyp_code_start:
>  ENTRY(__kvm_tlb_flush_vmid_ipa)
>  	push	{r2, r3}
>  
> +	dsb

This can be dsb	ish.

Will
