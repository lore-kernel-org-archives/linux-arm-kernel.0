From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 10 Jul 2015 23:42:58 +0100
Subject: [PATCH v2 1/7] KVM: api: introduce KVM_IRQ_ROUTING_EXTENDED_MSI
In-Reply-To: <1436430137-24205-2-git-send-email-eric.auger@linaro.org>
References: <1436430137-24205-1-git-send-email-eric.auger@linaro.org>
 <1436430137-24205-2-git-send-email-eric.auger@linaro.org>
Message-ID: <55A04A72.4010205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 09:22, Eric Auger wrote:
> On ARM, the MSI msg (address and data) comes along with
> out-of-band device ID information. The device ID encodes the
> device that writes the MSI msg. Let's convey the device id in
> kvm_irq_routing_msi and use a new routing entry type to
> indicate the devid is populated.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Just some forward looking statement: If this gets based on top of my ITS
emulation v2 series, the documentation should state that the new
KVM_CAP_MSI_DEVID capability tells userland about the need to provide
the device ID.

Cheers,
Andre.

> 
> ---
> 
> v1 -> v2:
> - devid id passed in kvm_irq_routing_msi instead of in
>   kvm_irq_routing_entry
> 
> RFC -> PATCH
> - remove kvm_irq_routing_extended_msi and use union instead
> ---
>  Documentation/virtual/kvm/api.txt | 10 +++++++++-
>  include/uapi/linux/kvm.h          |  6 +++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index bea8de7..3d920cd 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1453,6 +1453,7 @@ struct kvm_irq_routing_entry {
>  #define KVM_IRQ_ROUTING_IRQCHIP 1
>  #define KVM_IRQ_ROUTING_MSI 2
>  #define KVM_IRQ_ROUTING_S390_ADAPTER 3
> +#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
>  
>  No flags are specified so far, the corresponding field must be set to zero.
>  
> @@ -1465,9 +1466,16 @@ struct kvm_irq_routing_msi {
>  	__u32 address_lo;
>  	__u32 address_hi;
>  	__u32 data;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 devid;
> +	};
>  };
>  
> +for KVM_IRQ_ROUTING_EXTENDED_MSI routing entry type, the kvm_irq_routing_msi
> +routing entry is used and devid is populated with the device ID that wrote
> +the MSI message. For PCI, this is usually a BFD identifier in the lower 16 bits.
> +
>  struct kvm_irq_routing_s390_adapter {
>  	__u64 ind_addr;
>  	__u64 summary_addr;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9a261e5..39ec164 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -829,7 +829,10 @@ struct kvm_irq_routing_msi {
>  	__u32 address_lo;
>  	__u32 address_hi;
>  	__u32 data;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 devid;
> +	};
>  };
>  
>  struct kvm_irq_routing_s390_adapter {
> @@ -844,6 +847,7 @@ struct kvm_irq_routing_s390_adapter {
>  #define KVM_IRQ_ROUTING_IRQCHIP 1
>  #define KVM_IRQ_ROUTING_MSI 2
>  #define KVM_IRQ_ROUTING_S390_ADAPTER 3
> +#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
>  
>  struct kvm_irq_routing_entry {
>  	__u32 gsi;
> 
