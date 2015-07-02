From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 2 Jul 2015 18:10:04 +0100
Subject: [PATCH 7/7] KVM: arm: implement kvm_set_msi by gsi direct mapping
In-Reply-To: <1435592237-17924-8-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-8-git-send-email-eric.auger@linaro.org>
Message-ID: <5595706C.9010108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 29/06/15 16:37, Eric Auger wrote:
> If the ITS modality is not available, let's simply support MSI
> injection by transforming the MSI.data into an SPI ID.
> 
> This becomes possible to use KVM_SIGNAL_MSI ioctl for arm too.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  arch/arm/kvm/Kconfig | 1 +
>  virt/kvm/arm/vgic.c  | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 151e710..0f58baf 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -31,6 +31,7 @@ config KVM
>  	select KVM_VFIO
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_IRQFD
> +	select HAVE_KVM_MSI
>  	select HAVE_KVM_IRQCHIP
>  	select HAVE_KVM_IRQ_ROUTING
>  	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 0b4c48c..b3c10dc 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -2314,6 +2314,11 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
>  			return kvm->arch.vgic.vm_ops.inject_msi(kvm, &msi);
>  		else
>  			return -ENODEV;
> +	case KVM_IRQ_ROUTING_MSI:
> +		if (kvm->arch.vgic.vm_ops.inject_msi)
> +			return -EINVAL;
> +		else
> +			return kvm_vgic_inject_irq(kvm, 0, e->msi.data, level);

If you add:

static int vgic_v2m_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
{
	return kvm_vgic_inject_irq(kvm, 0, msi->data, 1);
}

to vgic-v2-emul.c and wire it up accordingly, you can simplify the above
kvm_set_msi, getting rid of all those extra case handling.
This also helps merging KVM_IRQ_ROUTING_MSI and the extended case.

I have hacked this up and it seems to work for me.

Cheers,
Andre.
