From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Dec 2014 18:30:23 +0000
Subject: [PATCH 4/5] arm/arm64: KVM: Don't allow creating VCPUs after
 vgic_initialized
In-Reply-To: <1418139844-27892-5-git-send-email-christoffer.dall@linaro.org>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-5-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5489E2BF.4030205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/14 15:44, Christoffer Dall wrote:
> When the vgic initializes its internal state it does so based on the
> number of VCPUs available at the time.  If we allow KVM to create more
> VCPUs after the VGIC has been initialized, we are likely to error out in
> unfortunate ways later, perform buffer overflows etc.
> 
> Cc: Eric Auger <eric.auger@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> This replaces Eric Auger's previous patch
> (https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012646.html),
> because it fits better with testing to include it in this series and I
> realized that we need to add a check against irqchip_in_kernel() as
> well.
> 
>  arch/arm/kvm/arm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index a9d005f..d4da244 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -213,6 +213,11 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>  	int err;
>  	struct kvm_vcpu *vcpu;
>  
> +	if (irqchip_in_kernel(kvm) && vgic_initialized(kvm)) {
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
>  	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
>  	if (!vcpu) {
>  		err = -ENOMEM;
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
