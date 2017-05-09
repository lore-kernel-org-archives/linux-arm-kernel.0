From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 9 May 2017 11:44:24 +0200
Subject: [PATCH v2 03/11] KVM: Add kvm_vcpu_get_idx to get vcpu index in
 kvm->vcpus
In-Reply-To: <20170509085618.28311-4-cdall@linaro.org>
References: <20170509085618.28311-1-cdall@linaro.org>
 <20170509085618.28311-4-cdall@linaro.org>
Message-ID: <0f3e3b18-2b62-58c6-ed82-9620943b568e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/05/2017 10:56, Christoffer Dall wrote:
> There are occasional needs to use the index of vcpu in the kvm->vcpus
> array to map something related to a VCPU.  For example, unlike the
> vcpu->vcpu_id, the vcpu index is guaranteed to not be sparse across all
> vcpus which is useful when allocating a memory area for each vcpu.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  include/linux/kvm_host.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2c14ad9..12eb26d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -490,6 +490,17 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  	return NULL;
>  }
>  
> +static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu *tmp;
> +	int idx;
> +
> +	kvm_for_each_vcpu(idx, tmp, vcpu->kvm)
> +		if (tmp == vcpu)
> +			return idx;
> +	BUG();
> +}
> +
>  #define kvm_for_each_memslot(memslot, slots)	\
>  	for (memslot = &slots->memslots[0];	\
>  	      memslot < slots->memslots + KVM_MEM_SLOTS_NUM && memslot->npages;\
> 
