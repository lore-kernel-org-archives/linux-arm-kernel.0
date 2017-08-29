From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 29 Aug 2017 12:00:55 +0200
Subject: [PATCH RFC v3 2/9] KVM: arm/arm64: fix vcpu self-detection in
 vgic_v3_dispatch_sgi()
In-Reply-To: <20170821203530.9266-3-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-3-rkrcmar@redhat.com>
Message-ID: <20170829100055.GV24649@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 10:35:23PM +0200, Radim Kr?m?? wrote:
> The index in kvm->vcpus array and vcpu->vcpu_id are very different
> things.  Comparing struct kvm_vcpu pointers is a sure way to know.
> 
> Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>

Acked-by: Christoffer Dall <cdall@linaro.org>

> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 408ef06638fc..9d4b69b766ec 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -797,7 +797,6 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  	u16 target_cpus;
>  	u64 mpidr;
>  	int sgi, c;
> -	int vcpu_id = vcpu->vcpu_id;
>  	bool broadcast;
>  
>  	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
> @@ -821,7 +820,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  			break;
>  
>  		/* Don't signal the calling VCPU */
> -		if (broadcast && c == vcpu_id)
> +		if (broadcast && c_vcpu == vcpu)
>  			continue;
>  
>  		if (!broadcast) {
> -- 
> 2.13.3
> 
