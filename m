From: david@redhat.com (David Hildenbrand)
Date: Tue, 22 Aug 2017 13:43:02 +0200
Subject: [PATCH RFC v3 2/9] KVM: arm/arm64: fix vcpu self-detection in
 vgic_v3_dispatch_sgi()
In-Reply-To: <20170821203530.9266-3-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-3-rkrcmar@redhat.com>
Message-ID: <a6c6b3e0-ded0-f81b-7b14-c85a12e513b5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.08.2017 22:35, Radim Kr?m?? wrote:
> The index in kvm->vcpus array and vcpu->vcpu_id are very different
> things.  Comparing struct kvm_vcpu pointers is a sure way to know.
> 
> Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>
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
> 

Yes, this looks correct to me.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
