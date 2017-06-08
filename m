From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Jun 2017 15:35:05 +0100
Subject: [PATCH v3 9/9] KVM: arm/arm64: Don't assume initialized vgic when
 setting PMU IRQ
In-Reply-To: <20170608133446.3875-10-cdall@linaro.org> (Christoffer Dall's
 message of "Thu, 8 Jun 2017 15:34:46 +0200")
References: <20170608133446.3875-1-cdall@linaro.org>
 <20170608133446.3875-10-cdall@linaro.org>
Message-ID: <87y3t2h7ja.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08 2017 at  3:34:46 pm BST, Christoffer Dall <cdall@linaro.org> wrote:
> The PMU IRQ number is set through the VCPU device's KVM_SET_DEVICE_ATTR
> ioctl handler for the KVM_ARM_VCPU_PMU_V3_IRQ attribute, but there is no
> enforced or stated requirement that this must happen after initializing
> the VGIC.  As a result, calling vgic_valid_spi() which relies on the
> nr_spis being set during the VGIC init can incorrectly fail.
>
> Introduce irq_is_spi, which determines if an IRQ number is within the
> SPI range without verifying it against the actual VGIC properties.
>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
>  include/kvm/arm_vgic.h | 2 ++
>  virt/kvm/arm/pmu.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 131668f..a2ae9d2 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -39,6 +39,8 @@
>  #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
>  
>  #define irq_is_ppi(irq) ((irq) >= VGIC_NR_SGIS && (irq) < VGIC_NR_PRIVATE_IRQS)
> +#define irq_is_spi(irq) ((irq) >= VGIC_NR_PRIVATE_IRQS && \
> +			 (irq) <= VGIC_MAX_SPI)
>  
>  enum vgic_type {
>  	VGIC_V2,		/* Good ol' GICv2 */
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 26a42a9..87cb325 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -547,7 +547,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  			return -EFAULT;
>  
>  		/* The PMU overflow interrupt can be a PPI or a valid SPI. */
> -		if (!(irq_is_ppi(irq) || vgic_valid_spi(vcpu->kvm, irq)))
> +		if (!(irq_is_ppi(irq) || irq_is_spi(irq)))
>  			return -EINVAL;
>  
>  		if (!pmu_irq_is_valid(vcpu->kvm, irq))

Does it mean that we can now fail an injection if the SPI is out of the
range of configured SPIs?

If that's the case, the WARN_ON() in kvm_pmu_update_state() is going to
fire badly, and that's going to be ugly. Should we add a check for this
case in kvm_arm_pmu_v3_init()?

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
