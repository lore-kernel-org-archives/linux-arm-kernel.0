From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 5 Aug 2015 18:59:05 +0200
Subject: [PATCH] kvm:arm:Fix error handling in the function vgic_v3_probe
In-Reply-To: <1438793303-30228-1-git-send-email-xerofoify@gmail.com>
References: <1438793303-30228-1-git-send-email-xerofoify@gmail.com>
Message-ID: <55C240D9.5060900@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/08/2015 18:48, Nicholas Krause wrote:
> This fixes the error handling in the function vgic_v3_probe
> for when calling the function kvm_register_device_ops to check
> if the call to this function has returned a error code and if
> so jump to the label out with goto to cleanup no longer required
> resources used by the function vgic_v3_probe before returning the
> error code from the call to kvm_register_device_ops to the caller
> of the function vgic_v3_probe.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  virt/kvm/arm/vgic-v3.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
> index dff0602..5102aa2 100644
> --- a/virt/kvm/arm/vgic-v3.c
> +++ b/virt/kvm/arm/vgic-v3.c
> @@ -264,12 +264,16 @@ int vgic_v3_probe(struct device_node *vgic_node,
>  	} else {
>  		vgic->vcpu_base = vcpu_res.start;
>  		vgic->can_emulate_gicv2 = true;
> -		kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
> -					KVM_DEV_TYPE_ARM_VGIC_V2);
> +		ret = kvm_register_device_ops(&kvm_arm_vgic_v2_ops,
> +					      KVM_DEV_TYPE_ARM_VGIC_V2);
> +		if (ret)
> +			goto out;
>  	}
>  	if (vgic->vcpu_base == 0)
>  		kvm_info("disabling GICv2 emulation\n");
> -	kvm_register_device_ops(&kvm_arm_vgic_v3_ops, KVM_DEV_TYPE_ARM_VGIC_V3);
> +	ret = kvm_register_device_ops(&kvm_arm_vgic_v3_ops, KVM_DEV_TYPE_ARM_VGIC_V3);
> +	if (ret)
> +		goto out;
>  
>  	vgic->vctrl_base = NULL;
>  	vgic->type = VGIC_V3;
> 

This really should never happen.  Perhaps kvm_register_device_ops should
instead return void, and WARN() when it currently returns an error.

Paolo
