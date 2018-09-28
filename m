From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Sep 2018 18:27:37 +0100
Subject: [PATCH v6 06/18] kvm: arm/arm64: Allow arch specific
 configurations for VM
In-Reply-To: <20180926163258.20218-7-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-7-suzuki.poulose@arm.com>
Message-ID: <fbca190b-473b-5dee-67be-c724392fd297@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 26/09/18 17:32, Suzuki K Poulose wrote:
> Allow the arch backends to perform VM specific initialisation.
> This will be later used to handle IPA size configuration and per-VM
> VTCR configuration on arm64.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm/include/asm/kvm_host.h   | 7 +++++++
>   arch/arm64/include/asm/kvm_host.h | 2 ++
>   arch/arm64/kvm/reset.c            | 7 +++++++
>   virt/kvm/arm/arm.c                | 5 +++--
>   4 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 3ad482d2f1eb..72d46418e1ef 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>   struct kvm *kvm_arch_alloc_vm(void);
>   void kvm_arch_free_vm(struct kvm *kvm);
>   
> +static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)

This is a bit of a nit, but VM is a bit of an overloaded term in this 
context. Given what we do in the following patch (moving the global 
stage-2 init to be on a per VM -- virtual machine), I'd like to rename 
this to something less ambiguous.

How about kvm_arm_config_stage2? Or something along those lines?

No need to respin the series on this account, we can address it in a 
separate patch. But I think it would help understanding what is done where.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
