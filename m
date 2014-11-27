From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 27 Nov 2014 11:19:12 +0100
Subject: [RFC PATCH 2/5] ARM: on IO mem abort - route the call to KVM
 MMIO bus
In-Reply-To: <20141124212651.10605.58116.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
 <20141124212651.10605.58116.stgit@i3820>
Message-ID: <5476FAA0.1060104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 10:26 PM, Nikolay Nikolaev wrote:
> On IO memory abort, try to handle the MMIO access thorugh the KVM
typo
> registered read/write callbacks. This is done by invoking the relevant
> kvm_io_bus_* API.
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> ---
>  arch/arm/kvm/mmio.c |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 4cb5a93..81230da 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -162,6 +162,36 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	return 0;
>  }
>  
> +/**
> + * kvm_handle_mmio - handle an in-kernel MMIO access
handle_kernel_mmio
> + * @vcpu:	pointer to the vcpu performing the access
> + * @run:	pointer to the kvm_run structure
> + * @mmio:	pointer to the data describing the access
> + *
> + * returns true if the MMIO access has been performed in kernel space,
> + * and false if it needs to be emulated in user space.
> + */
> +static bool handle_kernel_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +		struct kvm_exit_mmio *mmio)
> +{
> +	int ret;
> +
> +	if (mmio->is_write) {
> +		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
> +				mmio->len, &mmio->data);
> +
> +	} else {
> +		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
> +				mmio->len, &mmio->data);

> +	}
> +	if (!ret) {
> +		kvm_prepare_mmio(run, mmio);
> +		kvm_handle_mmio_return(vcpu, run);
Shouldn't the comment associated to kvm_handle_mmio_return saying
the function "should only be called after returning from userspace for
MMIO load emulation" be updated? Here we did kernel emulation and we
call it. also in vgic it is called. Must aknowledge I do not fully
understand what the .rt is.
> +	}
> +
> +	return !ret;
what if kvm_io_bus_read returned -EOPNOTSUPP?
> +}
> +
>  int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		 phys_addr_t fault_ipa)
>  {
> @@ -200,6 +230,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	if (vgic_handle_mmio(vcpu, run, &mmio))
>  		return 1;
>  
> +	if (handle_kernel_mmio(vcpu, run, &mmio))
> +		return 1;
> +

>  	kvm_prepare_mmio(run, &mmio);
>  	return 0;
>  }
> 
