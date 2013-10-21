From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 21 Oct 2013 15:03:29 +0100
Subject: [RFC PATCH 3/5] arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
In-Reply-To: <1380888978-27725-4-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
 <1380888978-27725-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131021140329.GG39411@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 01:16:16PM +0100, Marc Zyngier wrote:
> We now have the information about the number of CPU interfaces in
> the distributor itself. Let's get rid of VGIC_MAX_CPUS, and just
> rely on KVM_MAX_VCPUS where we don't have the choice. Yet.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/arm.c     | 2 +-
>  include/kvm/arm_vgic.h | 3 +--
>  virt/kvm/arm/vgic.c    | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index f0f7a8a..2f465fe 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -789,7 +789,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	switch (ioctl) {
>  	case KVM_CREATE_IRQCHIP: {
>  		if (vgic_present)
> -			return kvm_vgic_create(kvm, VGIC_MAX_CPUS, VGIC_NR_IRQS);
> +			return kvm_vgic_create(kvm, KVM_MAX_VCPUS, VGIC_NR_IRQS);
>  		else
>  			return -ENXIO;
>  	}
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 8ce9c08..4d4ab2e 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -30,11 +30,10 @@
>  #define VGIC_NR_SGIS		16
>  #define VGIC_NR_PPIS		16
>  #define VGIC_NR_PRIVATE_IRQS	(VGIC_NR_SGIS + VGIC_NR_PPIS)
> -#define VGIC_MAX_CPUS		KVM_MAX_VCPUS
>  #define VGIC_MAX_LRS		(1 << 6)
>  
>  /* Sanity checks... */
> -#if (VGIC_MAX_CPUS > 8)
> +#if (KVM_MAX_VCPUS > 8)
>  #error	Invalid number of CPU interfaces
>  #endif
>  
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 951b560..259b9dd 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -954,7 +954,7 @@ static bool vgic_queue_sgi(struct kvm_vcpu *vcpu, int irq)
>  
>  	sources = *vgic_get_sgi_sources(dist, vcpu_id, irq);
>  
> -	for_each_set_bit(c, &sources, VGIC_MAX_CPUS) {
> +	for_each_set_bit(c, &sources, dist->nr_cpus) {
>  		if (vgic_queue_irq(vcpu, c, irq))
>  			clear_bit(c, &sources);
>  	}
> @@ -1326,7 +1326,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		return ret;
>  
> -	if (vcpu->vcpu_id >= VGIC_MAX_CPUS)
> +	if (vcpu->vcpu_id >= dist->nr_cpus)
>  		return -EBUSY;
>  
>  	for (i = 0; i < VGIC_NR_IRQS; i++) {
> -- 
> 1.8.2.3
> 
> 
Looks fine,

-- 
Christoffer
