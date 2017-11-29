From: david@redhat.com (David Hildenbrand)
Date: Wed, 29 Nov 2017 18:30:33 +0100
Subject: [PATCH v2 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
In-Reply-To: <20171129164116.16167-16-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-16-christoffer.dall@linaro.org>
Message-ID: <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +++ b/virt/kvm/arm/arm.c
> @@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> -	vcpu_load(vcpu);
> -
>  	if (vcpu->arch.power_off)
>  		mp_state->mp_state = KVM_MP_STATE_STOPPED;
>  	else
>  		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>  
> -	vcpu_put(vcpu);
>  	return 0;
>  }

Okay, this also makes sense on other architectures. The important thing
is only that we hold the vcpu mutex.


-- 

Thanks,

David / dhildenb
